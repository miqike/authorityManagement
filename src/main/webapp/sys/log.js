function mainGridButtonHandler() {
	var row = $('#mainGrid').datagrid('getSelected');
	if(row != null && row.content != undefined) {
        $('#btnShowDetail').linkbutton('enable');
    } else {
        $('#btnShowDetail').linkbutton('disable');
    }
}

function mainGridDblClickHandler(index,row) {
	showDetail(null);
}

function mainGridLoadErrorHandler() {
	alert("---")
}

function logLevelStyler(value, rowData, rowIndex) {
	if(value == 'WARN') {
		return 'background-color:#FFCC00;';
	} else if (value == 'ERROR') {
		return 'background-color:#FF6666;';
	}
} 

function format(state) {
    if (!state.id) return state.text; // optgroup
    return state.text;
}

function loadSuccessHandler(data) {
    if(data.status == $.husky.SUCCESS) {
        $('#mainGrid').datagrid('unselectAll');
        $('#btnShowDetail').linkbutton('disable');
        $('#f_lastIdString').val(data.rows[data.rows.length - 1].idString);
    } else {
    	$.messager.alert("错误", data.message);
    }
}

function showDetail(){
    var row = $('#mainGrid').datagrid('getSelected');
    if (row && row.content != undefined) {
        $.easyui.showDialog({
        	title:"详细信息",
        	width: 750, height: 430,
        	modal:true,
        	iconCls:'icon-search',
            topMost: false,
            href: "./logDetail.jsp",
            enableSaveButton : false,
        	enableApplyButton : false,
        	closeButtonText : "返回",
        	closeButtonIconCls : "icon-undo",
        	onLoad : function() {
        		 $('#message').text(row.message);
        	     $('#content').text(row.content);
    		}
        });
    }
}

function search(){
	var queryObj = {
		businessKey: $("#f_businessKey").val(), 
		errorNo: $("#f_errorNo").val(),
		operator: $("#f_operator").val(),
		org: $("#f_org").val(),
		module: $("#f_module").val(),
		logLevel: $("#f_logLevel").val(),
		hostIp: $("#f_hostIp").val(),
		hostPort: $("#f_hostPort").val(),
		key: $("#f_key").val()
	};
	
	if($("#f_startTime").datetimebox("getValue") != '') {
		queryObj.startTime = datetimeParser($("#f_startTime").datetimebox("getValue")).getTime();
	}

	if($("#f_endTime").datetimebox("getValue") != '') {
		queryObj.endTime = datetimeParser($("#f_endTime").datetimebox("getValue")).getTime();
	}
	
	$('#mainGrid').datagrid('load',queryObj);
}

function reset(){
	$("#f_businessKey").val(""), 
	$("#f_errorNo").val(""),
	$("#f_operator").val(""),
	$("#f_org").val(""),
	$("#f_module").val(""),
	$("#f_logLevel").val(""),
	$("#f_hostIp").val(""),
	$("#f_hostPort").val(""),
	$("#f_startTime").datetimebox("setValue", ""),
	$("#f_endTime").datetimebox("setValue", ""),
	$("#f_key").val("");
}

