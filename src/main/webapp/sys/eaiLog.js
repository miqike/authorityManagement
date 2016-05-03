function mainGridButtonHandler() {
	var row = $('#mainGrid').datagrid('getSelected');
	if(row != null) {
		$('#btnShowDetail').linkbutton('enable');
	} else {
		$('#btnShowDetail').linkbutton('disable');
	}
}

function formatInterfaceType(val, row) {
    if(val == undefined) {
        return "";
    } else if(val == 'client') {
        return '<span class="icon2 r3_c9" style="width: 16px;height: 16px;line-height: 16px;"></span>';
    } else {
        return '<span class="icon-back" style="display: inline-block;width: 16px;height: 16px;line-height: 16px;"></span>';
    }
}

function formatLogLevel(val, row) {
    if(val == undefined) {
        return "";
    } else if(val == 'INFO') {
        return '<span class="icon2 r1_c1"></span>';
    } else if(val == 'WARN') {
        return '<span class="icon2 r20_c6"></span>';
    } else if(val == 'ERROR') {
        return '<span class="icon2 r7_c8"></span>';
    } else {
        return "";
    }
}


function format(state) {
    if (!state.id) return state.text; // optgroup
    return state.text;
}

function loadSuccess(data) {
	$('#mainGrid').datagrid('unselectAll');
	$('#btnShowDetail').linkbutton('disable');
}

function tabSelectHandler(title, index) {
    var row = $('#mainGrid').datagrid('getSelected');

    if(index != 0) {
        $("#tabPanel").tabs('getSelected').panel({href:'./eaiLog/message?type=' + index + '&id=' + row.id});
    }
}

function mainGridDblClickHandler(index,row) {
	view(null);
}

function view(event){
	if(event == null || !$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
        if (row) {
            showModalDialog("popWindow");
			if(row.interfaceType == "server") {
				$.getJSON("./inboundInterface/" + row.interfaceCode, null, function (response) {
					loadForm($('#inboundInterfaceTable'), response.data);
					$('#inboundInterfaceTable').show();
					$('#outboundInterfaceTable').hide();
				});
			} else {
				$.getJSON("./outboundInterface/" + row.interfaceCode, null, function (response) {
					loadForm($('#outboundInterfaceTable'), response.data);
					$('#inboundInterfaceTable').hide();
					$('#outboundInterfaceTable').show();
				});
			}
        }
    }
}

$(function() {
	$("html").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
	
	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			businessKey: $("#f_businessKey").val(), 
			errorNo: $("#f_errorNo").val(),
			operator: $("#f_operator").val(),
			company: $("#f_company").val(),
			level: $("#f_level").val(),
			hostIp: $("#f_hostIp").val(),
			hostPort: $("#f_hostPort").val(),
			startTime: $("#f_startTime").datetimebox("getValue"),
			endTime: $("#f_endTime").datetimebox("getValue"),
			key: $("#f_key").val()
		});
	});
	
	$("#btnReset").click(function(){
		$("#f_businessKey").val(""), 
		$("#f_errorNo").val(""),
		$("#f_operator").val(""),
		$("#f_company").val(""),
		$("#f_module").val(""),
		$("#f_level").val(""),
		$("#f_hostIp").val(""),
		$("#f_hostPort").val(""),
		$("#f_startTime").datetimebox("setValue", ""),
		$("#f_endTime").datetimebox("setValue", ""),
		$("#f_key").val("");
	});
	
	$('#btnShowDetail').linkbutton('disable').click(view);

});