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
	$("#p_id").val(row.id);
	$("#p_role").textbox("setValue", row.role);
	$("#p_name").textbox("setValue", row.name);
	$("#p_status").combobox('setValue', row.status);
	$("#p_description").textbox("setValue", row.description);
	showModalDialog("roleWindow");
	$("#btnEditOrSave").parent().css("text-align", " left");
	$('#roleWindow input.easyui-validatebox').validatebox();
	$.each($("#roleTable input.easyui-textbox"), function (idx, elem) {
		$(elem).next().find("input.textbox-text").css("width", "100%");
	});
	$('#tabPanel').tabs('select', 0);
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
	window.selected = -1;
	$('#mainGrid').datagrid('unselectAll');
	$('#roleTable input').val('');
	$("#p_status").combobox('setValue', '1').combobox('setText', '正常')

	showModalDialog("roleWindow");
	$('#roleTable input.easyui-textbox').textbox("enable");
	$('#roleTable input.easyui-combobox').combobox("enable");
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
		$('#tabPanel').tabs('select', 0);
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
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
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "角色删除成功"
								});
							} else {
								$.messager.alert('错误', '角色删除失败：' + response.message, 'error');
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
		var msg = '是否' + operate + '角色 "' + row.name + '" ?';
		if (row) {
			$.messager.confirm('确认', msg, function (r) {
				if (r) {
					$.getJSON("../sys/role/" + row.id + "/lock", null, function (response) {
						if (response.status == SUCCESS) {
							$.messager.show({
								title: '提示',
								msg: operate + "操作成功"
							});
							$('#mainGrid').datagrid('reload');
						} else {
							$.messager.alert('提示', operate + '操作失败: ' + response.message, 'error');
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
			$.messager.alert('错误', '保存角色失败: ' + response.message, 'error');
		} else {
			$("#mainGrid").datagrid("reload");
			$("#p_id").val(response.data.id);
			$.messager.show({
				title : '提示',
				msg : "保存角色成功"
			});
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
			$.messager.alert("操作错误", "请先选择或保存角色基本信息", "error");
			$('#tabPanel').tabs('select',0 );
		}

	} else if (index == 2) { //选择用户TAB
		$("#f_name1").val('');
		$("#f_organization1").val('');
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
    options.queryParams.organization = $('#f_organization1').val();
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
/*
*/

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
			$.messager.show({
				title : '提示',
				msg : "角色授权成功"
			});
		} else {
			$.messager.alert("错误", "角色授权失败", 'error');
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
			saveRole();
		}
	}
}

function addUserRole() {
	$("#f_name").val("");
	$("#f_organization").val("");
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
    options.queryParams.organization = $('#f_organization').val();
    $("#grid3").datagrid("reload");
}

function deleteUserRole() {
	if(!$(this).linkbutton('options').disabled) {
		$.messager.confirm('确认删除', '确认删除选中的用户?', function (r) {
			if (r) {
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
							$.messager.alert('提示', '操作失败: ' + response.message, 'error');
						}
					}
				});
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
				$.messager.alert("错误", "用户角色保存失败", 'error');
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

function loadForm() {
	row = $('#mainGrid').datagrid('getSelected');
	if(row != null) {
		$("#p_id").val(row.id);
		$("#p_role").textbox("setValue", row.role);
		$("#p_name").textbox("setValue", row.name);
		$("#p_status").combobox('setValue', row.status);
		$("#p_description").textbox("setValue", row.description);
		//$("#btnEditOrSave").parent().css("text-align", " left");
		$('#roleWindow input.easyui-validatebox').validatebox();
		$.each($("#roleTable input.easyui-textbox"), function (idx, elem) {
			$(elem).next().find("input.textbox-text").css("width", "100%");
		});
	} else {
		$("#p_id").val("");
		$("#p_role").textbox("clear");
		$("#p_name").textbox("clear");
		$("#p_status").combobox('setValue', '1').combobox('setText', '正常')
		$("#p_description").textbox("clear");
	}
	$('#tabPanel').tabs('select', 0);
}

function mainGridLoadSuccessHandler(data) {

	if(window.selected == undefined || window.selected == -1) {
		var pId = $("#p_id").val();
		for(var i = 0; i<data.rows.length; i++) {
			if(data.rows[i].id == pId) {
				window.selected = i;
				break;
			}
		}
	}
	if(data.rows.length > 0) {
		if (window.selected > data.rows.length - 1) {
			window.selected = data.rows.length - 1;
		} else if (window.selected < 0) {
			window.selected = 0;
		}
		$('#mainGrid').datagrid('selectRow', window.selected);
		loadForm();
	}
}

function add1() {
	window.selected = -1;
	$('#mainGrid').datagrid('unselectAll');
	loadForm();
}

function showPre() {
	var row =  $('#mainGrid').datagrid('getSelected');
	var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
	if(rowIndex > 0) {
		window.selected = rowIndex - 1;
		$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
		loadForm();
	}
}

function showNext() {
	var row =  $('#mainGrid').datagrid('getSelected');
	var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
	if(rowIndex < $('#mainGrid').datagrid('getRows').length - 1) {
		$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', rowIndex + 1);
		window.selected = rowIndex + 1;
		loadForm();
	}
}

function shorFirst() {
	var row =  $('#mainGrid').datagrid('getSelected');
	var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
	if(rowIndex > 0) {
		$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', 0);
		window.selected = 0;
		loadForm();
	}
}

function showLast() {
	var row =  $('#mainGrid').datagrid('getSelected');
	var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
	if(rowIndex < $('#mainGrid').datagrid('getRows').length - 1) {
		window.selected = $('#mainGrid').datagrid('getRows').length - 1;
		$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
		loadForm();
	}
}

function remove1() {
	$.messager.confirm('确认删除', '确认删除角色?', function (r) {
		if (r) {
			var row =  $('#mainGrid').datagrid('getSelected');
			var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
			$.ajax({
				url: "../sys/role/" + row.id,
				type: 'DELETE',
				success: function (response) {
					if (response.status == SUCCESS) {
						window.selected = rowIndex;
						$('#mainGrid').datagrid('reload');
						$.messager.show({
							title: '提示',
							msg: "角色已删除"
						});
					} else {
						$.messager.alert('错误', '角色删除失败：' + response.message, 'error');
					}
				}
			});
		}
	});
}

function closeWindow() {
	$("#roleWindow").window("close");
}

function expandAll(e) {
	var zTree = $.fn.zTree.getZTreeObj("tree"),
		type = e.data.type,
		nodes = zTree.getSelectedNodes();
	if (type.indexOf("All")<0 && nodes.length == 0) {
		alert("请先选择一个父节点");
	}
	if (type == "expandAll") {
		expandNodes(zTree, zTree.getNodes());
	} else if (type == "collapseAll") {
		zTree.expandAll(false);
	}
}

function expandNodes(zTree, nodes) {
	if (!nodes) return;
	//curStatus = "expand";
	for (var i=0, l=nodes.length; i<l; i++) {
		zTree.expandNode(nodes[i], true, false, false, true);
		if (nodes[i].isParent && nodes[i].zAsync) {
			expandNodes(zTree,  nodes[i].children);
		//} else {
		//	goAsync = true;
		}
	}
}

$(function() {
	$("#p_id").val("");
	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnDelete").click(remove);
	$("#btnLock").click(lockUnlock);

	$("#btnEditOrSave").click(editOrSave);


	$("#btnAdd1").click(add1);
	$("#btnPre").click(showPre);
	$("#btnNext").click(showNext);
	$("#btnFirst").click(shorFirst);
	$("#btnLast").click(showLast);
	$("#btnDelete1").click(remove1);
	$("#btnClose").click(closeWindow);

	$("#btnEditOrSaveRoleResource").click(saveRoleResource);

	$("#btnAddUserRole").click(addUserRole);
	$("#btnDeleteUserRole").click(deleteUserRole);

	$("#btnSaveUserRole").click(saveUserRole);
	$("#btnReturn").click(_return);

    $("#btnReset").click(function(){
        $("#f_name").val('');
        $("#f_organization").val('');
		queryUserByRoleIdNegative();
    });
    $("#btnSearch").click(queryUserByRoleIdNegative);

    $("#btnReset1").click(function(){
        $("#f_name1").val('');
        $("#f_organization1").val('');
		queryUserByRoleId();
    });
    $("#btnSearch1").click(queryUserByRoleId);

	$(".datagrid-body").niceScroll({
		cursorcolor : "lightblue", // 滚动条颜色
		cursoropacitymax : 3, // 滚动条是否透明
		horizrailenabled : false, // 是否水平滚动
		cursorborderradius : 0, // 滚动条是否圆角大小
		autohidemode : false // 是否隐藏滚动条
	});

	//预先加载所有功能数据
	/*$.getJSON("../sys/resource", null, function(response){
		window.resTreeData = response;
		window.resTreeDataIds = new Array();
		for(var i=0; i<resTreeData.length; i++) {
			resTreeDataIds.push(resTreeData[i].id);
		}
	});*/

	$("#btnExpandAll").bind("click", {type:"expandAll"}, expandAll);
	$("#btnCollapseAll").bind("click", {type:"collapseAll"}, expandAll);

});