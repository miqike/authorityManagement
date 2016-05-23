window.operateType = "";//操作类型

//设置页面为编辑状态
function setEditStatus() {
    $("#btnAdd").linkbutton('disable');
    $("#btnEdit").linkbutton('disable');
    $("#btnDelete").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');

    $("#baseTable input.easyui-textbox").textbox("enable");
    $("#baseTable input.easyui-datebox").datebox("enable");
    $("#baseTable input.easyui-combobox").combobox("enable");
    $("#baseTable input.easyui-combotree").combotree("enable");

}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    $("#btnEdit").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');

    $("#baseTable input.easyui-textbox").textbox("disable");
    $("#baseTable input.easyui-datebox").datebox("disable");
    $("#baseTable input.easyui-combobox").combobox("disable");
    $("#baseTable input.easyui-combotree").combotree("disable");
}
//通用保存函数
function save() {
    var data = $.easyuiExtendObj.drillDownForm('baseTable');

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
    if ($("#baseTable").form('validate') && !$(this).linkbutton('options').disabled) {
        save();
    }
}
//取消按钮点击事件
function btnCloseClick() {
    if (!$(this).linkbutton('options').disabled) {
        $("#baseWindow").window("close");
    }
}

//修改按钮点击事件
function btnViewClick() {
    // if (!$(this).linkbutton('options').disabled) {
    window.operateType = "edit";
    setEditStatus();
    showModalDialog("baseWindow", "修改部门信息");
    // }
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
    if (!$(this).linkbutton('options').disabled) {
        $("#baseTable").form('clear');
        window.operateType = "add";
        setEditStatus();
        showModalDialog("baseWindow", "新部门信息");
    }
}
$(function () {
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