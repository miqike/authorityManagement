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
    $.husky.loadForm("treeNodeForm",treeNode);
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
    $("#btnRemove").linkbutton('disable');
    $("#btnStop").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');
    $.husky.setFormStatus("treeNodeForm", 'editable')
}
//设置页面为不可编辑状态
function setReadOnlyStatus(){
    $("#btnAdd").linkbutton('enable');
    $("#btnAddChild").linkbutton('enable');
    $("#btnEdit").linkbutton('enable');
    $("#btnRemove").linkbutton('enable');
    $("#btnStop").linkbutton('enable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');
    $.husky.setFormStatus("treeNodeForm", 'readonly')
}
//通用保存函数
function _save(){
    var data = $.husky.getFormData('treeNodeForm');
    data.nameWithId=data.id+" "+data.name;

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
        if(response.status== $.husky.FAIL){
            $.messager.alert("警告", $.husky.combineErrorMessage(response), "warning");
        }else{
            $.messager.show("操作提醒", response.message, "info", "bottomRight");
            
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
function save() {
    if ($("#treeNodeForm").form('validate') ) {
        _save();
    }
}
//取消按钮点击事件
function cancel(){
    onTreeClick(null,null,$.zTreeExtendObj.getSelectedNode("tree"),null);
}
//增加本级按钮点击事件
function add(){
    var node=$.zTreeExtendObj.getSelectedNode("tree");
    if(null == node) {
    	$.messager.alert("操作提示", "请首先选择同级节点");
    } else {
    	$("#treeNodeForm").form('clear');
    	window.operateType="add";
    	if(node.getParentNode()!=null){
    		var parentId = node.getParentNode().id;
    		$("#f_parentId").val(parentId);
    		$("#f_id").val(parentId);
    	} else {
    		$("#f_parentId").val("0");
    	}
    	setEditStatus();
    }
}
//添加子节点
function addChild(){
    var node=$.zTreeExtendObj.getSelectedNode("tree");
    if(null == node){
        $.messager.alert("操作提示","请首先选择父节点","warning");
    }else{
        $("#treeNodeForm").form('clear');
        window.operateType="addChild";
        $("#f_id").val(node.id);
        $("#f_parentId").val(node.id);
        setEditStatus();
    }
}
//修改按钮点击事件
function edit(){
    var node=$.zTreeExtendObj.getSelectedNode("tree");
    if(null == node){
        $.messager.alert("警告","请首先选择父节点","warning");
    }else{
        window.operateType="edit";
        setEditStatus();
    }
}
//删除按钮点击事件
function remove(){
    var node=$.zTreeExtendObj.getSelectedNode("tree");
    if(null == node){
        $.messager.alert("警告","请首先选择父节点","warning");
    }else{
        window.operateType="delete";
        _save();
        setReadOnlyStatus();
    }
}

//TAB页选择事件
function tabSelectHandler(title, index) {

}

$(function() {
    $.fn.zTree.init($("#tree"), setting);
    setReadOnlyStatus();
});