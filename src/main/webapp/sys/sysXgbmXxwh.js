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
    $.easyuiExtendObj.loadForm("deptTable", treeNode);
    setReadOnlyStatus();
}

//设置页面为编辑状态
function setEditStatus() {
    $("#btnAdd").linkbutton('disable');
    $("#btnEdit").linkbutton('disable');
    $("#btnDelete").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');

    $("#deptTable input.easyui-textbox").textbox("enable");
    $("#deptTable input.easyui-datebox").datebox("enable");
    $("#deptTable input.easyui-combobox").combobox("enable");
    $("#deptTable input.easyui-combotree").combotree("enable");
}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    $("#btnEdit").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');

    $("#deptTable input.easyui-textbox").textbox("disable");
    $("#deptTable input.easyui-datebox").datebox("disable");
    $("#deptTable input.easyui-combobox").combobox("disable");
    $("#deptTable input.easyui-combotree").combotree("disable");
}
//通用保存函数
function save() {
    var data = $.easyuiExtendObj.drillDownForm('deptTable');

    var url = "../sys/organization";
    if (window.operateType == "add") {//增加本级
        url = "../sys/organization/save";
    }
    if (window.operateType == "edit") {//修改
        url = "../sys/organization/update";
    }
    if (window.operateType == "delete") {//删除
        url = "../sys/organization/delete";
    }
    $.post(url, data, function (response) {
        if (response.status == myJsCommon.FAIL) {
            $.messager.alert("警告", myJsCommon.combineErrorMessage(response), "warning");
        } else {
            $.messager.show({
                title: '提示',
                msg: response.message
            });
            setReadOnlyStatus();
        }
    }, "json");
}
//保存按钮点击事件
function btnSaveClick() {
    if ($("#treeNodeForm").form('validate') && !$(this).linkbutton('options').disabled) {
        save();
    }
}
//取消按钮点击事件
function btnCloseClick() {
    if (!$(this).linkbutton('options').disabled) {
        onTreeClick(null, null, $.zTreeExtendObj.getSelectedNode("tree"), null);
        $("#depWindow").window("close");
    }
}

//修改按钮点击事件
function btnViewClick() {
    // if (!$(this).linkbutton('options').disabled) {
    window.operateType = "edit";
    setEditStatus();
    showModalDialog("depWindow", "修改部门信息");
    // }
}
//删除按钮点击事件
function btnDeleteClick() {
    if (!$(this).linkbutton('options').disabled) {
        var node = $.zTreeExtendObj.getSelectedNode("tree");
        if (null == node) {
            $.messager.alert("警告", "请首先选择父节点", "warning");
        } else {
            window.operateType = "delete";
            save();
            setReadOnlyStatus();
        }
    }
}
//增加本级按钮点击事件
function btnAddClick() {
    if (!$(this).linkbutton('options').disabled) {
        $("#deptTable").form('clear');
        window.operateType = "add";
        setEditStatus();
        showModalDialog("depWindow", "新部门信息");
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

    $(".datagrid-body").niceScroll({
        cursorcolor: "lightblue", // 滚动条颜色
        cursoropacitymax: 3, // 滚动条是否透明
        horizrailenabled: false, // 是否水平滚动
        cursorborderradius: 0, // 滚动条是否圆角大小
        autohidemode: false // 是否隐藏滚动条
    });
});