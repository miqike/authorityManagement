

window.excludeSaved = false;


function funSubmit(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $("#planGrid").datagrid('getSelected');
		$.messager.confirm("确认", "是否确认提交票据计划?", function(r){
			if(r) {
				$.post("./submitPlan",{planId: row.bi1501, status: 1},
					function(response){
						if(response.status == SUCCESS) {
							refreshFunGrid();
						} else {
                            $.messager.alert("警告", combineErrorMessage(response), "warning");
						}
					}, 'json');
			}
		});
	}
}

function showPlanDetail() {
	var row = $("#grid1").datagrid('getSelected');
	/*window.billType = window.billTypeMap[row.ba01861];
	if(row.bi1522 == 0) {
        $("#btnUpdate").linkbutton("enable");
        $("#btnDelete").linkbutton("enable");
		$("#btnSubmit").linkbutton("enable");
	} else {
		disableUpdateAndDeleteButton();
	}

	$.getJSON('../common/query?mapper=bi15DMapper&queryName=selectByBi1501',
		{ bi1501:row.bi1501},
		function(response){
			$('#planDetailGrid').datagrid('loadData',response.rows);
		});*/
}

function depNameChangeHandler() {
	$('#btnAddItem').linkbutton('enable');
	var orgId = $("#deptName").combobox('getValue');
	getBillType(orgId);
}

function collapseHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}

//初始化
$(function() {
    $("#btnAdd").click(funAdd);
	$("#btnUpdate").click(update);
	$("#btnDelete").click(remove);
	$("#btnSubmit").click(funSubmit);
	$("#btnAddPlan").hide();
});

