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
        type = "PUT";
        url = "../21/2103";
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
			$.messager.confirm("请确人是否删除该检查项?", function (c) { if(c){
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
				$.messager.confirm("请确人是否取消注销?", function (c) { if(c){
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

function funcShowDocWindow() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	if(auditItem != null) {
		showModalDialog("docWindow");
		$("#docPanel").panel({
		    href:'./docList.jsp',
		    onLoad:function(){
		    	doDocListInit();
		    }
		});
	}
}

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnDisable').linkbutton('enable');
		$('#btnShowDocWindow').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnDisable').linkbutton('disable');
		$('#btnShowDocWindow').linkbutton('disable');
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
	
	$.getJSON("../common/query?mapper=hcsxMapper&queryName=query", {
		gsxm: $('#f_gsxm').val(),
		hclx: $('#f_hclx').combobox("getValue"),
		hcxxfl: $('#f_hcxxfl').combobox("getValue")
    }, function (response) {
        if (response.status == SUCCESS) {
        	 $("#mainGrid").datagrid("loadData",response);
        }
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
    $("#btnShowDocWindow").click(funcShowDocWindow);

    setReadOnlyStatus();

    clearInput();
    loadMainGrid();
    

});