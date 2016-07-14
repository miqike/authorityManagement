function mainGridButtonHandler() {
	var row = $('#mainGrid').datagrid('getSelected');
	if(row != null && row.content != undefined) {
        $('#btnShowDetail').linkbutton('enable');
    } else {
        $('#btnShowDetail').linkbutton('disable');
    }
}

function mainGridDblClickHandler(index,row) {
	view(null);
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
    if(data.status == SUCCESS) {
        $('#mainGrid').datagrid('unselectAll');
        $('#btnShowDetail').linkbutton('disable');
    } else {
    	$.messager.alert("错误", data.stack);
    }
}

function view(event){
    if(event == null || !$(this).linkbutton('options').disabled) {
        var row = $('#mainGrid').datagrid('getSelected');
        if (row && row.content != undefined) {
            $('#message').text(row.message);
            $('#content').text(row.content);
            showModalDialog("popWindow");
        }
    }
}

$(function() {
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
	
	$("#btnSearch").click(function(){
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
	});
	
	$("#btnReset").click(function(){
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
	});
	
	$('#btnShowDetail').linkbutton('disable').click(view);
	
});