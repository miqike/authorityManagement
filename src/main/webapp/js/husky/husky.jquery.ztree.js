//更新选定节点
function updateZtreeSelectedNode(treeId,data){
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    var node=getZTreeSelectedNode(treeId);

    for(var key in data){
        node[key]=data[key];
    }
    treeObj.updateNode(node);
}
//取得当前选中节点
function getZTreeSelectedNode(treeName){
    var treeObj = $.fn.zTree.getZTreeObj(treeName);
    if(null != treeObj) {
        var nodes = treeObj.getSelectedNodes();
        return nodes[0];
    } else {
        return null;
    }
}
//从指定节点刷新树
function refreshZTree(treeId,setting,startNode){
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    if (null != startNode) {
        treeObj.reAsyncChildNodes(startNode, "refresh");
        treeObj.expandNode(startNode, true,true, true, true);
        if(startNode.children.length>0){
            startNode.isParent=true;
        }else{
            startNode.isParent=false;
        }
    }else{
        $.fn.zTree.init($("#"+treeId), setting);
    }
}
//从选定节点开始刷新树，添加子节点后调用
function refreshZTreeBySelectedNode(treeId,setting){
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    var ztreeNode=getZTreeSelectedNode(treeId);
    ztreeNode.isParent=true;
    if (null != ztreeNode) {
        treeObj.reAsyncChildNodes(ztreeNode, "refresh");
        treeObj.expandNode(ztreeNode, true,true, true, true);
    }else{
        $.fn.zTree.init($("#"+treeId), setting);
    }
}
//定位到指定节点
function locateZTree(treeId,startNode){
    var node=startNode;
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    if(null ==node){
        node=treeObj.getNodes()[0];
        treeObj.selectNode(node);
    }else{
        treeObj.selectNode(node);
    }
    return node;
}
//根据节点的KEY进行定位
function locateZTreeByKey(treeId,key,value){
    var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
    var node = ztreeObj.getNodeByParam(key,value,null);
    if(null ==node){
        node=ztreeObj.getNodes()[0];
        ztreeObj.selectNode(node);
    }else{
        ztreeObj.selectNode(node);
    }
    return node;
}