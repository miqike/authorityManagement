

function collapseHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		
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


function poiExport() {
    $("<iframe id='poiExport' style='display:none' src='../user/poiExport'>") .appendTo("body");
}

function showExamHistory() {
	showModalDialog("examHistory");
}

//---------------
function loadMyTask() {
	var options = $("#grid1").datagrid("options");
	options.url = '../common/query?mapper=hcrwMapper&queryName=queryForAuditor';
	$('#grid1').datagrid('load',{
		
	});
}

function grid1ClickHandler() {
	//控制四个按钮显示
	//加载右侧grid
	var options = $("#mainGrid").datagrid("options");
	options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
	$('#mainGrid').datagrid('load',{
		hcrwId:"1"
	});
}

$(function() {
	$("#btnView").click(showExamHistory);
	loadMyTask();
});