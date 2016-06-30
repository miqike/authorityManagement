/**
 * Created by Tommy on 11/28/2014.
 */

function tabSelectHandler(title, index) {
    var id = $("#f_id").textbox("getValue");
    if(index == 1) { //选择角色TAB
        if(id != "") {
            $.getJSON("../common/query?mapper=roleMapper&queryName=queryRole", {}, function(response) {
                $("#roleGrid").datagrid("loadData", response.rows);
                $.getJSON("../common/query?mapper=roleResourcePermissionMapper&queryName=queryByResourceId", {resourceId: id}, function(responseA) {
                    $.each(response.rows, function(idx, rowData) {
                        if(_.contains(responseA.rows, rowData.id)) {
                            rowData.ck = "true";
                            $('#roleGrid').datagrid('checkRow', idx);
                        }
                    });
                    $("#roleGrid").parent().find("input:checkbox").attr("disabled", true);
                });
            });
        } else {
            $.messager.alert("操作错误", "请先选择资源信息");
            $('#tabPanel').tabs('select',0 );
        }
    } else if (index == 2) { //选择用户TAB
        if(id != "") {
            var options = $('#userGrid').datagrid('options');
            options.url = '../common/query?mapper=userMapper&queryName=queryByResourceId';
            options.queryParams.resourceId = id;
            $("#userGrid").datagrid("reload");
        } else {
            $.messager.alert("操作错误", "请先选择资源信息");
            $('#tabPanel').tabs('select',0 );
        }
    }
}

function roleGridButtonHandler() {
    if($('#roleGrid').datagrid('getSelected') != null) {
        $('#btnEditOrSaveResourceRole').linkbutton('enable');
    } else {
        $('#btnEditOrSaveResourceRole').linkbutton('disable');
    }
}

function _add(sibling) {
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var nodes = treeObj.getSelectedNodes();
    var selectedNode = nodes[0];
    $("#treeNodeForm input.easyui-textbox").textbox("enable");
    $("#treeNodeForm input.easyui-combobox").combobox("enable");

    if(sibling) {
        $("#parentIds").textbox("setValue", selectedNode.parentIds).textbox("disable");
        $("#parentId").textbox('setValue', selectedNode.parentId).textbox("disable");
    } else {
        $("#parentIds").textbox("setValue", selectedNode.parentIds + selectedNode.id + "/");
        $("#parentId").textbox('setValue', selectedNode.id).textbox("disable");
    }
    setParentName();

    $("#btnEditOrSave").linkbutton({
        iconCls:'icon-save',
        text:'保存'
    });
    $("#btnAddSibling").linkbutton("disable");
    $("#btnAddChild").linkbutton("disable");
    $("#btnDelete").linkbutton("disable");
}

function addSibling() {
    _add(true);
}

function addChild() {
    _add(false);
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
                    $.ajax({
                        url: "../sys/resource/" + id ,
                        type: 'DELETE',
                        success: function(response) {
                            if (response.status == 1) {
                                treeObj.selectNode(node.getParentNode());
                                treeObj.removeNode(node);
                                $("#treeNodeForm").form("clear");
                            } else {
                                $.messager.alert("错误", response.message);
                            }
                        }
                    });
                }
            });
        }
    }
}

function editOrSave () {
    if( $("#btnEditOrSave").linkbutton("options").text == "编辑") {
        $("#btnEditOrSave").linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });

        $("#treeNodeForm input.easyui-textbox").textbox("enable");
        $("#parentIds").textbox("disable");
        $("#treeNodeForm input.easyui-combobox").combobox("enable");
    } else {
        $("#btnEditOrSave").linkbutton({
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
        var data = $.husky.getFormData('treeNodeForm');
        $.each($("#treeNodeForm input:hidden"), function(idx, elem) {
            data.zfbz="0";
            data.auditFlag="0";
            data.chargeFlag="1";
        });
        console.log(data)
        $.post("../sys/resource/" + $("#treeNodeForm input[name='id']").val(), data, function(response) {
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
        url:"../sys/resource",
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

    $("#btnEditOrSave").linkbutton({
        iconCls:'icon-edit',
        text:'编辑'
    });
    $("#treeNodeForm input.easyui-textbox").textbox("disable");
    $("#treeNodeForm input.easyui-combobox").combobox("disable");

    return (treeNode.click != false);
}

function onClick(event, treeId, treeNode, clickFlag) {
    event.preventDefault();
    $("#treeNodeForm").form("load", treeNode);
    if(treeNode.icon == null && treeNode.iconSkin != null) {
        $("#f_icon").textbox("setValue", treeNode.iconSkin);
    }
    $("#btnAddSibling").linkbutton('enable');
    $("#btnAddChild").linkbutton('enable');
    $("#btnEditOrSave").linkbutton('enable');
    $("#btnDelete").linkbutton('enable');

    var parent_id = treeNode._parentId;
    setParentName(parent_id);

    $("#treeNodeForm input.easyui-textbox").textbox("disable");
    $("#treeNodeForm input.easyui-combobox").combobox("disable");
    $('#tabPanel').tabs('select',0 );
}

function setParentName(parent_id) {
	$("#f_parentId").textbox("setValue", parent_id);
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var parentNode = treeObj.getNodesByParam("id", $("#f_parentId").textbox("getValue"), null);
    if(parentNode.length == 1) {
        $("#f_parentName").textbox("setValue", parentNode[0].name).textbox("disable");
    } else {
        $("#f_parentName").textbox("setValue", "").textbox("disable");
    }
}

function saveResourceRole() {
    var checkedRows = $('#roleGrid').datagrid('getChecked');
    var param = new Array();
    $.each(checkedRows, function(idx, elem) {
        param.push(elem.id);
    });

    $.ajax({
        url:"../sys/resource/role/" + $("#f_id").textbox("getValue"),
        data:JSON.stringify(param),
        type:"post",
        contentType: "application/json; charset=utf-8",
        cache:false,
        success: function(response) {
            if(response.status == $.husky.SUCCESS) {
                //$.messager.alert("提示", "角色授权成功");
				$.messager.show('提示',"角色授权成功","info", "bottomRight");
            } else {
                $.messager.alert("错误", "角色授权失败");
            }
        }
    });
}

function editOrSaveResourceRole() {
    if( $("#btnEditOrSaveResourceRole").linkbutton("options").text == "编辑") {
        $("#btnEditOrSaveResourceRole").linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });
        $("#roleGrid").parent().find("input:checkbox").attr("disabled", false);
    } else {
        $("#btnEditOrSaveResourceRole").linkbutton({
            iconCls:'icon-edit',
            text:'编辑'
        });
        saveResourceRole();
        $("#roleGrid").parent().find("input:checkbox").attr("disabled", true);
    }
}

$(function () {
    $("#treeNodeForm").form('clear');
    $.fn.zTree.init($("#tree"), setting);
    $("#btnAddSibling").click(addSibling);
    $("#btnAddChild").click(addChild);
    $("#btnEditOrSave").click(editOrSave);
    $("#btnDelete").click(remove);
    $("#btnEditOrSaveResourceRole").click(editOrSaveResourceRole);

    $(".datagrid-body").niceScroll({
        cursorcolor : "lightblue", // 滚动条颜色
        cursoropacitymax : 3, // 滚动条是否透明
        horizrailenabled : false, // 是否水平滚动
        cursorborderradius : 0, // 滚动条是否圆角大小
        autohidemode : false // 是否隐藏滚动条
    });
})