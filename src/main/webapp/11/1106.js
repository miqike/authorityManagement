window.queryChild = false;

function levelExpandTree(newValue, oldValue) {
    levelExpand($.fn.zTree.getZTreeObj("orgTree"), newValue);
}

//查询用户
function queryUser() {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes()

    if (selected.length == 1) {
        var options = $("#mainGrid").datagrid("options");
        options.url = '../common/query?mapper=userMapper&queryName=queryUserForOrg';
        $('#mainGrid').datagrid('load', {
            organization: processorOrgId(selected[0].id)
        });

    } else {
    }

}

function onExpand(event, treeId, treeNode) {
    checkAuthorizedResourceNode(treeNode);
}

function checkAuthorizedResourceNode(treeNode) {
    var disable = true;
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var nodes;

    if (treeNode == undefined) {
        nodes = treeObj.getNodes();
    } else {
        nodes = treeNode.children;
    }

    if (nodes.length > 0) {
        $.each(nodes, function (idx, node) {
            //treeObj.setChkDisabled(node, false);
            if (_.contains(window.ownedResources, node.id)) {
                //treeObj.checkNode(node, true);
                treeObj.showNode(node);
            } else {
                //treeObj.checkNode(node, false);
                treeObj.hideNode(node);
            }
            //treeObj.setChkDisabled(node, disable);
            if (node.isParent) {
                checkAuthorizedResourceNode(node)
            }
        })
    }
}
//更新单位树
function refreshOrgTree() {
    var setting = {
        data: {
            key: {
                title: "parentId",
                name: "nameWithId"
            }
        },
        async: {
            enable: true,
            type: "get",
            url: "../sys/organization/getSub",
            autoParam: ["id"]
        },
        callback: {
            onClick: function (event, treeId, treeNode) {
                $("#deptGrid").datagrid("loadData",[]);
                queryUser();
            }
        }
    };

    $.fn.zTree.init($("#orgTree"), setting);
}

//单位选择
function selectOrganization() {
    var setting = {
        data: {
            key: {
                title: "parentId",
                name: "nameWithId"
            }
        },
        async: {
            enable: true,
            type: "get",
            url: "../sys/organization/getSub",
            autoParam: ["id"]
        },
        callback: {
            beforeClick: function (treeId, treeNode, clickFlag) {
            	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
            	var exists = $("#deptGrid").datagrid("getData").rows;
        		var validate = idDescent(treeObj, treeNode, exists);
        		if(validate == -1) {
        			$.messager.alert("操作提示", "已经设置了该单位权限");
        			return false;
        		} else if(validate == -2) {
        			$.messager.alert("操作提示", "已经设置了上级单位权限");
        			return false;
        		} else {
        			return true;
        		}
            },
            
            onClick: function () {
                var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
                var selected = treeObj.getSelectedNodes();
                if (selected.length == 1) {
               		$("#btnOrganizationSelect").linkbutton("enable");
                } else {
                    $("#btnOrganizationSelect").linkbutton("disable");
                }
            }
        }
    };

    $.fn.zTree.init($("#orgTreeSelect"), setting);
    $('#organizationSelectDialog').dialog('open');
}

function idDescent(treeObj, treeNode, exists) {
	var result = 0;
	for(var i=0; i<exists.length; i++) {
		result = _idDescent(treeObj, treeNode, exists[i]);
		if(result < 0) {
			break;
		}
	}
	
	return result;
}

function _idDescent(treeObj, treeNode, exist) {
	var result = 0;
	if(treeNode.id == exist.orgId) {
		result = -1;
	} else {
		var parent = treeNode.getParentNode();
		debugger;
		while(parent != null) {
			if(parent.id == exist.orgId) {
				result = -2;
				break;
			} else {
				parent = parent.getParentNode();
			}
			
		}
	}
	return result;
}

function organizationSelect() {
    //if(validate()) {
	var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
    var selected = treeObj.getSelectedNodes();
    var datas = new Array();
    var user = $("#mainGrid").datagrid("getSelected");
    for (var i = 0; i < selected.length; i++) {
        var data = {};
        data.userId = user.userId;
        data.userName = user.name;
        data.orgId = selected[i].id;
        data.orgName = selected[i].name;
        datas.push(data);
    }

	$.ajax({
        url: "../11/1106/batch",
        type: "POST",
        data: JSON.stringify(datas),
        dataType: "json",
        contentType: 'application/json;charset=utf-8',
        success: function (response) {
            if (response.status == SUCCESS) {
                refreshDeptGrid();
                $('#organizationSelectDialog').dialog('close');
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });
    //}
}

function expandNodes(zTree, nodes) {
    if (!nodes) return;
    for (var i = 0, l = nodes.length; i < l; i++) {
        zTree.expandNode(nodes[i], true, false, false, true);
        if (nodes[i].isParent && nodes[i].zAsync) {
            expandNodes(zTree, nodes[i].children);
        }
    }
}
function expandAll(e) {
    var zTree = $.fn.zTree.getZTreeObj("tree"),
        type = e.data.type,
        nodes = zTree.getSelectedNodes();
    if (type.indexOf("All") < 0 && nodes.length == 0) {
        alert("请先选择一个父节点");
    }
    if (type == "expandAll") {
        expandNodes(zTree, zTree.getNodes());
        checkAuthorizedResourceNode();
    } else if (type == "collapseAll") {
        zTree.expandAll(false);
    }

}

//刷新授权单位网格
function refreshDeptGrid() {
    var user = $("#mainGrid").datagrid("getSelected");
    if (user != null) {
        var options = $('#deptGrid').datagrid('options');
        options.url = '../common/query?mapper=userOrgMapper&queryName=query';
        options.queryParams = {
            userId: user.userId
        };
        $("#deptGrid").datagrid(options);
    }
}
$(function () {
    //取得登录用户信息
    getUserInfo();
    if (null != window.userInfo) {
        refreshOrgTree();
    } else {
        $.subscribe("USERINFO_INITIALIZED", refreshOrgTree);
    }

    $("#deptGrid").datagrid("loadData", []);
    $("#mainGrid").datagrid("loadData", []);
    $("#mainGrid").datagrid({"singleSelect": "true"}).datagrid({
        onSelect: function (index, row) {
            refreshDeptGrid();
        },
        onUnselect: function (index, row) {
            $("#deptGrid").datagrid("loadData", []);
        }
    });

    $("#btnReset").click(function () {
        if (!$(this).linkbutton('options').disabled) {
            $("#f_name").val('');
            var dg = $('#mainGrid');
            dg.datagrid('disableFilter');
            $("#btnSearch").linkbutton('enable');
            var treeObj = $.fn.zTree.getZTreeObj("orgTree");
            var selected = treeObj.getSelectedNodes()[0];

            $('#mainGrid').datagrid('load', {
                organization: selected.ba01861
            });
        }
    });

    $("#btnAdd").click(selectOrganization);
    $("#btnOrganizationSelect").click(organizationSelect);
    $("#btnDelete").click(function () {
        var depts = $("#deptGrid").datagrid("getSelections");
        var user = $("#mainGrid").datagrid("getSelected");
        var datas = new Array();
        for (var i = 0; i < depts.length; i++) {
            var data = {};
            data.userId = user.userId;
            data.userName = user.name;
            data.orgId = depts[i].orgId;
            data.orgName = depts[i].orgName;
            datas.push(data);
        }
        $.ajax({
            url: "../11/1106/batch",
            type: "DELETE",
            data: JSON.stringify(datas),
            dataType: "json",
            contentType: 'application/json;charset=utf-8',
            success: function (response) {
                if (response.status == SUCCESS) {
                    refreshDeptGrid();
                } else {
                    $.messager.alert('失败', response.message, 'info');
                }
            }
        });
    });

    $("#btnSearch").click(function () {
        if (!$(this).linkbutton('options').disabled) {
            var treeObj = $.fn.zTree.getZTreeObj("orgTree");
            var selected = treeObj.getSelectedNodes()[0];

            $('#mainGrid').datagrid('load', {
                name: encodeURI($('#f_name').val()),
                organization: selected.ba01861
            });
        }
    });


});