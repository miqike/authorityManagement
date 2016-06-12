function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnResetPass').linkbutton('enable');
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
		$('#btnResetPass').linkbutton('disable');
		$('#btnLock').linkbutton('disable');
	}
}

function mainGridDblClickHandler(index,row) {
	window.selected = index;
	$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
	$("#p_userId").textbox("setValue", row.userId).textbox("readonly", "true");
	$("#p_name").textbox("setValue", row.name);
	$("#p_orgId").textbox("setValue", row.orgId);
	$("#p_orgType").combobox('setValue', row.orgType);
	$("#p_orgName").textbox('setValue', row.orgName);
	$("#p_managerId").textbox('setValue', row.managerId);
	$("#p_managerName").textbox('setValue', row.managerName);
	$("#p_status").combobox("setValue", row.status);
	$("#p_mobile").textbox("setValue", row.mobile);
	$("#p_email").textbox("setValue", row.email);
	showModalDialog("userWindow");
	$("#btnEditOrSave").parent().css("text-align", " left");
	$('#userWindow input.easyui-validatebox').validatebox();

	//$("#tg").parent().find("input:checkbox").attr("disabled", true);
	//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
	$('#tabPanel').tabs('select', 0);
}

function grid3ButtonHandler() {
	if($('#grid3').datagrid('getSelected') != null) {
		$('#btnManagerSelect').linkbutton('enable');
	} else {
		$('#btnManagerSelect').linkbutton('disable');
	}
}

function grid4ButtonHandler() {
	var udpr = $('#grid4').datagrid('getSelected');
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
	if(rule != null /*&& rule.isDefault != 1*/) {
		$('#btnDataPermRuleSelect').linkbutton('enable');
	} else {
		//$('#btnDataPermRuleSelect').linkbutton('disable');
	}
}

function add(){
	$('#userWindow input').val('');
	showModalDialog("userWindow");
	$('#userTable input.easyui-textbox').textbox("enable");
	$('#userTable input.easyui-combobox').combobox("enable");
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
			$("#p_userId").textbox("setValue", row.userId).textbox("readonly", "true");
			$("#p_name").textbox("setValue", row.name);
			$("#p_orgId").textbox("setValue", row.orgId);
			$("#p_orgType").combobox('setValue', row.orgType);
			$("#p_orgName").textbox('setValue', row.orgName);
			$("#p_managerId").textbox('setValue', row.managerId);
			$("#p_managerName").textbox('setValue', row.managerName);
			$("#p_status").combobox("setValue", row.status);
			$("#p_mobile").textbox("setValue", row.mobile);
			$("#p_email").textbox("setValue", row.email);
			showModalDialog("userWindow");
			$("#btnEditOrSave").parent().css("text-align", " left");
			$('#userWindow input.easyui-validatebox').validatebox();
		};
		//$("#tg").parent().find("input:checkbox").attr("disabled", true);
		//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
		$('#tabPanel').tabs('select', 0);
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {

		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除账户', function (r) {
				if (r) {
					$.ajax({
						url: "../user/" + row.userId,
						type: 'DELETE',
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
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

function resetPass(){
	if(!$(this).linkbutton('options').disabled) {

		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认重置密码', '确认重置该账户密码', function (r) {
				if (r) {
					$.getJSON("../user/" + row.userId + "/resetPass", null, function (response) {
						if (response.status == SUCCESS) {
							$.messager.alert("重置成功", "新密码为：" + response.message, 'info');
						} else {
							$.messager.alert('重置失败', response.message, 'info');
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
			$.messager.confirm('确认' + operate + '用户', '是否' + operate + '该用户？', function (r) {
				if (r) {
					$.getJSON("../user/" + row.userId + "/lock", null, function (response) {
						if (response.status == SUCCESS) {
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

function saveUser(){
	if($('#userWindow').form('validate')) {
		$.post("../user", {
			userId: $("#p_userId").textbox("getValue"),
			name: $("#p_name").textbox("getValue"),
			orgId: $("#p_orgId").textbox("getValue"),
			orgType: $("#p_orgType").combobox("getValue"),
			orgName: $("#p_orgName").textbox("getValue"),
			mobile: $("#p_mobile").textbox("getValue"),
			managerId: $("#p_managerId").textbox("getValue"),
            managerName: $("#p_managerName").textbox("getValue"),
			status: $("#p_status").textbox("getValue"),
			email: $("#p_email").textbox("getValue")
		}, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
		    } else {
		    	$("#mainGrid").datagrid("reload");
				//$.messager.alert('保存成功','保存成功','info');
				$.messager.show({
					title : '提示',
					msg : "保存成功"
				});
				//$("#userWindow").window("close");
		    }
		}, "json");
	}
	return false;
}

function tabSelectHandler(title, index) {
	var userId = $('#p_userId').textbox('getValue');
	if(index == 1) { //选择角色TAB
		if(userId != "") {
			$.getJSON("../common/query?mapper=roleMapper&queryName=queryRole", {}, function(response) {
				$("#grid2").datagrid("loadData", response.rows);

				$.getJSON("../sys/user/role/" + userId, {}, function(responseA) {
					$.each(response.rows, function(idx, rowData) {
						if(_.contains(responseA.data, rowData.id)) {
							rowData.ck = "true";
							$('#grid2').datagrid('checkRow', idx);
						}
					});
					//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
				});
			});
		} else {
			$.messager.alert("操作错误", "请先保存用户基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	} else if (index == 2) { //选择权限TAB
		if(userId != "") {
			$.getJSON("../sys/user/resource/" + userId, {}, function(responseA) {
				window.ownedResources = responseA.data;
				checkAuthorizedResourceNode();
			});
		} else {
			$.messager.alert("操作错误", "请先保存用户基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	} else if (index == 3) { //选择权限TAB
		if(userId != "") {
			loadGrid4();
		} else {
			$.messager.alert("操作错误", "请先保存用户基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	}
}

function fillResourceCheckbox() {
	var rows = $("#tg").treegrid("getData");
	fillResourceCheckboxRecursive(rows);
	//$("#tg").parent().find("input:checkbox").attr("disabled", true);
}

function fillResourceCheckboxRecursive(rows) {
	$.each(rows, function(idx, rowData) {
		if(_.contains(ownedResources, rowData.id)) {
			$('#tg').datagrid('checkRow', rowData.id);
		}
		if(rowData.children.length > 0) {
			fillResourceCheckboxRecursive(rowData.children);
		}
	});
}

function editOrSaveUserRole() {
	if($("#btnEditOrSaveUserRole").linkbutton("options").text == "编辑") {
		$("#btnEditOrSaveUserRole").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		//$("#grid2").parent().find("input:checkbox").attr("disabled", false);

	} else {
		$("#btnEditOrSaveUserRole").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});

		//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
		saveUserRole();
	}
}

function saveUserRole() {
	var checkedRows = $('#grid2').datagrid('getChecked');
	var param = new Array();
	$.each(checkedRows, function(idx, elem) {
		param.push(elem.id);
	});

	$.ajax({
		url:"../sys/user/role/" + $('#mainGrid').datagrid('getSelected').userId,
		data:JSON.stringify(param),
		type:"put",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if(response.status == SUCCESS) {
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


function editOrSave () {
	if($("#btnEditOrSave").linkbutton("options").text == "编辑") {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$.each($("#userTable input.easyui-textbox"), function(idx, elem) {
			if(elem.id != 'p_userId' && elem.id != 'p_name' && elem.id != 'p_dwname') {
				$(elem).textbox("enable").textbox("readonly", false);
			}
		});
		$("#p_status").combobox("enable");
	} else {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		/*$.each($("#userTable input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox("disable").textbox("readonly", true);
		});
		$("#p_status").combobox("disable");*/
		saveUser();
	}
}

function selectOrganization() {
	$('#orgTypeSelectDialog').dialog('open');
}

function selectManager() {
    var orgId = $("#p_orgId").textbox("getValue");
    if(orgId == "") {
        $.messager.alert("提示", "请先选择所属单位");
    } else {
        var options = $('#grid3').datagrid('options');
        options.url = '../common/query?mapper=userMapper&queryName=queryManagerCandidate';
        options.queryParams= {
            _orgId: orgId,
            _currentUserId: $("#p_userId").textbox("getValue")/*,
            orgType: $("#p_orgType").combobox("getValue")*/
        };

        $("#grid3").datagrid("reload");

    	$('#managerSelectDialog').dialog('open');
    }

}

function orgTypeSelect() {
	var isFinancial = $("input:radio[name=isFinancial]:checked").val();
	var url;
	if(isFinancial == "0") {
		url = "../ba/ba01";
	} else {
		url = "../ba/ba04";
	}
	var setting = {
		data: {
			key: {
				title:"parentId",
				name:"nameWithId"
			}},
		async: {
			enable: true,
			type: "get",
			url: url,
			autoParam:["treeId"]
		},
		callback: {
			onClick: function() {
				var treeObj = $.fn.zTree.getZTreeObj("orgTree");
				var selected = treeObj.getSelectedNodes();
				if(selected.length == 1) {
					$("#btnOrganizationSelect").linkbutton("enable");
				} else {
					$("#btnOrganizationSelect").linkbutton("disable");
				}
			}
		}
	};

	$.fn.zTree.init($("#orgTree"), setting);
	$('#orgTypeSelectDialog').dialog('close');
	$('#organizationSelectDialog').dialog('open');
}

function organizationSelect() {
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()[0];
	var isFinancial = $("input:radio[name=isFinancial]:checked").val();
	if(isFinancial == "0") {
		$("#p_orgId").textbox("setValue", selected.ba01861);
		$("#p_orgType").combobox("setValue", selected.ba0113c);
		$("#p_orgName").textbox("setValue", selected.ba01862);
	} else {
		$("#p_orgId").textbox("setValue", selected.bac861);
		$("#p_orgType").combobox("setValue", 0);
		$("#p_orgName").textbox("setValue", selected.bac862);
	}
	$('#organizationSelectDialog').dialog('close');
}

function managerSelect() {
    var row = $('#grid3').datagrid('getSelected');
    $("#p_managerId").textbox("setValue", row.userId);
    $("#p_managerName").textbox("setValue", row.name);
	$('#managerSelectDialog').dialog('close');
}

function onExpand(event, treeId, treeNode) {
	checkAuthorizedResourceNode(treeNode);
}

function checkAuthorizedResourceNode(treeNode) {
	var disable = true;
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	var nodes;

	if(treeNode == undefined) {
		nodes = treeObj.getNodes();
	} else {
		nodes = treeNode.children;
	}

	if(nodes.length > 0) {
		$.each(nodes, function(idx, node) {
			if(_.contains(window.ownedResources, node.id)) {
				treeObj.checkNode(node, true);
			} else {
				treeObj.checkNode(node, false);
			}
			treeObj.setChkDisabled(node, disable);
		})
	}
}

//设置CHECKBOX
function setCheckBox(){
	if($("#queryChild").is(':checked')){
		$("#queryChild").removeAttr()("checked");
	}else{
		$("#queryChild").attr("checked",'checked');
	}
}
//查询用户
function queryUser(){
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()

	if(selected.length == 1) {
		var options = $("#mainGrid").datagrid("options");
		if(window.queryChild){
			options.url = '../common/query?mapper=userMapper&queryName=queryUserForOrg';
			$('#mm').menu('setIcon', {
				target: $('#menu1')[0],
				iconCls: 'icon-check'
			});

		}else{
			options.url = '../common/query?mapper=userMapper&queryName=queryUserForSingleOrg';
			$('#mm').menu('setIcon', {
				target: $('#menu1')[0],
				iconCls: 'icon-uncheck'
			});

		}
		$('#mainGrid').datagrid('load',{
			organization: window.isFinancial == "0"? selected[0].ba01861: selected[0].bac861
		});

	} else {
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

function formatDefaultFlag1(val, row) {
	var _val = parseInt(val);
	if(_val == 1) {
		return "<img src='../images/star.png'/>";
	} else {
		return "";
	}
}

function loadGrid4() {
	$.getJSON("../common/query?mapper=userDataPermissionRuleMapper&queryName=query", {"pUserId":$("#p_userId").textbox("getValue")}, function(response) {
		$("#grid4").datagrid("loadData", response.rows);
	});
}

function loadGrid5() {
	$.getJSON("../common/query?mapper=dataPermissionRuleMapper&queryName=queryByDataPermissionId", {
		dataPermissionId:  $('#grid4').datagrid('getSelected').DATAPERMID
	}, function(response) {
		$("#grid5").datagrid("loadData", response.rows);
		var dprId = $('#grid4').datagrid('getSelected').DATAPERMRULEID;
		$.each(response.rows, function(idx, rowData) {
			if(rowData.id == dprId) {
				$('#grid5').datagrid('selectRow', idx);
			}
		});
	});
}

function editDataPermission() {
	loadGrid5();
	$('#dataPermRuleSelectDialog').dialog('open');
}

function showAcl() {
	var aclType = $('#grid4').datagrid('getSelected').ACLTYPE;
	//var aclType = prompt("选择ACL类型:", "")

	if(aclType == "4") {
		$("#aclTreeDiv").hide();
		$("#bi01Div").show();

	} else {
		var setting = {
			data: {
				key: {
					title:"parentId",
					name:"nameWithId"
				}},
			async: {
				enable: true,
				type: "get",
				autoParam:["treeId"]
			},
			callback: {
				onDblClick: function(event, treeId, treeNode) {
					var dataGridData = $("#grid7").datagrid("getData");
					if(aclType == "1") {
						dataGridData.rows.push({"acl":treeNode.bac861, literal:treeNode.bac862});
					} else if(aclType == "2") {
						dataGridData.rows.push({"acl":treeNode.ba01861, literal:treeNode.ba01862});
					} else if(aclType == "3") {
						dataGridData.rows.push({"acl":treeNode.fa0101, literal:treeNode.fa0111});
					}

					dataGridData.total += 1;
					$("#grid7").datagrid("loadData", dataGridData);
					var treeObj = $.fn.zTree.getZTreeObj("aclTree");
					treeObj.hideNode(treeNode);
				},
				onExpand: function(event, treeId, treeNode) {
					hideLeft();
				},
				onAsyncSuccess: function(event, treeId, treeNode) {}
			}
		};

		if(aclType == "1") {
			setting.async.url = "../ba/ba04";
		} else if(aclType == "2") {
			setting.async.url = "../ba/ba01";
		} else if(aclType == "3") {
			setting.async.url = "../fa/fa01";
			setting.data.key.title = "fa0101";
		}
		$.fn.zTree.init($("#aclTree"), setting);
		$("#aclTreeDiv").show();
		$("#bi01Div").hide();
	}

	$('#aclSelectDialog').dialog('open');
	if($("#grid4").datagrid("getSelected").ACL != undefined) {
		$.getJSON("../sys/dataPermission/aclTrans/" + aclType, {
			acl: $("#grid4").datagrid("getSelected").ACL
		}, function (response) {
			if (response.status == FAIL) {
				$.messager.alert('设置用户数据权限ACL失败', response.message, 'info');
			} else {
				$("#grid7").datagrid().datagrid("loadData", response.rows);
				hideLeft();
			}
		});
	}
}

function hideLeft() {
	var aclType = $('#grid4').datagrid('getSelected').ACLTYPE;
	var treeObj = $.fn.zTree.getZTreeObj("aclTree");
	var dataGridData = $("#grid7").datagrid("getData");
	$.each(dataGridData.rows, function(idx, row){
		if(aclType == "1") {
			treeObj.hideNodes(treeObj.getNodesByParam("bac861", row.acl, null));
		} else if(aclType == "2") {
			treeObj.hideNodes(treeObj.getNodesByParam("ba01861", row.acl, null));
		} else if(aclType == "3") {
			treeObj.hideNodes(treeObj.getNodesByParam("fa0101", row.acl, null));
		}
	});
}

function grid7DblClickHandler(index,row) {
	var aclType = $('#grid4').datagrid('getSelected').ACLTYPE;
	$("#grid7").datagrid("deleteRow", index);
	var treeObj = $.fn.zTree.getZTreeObj("aclTree");
	if(aclType == "1") {
		treeObj.showNodes(treeObj.getNodesByParam("bac861", row.acl, null));
	} else if(aclType == "2") {
		treeObj.showNodes(treeObj.getNodesByParam("ba01861", row.acl, null));
	} else if(aclType == "3") {
		treeObj.showNodes(treeObj.getNodesByParam("fa0101", row.acl, null));
	} else if(aclType == "4") {
		alert("TODO....")
	}
}

function selectDataPermRule() {
	var row = $('#grid5').datagrid('getSelected');
	if (row) {
		$.post("../sys/dataPermission/userRule/" + $("#p_userId").textbox("getValue") + "/" + row.dataPermId + "/" + row.id, null, function (response) {
			if (response.status == FAIL) {
				$.messager.alert('设置用户数据权限规则失败', response.message, 'info');
			} else {
				loadGrid4();
				$.messager.show({
					title: '提示',
					msg: "设置用户数据权限规则成功"
				});

				$('#dataPermRuleSelectDialog').dialog('close');
			}
		}, "json");
	}
}

function aclSelect() {
	var selected = $("#grid7").datagrid("getData").rows;

	var param = new Array();
	$.each(selected, function(idx, node) {
		param.push(node.acl);
	});
	var row = $('#grid4').datagrid('getSelected');
	$.ajax({
		url:"../sys/dataPermission/acl/" + $("#p_userId").textbox("getValue") + "/" + row.DATAPERMID + "/" + row.DATAPERMRULEID,
		data:JSON.stringify(param),
		type:"post",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if (response.status == FAIL) {
				$.messager.alert('设置用户数据权限ACL失败', response.message, 'info');
			} else {
				loadGrid4();
				$.messager.show({
					title: '提示',
					msg: "设置用户数据权限ACL成功"
				});
				$('#aclSelectDialog').dialog('close');
			}
		}
	});
}

function poiExport() {
    $("<iframe id='poiExport' style='display:none' src='../user/poiExport'>") .appendTo("body");
}

$(function() {
	
	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnResetPass").click(resetPass);
	$("#btnDelete").click(remove);
	$("#btnLock").click(lockUnlock);
	$("#btnExport").click(poiExport);

	$("#btnEditOrSave").click(editOrSave);

	$("#btnEditOrSaveUserRole").click(editOrSaveUserRole);

	$("#btnOrgTypeSelect").click(orgTypeSelect);
	$("#btnOrganizationSelect").click(organizationSelect);
	$("#btnManagerSelect").click(managerSelect);

	$("#btnEditDataPermission").click(editDataPermission);
	$("#btnShowAcl").click(showAcl);
	$('#btnDataPermRuleSelect').click(selectDataPermRule);

	$("#btnAclSelect").click(aclSelect);

	$("#btnReset").click(function(){
		$("#f_name").val('');
		$("#f_organization").val('');
	});
	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			name: encodeURI($('#f_name').val()),
			organization: processorOrgId($('#f_organization').val())
		});
	});
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

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
			//onClick: onClick
			onExpand: onExpand
		}
	};

	$.fn.zTree.init($("#tree"), setting);

	$("#userTable td:even").css("text-align", "right");
	$('#orgTypeSelectDialog').dialog('close');
});