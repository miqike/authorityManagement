window.currentOperateType="new";
window.operateType={"new":"new","update":"update","delete":"delete","child":"child"};
window.users={};
window.planTreeUrl="../plan/getPlanTreeByParentId";
window.treeId="tree";
window.currentPlanId="";
window.currentNode=null;

var setting = {
    data:{
        key:{
            name:"title"
        },
        simpleData : {
            enable : true,
            idKey : "id", // id编号命名
            pIdKey : "parentId", // 父id编号命名
            rootId : ""
        }
    },
    async: {
        enable: true,
        type: "get",
        url:window.planTreeUrl,
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
    if (window.currentOperateType == window.operateType.new ) {
        onTreeClick(null,null,locateZTreeByKey(window.treeId,"id",window.currentPlanId),null);
    }else if(window.currentOperateType == window.operateType.child){
        var node=locateZTreeByKey(window.treeId,"id",window.currentPlanId);
        onTreeClick(null,null,node,null);
    }else if(window.currentOperateType == window.operateType.delete) {
        onTreeClick(null,null,locateZTree(window.treeId,window.currentNode),null);
    }
}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    if(treeNode!=null) {
        loadForm($("#planForm"), treeNode);
        window.currentOperateType = window.operateType.update;
    }else{
        $("#planForm").form("clear");
        window.currentOperateType = window.operateType.new;
    }
}
//新增或修改
function saveOrUpdate(){
    if($("#planForm").form('validate')){
        var data = drillDownForm("planForm");
        var url = "";
        if (window.currentOperateType == window.operateType.new || window.currentOperateType == window.operateType.child) {
            url = "../plan/new";
            data.createTime = $.fn.datebox.defaults.formatter(new Date());
        } else {
            url = "../plan/update";
        }
        $.post(url, data, function (response) {
            if (response.status == 1) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                window.currentPlanId=response.id;
                if (window.currentOperateType == window.operateType.new ) {
                    refreshZTree(window.treeId,setting,null);
                }else if(window.currentOperateType == window.operateType.child){
                    refreshZTreeBySelectedNode(window.treeId,setting);
                }else{
                    updateZtreeSelectedNode(window.treeId,data);
                }
                return true;
            } else {
                $.messager.alert("错误", response.message);
                return false;
            }
        });
    }else{
        $.messager.show({
            title: '提示',
            msg: "数据不完整！"
        });
        return false;
    }
}
$(function() {
    //初始化树
    $.getJSON(window.planTreeUrl,null, function(response) {
        $.fn.zTree.init($("#tree"), setting, response);
    });
    //取得操作员列表
    $.getJSON("../common/query?mapper=userMapper&queryName=queryUser",null,function(response){
        window.users=response.rows;
        $("#f_authorId").combobox({
            valueField: "id",
            textField: "name",
            data:window.users,
            onSelect:function(record){
                $("#f_authorName").textbox("setValue",record.name);
            }
        });
        $("#f_ownerId").combobox({
            valueField: "id",
            textField: "name",
            data:window.users,
            onSelect:function(record){
                $("#f_ownerName").textbox("setValue",record.name);
                $("#f_deptId").textbox("setValue",record.orgId);
                $("#f_deptName").textbox("setValue",record.orgName);

            }
        });
        $("#f_approverId").combobox({
            valueField: "id",
            textField: "name",
            data:window.users,
            onSelect:function(record){
                $("#f_approverName").textbox("setValue",record.name);
            }
        });
    });
    //保存按钮点击事件
    $("#btnSave").click(saveOrUpdate);
    //取消按钮点击事件
    $("#btnCancel").click(function(){
        var treeNode=getZTreeSelectedNode("tree");
        loadForm($("#planForm"), treeNode);
    });
    //新增按钮点击事件
    $("#btnAdd").click(function(){
        window.currentOperateType=window.operateType.new;
        $("#planForm").form("clear");
    });
    //删除按钮点击事件
    $("#btnDelete").click(function(){
        window.currentOperateType=window.operateType.delete;
        var ztreeNode=getZTreeSelectedNode(window.treeId);
        if(ztreeNode==null){
            $.messager.show({
                title: '提示',
                msg: "请先选择一个计划！"
            });
        }else{
            $.post("../plan/delete",{"id":ztreeNode.id},function(response){
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                if(response.status==1){
                    $("#planForm").form("clear");
                    window.currentNode=ztreeNode.getParentNode();
                    refreshZTree(window.treeId,setting,window.currentNode);
                }
            })
        }
    });
    //添加下级按钮点击事件
    $("#btnAddChild").click(function(){
        window.currentOperateType=window.operateType.child;
        var ztreeNode=getZTreeSelectedNode("tree");
        if(ztreeNode==null){
            $.messager.show({
                title: '提示',
                msg: "请先选择一个计划！"
            });
        }else{
            $("#planForm").form("clear");
            $("#f_parentId").textbox("setValue",ztreeNode.id);
            $("#f_parentName").textbox("setValue",ztreeNode.name);
        }
    });
    //审核按钮点击事件
    $("#btnAudit").click(function(){
        window.currentOperateType=window.operateType.update;
        if($("#f_approveTime").datebox("getValue")!=""){
            $("#f_approveTime").datebox("setValue", "");
        }else {
            $("#f_approveTime").datebox("setValue", new Date().format("yyyy-MM-dd"));
        }
        var flag = saveOrUpdate();
        if (flag) {
            $("#f_approveTime").datebox("setValue", "");
        }
    });
});