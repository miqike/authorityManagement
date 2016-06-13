window.queryChild=false;

function levelExpandTree(newValue, oldValue) {
	levelExpand($.fn.zTree.getZTreeObj("orgTree"), newValue);
}

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
	window.operate = 'update';
	$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
	showModalDialog("userWindow");
	$("#p_userId").textbox("setValue", row.userId).textbox("disable");
	$("#p_name").textbox("setValue", row.name);
	$("#p_orgId").textbox("setValue", row.orgId);
	$("#p_orgType").combobox("setValue", row.orgType);
	$("#p_orgName").textbox('setValue', row.orgName).textbox("disable");
	$("#p_status").combobox("setValue", row.status);
	$("#p_mobile").textbox("setValue", row.mobile);
	$("#p_email").textbox("setValue", row.email);
	//("#btnEditOrSave").parent().css("text-align", " left");
	$('#userWindow input.easyui-validatebox').validatebox();

	//$("#tg").parent().find("input:checkbox").attr("disabled", true);
	//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
	$('#tabPanel').tabs('select', 0);
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
	window.operate = 'add';
	showModalDialog("userWindow");
	loadForm();
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()[0];
	$('#tabPanel').tabs('select',0 );
}

function view(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			window.operate = 'update';
			showModalDialog("userWindow");

			$("#p_userId").textbox("setValue", row.userId).textbox("disable");
			$("#p_name").textbox("setValue", row.name);
			$("#p_orgId").textbox("setValue", row.orgId);
			$("#p_orgType").combobox("setValue", row.orgType);
			$("#p_orgName").textbox('setValue', row.orgName).textbox("disable");
			$("#p_status").combobox("setValue", row.status);
			$("#p_mobile").textbox("setValue", row.mobile);
			$("#p_email").textbox("setValue", row.email);
			//$("#btnEditOrSave").parent().css("text-align", " left");
			$('#userWindow input.easyui-validatebox').validatebox();
		}
		;
		//$("#tg").parent().find("input:checkbox").attr("disabled", true);
		//$("#grid2").parent().find("input:checkbox").attr("disabled", true);
		$('#tabPanel').tabs('select', 0);
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var checkedRows = $('#mainGrid').datagrid('getSelections');
		if (checkedRows.length > 0) {
			$.messager.confirm('确认删除', '确认删除选中的用户?', function (r) {
				if (r) {
					var param = new Array();
					$.each(checkedRows, function (idx, elem) {
						param.push(elem.userId);
					});

					$.ajax({
						url: "../user",
						data:JSON.stringify(param),
						type: 'DELETE',
						contentType: "application/json; charset=utf-8",
						cache:false,
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "用户删除成功"
								});
							} else {
								$.messager.alert('错误', '用户删除失败：' + response.message, 'error');
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

		var data =  {
			userId: $("#p_userId").textbox("getValue"),
			name: $("#p_name").textbox("getValue"),
			orgId: $("#p_orgId").textbox("getValue"),
			//orgType: $("#p_orgType").combobox("getValue"),
			orgName: $("#p_orgName").textbox("getValue"),
			mobile: $("#p_mobile").textbox("getValue"),
			status: $("#p_status").combobox("getValue"),
			email: $("#p_email").textbox("getValue")
		};
		if(window.operate == 'update') {
			data._method = 'put';
		}
		$.post("../user/", data, function(response) {
			if(response.status == FAIL){
				$.messager.alert('错误', response.message, 'error');
			} else {
		    	$("#mainGrid").datagrid("reload");
				$.messager.show({
					title : '提示',
					msg : "保存用户成功"
				});
		    }
		}, "json");
	}
	return false;
}

function tabSelectHandler(title, index) {
	var userId = $('#p_userId').textbox('getValue');
	if(index == 1) { //选择角色TAB
		if(userId != "") {
			loadGrid2();
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
	$("#tg").parent().find("input:checkbox").attr("disabled", true);
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

function addUserRole() {
	$('#roleSelectDialog').dialog('open');
	loadGrid8();
}

function deleteUserRole() {
	var rows = $('#grid2').datagrid('getSelections');
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
			if(response.status == SUCCESS) {
				$.messager.show({
					title : '提示',
					msg : "删除用户角色成功"
				});
				loadGrid2();
				loadGrid8()
			} else {
				$.messager.alert("错误", "删除用户角色失败");
			}
		}
	});
}

function addUserRole1() {
	var rows = $('#grid8').datagrid('getSelections');
	var param = new Array();
	$.each(rows, function(idx, elem) {
		param.push(elem.id);
	});

	$.ajax({
		url:"../sys/user/role1/" + $('#mainGrid').datagrid('getSelected').userId,
		data:JSON.stringify(param),
		type:"put",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if(response.status == SUCCESS) {
				$.messager.show({
					title : '提示',
					msg : "添加用户角色成功"
				});
				loadGrid2();
				loadGrid8()
			} else {
				$.messager.alert("错误", "添加用户角色失败");
			}
		}
	});
}

function loadGrid2() {
	$.getJSON("../sys/user/role1/" + $('#p_userId').textbox('getValue'), {}, function(responseA) {
		$("#grid2").datagrid("loadData", responseA.data);
	});
}

function loadGrid8() {
	var options = $("#grid8").datagrid("options");
	options.url = '../common/query?mapper=roleMapper&queryName=selectRoleByUserIdExclude';
	$('#grid8').datagrid('load',{
		userId: $('#mainGrid').datagrid('getSelected').userId
	});
}

function onExpand(event, treeId, treeNode) {
	checkAuthorizedResourceNode(treeNode);
}

function checkAuthorizedResourceNode(treeNode) {
	/*
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
	}*/
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
		options.url = '../common/query?mapper=userMapper&queryName=queryUserForOrg';
		$('#mainGrid').datagrid('load',{
			organization: processorOrgId(selected[0].id)
		});

	} else {
	}

}
//更新单位树
function refreshOrgTree(){
	var setting = {
		data: {
			key: {
				title:"parentId",
				name:"name"
			}},
		async: {
			enable: true,
			type: "get",
			url: "../sys/organization/getSub",
			autoParam:["id"]
		},
		callback: {
			onClick: function(event, treeId, treeNode) {
				queryUser();
			}
		}
	};

	$.fn.zTree.init($("#orgTree"), setting);
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
//单位选择
function selectOrganization() {
	var setting = {
		data: {
			key: {
				title:"parentId",
				name:"name"
			}},
		async: {
			enable: true,
			type: "get",
			url: "../sys/organization/getSub",
			autoParam:["id"]
		},
		callback: {
			onClick: function() {
				var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
				var selected = treeObj.getSelectedNodes();
				if(selected.length == 1) {
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

function organizationSelect() {
	var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
	var selected = treeObj.getSelectedNodes()[0];
	$("#p_orgId").textbox("setValue", selected.id);
	$("#p_orgType").combobox("setValue", 0);
	$("#p_orgName").textbox("setValue", selected.name);
	$('#organizationSelectDialog').dialog('close');
}

function mainGridLoadSuccessHandler(data) {
	if(window.selected == undefined || window.selected == -1) {
		var pId = $("#p_userId").val();
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
	window.operate = 'add';
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
	$.messager.confirm('确认删除', '确认删除用户?', function (r) {
		if (r) {
			var row =  $('#mainGrid').datagrid('getSelected');
			var rowIndex = $('#mainGrid').datagrid('getRowIndex', row);
			$.ajax({
				url: "../user/" + row.userId,
				type: 'DELETE',
				success: function (response) {
					if (response.status == SUCCESS) {
						window.selected = rowIndex;
						$('#mainGrid').datagrid('reload');
						$.messager.show({
							title: '提示',
							msg: "用户已删除"
						});
					} else {
						$.messager.alert('错误', '用户删除失败：' + response.message, 'error');
					}
				}
			});
		}
	});
}

function closeWindow() {
	$("#userWindow").window("close");
}

function loadForm() {
	row = $('#mainGrid').datagrid('getSelected');
	if(row != null) {
		window.operate = 'update';
		$("#p_userId").textbox("setValue", row.userId).textbox("disable");
		$("#p_name").textbox("setValue", row.name);
		$("#p_orgId").textbox("setValue", row.orgId);
		$("#p_orgType").combobox("setValue", row.orgType);
		$("#p_orgName").textbox('setValue', row.orgName).textbox("disable");
		$("#p_status").combobox("setValue", row.status);
		$("#p_mobile").textbox("setValue", row.mobile);
		$("#p_email").textbox("setValue", row.email);
		$('#userWindow input.easyui-validatebox').validatebox();
	} else {
		window.operate = 'add';
		$("#p_userId").textbox("clear").textbox("enable");
		$("#p_name").textbox("clear");

		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		var selected = treeObj.getSelectedNodes()[0];

		$("#p_orgId").textbox("enable").textbox("setValue", selected == null? "": selected.ba01861);
		$("#p_orgType").combobox("enable").combobox("setValue", selected == null? "": selected.ba0113c);
		$("#p_orgName").textbox('disable').textbox("setValue", selected == null? "": selected.ba01862);
		$("#p_status").combobox("setValue", "1");
		$("#p_mobile").textbox("clear");
		$("#p_email").textbox("clear");
		$("#userTable").form("validate");
	}
	$('#tabPanel').tabs('select', 0);
}

function validateOrg() {
	/*var orgId = $("#p_orgId").textbox("getValue");
	if(orgId != "") {
		$.getJSON("../ba/ba01/load/" + orgId, null, function (response) {
			if (response.status == SUCCESS) {
				if (response.data != null) {
					$("#p_orgName").textbox('setValue', response.data.ba01862);
				} else {
					$.messager.alert('错误', '单位不存在，请重新输入', 'error');
					$("#p_orgId").textbox('clear');
				}
			} else {
				$.messager.alert('错误', '加载单位信息失败：' + response.message, 'error');
			}

		});
	}*/
}

function search1(){
	$.fn.zTree.destroy("orgTree");
	var setting = {
		data: {
			key: {
				title:"parentId",
				name:"nameWithId"
			},
			simpleData:{
				enable:true,
				idKey: "treeId",
				pIdKey: "parentId",
				rootPId: 1
			}
		},
		async: {
			enable: true,
			type: "get",
			url: "../ba/ba01",
			autoParam:["treeId"]
		},
		callback: {
			//beforeClick: beforeClick,
			onClick: function(event, treeId, treeNode) {
				queryUser();
			}
		}
	};
/*
	$.getJSON("../common/query?mapper=ba01Mapper&queryName=query", {
		ba0101: $("#q_ba0101").val(),
 		ba0111: $("#q_ba0111").val()
	}, function(response) {
		if(response.rows.length > 0) {
			$.fn.zTree.init($("#orgTree"), setting, response.rows);
			var treeObj = $.fn.zTree.getZTreeObj("orgTree");
			levelExpand(treeObj, $("#f_expandLevel").numberspinner("getValue"));
			//freezeStatusFilter();
		} else {
			$.messager.alert("警告", "没有符合条件的单位", "warning");
		}
	});*/
}

function poiExport() {
	$("<iframe id='poiExport' style='display:none' src='../user/poiExport'>") .appendTo("body");
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
	//取得登录用户信息
	getUserInfo();
	if(null!=window.userInfo){
		refreshOrgTree();
	}else{
		$.subscribe("USERINFO_INITIALIZED", refreshOrgTree);
	}

	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnResetPass").click(resetPass);
	$("#btnDelete").click(remove);
	$("#btnLock").click(lockUnlock);
	//$("#btnEditOrSave").click(editOrSave);

	$("#btnPrint").click(function(){
        var params={};
        params["pageRows"]=50;
        params["pageTitle"]="用户列表";
        params["topMargin"]=5;
        params["leftMargin"]=5;
        params["pageWidth"]=210;
        params["pageHeight"]=297;

        var columnList=[];
        columnList.push({"header":"用户编码","fieldName":"userId","codeName":null,"colWidth":40});
        columnList.push({"header":"用户姓名","fieldName":"name","codeName":null,"colWidth":40});
        columnList.push({"header":"单位编码","fieldName":"orgId","codeName":null,"colWidth":40});
        columnList.push({"header":"单位名称","fieldName":"orgName","codeName":null,"colWidth":80});

        listPrint(params,$("#mainGrid").datagrid("getRows"),columnList);
	});
	$("#btnExport").click(poiExport);

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

	$.fn.zTree.init($("#tree"), setting);

	window._expandeLevel = $("#f_expandLevel").numberspinner("getValue");
/*
	$("#btnSearch1").click(search1);

	$("#btnReset1").click(function(){
		$("#p input:text").val("");
		$("#f_expandLevel").numberspinner("setValue", 3);
		search1();
	});
*/
	$("#btnOrganizationSelect").click(organizationSelect);
	$("#btnExpandAll").bind("click", {type:"expandAll"}, expandAll);
	$("#btnCollapseAll").bind("click", {type:"collapseAll"}, expandAll);
});