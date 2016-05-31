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
                $("#mainGrid").datagrid("reload");
                $("#btnView").linkbutton("disable");
                $("#btnDelete").linkbutton("disable");
                $("#baseWindow").window("close");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });

}

//修改按钮点击事件
function btnViewClick() {
    if (!$(this).linkbutton('options').disabled) {
    	$.easyui.showDialog({
    		title : "修改抽检事项信息",
    		width : 750,
    		height : 400,
    		topMost : false,
    		enableSaveButton : true,
    		enableApplyButton : false,
    		closeButtonText : "返回",
    		closeButtonIconCls : "icon-undo",
    		href : "./auditItem.jsp",
    		onLoad : function() {
    			window.operateType="edit";
    			//$.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
    			doInit("edit");
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
    	
      
       /* 
        $("#basePanel").panel({
		    href:'./auditItem.jsp',
		    onLoad:function(){
		    	doInit("edit");
		    }
		});*/
        setEditStatus();
    }
}
//删除按钮点击事件
function btnDeleteClick() {
    if (!$(this).linkbutton('options').disabled) {
        window.operateType = "delete";
        save();
        setReadOnlyStatus();
    }
}
//新增按钮点击事件
function btnAddClick() {
    if (!$(this).linkbutton('options').disabled) {
        showModalDialog("baseWindow", "新抽检事项信息");
        $("#baseInfo").form('clear');
        window.operateType = "add";
        
        $("#basePanel").panel({
		    href:'./auditItem.jsp',
		    onLoad:function(){
		    	doInit("add");
		    }
		});
        
        setEditStatus();
    }
}

function funcShowDocWindow() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	if(auditItem != null) {
		showModalDialog("docWindow");
		$("#docPanel").panel({
		    href:'./docList.jsp',
		    onLoad:function(){
		    	doInit();
		    }
		});
	}
}

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnDrop').linkbutton('enable');
		$('#btnShowDocWindow').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnDrop').linkbutton('disable');
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

$(function () {
    $("#btnAdd").click(btnAddClick);
    $("#btnView").click(btnViewClick);
    $("#btnDelete").click(btnDeleteClick);
    $("#btnShowDocWindow").click(funcShowDocWindow);

    setReadOnlyStatus();

    $("#mainGrid").datagrid({
    	url:'../common/query?mapper=hcsxMapper&queryName=query',
        onSelect: function (index, row) {
            $("#btnView").linkbutton("enable");
            $("#btnDelete").linkbutton("enable");
        },
        onUnselect: function (index, row) {
            $("#btnView").linkbutton("disable");
            $("#btnDelete").linkbutton("disable");
        }
    });

});