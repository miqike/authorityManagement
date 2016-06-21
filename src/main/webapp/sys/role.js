function mainGridButtonHandler(index,row) {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnLock').linkbutton('enable');
		if($('#mainGrid').datagrid('getSelected').status == 2) {
			$('#btnLock').linkbutton({
				text:'解锁',
				iconCls: 'icon2 r14_c2'
			});
		} else {
			$('#btnLock').linkbutton({
				text:'锁定',
				iconCls: 'icon2 r14_c1'
			});
		}
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnLock').linkbutton('disable');
	}
}

function mainGridDblClickHandler(index,row) {
	window.selected = index;
	$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
	var row = $('#mainGrid').datagrid('getSelected');
	showRoleForm("update", row);
}

function add(){
	$('#mainGrid').datagrid('unselectAll');
	showRoleForm("add");
}


function view(){
	var row = $('#mainGrid').datagrid('getSelected');
	if (row) {
		showRoleForm("update", row);
	}
}

function remove(){
	var checkedRows = $('#mainGrid').datagrid('getSelections');
	if (checkedRows.length > 0) {
		$.messager.confirm('确认删除', '确认删除选中的角色?', function (r) {
			if (r) {
				var param = new Array();
				$.each(checkedRows, function (idx, elem) {
					param.push(elem.id);
				});

				$.ajax({
					url: "../sys/role",
					data:JSON.stringify(param),
					type: 'DELETE',
					contentType: "application/json; charset=utf-8",
					cache:false,
					success: function (response) {
						if (response.status == $.husky.SUCCESS) {
							$('#mainGrid').datagrid('reload');
							$.messager.show("操作提醒", response.message, "info", "bottomRight");
						} else {
							$.messager.alert('错误', '角色删除失败：' + response.message, 'error');
						}
					}
				});
			}
		});
	}
}

function lock() {
	var row = $('#mainGrid').datagrid('getSelected');
	var operate = row.status == 2 ? "解锁" : "锁定";
	var msg = '是否' + operate + '角色 "' + row.name + '" ?';
	if (row) {
		$.messager.confirm('确认', msg, function (r) {
			if (r) {
				$.getJSON("../sys/role/" + row.id + "/lock", null, function (response) {
					if (response.status == $.husky.SUCCESS) {
						$.messager.show("操作提醒", response.message, "info", "bottomRight");
						$('#mainGrid').datagrid('reload');
					} else {
						$.messager.alert('提示', operate + '操作失败: ' + response.message, 'error');
					}
				});
			}
		});
	}
}

function showRoleForm(operation, data) {
	$.easyui.showDialog({
		title : "角色信息",
		width : 750,
		height : 440,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./roleForm.jsp",
		onLoad : function() {
			roleFormInitHandler(operation, data);
		},
		onSave: function() {
			roleFormSaveHandler(operation);
			return false;
		},
        toolbar: [
  			{ text: "新增", iconCls:"icon-add", handler: roleFormAddHandler },
  			{ text: "删除", iconCls:"icon-remove", handler: roleFormDeleteHandler },
  			"-",
  			{ text: "首个", iconCls:"icon-first", handler: function () { $.husky.ramble("first", "mainGrid", "roleTable"); } },
  			{ text: "上一个", iconCls:"icon-previous", handler: function () { $.husky.ramble("previous", "mainGrid", "roleTable"); } },
  			{ text: "下一个", iconCls:"icon-next", handler: function () { $.husky.ramble("next", "mainGrid", "roleTable"); } },
  			{ text: "末个", iconCls:"icon-last", handler: function () { $.husky.ramble("last", "mainGrid", "roleTable"); } }
  		]
	});
}

function roleFormSaveHandler(operation){
	var tab = $('#tabPanel').tabs('getSelected');
	var index = $('#tabPanel').tabs('getTabIndex',tab);
	if(index == 0 && $('#roleWindow').form('validate')) {
		saveRole();
	} else if (index == 1) {
		saveRoleResource();
	}
}


function roleFormAddHandler(){
	var selected = $("#tabPanel").tabs("getSelected");
	var tabIndex = $("#tabPanel").tabs("getTabIndex", selected);
	if(tabIndex == 0) { //基本信息
		$.husky.loadForm("roleTable", {});
		$.husky.setFormStatus("roleTable", "add");
		$("#mainGrid").datagrid("unselectAll");
	} else if(tabIndex == 1) { //选择角色功能授权TAB
		//Do nothing
	} else if (tabIndex == 2) { //选择操作人员TAB
		showRoleUserCandidateDialog();
    }
}

function roleFormDeleteHandler(){
	var selected = $("#tabPanel").tabs("getSelected");
	var tabIndex = $("#tabPanel").tabs("getTabIndex", selected);
	if(tabIndex == 0) { //基本信息
		var row = $('#mainGrid').datagrid('getSelected');
		remove();
	} else if(tabIndex == 1) { //选择角色功能授权TAB
		//Do nothing
	} else if (tabIndex == 2) { //选择权限TAB
		deleteRoleUser();
    }
}

function saveRoleResource() {
	var treeObj = $.fn.zTree.getZTreeObj("resTree");
	var checkedNodes = treeObj.getCheckedNodes(true);

	var param = new Array();
	$.each(checkedNodes, function(idx, elem) {
		param.push(elem.id);
	});

	$.post("../sys/role/resource/" + $('#p_id').val(), {
		resourceIds:param.join(',')
	}, function(response){
		if(response.status == $.husky.SUCCESS) {
			$.messager.show("操作提醒", "角色授权成功", "info", "bottomRight");
		} else {
			$.messager.alert("错误", "角色授权失败", 'error');
		}
	}, "json");
}


function roleFormInitHandler(operation, data) {
	$.codeListLoader.parse($('#roleTable'))
	if(operation == "add"){
		$.husky.loadForm("roleTable", {});
		$("#mainGrid").datagrid("unselectAll");
	} else {
		if(null != data) {
			$.husky.loadForm("roleTable", data);
			$.husky.setFormStatus("roleTable", operation);
		}
	}
}


function saveRole(){
	if($('#roleTable').form('validate')) {
		var data = $.husky.getFormData("roleTable");
		$.post("../sys/role", data, function(response) {
			if(response.status == $.husky.FAIL){
				$.messager.alert('错误', '保存角色失败: ' + response.message, 'error');
			} else {
				var grid = $("#mainGrid");
		    	var row = grid.datagrid("getSelected");
		    	if(null==row) { //新增,设置查找条件,重新加载grid,选中
		    		$("#mainGrid").datagrid("reload");
		    	} else {
		    		$.husky.refreshParent("mainGrid", data);
		    	}
		    	$.messager.show("操作提醒", response.message, "info", "bottomRight");
			}
		}, "json");
	}
	return false;
}

function tabSelectHandler(title, index) {
	var id = $("#p_id").val();
	if(id == "" && index != 0) {
		$.messager.alert("操作错误", "请先选择或保存角色基本信息", "error");
		$('#tabPanel').tabs('select',0 );
	} else {
		if(index == 1) { //选择权限TAB
			$.getJSON("../sys/role/resource/" + id, {}, function(responseA) {
				window.x = responseA.data;
				$("#treePanel").empty();
				$('<ul id="resTree" class="ztree"></ul>').appendTo($("#treePanel"));
				setting.callback.onAsyncSuccess = function(event, treeId, treeNode, msg){
					_checkAuthorizedResourceNode(treeObj, treeNode);
				};
				treeObj = $.fn.zTree.init($("#resTree"), setting);
				checkAuthorizedResourceNode();
			});
		} else if (index == 2) { //选择用户TAB
			loadRoleUserForm();
		}
	}
}

function loadRoleUserForm() {
	$("#roleUserForm").panel({
		href: "./roleUserForm.jsp",
		onLoad:function(){
			$("#f_name1").val('');
			$("#f_organization1").val('');
			queryUserByRoleId();
	    }
	});
}

function queryUserByRoleId(){
    var options = $('#roleUserGrid').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=queryByRoleId';
    options.queryParams.roleId = $("#p_id").val();
    options.queryParams.name = $('#f_name1').val();
    options.queryParams.organization = $('#f_organization1').val();
    $("#roleUserGrid").datagrid("reload");
}

function checkAuthorizedResourceNode(treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj("resTree");
	_checkAuthorizedResourceNode(treeObj, treeNode);
}

function _checkAuthorizedResourceNode(treeObj, treeNode) {
	var disable = false;//$("#btnEditOrSaveRoleResource").linkbutton("options").text == "编辑";
	var nodes;
	if(treeNode == undefined) {
		nodes = treeObj.getNodes();
	} else {
		nodes = treeNode.children;
	}

	if(nodes.length > 0) {
		$.each(nodes, function(idx, node) {
			//treeObj.setChkDisabled(node, !disable);
			if(_.contains(window.x, node.id)) {
				treeObj.checkNode(node, true);
			} else {
				treeObj.checkNode(node, false);
			}
			//treeObj.setChkDisabled(node, disable);
			if(node.isParent)
				_checkAuthorizedResourceNode(treeObj, node);
		})
	}
}

function enableResourceNodeChecked(enable) {
	var treeObj = $.fn.zTree.getZTreeObj("resTree");
	var nodes = treeObj.getNodes();
	if(nodes.length > 0) {
		$.each(nodes, function(idx, node) {
			treeObj.setChkDisabled(node, !enable, null, true);
		})
	}
}

function onExpand(event, treeId, treeNode) {
	checkAuthorizedResourceNode(treeNode);
}

function showRoleUserCandidateDialog() {
	$("#f_name").val("");
	$("#f_organization").val("");
	
	$.easyui.showDialog({
		title : "候选用户信息",
		width : 640,
		height : 440,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./candidateRoleUserSelecteDialog.jsp",
		onLoad : function() {
			//doRoleFormInit(operation, data);
			//$("#candidateRoleUserWindow").dialog("show");
			var options = $('#candidateUserGrid').datagrid('options');
			options.url = '../common/query?mapper=userMapper&queryName=queryByRoleIdNegative';
			$("#candidateUserGrid").datagrid("load", {
				roleId: $("#p_id").val()
			});
		},
		onSave: function() {
			saveRoleUser();
			return false;
		}
	});
	
}

function queryUserByRoleIdNegative(){
    var options = $('#candidateUserGrid').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=queryByRoleIdNegative';
    options.queryParams.roleId = $("#p_id").val();
    options.queryParams.name = $('#f_name').val();
    options.queryParams.organization = $('#f_organization').val();
    $("#candidateUserGrid").datagrid("reload");
}

function deleteRoleUser() {
	$.messager.confirm('确认删除', '确认删除选中的用户?', function (r) {
		if (r) {
			var roleId = $("#p_id").val();
			var param = new Array();
			$.each($('#roleUserGrid').datagrid('getSelections'), function (idx, elem) {
				param.push(elem.userId);
			});

			$.ajax({
				url: "../sys/role/user/" + roleId,
				data: JSON.stringify(param),
				type: "delete",
				contentType: "application/json; charset=utf-8",
				cache: false,
				success: function (response) {
					if (response.status == $.husky.SUCCESS) {
						$('#roleUserGrid').datagrid('reload');
						//$.messager.alert("提示", "操作成功", 'info');
						$.messager.show("操作提醒", response.message, "info", "bottomRight");
					} else {
						$.messager.alert('提示', '操作失败: ' + response.message, 'error');
					}
				}
			});
		}
	});
}

function saveRoleUser() {
	var param = new Array();
	$.each($('#candidateUserGrid').datagrid('getSelections'), function(idx, elem) {
		param.push(elem.userId);
	});

	$.ajax({
		url:"../sys/role/user/" + $('#mainGrid').datagrid('getSelected').id ,
		data:JSON.stringify(param),
		type:"post",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if(response.status == $.husky.SUCCESS) {
				$('#roleUserGrid').datagrid('reload');
				$('#candidateUserGrid').datagrid('reload');
				$.messager.show("操作提醒", "用户角色保存成功", "info", "bottomRight");
			} else {
				$.messager.alert("错误", "用户角色保存失败", 'error');
			}
		}
	});
}

var setting = {
	data: {key: {
		title:"parentId",
		name:"nameWithId"
	}},
	check: {
		enable: true
	},
	async: {
		enable: true,
		type: "get",
		url:"../sys/resource",
		autoParam:["id"]/*,
		 dataFilter: filter*/
	},
	callback: {
		//beforeClick: beforeClick,
		onClick: onClick,
		onExpand: onExpand
	}
};

function onClick(event, treeId, treeNode, clickFlag) {
	event.preventDefault();
}

function mainGridLoadSuccessHandler(data) {
	$('#mainGrid').datagrid('unselectAll');
}


$(function() {
	$("#p_id").val("");
	$(".datagrid-body").niceScroll({
		cursorcolor : "lightblue", // 滚动条颜色
		cursoropacitymax : 3, // 滚动条是否透明
		horizrailenabled : false, // 是否水平滚动
		cursorborderradius : 0, // 滚动条是否圆角大小
		autohidemode : false // 是否隐藏滚动条
	});

	//预先加载所有功能数据
});