function mainGridButtonHandler() {
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

function grid2ButtonHandler() {
	if($('#grid2').datagrid('getSelected') != null) {
		$('#btnDeleteUserRole').linkbutton('enable');
	} else {
		$('#btnDeleteUserRole').linkbutton('disable');
	}
}

function grid3ButtonHandler() {
	if($('#grid3').datagrid('getSelected') != null) {
		$('#btnSaveUserRole').linkbutton('enable');
	} else {
		$('#btnSaveUserRole').linkbutton('disable');
	}
}

function add(){
	$('#roleTable input').val('');
	showModalDialog("roleWindow");
	$('#roleTable input.easyui-textbox').textbox("enable");
	$('#roleTable input.easyui-combobox').combobox("enable");
	$("#btnEditOrSave").linkbutton({
		iconCls:'icon-save',
		text:'保存'
	});
	$('#tabPanel').tabs('select',0 );
}

function view(){
	if(!$(this).linkbutton('options').disabled) {

		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$("#p_id").val(row.id);
			$("#p_role").textbox("setValue", row.role);
			$("#p_name").textbox("setValue", row.name);
			$("#p_status").combobox('setValue', row.status);
			$("#p_description").textbox("setValue", row.description);
			showModalDialog("roleWindow");
			$("#btnEditOrSave").parent().css("text-align", " left");
			$('#roleWindow input.easyui-validatebox').validatebox();
		}
		$.each($("#roleTable input.easyui-textbox"), function (idx, elem) {
			$(elem).next().find("input.textbox-text").css("width", "100%");
		});
		$("#tg").parent().find("input:checkbox").attr("disabled", true);

		$('#tabPanel').tabs('select', 0);
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {

		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除角色已经该角色所有用户/权限关联?', function (r) {
				if (r) {
					$.ajax({
						url: "../sys/role/" + row.id,
						type: 'DELETE',
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "角色已删除"
								});
							} else {
								$.messager.alert('删除失败', response, 'info');
							}
						}
					});
				}
			});
		}
	}
}

function lockUnlock() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		var operate = row.status == 2 ? "解锁" : "锁定";
		if (row) {
			$.messager.confirm('确认', '是否' + operate + '角色 <<' + row.name + '>> ?', function (r) {
				if (r) {
					$.getJSON("../sys/role/" + row.id + "/lock", null, function (response) {
						if (response.status == SUCCESS) {
							//$.messager.alert("提示", operate + "操作成功", 'info');
							$.messager.show({
								title: '提示',
								msg: operate + "操作成功"
							});
							$('#mainGrid').datagrid('reload');
						} else {
							$.messager.alert('提示', operate + '操作失败: ' + response.message, 'info');
						}
					});
				}
			});
		}
	}
}

function saveRole(){
	$.post("../sys/role", {
		id:$("#p_id").val(),
		role: $("#p_role").textbox("getValue"),
		name: $("#p_name").textbox("getValue"),
		status: $("#p_status").combobox("getValue"),
		description: $("#p_description").textbox("getValue")
	}, function(response) {
		if(response.status == FAIL){
			$.messager.alert('保存失败', response.message, 'info');
		} else {
			$("#mainGrid").datagrid("reload");
			$("#p_id").val(response.data.id);
			//$.messager.alert('保存成功','保存成功','info');
			$.messager.show({
				title : '提示',
				msg : "保存成功"
			});
			//$("#roleWindow").window("close");
		}
	}, "json");
	return false;
}

function tabSelectHandler(title, index) {
	var id = $("#p_id").val();
	if(index == 1) { //选择权限TAB
		if(id != "") {
			$.getJSON("../sys/role/resource/" + id, {}, function(responseA) {
				window.x = responseA.data;
				checkAuthorizedResourceNode();
			});
		} else {
			$.messager.alert("操作错误", "请先保存角色基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	} else if (index == 2) { //选择用户TAB
		var options = $('#grid2').datagrid('options');
		options.url = '../common/query?mapper=userMapper&queryName=queryByRoleId';
		options.queryParams.roleId = id;
		$("#grid2").datagrid("reload");
	}
}

function queryUserByRoleId(){
    var options = $('#grid2').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=queryByRoleId';
    options.queryParams.roleId = $("#p_id").val();
    options.queryParams.name = $('#f_name1').val();
    $("#grid2").datagrid("reload");

}

function checkAuthorizedResourceNode(treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	if(null == treeObj) {
		setting.callback.onAsyncSuccess = function(event, treeId, treeNode, msg){
			_checkAuthorizedResourceNode(treeObj, treeNode);
		};
		treeObj = $.fn.zTree.init($("#tree"), setting);
	} else {
		_checkAuthorizedResourceNode(treeObj, treeNode);
	}
}

function _checkAuthorizedResourceNode(treeObj, treeNode) {
	var disable = $("#btnEditOrSaveRoleResource").linkbutton("options").text == "编辑";
	var nodes;

	if(treeNode == undefined) {
		nodes = treeObj.getNodes();
	} else {
		nodes = treeNode.children;
	}

	if(nodes.length > 0) {
		$.each(nodes, function(idx, node) {
			treeObj.setChkDisabled(node, !disable);
			if(_.contains(window.x, node.id)) {
				treeObj.checkNode(node, true);
			} else {
				treeObj.checkNode(node, false);
			}
			treeObj.setChkDisabled(node, disable);
		})
	}
}

function enableResourceNodeChecked(enable) {
	var treeObj = $.fn.zTree.getZTreeObj("tree");
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

function editOrSaveRoleResource() {
	if($("#btnEditOrSaveRoleResource").linkbutton("options").text == "编辑") {
		$("#btnEditOrSaveRoleResource").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});
		enableResourceNodeChecked(true);
	} else {
		$("#btnEditOrSaveRoleResource").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		saveRoleResource();
		enableResourceNodeChecked(false);

	}
}

function saveRoleResource() {
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var checkedNodes = treeObj.getCheckedNodes(true);

	var param = new Array();
	$.each(checkedNodes, function(idx, elem) {
		param.push(elem.id);
	});
	$.post("../sys/role/resource/" + $('#p_id').val(), {
		resourceIds:param.join(',')
	}, function(response){
		if(response.status == SUCCESS) {
			//$.messager.alert("提示", "角色授权成功");
			$.messager.show({
				title : '提示',
				msg : "角色授权成功"
			});
		} else {
			$.messager.alert("错误", "角色授权失败");
		}
	}, "json");
}


function editOrSave () {
	if($("#btnEditOrSave").linkbutton("options").text == "编辑") {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$.each($("#roleTable input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox("enable").textbox("readonly", false);
		});
		$("#p_status").combobox("enable").combobox("readonly", false);

	} else {
		if($('#roleWindow').form('validate')) {
			$("#btnEditOrSave").linkbutton({
				iconCls: 'icon-edit',
				text: '编辑'
			});
			$.each($("#roleTable input.easyui-textbox"), function (idx, elem) {
				$(elem).textbox("disable").textbox("readonly", true);
			});
			$("#p_status").combobox("disable").combobox("readonly", true);
			saveRole();
		}
	}
}

function addUserRole() {
	showModalDialog("userRoleWindow");
	var options = $('#grid3').datagrid('options');
	options.url = '../common/query?mapper=userMapper&queryName=queryByRoleIdNegative';
	options.queryParams.roleId = $("#p_id").val();
	$("#grid3").datagrid("reload");
}

function queryUserByRoleIdNegative(){
    var options = $('#grid3').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=queryByRoleIdNegative';
    options.queryParams.roleId = $("#p_id").val();
    options.queryParams.name = $('#f_name').val();
    $("#grid3").datagrid("reload");

}

function deleteUserRole() {
	if(!$(this).linkbutton('options').disabled) {
		var roleId = $("#p_id").val();
		var param = new Array();
		$.each($('#grid2').datagrid('getSelections'), function (idx, elem) {
			param.push(elem.userId);
		});

		$.ajax({
			url: "../sys/role/user/" + roleId,
			data: JSON.stringify(param),
			type: "delete",
			contentType: "application/json; charset=utf-8",
			cache: false,
			success: function (response) {
				if (response.status == SUCCESS) {
					$('#grid2').datagrid('reload');
					//$.messager.alert("提示", "操作成功", 'info');
					$.messager.show({
						title: '提示',
						msg: "操作成功"
					});
				} else {
					$.messager.alert('提示', '操作失败: ' + response.message, 'info');
				}
			}
		});
	}
}

function saveUserRole() {
	var param = new Array();
	$.each($('#grid3').datagrid('getSelections'), function(idx, elem) {
		param.push(elem.userId);
	});

	$.ajax({
		url:"../sys/role/user/" + $('#mainGrid').datagrid('getSelected').id ,
		data:JSON.stringify(param),
		type:"post",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if(response.status == SUCCESS) {
				$('#grid2').datagrid('reload');
				$('#grid3').datagrid('reload');
				//$.messager.alert("提示", "用户角色保存成功");
				$.messager.show({
					title : '提示',
					msg : "用户角色保存成功"
				});
			} else {
				$.messager.alert("错误", "用户角色保存失败");
			}
		}
	});
}

function _return() {
	$("#userRoleWindow").window("close");
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

$(function() {
	$("#p_id").val("");
	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnDelete").click(remove);
	$("#btnLock").click(lockUnlock);

	$("#btnEditOrSave").click(editOrSave);

	$("#btnEditOrSaveRoleResource").click(editOrSaveRoleResource);
	$("#btnAddUserRole").click(addUserRole);
	$("#btnDeleteUserRole").click(deleteUserRole);

	$("#btnSaveUserRole").click(saveUserRole);
	$("#btnReturn").click(_return);

    $("#btnReset").click(function(){
        $("#f_name").val('');
    });
    $("#btnSearch").click(queryUserByRoleIdNegative);

    $("#btnReset1").click(function(){
        $("#f_name1").val('');
    });
    $("#btnSearch1").click(queryUserByRoleId);

	$(".datagrid-body").niceScroll({
		cursorcolor : "lightblue", // 滚动条颜色
		cursoropacitymax : 3, // 滚动条是否透明
		horizrailenabled : false, // 是否水平滚动
		cursorborderradius : 0, // 滚动条是否圆角大小
		autohidemode : false // 是否隐藏滚动条
	});
});