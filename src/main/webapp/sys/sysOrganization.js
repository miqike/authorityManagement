window.operateType="";//操作类型

var setting = {
    data: {
        key: {
            title:"parentId",
            name:"nameWithId"
        }},
    async: {
        enable: true,
        type: "get",
        url:"../sys/organization/getSub",
        autoParam:["id"]
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
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    $.easyuiExtendObj.loadForm("treeNodeForm",treeNode);
    setReadOnlyStatus();

    var tab = $('#tabPanel').tabs('getSelected');
    var index = $('#tabPanel').tabs('getTabIndex',tab);
    tabSelectHandler("",index);
}

//设置页面为编辑状态
function setEditStatus(){
    $("#btnAdd").linkbutton('disable');
    $("#btnAddChild").linkbutton('disable');
    $("#btnEdit").linkbutton('disable');
    $("#btnDelete").linkbutton('disable');
    $("#btnStop").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');

    $("#treeNodeForm input.easyui-textbox").textbox("enable");
    $("#treeNodeForm input.easyui-datebox").datebox("enable");
    $("#treeNodeForm input.easyui-combobox").combobox("enable");
    $("#treeNodeForm input.easyui-combotree").combotree("enable");

    $("#f_parentId").textbox("readonly");
}
//设置页面为不可编辑状态
function setReadOnlyStatus(){
    $("#btnAdd").linkbutton('enable');
    $("#btnAddChild").linkbutton('enable');
    $("#btnEdit").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');
    $("#btnStop").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');

    $("#treeNodeForm input.easyui-textbox").textbox("disable");
    $("#treeNodeForm input.easyui-datebox").datebox("disable");
    $("#treeNodeForm input.easyui-combobox").combobox("disable");
    $("#treeNodeForm input.easyui-combotree").combotree("disable");
}
//通用保存函数
function save(){
    var data = $.easyuiExtendObj.drillDownForm('treeNodeForm');

    var url="../sys/organization";
    if(window.operateType=="add"){//增加本级
        url="../sys/organization/save";
    }
    if(window.operateType=="addChild"){//增加下级
        url="../sys/organization/save";
    }
    if(window.operateType=="edit"){//修改
        url="../sys/organization/update";
    }
    if(window.operateType=="delete"){//删除
        url="../sys/organization/delete";
    }
    $.post(url, data, function (response) {
        if(response.status==myJsCommon.FAIL){
            $.messager.alert("警告", myJsCommon.combineErrorMessage(response), "warning");
        }else{
            $.messager.show({
                title : '提示',
                msg : response.message
            });
            if(window.operateType=="add"){//增加本级
                var node=$.zTreeExtendObj.getSelectedNode("tree");
                $.zTreeExtendObj.addNode("tree",node==null?null:node.getParentNode(),data);
            }else if(window.operateType=="addChild"){//增加下级
                $.zTreeExtendObj.addNodeBySelectedNode("tree",data);
            }else if(window.operateType=="edit"){//修改
                $.zTreeExtendObj.updateSelectedNode("tree",data,null);
            }else {//删除
                $.zTreeExtendObj.removeSelectedNode("tree");
            }
            setReadOnlyStatus();
        }
    }, "json");
}
//保存按钮点击事件
function btnSaveClick() {
    if ($("#treeNodeForm").form('validate') && !$(this).linkbutton('options').disabled ) {
        save();
    }
}
//取消按钮点击事件
function btnCancelClick(){
    if(!$(this).linkbutton('options').disabled) {
        onTreeClick(null,null,$.zTreeExtendObj.getSelectedNode("tree"),null);
    }
}
//增加本级按钮点击事件
function btnAddClick(){
    if(!$(this).linkbutton('options').disabled) {
        var node=$.zTreeExtendObj.getSelectedNode("tree");
        $("#treeNodeForm").form('clear');
        window.operateType="add";
        setEditStatus();
        if(node!=null && node.getParentNode()!=null){
            $("#f_parentId").textbox("setValue",node.getParentNode().id);
        }else{
            $("#f_parentId").textbox("setValue","0");
        }
    }
}
//添加子节点
function btnAddChildClick(){
    if(!$(this).linkbutton('options').disabled) {
        var node=$.zTreeExtendObj.getSelectedNode("tree");
        if(null == node){
            $.messager.alert("警告","请首先选择父节点","warning");
        }else{
            $("#treeNodeForm").form('clear');
            window.operateType="addChild";
            setEditStatus();
            $("#f_parentId").textbox("setValue",node.id);
        }
    }
}
//修改按钮点击事件
function btnEditClick(){
    if(!$(this).linkbutton('options').disabled) {
        var node=$.zTreeExtendObj.getSelectedNode("tree");
        if(null == node){
            $.messager.alert("警告","请首先选择父节点","warning");
        }else{
            window.operateType="edit";
            setEditStatus();
        }
    }
}
//删除按钮点击事件
function btnDeleteClick(){
    if(!$(this).linkbutton('options').disabled) {
        var node=$.zTreeExtendObj.getSelectedNode("tree");
        if(null == node){
            $.messager.alert("警告","请首先选择父节点","warning");
        }else{
            window.operateType="delete";
            save();
            setReadOnlyStatus();
        }
    }
}

//TAB页选择事件
function tabSelectHandler(title, index) {

}

$(function() {
    $.fn.zTree.init($("#tree"), setting);

    $("#btnAdd").click(btnAddClick);
    $("#btnAddChild").click(btnAddChildClick);
    $("#btnEdit").click(btnEditClick);
    $("#btnDelete").click(btnDeleteClick);
    $("#btnSave").click(btnSaveClick);
    $("#btnCancel").click(btnCancelClick);

    setReadOnlyStatus();

    $(".datagrid-body").niceScroll({
        cursorcolor : "lightblue", // 滚动条颜色
        cursoropacitymax : 3, // 滚动条是否透明
        horizrailenabled : false, // 是否水平滚动
        cursorborderradius : 0, // 滚动条是否圆角大小
        autohidemode : false // 是否隐藏滚动条
    });
});