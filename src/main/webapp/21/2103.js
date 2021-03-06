window.operateType = "";//操作类型

//设置页面为编辑状态
function setEditStatus() {
    //$("#btnAdd").linkbutton('disable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnDelete").linkbutton("disable");
    }

    $("#baseInfo input.easyui-validatebox").attr("readonly", true);
    $("#baseInfo input.easyui-numberbox").numberbox("enable");
    $("#baseInfo input.easyui-datebox").datebox("enable");
    $("#baseInfo input.easyui-combobox").combobox("enable");

}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnDelete").linkbutton("disable");
    }

    $("#baseInfo input.easyui-validatebox").removeAttr("readonly");
    $("#baseInfo input.easyui-numberbox").numberbox("disable");
    $("#baseInfo input.easyui-datebox").datebox("disable");
    $("#baseInfo input.easyui-combobox").combobox("disable");
}
//通用保存函数
function save() {
    var data = $.easyuiExtendObj.drillDownForm('baseInfo');
    //data.hcffsm = $("#p_hcffsm").val();
    var type = "";
    var url = "";
    if (window.operateType == "add") {//增加本级
        type = "POST";
        url = "../21/2103";
    }
    if (window.operateType == "edit") {//修改
        type = "POST";
        url = "../21/2103";
        data._method = "put";
    }
    if (window.operateType == "delete") {//删除
        type = "DELETE";
        data = {"id": $("#p_id").val()};
        data = JSON.stringify(data);
        url = "../21/2103?id=" + $("#p_id").val();
    }
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: function (response) {
            if (response.status == SUCCESS) {
                setReadOnlyStatus();
                loadMainGrid();
                $("#btnView").linkbutton("disable");
                $("#btnDelete").linkbutton("disable");
                $("#baseWindow").window("close");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });
}

//删除按钮点击事件
function btnDeleteClick() {
    if (!$(this).linkbutton('options').disabled) {
    	var row = $("#mainGrid").datagrid("getSelected");
		if(null != row) {
			$.messager.confirm("请确认是否删除该检查项?", function (c) { if(c){
				$.ajax({
			        url: "../21/2103?id=" + row.id,
			        type: "DELETE",
			        success: function (response) {
			            if (response.status == SUCCESS) {
			                setReadOnlyStatus();
			                loadMainGrid();
			                $("#btnView").linkbutton("disable");
			                $("#btnDelete").linkbutton("disable");
			                $("#baseWindow").window("close");
			            } else {
			                $.messager.alert('失败', response.message, 'info');
			            }
			        }
			    });
				
			}});
		}
    }
}

function funcDisable() {
	if (!$(this).linkbutton('options').disabled) {
		var row = $("#mainGrid").datagrid("getSelected");
		if(null != row) {
			if(row.zxrq == null && row.zxsm == null) {
				$.messager.prompt("请输入注销说明:", function (text) { if (text != undefined) { 
					disableAuditItem(1, row.id, text);
				}});
			} else {
				$.messager.confirm("请确认是否取消注销?", function (c) { if(c){
					disableAuditItem(0, row.id);
				}});
			}
		}
	}
}

function disableAuditItem(disableFlag, auditItemId, zxsm) {
	$.post("../21/2103/" + auditItemId + "/disable", {
		disableFlag: disableFlag,
		zxsm: zxsm
    }, function(response) {
        if(response.status == FAIL){
            $.messager.alert('错误', response.message, 'error');
        } else {
            //$("#mainGrid").datagrid("reload");
            loadMainGrid();
            $.messager.show({
                title : '提示',
                msg : response.message
            });
        }
    }, "json");
}


function funcAdd() {
	window.selected = -1;
	$('#mainGrid').datagrid('unselectAll');
	if (!$(this).linkbutton('options').disabled) {
		window.operateType = "add";
		showAuditItemForm();
	}
	
}

function funcView() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			window.operateType = "edit";
			showAuditItemForm(row);
		}
	}
}

function showAuditItemForm(data) {
	$.easyui.showDialog({
		title : "修改抽检事项信息",
		width : 750,
		height : 450,
		topMost : false,
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./auditItem.jsp",
		onLoad : function() {
			//$.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
			doAuditItemFormInit(window.operateType);
		},
		onSave: function (d) {
            var validate = d.form("validate");
            if (validate) {
                save();
            } else {
                return false;
            }
        }
	});
    setEditStatus();
}

function showEnterpriseTypeWindow() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	if(auditItem != null) {
		$.easyui.showDialog({
			title : "关联企业类型",
			iconCls: 'icon2 r8_c14',
			width : 470,
			height : 380,
			topMost : false,
			enableSaveButton : true,
			enableApplyButton : false,
			saveButtonText : "保存",
			closeButtonText : "返回",
			closeButtonIconCls : "icon-undo",
			href : "./enterpriseTypeList.jsp",
			onLoad : function() {
				doEnterpriseTypeListInit();
			},
			onSave : function() {
				doEnterpriseTypeListSave();
			}
		});
	}
}

function funcShowDocWindow() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	if(auditItem != null) {
		$.easyui.showDialog({
			title : "抽检材料清单",
			iconCls: 'icon2 r8_c14',
			width : 750,
			height : 420,
			topMost : false,
			enableSaveButton : false,
			enableApplyButton : false,
			closeButtonText : "返回",
			closeButtonIconCls : "icon-undo",
			href : "./docList.jsp",
			onLoad : function() {
				doDocListInit();
			}
		});
	}
}

function funcShowComment() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	if(auditItem != null) {
		$.easyui.showDialog({
			title : "常见问题说明",
			width : 750,
			height : 420,
			topMost : false,
			enableSaveButton : false,
			enableApplyButton : false,
			closeButtonText : "返回",
			closeButtonIconCls : "icon-undo",
			href : "./commentList.jsp",
			onLoad : function() {
				doCommentListInit();
			}
		});
	}
}

function doCommentListInit() {
	$("#btnAddComment").click(funcAddComment); 
	$("#btnModifyComment").click(funcModifyComment);
	$("#btnRemoveComment").click(funcRemoveComment);
	var auditItem = $("#mainGrid").datagrid("getSelected");
	$("#_name_comment_").text(auditItem.name);
	loadCommentGrid(auditItem.id);
}

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnDisable').linkbutton('enable');
		$('#btnShowEnterpriseTypeWindow').linkbutton('enable');
		$('#btnShowDocWindow').linkbutton('enable');
		$('#btnShowComment').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnDisable').linkbutton('disable');
		$('#btnShowEnterpriseTypeWindow').linkbutton('disable');
		$('#btnShowDocWindow').linkbutton('disable');
		$('#btnShowComment').linkbutton('disable');
	}
}

function hclxStyler(val, row, index) {
	if (val == 1) {
		return "background-color:lightgreen";
    } else if (val == 2) {
        return "background-color:orange";
    }
}

function hcffStyler(val, row, index) {
	if (val == 1) {
		return "color:blue";
	} else if (val == 2) {
		return "color:orange";
	} else if (val == 3) {
		return "color:green";
	}
}

function hcxxflStyler(val, row, index) {
	if (val == 1) {
		return "color:blue";
	} else if (val == 2) {
		return "color:red";
	}
}

function loadMainGrid() {
	$("#mainGrid").datagrid("load", {
		gsxm: $('#f_gsxm').val(),
		hclx: $('#f_hclx').combobox("getValue"),
		hcxxfl: $('#f_hcxxfl').combobox("getValue")
    });
}

function funcBtnRest() {
    clearInput();
}

function clearInput() {
    $("#f_gsxm").val("");
    $("#f_hclx").combobox("setValue", "");
    $("#f_hcxxfl").combobox("setValue", "");
}

$(function () {
	
	$("#btnSearch").click(loadMainGrid);
    $("#btnReset").click(funcBtnRest);
    
    $("#btnAdd").click(funcAdd);
    $("#btnView").click(funcView);
    $("#btnDelete").click(btnDeleteClick);
    $("#btnDisable").click(funcDisable);
    $("#btnShowEnterpriseTypeWindow").click(showEnterpriseTypeWindow);
    $("#btnShowDocWindow").click(funcShowDocWindow);
    $("#btnShowComment").click(funcShowComment);

    setReadOnlyStatus();
    clearInput();
});