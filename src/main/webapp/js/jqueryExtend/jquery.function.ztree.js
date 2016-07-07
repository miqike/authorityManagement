jQuery.zTreeExtendObj = {
    //更新选定节点
    updateSelectedNode:function (treeId,data,callBack){
    	console.log("jQuery.zTreeExtendObj.updateSelectedNode")
    	console.log(treeId)
    	console.log(data)
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        var node=this.getSelectedNode(treeId);

        for(var key in data){
            node[key]=data[key];
        }
        treeObj.updateNode(node);

        if(callBack){
            callBack(node);
        }
    },
    //取得当前选中节点
    getSelectedNode:function (treeId){
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        if(null != treeObj) {
            var nodes = treeObj.getSelectedNodes();
            return nodes.length>0?nodes[0]:null;
        } else {
            return null;
        }
    },
    //定位到指定节点
    locate:function (treeId,startNode,callBack){
        var node=startNode;
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        if(null ==node){
            node=treeObj.getNodes()[0];
            treeObj.selectNode(node);
        }else{
            treeObj.selectNode(node);
        }
        if(callBack){
            callBack(node);
        }
        return node;
    },
    //根据节点的KEY进行定位
    locateByKey:function (treeId,key,value,parentNode,callBack){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var node = ztreeObj.getNodeByParam(key,value,parentNode);
        if(null ==node){
            ztreeObj.selectNode(parentNode);
        }else{
            ztreeObj.selectNode(node);
        }
        if(callBack){
            callBack(node);
        }
        return node;
    },
    //在指定节点下增加单个节点
    addNode:function(treeId,parentNode,newNode){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var locateNode=ztreeObj.addNodes(parentNode,newNode,false);
        ztreeObj.selectNode(locateNode[0]);
    },
    //在指定节点下增加多个节点
    addNodes:function(treeId,parentNode,newNodes){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var locateNode=ztreeObj.addNodes(parentNode,newNodes,false);
        ztreeObj.selectNode(locateNode[0]);
    },
    //在选定节点下增加单个节点
    addNodeBySelectedNode:function(treeId,newNode){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var locateNode=ztreeObj.addNodes(this.getSelectedNode(treeId),newNode,false);
        ztreeObj.selectNode(locateNode[0]);
    },
    //在定节节点下增加多个节点
    addNodesBySelectedNode:function(treeId,newNodes){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var locateNode=ztreeObj.addNodes(this.getSelectedNode(treeId),newNodes,false);
        ztreeObj.selectNode(locateNode[0]);
    },
    //删除指定节点
    removeNode:function(treeId,node){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        ztreeObj.removeNode(node);
        if(node.getParentNode()!=null){
            ztreeObj.selectNode(node.getParentNode());
        }else{
            var nodes=ztreeObj.getNodes();
            if(nodes.length>0){
                ztreeObj.selectNode(nodes[0]);
            }
        }
    },
    //删除选定节点
    removeSelectedNode:function(treeId){
        var ztreeObj = $.fn.zTree.getZTreeObj(treeId);
        var node=this.getSelectedNode(treeId);
        ztreeObj.removeNode(node);
        if(node.getParentNode()!=null){
            ztreeObj.selectNode(node.getParentNode());
        }else{
            var nodes=ztreeObj.getNodes();
            if(nodes.length>0){
                ztreeObj.selectNode(nodes[0]);
            }
        }
    }
};
