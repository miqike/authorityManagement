/**
 * Created by Tommy on 11/28/2014.
 */

function append() {
    if(!$(this).linkbutton('options').disabled) {
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#treeNodeForm").form('clear').form("load", {
                parentId: nodes[0].id,
                parentOrgName: nodes[0].name
            });
            editOrSave();
        } else {
            $.messager.alert("错误", "请首先选择父节点");
        }
    }
}

function remove() {
    if(!$(this).linkbutton('options').disabled) {
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        var nodes = treeObj.getSelectedNodes();
        for (var i=0, l=nodes.length; i < l; i++) {
            var node = nodes[i];
            var id = nodes[i].id;
            $.messager.confirm("确认", "是否确认删除该节点及所有下属节点?", function (r) {
                if (r) {
                    $.getJSON("../master/organization/" + id + "/delete", null, function (response) {
                        if (response.status == 1) {
                            treeObj.removeNode(node);
                        } else {
                            $.messager.alert("错误", response.message);
                        }
                    });
                }
            });
        }
    }
}

function editOrSave () {
    var btn = $("#btnEditOrSave");
    var options = btn.linkbutton("options");

    if(options.text == "编辑") {
        btn.linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });

        $("#treeNodeForm input.easyui-textbox").textbox("enable");
        $("#treeNodeForm input.easyui-combobox").combobox("enable");

    } else {
        btn.linkbutton({
            iconCls:'icon-edit',
            text:'编辑'
        });
        $("#treeNodeForm input.easyui-textbox").textbox("disable");
        $("#treeNodeForm input.easyui-combobox").combobox("disable");

        save();
    }
}

function save() {
    if ($("#treeNodeForm").form('validate')) {
        var data = drillDownForm('treeNodeForm');

        $.each($("#treeNodeForm input:hidden"), function(idx, elem) {
            data.zfbz="0";
            data.auditFlag="0";
            data.chargeFlag="1";
        });
        $.post("../master/organization/" + $("#treeNodeForm input[name='id']").val(), data, function(response) {
            var treeObj = $.fn.zTree.getZTreeObj("tree");
            var nodes = treeObj.getSelectedNodes();
            if (nodes.length>0) {
                var parentId = nodes[0].parentId;
                var parentNode = treeObj.getNodeByParam("id", parentId, null);
                treeObj.reAsyncChildNodes(parentNode, "refresh");
            }
        }, "json");
    }
}

var log, className = "dark";
var setting = {
    data: {key: {
        title:"parentId",
        name:"nameWithId"
    }},
    async: {
        enable: true,
        type: "get",
        url:"../master/organization",
        autoParam:["id"],
        dataFilter: filter
    },
    callback: {
        beforeClick: beforeClick,
        onClick: onClick
    }
};

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
    $("#treeNodeForm").form("load", treeNode);
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var parentId = treeNode.parentId;
    if(parentId != 0) {
        var parentNode = treeObj.getNodeByParam("id", parentId, null);

        $("#treeNodeForm input[textboxname=parentOrgName]").textbox("setValue", parentNode.name);
    }
    $("#btnAdd").linkbutton('enable');
    $("#btnEditOrSave").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');
    $("#treeNodeForm input.easyui-textbox").textbox("disable");
    $("#treeNodeForm input.easyui-combobox").combobox("disable");
}

function showOrgCode() {
    //nodes[i].name = nodes[i].name.replace(/_[\d]*$/g, "") + "_" + (nameCount++);
    //parentNode.name = parentNode.name + " - " + 'sssssss';
    //console.log(parentNode)
    //treeObj.updateNode(parentNode);
}
$(function () {
    $("#treeNodeForm").form('clear')
    $.fn.zTree.init($("#tree"), setting);
    $("#btnAdd").click(append);
    $("#btnEditOrSave").click(editOrSave);
    $("#btnDelete").click(remove);
    $("#whetherShowOrgCode").change(showOrgCode);

})