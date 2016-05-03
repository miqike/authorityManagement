/**
 * Created by Tommy on 11/28/2014.
 */

function save() {
    var tree = $.fn.zTree.getZTreeObj("tree");
    var id = tree.getSelectedNodes()[0].id;

    var treeB = $.fn.zTree.getZTreeObj("treeB");
    //var callbackFlag = $("#callbackTrigger").attr("checked");
    var nodes = treeB.getChangeCheckedNodes();
    var removed = new Array(), appended = new Array();
    $.each(nodes, function(idx, elem) {
        if(elem.checked) {
            appended.push(elem.id);
        } else {
            removed.push(elem.id);
        }
    });

    $.post("../master/feeOfTollItemType/" + id, {
        removed: removed.join(","),
        appended: appended.join(",")
    }, function(response) {
    });


}

var log, className = "dark";
var setting = {
    key: {
        title:"t"
    },
    async: {
        enable: true,
        type: "get",
        url:"../master/tollItemType",
        autoParam:["id"]/*,
        dataFilter: filter*/
    },
    callback: {
        beforeClick: beforeClick,
        onClick: onClick
    },
    simpleData: {
        enable:true,
        rootPid: "0"
    }
};

var settingB = {
    key: {
        title:"t"
    },
    async: {
        enable: true,
        type: "get",
        url:"../master/fee",
        autoParam:["id"]/*,
        dataFilter: filter*/
    },
    callback: {
        onAsyncSuccess: zTreeOnAsyncSuccess
    },
    check: {
        enable: true
    }
};

function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
    if(treeNode != null && treeNode.children.length > 0 ) {
        var tree = $.fn.zTree.getZTreeObj("tree");
        try {
            var id = tree.getSelectedNodes()[0].id;
            xxx(window.model.tollItemOfTollItemType[id]);
        } catch (e) {
        }

    }

}

function filter(treeId, parentNode, childNodes) {
    if (!childNodes) return null;
    for (var i=0, l=childNodes.length; i<l; i++) {
        childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
    }
    return childNodes;
}

function beforeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}

function onClick(event, treeId, treeNode, clickFlag) {
    var id = treeNode.id;
    $("#btnSave").linkbutton('enable');
    if(window.model.tollItemOfTollItemType[id] == undefined) {
        $.getJSON("../master/tollItemOfTollItemType/" + id, null, function (response) {

            window.model.tollItemOfTollItemType[id] = response.data;

            xxx(window.model.tollItemOfTollItemType[id]);
            /*var zTree = $.fn.zTree.getZTreeObj("treeB");
            zTree.checkAllNodes(false);
            $.each(response.data, function (idx, elem) {
                checkNode(zTree, elem.superviseeId)
            });*/
        });
    } else {
        xxx(window.model.tollItemOfTollItemType[id]);
    }
}

function xxx(tollItemOfTollItemType) {
    var zTree = $.fn.zTree.getZTreeObj("treeB");
    zTree.checkAllNodes(false);
    $.each(tollItemOfTollItemType, function (idx, elem) {
        checkNode(zTree, elem);
    });
}

function checkNode(zTree, id) {
    //var callbackFlag = $("#callbackTrigger").attr("checked");
    var node = zTree.getNodeByParam("id", id);
    if(null != node) {
        zTree.checkNode(node, true, false, null);
        node.checkedOld = node.checked;
    }
}

$(function () {
    window.model = {
        tollItemOfTollItemType: []
    };
    $.fn.zTree.init($("#tree"), setting);
    $.fn.zTree.init($("#treeB"), settingB);
    $("#btnSave").click(save);

})