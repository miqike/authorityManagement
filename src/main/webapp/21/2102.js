window.operateType = "";//操作类型

var setting = {
    data: {
        key: {
            title: "parentId",
            name: "name"
        }
    },
    async: {
        enable: true,
        type: "get",
        url: "../sys/organization/getSub",
        autoParam: ["id"]
    },
    callback: {
        beforeClick: beforeTreeClick,
        onClick: onTreeClick,
        onAsyncSuccess: zTreeOnAsyncSuccess
    }
};

var log, className = "dark";
//树加载成功后事件
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {

}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "" : "dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=zfryMapper&queryName=query';
    console.log(treeNode);
    options.queryParams = {
        dwId: treeNode.id
    };
    $("#mainGrid").datagrid(options);

    setReadOnlyStatus();
}

//设置页面为编辑状态
function setEditStatus() {
    $("#btnAdd").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
        $("#btnTrans").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnDelete").linkbutton("disable");
        $("#btnTrans").linkbutton("disable");
    }

    $("#baseTable input.easyui-textbox").textbox("enable");
    $("#baseTable input.easyui-datebox").datebox("enable");
    $("#baseTable input.easyui-combobox").combobox("enable");
    $("#baseTable input.easyui-combotree").combotree("enable");
}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
        $("#btnTrans").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnDelete").linkbutton("disable");
        $("#btnTrans").linkbutton("disable");
    }
    $("#baseTable input.easyui-textbox").textbox("disable");
    $("#baseTable input.easyui-datebox").datebox("disable");
    $("#baseTable input.easyui-combobox").combobox("disable");
    $("#baseTable input.easyui-combotree").combotree("disable");
}
//通用保存函数
function save() {
    var data = $.easyuiExtendObj.drillDownForm('baseInfo');

    var type = "";
    var url = "";
    if (window.operateType == "add") {//增加本级
        type = "POST";
        url = "../21/2102";
    }
    if (window.operateType == "edit") {//修改
        type = "PUT";
        url = "../21/2102";
    }
    if (window.operateType == "delete") {//删除
        type = "DELETE";
        data = {"id": $("#p_code").textbox("getValue")};
        data = JSON.stringify(data);
        url = "../21/2102?code=" + $("#p_code").textbox("getValue");
    }
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: function (response) {
            if (response.status == SUCCESS) {
                setReadOnlyStatus();
                var options = $('#mainGrid').datagrid('options');
                options.url = '../common/query?mapper=zfryMapper&queryName=query';
                $("#mainGrid").datagrid(options);
                if ($("#mainGrid").datagrid("getSelected") != null) {
                    $("#btnView").linkbutton("enable");
                    $("#btnDelete").linkbutton("enable");
                    $("#btnTrans").linkbutton("enable");
                } else {
                    $("#btnView").linkbutton("disable");
                    $("#btnDelete").linkbutton("disable");
                    $("#btnTrans").linkbutton("disable");
                }
                $("#baseWindow").window("close");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });
}
//保存按钮点击事件
function btnSaveClick() {
    if ($("#baseInfo").form('validate') && !$(this).linkbutton('options').disabled) {
        save();
    }
}
//取消按钮点击事件
function btnCloseClick() {
    if (!$(this).linkbutton('options').disabled) {
        $("#baseWindow").window("close");
        setReadOnlyStatus();
    }
}

//修改按钮点击事件
function btnViewClick() {
    if (!$(this).linkbutton('options').disabled) {
        showModalDialog("baseWindow", "修改执法人员信息");
        window.operateType = "edit";
        setEditStatus();
        $("#p_code").textbox("disable");
        $.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
    }
}
//删除按钮点击事件
function btnDeleteClick() {
    if (!$(this).linkbutton('options').disabled) {
        window.operateType = "delete";
        save();
        setReadOnlyStatus();
    }
}
//增加本级按钮点击事件
function btnAddClick() {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();
    if (!$(this).linkbutton('options').disabled && selected.length == 1) {
        showModalDialog("baseWindow", "新执法人员信息");
        setEditStatus();
        $("#baseInfo").form('clear');
        $("#p_dwId").textbox("setValue", selected[0].id);
        $("#p_dwName").textbox("setValue", selected[0].name);
        window.operateType = "add";
    } else {
        $.messager.alert('提示', "请先选择单位！", 'info');
    }
}
$(function () {
    $.fn.zTree.init($("#orgTree"), setting);

    $("#btnAdd").click(btnAddClick);
    $("#btnView").click(btnViewClick);
    $("#btnDelete").click(btnDeleteClick);
    $("#btnSave").click(btnSaveClick);
    $("#btnClose").click(btnCloseClick);

    setReadOnlyStatus();

    $("#mainGrid").datagrid({"singleSelect": "true"}).datagrid({
        onSelect: function (index, row) {
            $("#btnTrans").linkbutton("enable");
            $("#btnView").linkbutton("enable");
            $("#btnDelete").linkbutton("enable");
            $("#baseInfo").form('clear');
            $.easyuiExtendObj.loadForm("baseInfo", row);
        },
        onUnselect: function (index, row) {
            $("#btnView").linkbutton("disable");
            $("#btnDelete").linkbutton("disable");
            $("#btnTrans").linkbutton("disable");
            $("#baseInfo").form('clear');
        }
    });
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=zfryMapper&queryName=query';
    $("#mainGrid").datagrid(options);

    $(".datagrid-body").niceScroll({
        cursorcolor: "lightblue", // 滚动条颜色
        cursoropacitymax: 3, // 滚动条是否透明
        horizrailenabled: false, // 是否水平滚动
        cursorborderradius: 0, // 滚动条是否圆角大小
        autohidemode: false // 是否隐藏滚动条
    });
});