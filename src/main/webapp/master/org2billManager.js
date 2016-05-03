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
                    $.getJSON("../master/fee/" + id + "/delete", null, function (response) {
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
        var data = {};
        $.each($("#treeNodeForm input.easyui-textbox"), function(idx, elem) {
            data[$(elem).attr("textboxname")] = $(elem).textbox("getValue");
        });
        $.each($("#treeNodeForm input.easyui-combobox"), function(idx, elem) {
            data[$(elem).attr("textboxname")] = $(elem).combobox("getValue");
        });

        $.each($("#treeNodeForm input:hidden"), function(idx, elem) {
            data.zfbz="0";
            data.auditFlag="0";
            data.chargeFlag="1";
        });
        $.post("../master/fee/" + $("#treeNodeForm input[name='id']").val(), data, function(response) {
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
    key: {
        title:"name"
    },
    async: {
        enable: true,
        type: "get",
        url:"../master/billManager",
        autoParam:["id"]//,
        //otherParam:{"otherParam":"zTreeAsyncTest"},
        //dataFilter: filter
    },
    callback: {
        //beforeClick: beforeClick,
        onClick: onClick
    }
};

/*function filter(treeId, parentNode, childNodes) {
    if (!childNodes) return null;
    for (var i=0, l=childNodes.length; i<l; i++) {
        childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
    }
    return childNodes;
}*/

function beforeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}

function onClick(event, treeId, treeNode, clickFlag) {
    if(treeNode.id == -1){

    }
   /* var treeObj = $.fn.zTree.getZTreeObj("tree");
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

    $.getJSON("../common/query?mapper=billTypeMapper&queryName=queryBillTypeOfTollItem", {id: treeNode.id}, function(response) {
        $("#grid").datagrid("loadData", response.rows);
    });*/
}

function tabSelectHandler(title, index) {
    //var row = $('#mainGrid').datagrid('getSelected');
    if(index == 1) { //选择角色TAB

       /* $.getJSON("../common/query?mapper=roleMapper&queryName=queryRole", {}, function(response) {
            $("#grid2").datagrid("loadData", response.rows);

            $.getJSON("../user/" + row.userId + "/role", {}, function(responseA) {
                $.each(response.rows, function(idx, rowData) {
                    if(_.contains(responseA.data, rowData.id)) {
                        rowData.ck = "true";
                        $('#grid2').datagrid('checkRow', idx);
                    }
                });
                $("#grid2").parent().find("input:checkbox").attr("disabled", true);
            });
        });
*/
    } else if (index == 2) { //选择权限TAB
     /*   url:'../common/query?mapper=tollItemMapper&queryName=queryBillTypeOfTollItem'
        $.getJSON("../user/" + row.userId + "/resource", {}, function(responseA) {
            window.ownedResources = responseA.data;
            $("#tg").treegrid({
                url: '../sys/resource',
                onLoadSuccess: fillResourceCheckbox
            });
        });*/
    }
}


$(function () {
    $("#treeNodeForm").form('clear')
    $.fn.zTree.init($("#tree"), setting);
    $("#btnAdd").click(append);
    $("#btnEditOrSave").click(editOrSave);
    $("#btnDelete").click(remove);
    //$("#btnCancel").click(cancel);

})