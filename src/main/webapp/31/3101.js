window.excludeSaved = false;

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
        $("#btnAccept").linkbutton("disable");
    } else {
        $("#btnSort1").linkbutton("disable");
        $("#btnSort2").linkbutton("disable");
        $("#btnAccept").linkbutton("disable");
    }
}

function grid1LoadSucessHandler(data) {
	$('#btnModify').linkbutton('disable');
    $('#btnDispatch').linkbutton('disable');
    $('#btnViewCheckList').linkbutton('disable');
    $('#grid1').datagrid('selectRow', 0);
}

function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnModify').linkbutton('enable');
        $('#btnDispatch').linkbutton('enable');
        $('#btnViewCheckList').linkbutton('enable');
        var row = $('#grid1').datagrid('getSelected');
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
        $('#btnModify').linkbutton('disable');
        $('#btnDispatch').linkbutton('disable');
        $('#btnViewCheckList').linkbutton('disable');
    }
    $('#grid2').datagrid("loadData", {total: 0, rows: []})
}

function grid2ClickHandler() {
    /*if ($('#grid2').datagrid('getSelected') != null) {
        $('#btnShowDetail').linkbutton('enable');
    } else {
        $('#btnShowDetail').linkbutton('disable');
    }
    */
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
	if (!$(this).linkbutton('options').disabled) {
		showPlanForm();
	}
	
}

function modify() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid1').datagrid('getSelected');
		if (row) {
			showPlanForm(row);
		}
	}
}

function showPlanForm(data) {
	$.easyui.showDialog({
		title : "检查计划信息",
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
					savePlan();
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

function dispatch() {
	if (!$(this).linkbutton('options').disabled) {
		var row = $('#grid1').datagrid('getSelected');
		if (row) {
			var xdzt = (row.xdrmc == null && row.xdrq == null)? 0: 1;
			var action = xdzt == 0 ? '下达' : '取消下达';
			$.messager.confirm(action + '确认', '请确认是否对本计划进行<' + action + '>操作?', function (r) {
				if (r) {
					$.getJSON("./hcjh/dispatch/" + row.id + "/" + xdzt, null, function (response) {
						if (response.status == SUCCESS) {
							$.messager.alert("提示", action + "成功", 'info');
							loadGrid1();
						} else {
							$.messager.alert("错误", action + '失败: \n' + response.message, 'info');
						}
					});
				}
			});
		}
	}
}

function formatZfry(val, row) {
    return row.zfryName1 + "/" + row.zfryName2;
}

function tabSelectHandler(title, index) {
    var planId = $('#p_id').val();
    if (index == 1) { //选择角色TAB
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

function viewCheckList() {
    if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid1').datagrid('getSelected');
		if (row) {
			showAuditItemList(row);
		}
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
        if (response.status == SUCCESS) {
        	 $("#grid4").datagrid("loadData",response);
        }
    });
}

function funcAdd4() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $("#grid1").datagrid('getSelected');
        showModalDialog("addAuditItemWindow");
        var options = $("#grid5").datagrid("options");
        options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlanCandidate';
        $('#grid5').datagrid('load', {
            hcjhId: row.id,
            nr: row.nr
        });
    }
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
	            if (response.status == SUCCESS) {
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
	            if (response.status == SUCCESS) {
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

function loadGrid1() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').numberspinner("getValue"),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}

function clearInput() {
    $("#f_id").val("");
    $("#f_jhbh").val("");
    $("#f_gsjhbh").val("");
    $("#f_jhmc").val("");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function funcBtnRest() {
    $("#f_nd").val( new Date().getFullYear());
    clearInput();
}

/*function funcSavePlan() {
    //debugger;
    if ($("#planTable").form('validate') && !$(this).linkbutton('options').disabled) {
        savePlan();
    }
}*/

//设置页面为不可编辑状态
function setReadOnlyStatus() {
    /*$("#btnAdd").linkbutton('enable');
     $("#btnEdit").linkbutton('enable');
     $("#btnDelete").linkbutton('enable');
     $("#btnSave").linkbutton('disable');
     $("#btnCancel").linkbutton('disable');*/

    $("#planTable input.easyui-numberspinner").numberspinner("disable");
    $("#planTable input.easyui-validatebox").attr("readonly", true);
    $("#planTable input.easyui-datebox").datebox("disable");
    $("#planTable input.easyui-combobox").combobox("disable");
    $("#planTable input.easyui-combotree").combotree("disable");
}

function savePlan() {
    var data = $.easyuiExtendObj.drillDownForm('planTable');
    data.id = $("#p_id").val();
    var type = "";
    var url = "../31/hcjh";
    $.ajax({
        url: url,
        type: "POST",
        data: data,
        success: function (response) {
            if (response.status == SUCCESS) {
                $('#p_id').val(response.id);
                setReadOnlyStatus();
                $("#btnImportTask").linkbutton("enable");
                loadGrid1();
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });

}
function funcImportTask() {
    if (!$(this).linkbutton('options').disabled) {
        showModalDialog("importTaskWindow");
    }
}

function funcImportPlan() {
	if (!$(this).linkbutton('options').disabled) {
		var dialog = $.easyui.showDialog({
			title : "接口抽查计划信息",
			width : 650,
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
								$("#p_nd").numberspinner("setValue", selected.nd);
								$("#p_jhbh").val(selected.gsjhbh);
								$("#p_jhmc").val(selected.jhmc);
								$("#p_cxwh").val(selected.cxwh);
								$("#p_gsjhbh").val(selected.gsjhbh);
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
}

function doPlanAbstractListInit() {
	$.getJSON("../common/query?mapper=hcjhMapper&queryName=queryPlanAbstract",  null, function (response) {
	    if (response.status == SUCCESS) {
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
        if (response.status == SUCCESS) {
            $("#importReport #_hcrws").text(response.hcrws);
            $("#importReport #_hcrys").text(response.hcrys);
            $("#importReport").show();
        }
    });
}

function importDblink() {
    if (!$(this).linkbutton('options').disabled) {
        var hcjhId = $("#p_id").val();
        $.easyui.loading();
        $.getJSON("./hcjh/importDblink/" + hcjhId, null, function (response) {
            $.easyui.loaded();
            if (response.status == SUCCESS) {
                $.messager.alert("提示", "数据导入成功,导入任务: " + response.hcrws, 'info');
                loadGrid1();
            }
        });
    }
}

function funcSort1() {
	if (!$(this).linkbutton('options').disabled) {
		sort(1);
	}
}
function funcSort2() {
	if (!$(this).linkbutton('options').disabled) {
		sort(2);
	}
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

function funcAccept() {
	if (!$(this).linkbutton('options').disabled) {
		_funcAccept("accept");
	}
}
function funcUnAccept () {
	if (!$(this).linkbutton('options').disabled) {
		_funcAccept("unAccept");
	}
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
	            if (response.status == SUCCESS) {
	            	loadGrid1();
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
	
	getUserInfo();
    $.fn.zTree.init($("#orgTree"), setting);
    
    $("#btnSearch").click(loadGrid1);
    $("#btnReset").click(funcBtnRest);
    
    $("#btnAdd").click(add);
    $("#btnModify").click(modify);
    $("#btnDispatch").click(dispatch);
    $("#btnViewCheckList").click(viewCheckList);
    
    $("#btnSort1").click(funcSort1);
    $("#btnSort2").click(funcSort2);
    $("#btnAccept").click(funcAccept);
    $("#btnUnAccept").click(funcUnAccept);
    $("#f_nd").val( new Date().getFullYear());
    clearInput();
   
    
    //$("#btnSavePlan").click(funcSavePlan);
    $("#importTaskWindow input:radio").click(selectImportType);

    $("#btnTestDblink").click(testDblink);
    $("#btnImportDblink").click(importDblink);


    /*
     */
});

