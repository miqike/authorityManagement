window.excludeSaved = false;

function quickSearch (value, name) {
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()
	var options = $("#grid2").datagrid("options");
	var hcjh = $('#grid1').datagrid('getSelected');
    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg&' + name + "=" + value,
    $('#grid2').datagrid('load', {
        hcjhId: hcjh.id,
        organization: processorOrgId(selected[0].id),
        order:1
    });
}

function filterByZfry() {
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()
	var options = $("#grid2").datagrid("options");
	var hcjh = $('#grid1').datagrid('getSelected');
    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg&filterByZfry=y',
    $('#grid2').datagrid('load', {
        hcjhId: hcjh.id,
        organization: processorOrgId(selected[0].id),
        order:1
    });
}


function goFirst() {
	$.husky.ramble("first", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goLast() {
	$.husky.ramble("last", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goPrev() {
	$.husky.ramble("previous", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goNext() {
	$.husky.ramble("next", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function minimizeMyPlanListWindow() {
	$("#myPlanListWindow").window("minimize");
}

function showPlanListWindow() {
	var options = $("#grid1").datagrid("options")
	options.url = "../common/query?mapper=hcjhMapper&queryName=query" + (userInfo.ext1 == 1 ? "Ext": "");
	
	$("#myPlanListWindow").window({
        title: "我的计划列表", top: 5, left: $.util.windowSize().width-905, width: 900, height: 450,
        iconCls: 'icon2 r5_c20',
        modal:false,
        collapsible:true,
		closable:false,
        minimizable:true,
        border:false,
        autoVCenter: false,     //该属性如果设置为 true，则使窗口保持纵向居中，默认为 true。
        autoHCenter: false,      //该属性如果设置为 true，则使窗口保持横向居中，默认为 true。
		onOpen : function() {
			loadMyPlan();
		}
    });
}

function search() {
	loadMyPlan();
}

function loadMyPlan() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        hcjgmc: $('#f_hcjgmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue"),
        planType: $('#f_planType').combobox("getValue")
    });
}

function loadGrid1(hcjhId) {
	window._selectdPlanId_ = hcjhId;
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        hcjgmc: $('#f_hcjgmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue"),
        planType: $('#f_planType').combobox("getValue")
    });
}

function collapseHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}

function onTreeClick(event, treeId, treeNode, clickFlag) {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {
    	sort(1);

        $("#btnSort1").linkbutton("disable");
        $("#btnSort2").linkbutton("enable");
        //TODO
        //$("#btnAccept").linkbutton("disable");
    } else {
        $("#btnSort1").linkbutton("disable");
        $("#btnSort2").linkbutton("disable");
        //$("#btnAccept").linkbutton("disable");
    }
}

function grid1LoadSucessHandler(data) {
	$('#btnModify').linkbutton('disable');
    $('#btnDispatch').linkbutton('disable');
    $('#btnViewCheckList').linkbutton('disable');
    $('#grid1').datagrid('selectRow', 0);
    if(window._selectdPlanId_ != undefined) {
    	$("#grid1").datagrid("selectRow", getRowIndex());
    }
}

function getRowIndex() {
	var rows = $("#grid1").datagrid("getRows");
	var index;
	for(var i=0; i<rows.length; i++) {
		var row = rows[i];
		if(row.id == window._selectdPlanId_) {
			index = $("#grid1").datagrid("getRowIndex", row);
			break;
		}
	}
	return index;
}

function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnModify').linkbutton('enable');
        $('#btnDispatch').linkbutton('enable');
        $('#btnViewCheckList').linkbutton('enable');
        var row = $('#grid1').datagrid('getSelected');
        
        if(row.planType==1) {
	        if (row.xdrmc == null && row.xdrq == null) {
	            $('#btnModify').linkbutton('enable');
	            $('#btnDispatch').linkbutton({
	                text: '下达'
	            });
	        } else {
	            $('#btnModify').linkbutton('disable');
	            $('#btnDispatch').linkbutton({
	                text: '取消下达'
	            });
	        }
        } else {
        	$('#btnDispatch').linkbutton('disable');
        }
        
    } else {
        $('#btnModify').linkbutton('disable');
        $('#btnDispatch').linkbutton('disable');
        $('#btnViewCheckList').linkbutton('disable');
    }
    $('#grid2').datagrid("loadData", {total: 0, rows: []})
}

function grid2ClickHandler() {
	/*
	var plan = $('#grid1').datagrid('getSelected');
    if (plan != null && (plan.xdrmc != null || plan.xdrq != null) && $('#grid2').datagrid('getSelections').length > 0) {
    	
    	var acceptStatus = getAcceptStatus();
    	if(acceptStatus == 1) { //所有选中任务都是已认领
    		$('#btnAccept').linkbutton('disable');
    		$('#btnUnAccept').linkbutton('enable');
    	} else if(acceptStatus == 0) { //所有选中任务都是未认领
    		
    		$('#btnAccept').linkbutton('enable');
    		$('#btnUnAccept').linkbutton('disable');
    	} else {
    		
    		$('#btnAccept').linkbutton('enable');
    		$('#btnUnAccept').linkbutton('enable');
    	}
	} else {
		$('#btnAccept').linkbutton('disable');
		$('#btnUnAccept').linkbutton('disable');
	}
	*/
}

function getAcceptStatus() {
	var tasks = $("#grid2").datagrid("getSelections");
	var accepted = 0;
	for(var i=0; i<tasks.length; i++) {
		if(tasks[i].rlr != null && tasks[i].rlrq != null) {
			++accepted;
		}
	}
	
	if(accepted == 0) {
		return 0;
	} else if (accepted == tasks.length) {
		return 1;
	} else {
		return 2
	}
}

function setFormFieldStatus(formId, operation) {
    $("#" + formId + " input.easyui-validatebox." + operation).removeAttr("readonly");
    $("#" + formId + " input.easyui-validatebox." + operation).removeAttr("disabled");
    $("#" + formId + " input.easyui-combobox." + operation).combobox("enable");
    $("#" + formId + " input.easyui-numberspinner." + operation).numberspinner("enable");
    $("#" + formId + " input.easyui-datebox." + operation).datebox("enable");
    $("#" + formId + " a.easyui-linkbutton." + operation).linkbutton("enable");
    
    $("#" + formId + " input.easyui-validatebox:not(." + operation + ")").attr("readonly", true);
    $("#" + formId + " input.easyui-validatebox:not(." + operation + ")").attr("disabled", true);
    $("#" + formId + " input.easyui-combobox:not(." + operation + ")").combobox("disable");
    $("#" + formId + " input.easyui-numberspinner:not(." + operation + ")").numberspinner("disable");
    $("#" + formId + " input.easyui-datebox:not(." + operation + ")").datebox("disable");
    $("#" + formId + " a.easyui-linkbutton:not(." + operation + ")").linkbutton("disable");
}

function add() {
	window.selected = -1;
	$('#grid1').datagrid('unselectAll');
	showPlanForm();
}

function addRc() {
	window.selected = -1;
	$('#grid1').datagrid('unselectAll');
	showPlanFormb();
}

function modify() {
	var row = $('#grid1').datagrid('getSelected');
	if (row) {
		if(row.planType==1) {
			showPlanForm(row);
		} else {
			showPlanFormb(row);
		}
	}
}

function showPlanForm(data) {
	$.easyui.showDialog({
		title : "双随机计划信息",
		width : 750,
		height : 455,
		topMost : false,
		iconCls:'icon2 r16_c14',
		
		buttons:[{
			text:'保存',
			iconCls : "icon-save",
			handler:function(){
				var tab = $('#tabPanel').tabs('getSelected');
				var index = $('#tabPanel').tabs('getTabIndex',tab);
				if(index == 0 && $('#planWindow').form('validate')) {
					savePlan(1);
				} else if (index == 1) {
					//saveRoleResource();
				}
				return false;
			}
		}],
		
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		        	
		href : "./planForm.jsp",
		onLoad : function() {
			doPlanFormInit(data);
		}
	});
}

function showPlanFormb(data) {
	$.easyui.showDialog({
		title : "日常监管计划信息",
		width : 750,
		height : 455,
		topMost : false,
		iconCls:'icon2 r16_c14',
		
		buttons:[{
			text:'保存',
			iconCls : "icon-save",
			handler:function(){
				var tab = $('#tabPanelb').tabs('getSelected');
				var index = $('#tabPanelb').tabs('getTabIndex',tab);
				if(index == 0 /*&& $('#planWindowb').form('validate')*/) {
					savePlan(2);
				} else if (index == 1) {
				}
				return false;
			}
		}],
		
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		
		href : "./planFormb.jsp",
		onLoad : function() {
			doPlanFormInitb(data);
		}
	});
}

function doPlanFormInit(data) {
	$.codeListLoader.parse($('#planTable'))
	if(null != data) {
		$.easyuiExtendObj.loadForm('planTable', data);
		setFormFieldStatus("planTable", "modify");
		$('#planTable').form("validate");
	} else {
		setFormFieldStatus("planTable", "add");
	}
	
    $("#btnImportTask").click(funcImportTask);
    $("#btnImportPlan").click(funcImportPlan);
}

function doPlanFormInitb(data) {
	$.codeListLoader.parse($('#planTableb'))
	if(null != data) {
		$.easyuiExtendObj.loadForm('planTableb', data);
		setFormFieldStatus("planTableb", "modify");
		$('#planTableb').form("validate");
	} else {
		setFormFieldStatus("planTableb", "add");
		$("#k_planType").combobox("setValue", "2");
		$("#k_fl").combobox("setValue", "1");
		$("#k_djjg").val(userInfo.orgId);
		$("#k_djjgmc").val(userInfo.orgName);
		$("#k_xdr").val(userInfo.userId);
		$("#k_xdrmc").val(userInfo.name);
		$("#k_nd").val( new Date().getFullYear());
		$("#k_ksrq").datebox("setValue", (new Date()).format("YYYY-MM-DD"))
		$("#k_yqwcsj").datebox("setValue", (new Date()).format("YYYY-MM-DD"));
		$("#k_xdrq").datebox("setValue", (new Date()).format("YYYY-MM-DD"));
	}
	
	//$("#btnImportTask").click(funcImportTask);
	//$("#btnImportPlan").click(funcImportPlan);
	
}

function dispatch() {
	var row = $('#grid1').datagrid('getSelected');
	if (row) {
		var xdzt = (row.xdrmc == null && row.xdrq == null)? 0: 1;
		var action = xdzt == 0 ? '下达' : '取消下达';
		$.messager.confirm(action + '确认', '请确认是否对本计划进行<' + action + '>操作?', function (r) {
			if (r) {
				$.getJSON("./hcjh/dispatch/" + row.id + "/" + xdzt, null, function (response) {
					if (response.status == $.husky.SUCCESS) {
						$.messager.alert("提示", action + "成功", 'info');
						loadGrid1(row.id);
					} else {
						$.messager.alert("错误", action + '失败: \n' + response.message, 'info');
					}
				});
			}
		});
	}
}

function formatZfry(val, row) {
	if(row.zfryName1 != null && row.zfryName2 != null ) {
		return row.zfryName1 + "/" + row.zfryName2;
	} else if(row.zfryName1 == null ) {
		return row.zfryName2;
	} else if(row.zfryName2 == null ) {
		return row.zfryName1;
	}
}

function tabSelectHandler(title, index) {
    var planId = $('#p_id').val();
    if (index == 1) { 
        if (planId != "") {
            if ($('#p_hcrwsl').val() == "") {
                $.messager.alert("提示", "任务信息尚未导入");
                $('#tabPanel').tabs('select', 0);
                $('#btnImportTask').linkbutton('enable');
            } else {
                /*$.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForPlan", {planId:planId }, function(response) {
                 $("#grid3").datagrid("loadData", response.rows);
                 });
                 */
                var options = $("#grid3").datagrid("options");
                options.url = '../common/query?mapper=hcrwMapper&queryName=queryForPlan';
                $('#grid3').datagrid('load', {
                    planId: planId
                });
            }
        } else {
            $.messager.alert("操作错误", "请先保存计划基本信息");
            $('#tabPanel').tabs('select', 0);
        }
    }
}

function tabSelectHandlerb(title, index) {
	var planId = $('#k_id').val();
	if (index == 1) { 
		if (planId != "") {
			if ($('#k_hcrwsl').val() == "") {
				$.messager.alert("提示", "任务信息尚未添加");
				//$('#tabPanelb').tabs('select', 0);
				$('#btnImportTask').linkbutton('enable');
			} else {
				/*$.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForPlan", {planId:planId }, function(response) {
                 $("#grid3").datagrid("loadData", response.rows);
                 });
				 */
				var options = $("#grid3b").datagrid("options");
				options.url = '../common/query?mapper=hcrwMapper&queryName=queryForPlan';
				$('#grid3b').datagrid('load', {
					planId: planId
				});
			}
		} else {
			$.messager.alert("操作错误", "请先保存计划基本信息");
			$('#tabPanelb').tabs('select', 0);
		}
	}
}

function viewCheckList() {
	var row = $('#grid1').datagrid('getSelected');
	if (row) {
		showAuditItemList(row);
	}
}

function showAuditItemList(data) {
	$.easyui.showDialog({
		title : "检查事项",
		width : 750,
		height : 400,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./auditItemList.jsp",
		onLoad : function() {
			doAuditItemListInit(data);
		}
	});
}

function doAuditItemListInit(data) {
	$.codeListLoader.parse($('#auditItemListWindow'))
	if(null != data) {
		loadAuditItemList();
		$("#btnAdd4").click(funcAdd4);
		$("#btnDelete4").click(funcDelete4);
		$("#btnSave5").click(funcSave5);
		$("#btnClose5").click(funcClose5);
	}
}

function loadAuditItemList() {
	$.getJSON('../common/query?mapper=hcsxMapper&queryName=queryForPlan',  {
		hcjhId: $("#grid1").datagrid('getSelected').id
    }, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	 $("#grid4").datagrid("loadData",response);
        }
    });
}

function funcAdd4() {
    var row = $("#grid1").datagrid('getSelected');
    showModalDialog("addAuditItemWindow");
    var options = $("#grid5").datagrid("options");
    options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlanCandidate';
    $('#grid5').datagrid('load', {
        hcjhId: row.id,
        nr: row.nr
    });
}


function funcDelete4() {
	var checkedRows = $('#grid4').datagrid('getSelections');
    if(checkedRows.length == 0) {
    	$.messager.alert("操作提示", "请首先选择一项或者多项核查事项", "info");
    } else {
    	var param = new Array();
	    $.each(checkedRows, function (idx, elem) {
	        param.push(elem.id);
	    });
	    $.ajax({
	        url: "./hcjh/hcsx/" + $('#grid1').datagrid('getSelected').id,
	        type: "DELETE",
	        data: JSON.stringify(param),
	        dataType: "json",
	        contentType: 'application/json;charset=utf-8',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	            	loadAuditItemList();
	            } else {
	                $.messager.alert('失败', response.message, 'info');
	            }
	        }
	    });
    }
}

function funcSave5() {
    var checkedRows = $('#grid5').datagrid('getSelections');
    if(checkedRows.length == 0) {
    	$.messager.alert("操作提示", "请首先选择一项或者多项备选核查事项", "info");
    } else {
	    var param = new Array();
	    $.each(checkedRows, function (idx, elem) {
	        param.push(elem.id);
	    });
	
	    $.ajax({
	        url: "./hcjh/hcsx/" + $('#grid1').datagrid('getSelected').id,
	        data: JSON.stringify(param),
	        type: "put",
	        contentType: "application/json; charset=utf-8",
	        cache: false,
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	                //$.messager.alert("提示", "用户角色保存成功");
	
	            	loadAuditItemList();
	                $('#grid5').datagrid('reload')
	                /*$.messager.show({
	                 title : '提示',
	                 msg : "用户角色保存成功"
	                 });*/
	            } else {
	                $.messager.alert("错误", "检查事项保存失败");
	            }
	        }
	    });
	
	    $("#grid5").datagrid("reload");
    }
}

function funcClose5() {
    $("#addAuditItemWindow").window("close");
}

function clearInput() {
    $("#f_nd").val("");
    $("#f_id").val("");
    $("#f_jhbh").val("");
    $("#f_gsjhbh").val("");
    $("#f_jhmc").val("");
    $("#f_hcjgmc").val("");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
    $("#f_planType").combobox("setValue", "");
}

function rest() {
    clearInput();
}

//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#planTable input.easyui-numberspinner").numberspinner("disable");
    $("#planTable input.easyui-validatebox").attr("readonly", true);
    $("#planTable input.easyui-datebox").datebox("disable");
    $("#planTable input.easyui-combobox").combobox("disable");
    $("#planTable input.easyui-combotree").combotree("disable");
}

function savePlan(planType) {
    var data = planType==1? $.easyuiExtendObj.drillDownForm('planTable'): $.easyuiExtendObj.drillDownForm('planTableb');
    data.id = planType==1? $("#p_id").val(): $("#k_id").val();
	data.planType=planType;
    var url = "../31/hcjh";
    $.ajax({
        url: url,
        type: "POST",
        data: data,
        success: function (response) {
            if (response.status == $.husky.SUCCESS) {
            	if(planType==1) {
            		$('#p_id').val(response.id);
            		setReadOnlyStatus();
            		$("#btnImportTask").linkbutton("enable");
            	} else {
            		$('#k_id').val(response.id);
            	}
                loadGrid1(response.id);
                $.messager.show('操作提示', response.message, 'info', "bottomRight");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });

}
function funcImportTask() {
    $("#importTaskWindow").window("open");
}

function funcImportPlan() {
	var dialog = $.easyui.showDialog({
		title : "接口抽查计划信息",
		width : 800,
		height : 380,
		topMost : false,
		iconCls:'icon2 r16_c14',
		
		buttons:[{
			text:'确定',
			iconCls : "icon-ok",
			handler:function(){
				var selected = $('#planAbstractGrid').datagrid("getSelected");
				if(null != selected) {
					$.getJSON("./hcjh/validate/" + selected.gsjhbh, null, function(response) {
						if(response.validate) {
							$("#p_nd").val(selected.nd);
							$("#p_jhbh").val(selected.gsjhbh);
							$("#p_jhmc").val(selected.jhmc);
							$("#p_cxwh").val(selected.cxwh);
							$("#p_gsjhbh").val(selected.gsjhbh);
							$("#p_djjg").val(selected.djjg);
							$("#p_djjgmc").val(selected.djjgmc);
							
							$(dialog).dialog("close")
							return true;
						} else {
							$.messager.alert("操作提示", "该公示计划曾经导入,不能重复导入");
							return false;
						}
					});
				} else {
					$.messager.alert("操作提示", "请首先选择一项公示计划");
					return false;
				}
			}
		}],
		
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./planAbstractList.jsp",
		onLoad : function() {
			doPlanAbstractListInit();
		}
	});
}

function doPlanAbstractListInit() {
	$.getJSON("../common/query?mapper=hcjhMapper&queryName=queryPlanAbstract",  null, function (response) {
	    if (response.status == $.husky.SUCCESS) {
	    	 $("#planAbstractGrid").datagrid("loadData",response);
	    }
	});
}

function selectImportType() {
    var importType = $("#importTaskWindow input:radio:checked").val();
    $("#importTaskWindow #" + importType).show();
    $("#importTaskWindow div:not(#" + importType + ")").hide();

}

function testDblink() {
	var hcjhId = $("#p_id").val();
    $.getJSON("./hcjh/testDblink/" + hcjhId, null, function (response) {
        if (response.status == $.husky.SUCCESS) {
            $("#importReport #_hcrws").text(response.hcrws);
            $("#importReport #_hcrys").text(response.hcrys);
            $("#importReport").show();
        }
    });
}

function importDblink() {
    var hcjhId = $("#p_id").val();
    $.easyui.loading();
    $.getJSON("./hcjh/importDblink/" + hcjhId, null, function (response) {
        $.easyui.loaded();
        if (response.status == $.husky.SUCCESS) {
            $.messager.alert("提示", "数据导入成功,导入任务: " + response.hcrws, 'info');
            loadGrid1(hcjhId);
        }
    });
}

function sort1() {
	sort(1);
}

function sort2() {
	sort(2);
}

function sort(order) {
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()
	var options = $("#grid2").datagrid("options");
	var hcjh = $('#grid1').datagrid('getSelected');
    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
    $('#grid2').datagrid('load', {
        hcjhId: hcjh.id,
        organization: processorOrgId(selected[0].id),
        order:order
    });
    if(order == 1) {
    	$("#btnSort1").linkbutton("disable");
    	$("#btnSort2").linkbutton("enable");
    } else {
    	$("#btnSort1").linkbutton("enable");
    	$("#btnSort2").linkbutton("disable");
    }
}

function accept() {
	_funcAccept("accept");
}
function unAccept () {
	_funcAccept("unAccept");
}

function _funcAccept (operation) {
	var selected = $('#grid2').datagrid('getSelections');
	var validate = true;
	var datas = new Array();
	for(var i=0; i<selected.length; i++) {
		var task = selected[i];
		datas.push(task.id);
		/*if((task.zfryCode1 != userInfo.zfry && task.zfryCode2 != userInfo.zfry) || (task.rlr != null && task.rlr != "")) {
			validate = false;
			break;
		}*/
	}
	//if(validate) {
	    $.ajax({
	        url: "../51/" + selected[0].hcjhId + "/" + operation,
	        type: "POST",
	        data: JSON.stringify(datas),
	        dataType: "json",
	        contentType: 'application/json;charset=utf-8',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	            	loadGrid1(selected[0].hcjhId);
	                $('#grid2').datagrid("reload");
	            } else {
	                $.messager.alert('失败', response.message, 'info');
	            }
	        }
	    });
	/*} else {
		$.messager.alert("操作提醒", "选中的任务已认领或者没有指定到本人", "warning");
	}*/
}

//初始化
$(function () {
	$.husky.getUserInfo();
    $.fn.zTree.init($("#orgTree"), setting);
    
    //$("#btnSearch").click(loadGrid1);
    //$("#btnReset").click(funcBtnRest);
    
    //$("#btnAdd").click(add);
    //$("#btnAddRc").click(addRc);
    //$("#btnModify").click(modify);
    //$("#btnDispatch").click(dispatch);
    //$("#btnViewCheckList").click(viewCheckList);
    
    //$("#btnSort1").click(funcSort1);
    //$("#btnSort2").click(funcSort2);
    //$("#btnAccept").click(funcAccept);
    //$("#btnUnAccept").click(funcUnAccept);
    //$("#f_nd").val( new Date().getFullYear());
    clearInput();
   
    if (null != window.userInfo) {
        showPlanListWindow();
    } else {
        $.subscribe("USERINFO_INITIALIZED", showPlanListWindow);
    }
    //$("#btnSavePlan").click(funcSavePlan);
    $("#importTaskWindow input:radio").click(selectImportType);

    //$("#btnTestDblink").click(testDblink);
    //$("#btnImportDblink").click(importDblink);


});

