<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function userPermissionGridButtonHandler() {
    var udpr = $('#userPermissionGrid').datagrid('getSelected');
	if(udpr != null) {
		$('#btnEditDataPermission').linkbutton('enable');
        if(udpr.ACLTYPE != undefined && udpr.ACLTYPE != 0) {
            $('#btnShowAcl').linkbutton('enable');
        } else {
            $('#btnShowAcl').linkbutton('disable');
        }
	} else {
		$('#btnEditDataPermission').linkbutton('disable');
		$('#btnShowAcl').linkbutton('disable');
	}
}

function grid5ButtonHandler() {
    var rule = $('#grid5').datagrid('getSelected');
	if(rule != null && rule.isDefault != 1) {
		$('#btnDataPermRuleSelect').linkbutton('enable');
	} else {
		//$('#btnDataPermRuleSelect').linkbutton('disable');
	}
}

function formatDefaultFlag(val, row) {
    var _val = parseInt(val);
    if(_val == 1) {
        return "<img src='../images/star.png'/>";
    } else if(_val == 0) {
        return "<img src='../images/wrench_orange.png'/>";
    } else {
        return "";
    }
}

function loadUserRoleGrid() {
	$.getJSON("../sys/user/role1/" + $('#p_userId').val(), {}, function(responseA) {
		$("#userRoleGrid").datagrid("loadData", responseA.data);
	});
}

function loadUserPermissionGrid() {
    $.getJSON("../common/query?mapper=userDataPermissionRuleMapper&queryName=query", {"pUserId":$("#p_userId").val()}, function(response) {
        $("#userPermissionGrid").datagrid("loadData", response.rows);
    });
}

function checkAuthorizedResourceNode(treeNode) {
	var disable = true;
	var treeObj = $.fn.zTree.getZTreeObj("resTree");
	var nodes;
	if(treeNode == undefined) {
		nodes = treeObj.getNodes();
	} else {
		nodes = treeNode.children;
	}
	if(nodes.length > 0) {
		$.each(nodes, function(idx, node) {
			//treeObj.setChkDisabled(node, false);
			if(_.contains(window.ownedResources, node.id)) {
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

function showUserRoleCandidateDialog() {
	$.easyui.showDialog({
		title : "选择角色",
		width : 600,
		height : 300,
		topMost : false,
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./candidateUserRoleSelectDialog.jsp",
		onLoad : function() {
			loadCandidateUserRoleGrid();
		},
		onSave : function() {
			addUserRole();
			return false;
		}
	});
	
}

function deleteUserRole() {
	var rows = $("#userRoleGrid").datagrid("getSelections")
	if(rows.length > 0) {
		$.messager.confirm("确认", "是否要删除选中的用户角色?", function (r) {
			if (r) {
				var param = new Array();
				$.each(rows, function(idx, elem) {
					param.push(elem.id);
				});

				$.ajax({
					url:"../sys/user/role2/" + $('#mainGrid').datagrid('getSelected').userId,
					data:JSON.stringify(param),
					type:"put",
					contentType: "application/json; charset=utf-8",
					cache:false,
					success: function(response) {
						if(response.status == $.husky.SUCCESS) {
							$.messager.show("操作提醒", "删除用户角色成功", "info", "bottomRight");
							loadUserRoleGrid();
						} else {
							$.messager.alert("错误", "删除用户角色失败");
						}
					}
				});
			}
		});
		
	} else {
		$.messager.alert("操作提示", "请首先选择需要删除的用户角色!", "error");
	}
}

function initResTree(){
	var setting = {
		data: {key: {
			title:"parentId",
			name:"nameWithId"
		}},
		check: {
			enable: false
			//enable: true
		},
		async: {
			enable: true,
			type: "get",
			url:"../sys/resource",
			autoParam:["id"]
		},
		callback: {
			onExpand: onExpand,
			beforeAsync: beforeAsync,
			onAsyncSuccess: onAsyncSuccess,
			onAsyncError: onAsyncError
		}
	};

	$.fn.zTree.init($("#resTree"), setting);
}

function onExpand(event, treeId, treeNode) {
	checkAuthorizedResourceNode(treeNode);
}

function expandAll(e) {
	_expandAll("expandAll");
}

function collapseAll() {
	_expandAll("collapseAll");
}

function _expandAll(type) {
	var zTree = $.fn.zTree.getZTreeObj("resTree"),
		nodes = zTree.getSelectedNodes();
	if (type.indexOf("All")<0 && nodes.length == 0) {
		alert("请先选择一个父节点");
	}
	if (type == "expandAll") {
		expandNodes(zTree, zTree.getNodes());
		checkAuthorizedResourceNode();
	} else if (type == "collapseAll") {
		zTree.expandAll(false);
	}
}

function expandNodes(zTree, nodes) {
	if (!nodes) return;
	for (var i=0, l=nodes.length; i<l; i++) {
		zTree.expandNode(nodes[i], true, false, false, true);
		if (nodes[i].isParent && nodes[i].zAsync) {
			expandNodes(zTree,  nodes[i].children);
		}
	}
}

$(function() {
	initResTree();
});
	
</script>
<div id="userWindow">
    <div id="tabPanel" class="easyui-tabs" style="width:755px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="userTable">
                <tr>
                    <td class="label">单位编码</td>
                    <td><input class="easyui-validatebox" id="p_orgId" data-options="required:true,iconWidth: 20,
                        icons: [{
                            iconCls:'icon2 r22_c16',
                            handler: selectOrganization
                        }]" style="width:200px;" disabled/></td>
                </tr>
                <tr>
                    <td class="label">单位名称</td>
                    <td colspan="3">
                        <input id="p_orgName" class="easyui-validatebox" style="width:577px;" data-options="required:true"  disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="label">用户代码</td>
                    <td><input class="easyui-validatebox add" id="p_userId" type="text"
                               data-options="required:true,disabled:true" style="width:200px;"/>
                    </td>
                    <td class="label">用户姓名</td>
                    <td><input class="easyui-validatebox add update" id="p_name" data-options="required:true" style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">电话</td>
                    <td>
                        <input class="easyui-validatebox add update" id="p_mobile" style="width:200px;" data-options=""/>
                    </td>
                    <td class="label">邮箱</td>
                    <td><input class="easyui-validatebox add update" validType="email" id="p_email" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">状态</td>
                    <td>
                        <input id="p_status" class="easyui-combobox add update" style="width:208px;" data-options="required:true,panelHeight:80" codeName="userStatus"/>
                    </td>
                    <td class="label">排名</td>
                    <td>
                        <input id="p_weight" class="easyui-numberspinner add update" style="width:208px;" data-options="required:false" />
                    </td>
                </tr>
                <tr>
                    <td class="label">扩展</td>
                    <td>
                        <input id="p_ext1" class="easyui-validatebox add update" style="width:208px;" data-options="required:true,panelHeight:80" validType="integer"/>
                    </td>
                </tr>
            </table>
        </div>
        <div title="所属角色" >
            <table id="userRoleGrid"
                   class="easyui-datagrid"
                   data-options="
                       ctrlSelect:true,
                       collapsible:true">
                <thead>
                <tr>
                    <%--<th data-options="field:'ck',checkbox:true,disabled:true"></th>--%>
                    <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th>
                    <th data-options="field:'role'" halign="center" align="center" width="100">角色代码</th>
                    <th data-options="field:'name'" halign="center" align="center" width="100">角色名称</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="roleStatus"
                        formatter="formatCodeList">状态</th>
                    <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
                </tr>
                </thead>
            </table>
        </div>
        
        <div title="功能权限列表" style="width:700px;padding:5px;">
            <a href="#" id="btnExpandAll" class="easyui-linkbutton" iconCls="icon-plus" plain="true">展开</a>
            <a href="#" id="btnCollapseAll" class="easyui-linkbutton" iconCls="icon-minus" plain="true">缩回</a>
            <ul id="resTree" class="ztree"></ul>
        </div>
<!-- 
        <div title="数据权限"">
            <table id="userPermissionGrid"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       onClickRow:userPermissionGridButtonHandler,
                       checkOnSelect:false"
                   	toolbar="#userPermissionGridToolbar" >
                <thead>
                <tr>
                    <th data-options="field:'ISDEFAULT'" align="left" width="30" formatter="formatDefaultFlag"></th>
                    <th data-options="field:'DATAPERMID'" align="left" width="100">数据权限标识</th>
                    <th data-options="field:'DATAPERMDESC'" align="left" width="100">描述</th>
                    <th data-options="field:'DATAPERMRULEEXP'" align="left" width="150">规则表达式</th>
                    <th data-options="field:'ACLTYPE',halign:'center'" align="left" width="70" codeName="aclType" formatter="formatCodeList">ACL</th>
                    <th data-options="field:'DATAPERMRULEDESC',halign:'center',align:'left'" sortable="true" width="250">规则描述</th>
                    <th data-options="field:'ACL'" align="left" width="320">ACL列表</th>
                </tr>
                </thead>
            </table>
        </div> 
    </div>
    <div id="userPermissionGridToolbar">
        <a href="#" id="btnEditDataPermission" class="easyui-linkbutton" iconCls="icon-save" plain="true" >保存</a>
        <a href="#" id="btnShowAcl" class="easyui-linkbutton" iconCls="icon2 r5_c16" plain="true" disabled="true">ACL</a>
    </div> -->
</div>
<%-- 
<div id="dataPermRuleSelectDialog" class="easyui-dialog" title="选择数据权限规则"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div>
        <a href="#" id="btnDataPermRuleSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled="true">确定</a>
    </div>

    <table id="grid5"
           class="easyui-datagrid"
           data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       onClickRow:grid5ButtonHandler,
                       checkOnSelect:false"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'isDefault'" align="center" width="40" formatter="formatDefaultFlag1">缺省</th>
            <th data-options="field:'exp'" align="left" width="200">表达式</th>
            <th data-options="field:'aclType',halign:'center'" align="left" width="70" codeName="aclType" formatter="formatCodeList">ACL</th>
            <th data-options="field:'description'" align="left" width="300">描述</th>
        </tr>
        </thead>
    </table>
</div>

<div id="aclSelectDialog" class="easyui-dialog" title="用户访问控制列表"
     style="clear: both; width: 690px; height: 490px;padding:5px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">

    <div id="cc" class="easyui-layout" style="width:668px;height:442px;">
        <div data-options="region:'north',split:false,border:false" style="height:35px;padding-left:10px;">
            <a href="#" id="btnAclSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确认</a>
        </div>

        <div data-options="region:'center',title:'',split:true">
            <div id="aclTreeDiv">
                <ul id="aclTree" class="ztree"></ul>
            </div>
            <div id="bi01Div">
                <table id="grid6"
                       class="easyui-datagrid"
                       data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
                    method:'get',
                    url:'../common/query?mapper=bi01Mapper&queryName=query'
                    "
                       style="height: 200px"
                       pageSize="20"
                       pagination="true">
                    <thead>
                    <tr>
                        <th data-options="field:'bi0101',halign:'center',align:'left'" sortable="true" width="70">编码</th>
                        <th data-options="field:'bi0111',halign:'center',align:'center'" sortable="true" width="200">票据名称</th>
                        <th data-options="field:'bi0201f',halign:'center',align:'center'" sortable="true" width="170" codeName="bi02Service.getCodeList" formatter="formatCodeList">类别名称</th>
                        <th data-options="field:'bi0112c',halign:'center',align:'center'" sortable="true" width="100" codeName="debz" formatter="formatCodeList">定额标志</th>
                        <th data-options="field:'bi0114c',halign:'center',align:'center'" sortable="true" width="100" codeName="jxlx" formatter="formatCodeList">缴销类型</th>
                        <th data-options="field:'bi0125c',halign:'center',align:'center'" sortable="true" width="100" codeName="fmbz" formatter="formatCodeList">罚没标志</th>
                        <th data-options="field:'bi0127d',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">批准日期</th>
                        <th data-options="field:'startTime',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">启用日期</th>
                        <th data-options="field:'ceaseTime',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">停用日期</th>
                        <th data-options="field:'bi0143c',halign:'center',align:'center'" sortable="true" width="70" codeName="qyzt" formatter="formatCodeList">状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div data-options="region:'east',title:'',split:false" style="width:245px;">
            <table id="grid7"
                   class="easyui-datagrid"
                   data-options="singleSelect:true,collapsible:true,height:398,onDblClickRow:grid7DblClickHandler"
                   pagination="false">
                <thead>
                <tr>
                    <th data-options="field:'acl',halign:'center',align:'left'" sortable="true" width="90">编码</th>
                    <th data-options="field:'literal',halign:'center',align:'left'" sortable="true" width="130">名称</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

</div>

<div id="organizationSelectDialog" class="easyui-dialog" title="选择单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <div>
            <a href="#" id="btnOrganizationSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled="true">确定</a>
        </div>
        <ul id="orgTreeSelect" class="ztree"></ul>
    </div>
</div>


 --%>
