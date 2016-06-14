window.operateType = "";//操作类型

var setting = {
    data: {
        key: {
            title: "parentId",
            name: "nameWithId"
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
    options.url = '../common/query?mapper=bmMapper&queryName=query';
    console.log(treeNode);
    options.queryParams = {
        orgId: treeNode.id
    };
    $("#mainGrid").datagrid(options);
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnDelete").linkbutton("disable");
    }

    setReadOnlyStatus();
}

//设置页面为编辑状态
function setEditStatus() {
    $("#btnAdd").linkbutton('disable');
    $("#btnEdit").linkbutton('disable');
    $("#btnDelete").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');

    $("#baseInfo input.easyui-textbox").textbox("enable");
    $("#baseInfo input.easyui-datebox").datebox("enable");
    $("#baseInfo input.easyui-combobox").combobox("enable");
    $("#baseInfo input.easyui-combotree").combotree("enable");

}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    $("#btnEdit").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');

    $("#baseInfo input.easyui-textbox").textbox("disable");
    $("#baseInfo input.easyui-datebox").datebox("disable");
    $("#baseInfo input.easyui-combobox").combobox("disable");
    $("#baseInfo input.easyui-combotree").combotree("disable");
}
//通用保存函数
function save() {
    var data = $.easyuiExtendObj.drillDownForm('baseInfo');

    var type = "";
    var url = "";
    if (window.operateType == "add") {//增加本级
        type = "POST";
        url = "../11/sysOrgDep";
    }
    if (window.operateType == "edit") {//修改
        type = "PUT";
        url = "../11/sysOrgDep";
    }
    if (window.operateType == "delete") {//删除
        type = "DELETE";
        data = {"id": $("#p_id").textbox("getValue")};
        data = JSON.stringify(data);
        url = "../11/sysOrgDep?id=" + $("#p_id").textbox("getValue");
    }
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: function (response) {
            if (response.status == SUCCESS) {
                setReadOnlyStatus();
                var options = $('#mainGrid').datagrid('options');
                options.url = '../common/query?mapper=bmMapper&queryName=query';
                $("#mainGrid").datagrid(options);
                if ($("#mainGrid").datagrid("getSelected") != null) {
                    $("#btnView").linkbutton("enable");
                    $("#btnDelete").linkbutton("enable");
                } else {
                    $("#btnView").linkbutton("disable");
                    $("#btnDelete").linkbutton("disable");
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
        showModalDialog("baseWindow", "修改部门信息");
        window.operateType = "edit";
        setEditStatus();
        $("#p_id").textbox("disable");
        $("#p_gsxxfl").combobox("enable");
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
//新增按钮点击事件
function btnAddClick() {
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var selected = treeObj.getSelectedNodes();
    if (!$(this).linkbutton('options').disabled && selected.length == 1) {
        showModalDialog("baseWindow", "新部门信息");
        setEditStatus();
        $("#baseInfo").form('clear');
        $("#p_orgId").textbox("setValue", selected[0].id);
        $("#p_orgName").textbox("setValue", selected[0].name);
        window.operateType = "add";
    } else {
        $.messager.alert('提示', "请先选择单位！", 'info');
    }
}
$(function () {
    $.fn.zTree.init($("#tree"), setting);

    $("#btnAdd").click(btnAddClick);
    $("#btnView").click(btnViewClick);
    $("#btnDelete").click(btnDeleteClick);
    $("#btnSave").click(btnSaveClick);
    $("#btnClose").click(btnCloseClick);

    setReadOnlyStatus();

    $("#mainGrid").datagrid({"singleSelect": "true"}).datagrid({
        onSelect: function (index, row) {
            $("#btnView").linkbutton("enable");
            $("#btnDelete").linkbutton("enable");
            $("#baseInfo").form('clear');
            $.easyuiExtendObj.loadForm("baseInfo", row);
        },
        onUnselect: function (index, row) {
            $("#btnView").linkbutton("disable");
            $("#btnDelete").linkbutton("disable");
            $("#baseInfo").form('clear');
        }
    });
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=bmMapper&queryName=query';
    $("#mainGrid").datagrid(options);

    $(".datagrid-body").niceScroll({
        cursorcolor: "lightblue", // 滚动条颜色
        cursoropacitymax: 3, // 滚动条是否透明
        horizrailenabled: false, // 是否水平滚动
        cursorborderradius: 0, // 滚动条是否圆角大小
        autohidemode: false // 是否隐藏滚动条
    });
});