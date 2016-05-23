

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

function queryPlan(node){
	var _orgId = $("#f_deptName").combobox("getValue");
	if(_orgId != "" ) {
		var orgId = new Array();
		orgId.push(_orgId);
		xxxx(orgId);
	} else if(window.orgTreeObj) {
		queryPlanFromTree();
	}
}

function xxxx(orgId) {
	var year = $("#f_year").numberspinner('getValue');
	window.planGridKey = {year:year, tOrgId:orgId, excludeSaved: excludeSaved};
	if(orgId != undefined && orgId != null )
		refreshFunGrid(orgId);
}
//================

function onTreeClick(event, treeId, treeNode, clickFlag) {
	
	console.log(treeNode);
	
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()

	if(selected.length == 1) {
		var options = $("#grid2").datagrid("options");
		options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
		$('#grid2').datagrid('load',{
			organization: selected[0].id
		});

	} else {
	}
}
//初始化
$(function() {
	$.fn.zTree.init($("#orgTree"), setting);
    /*$("#btnAdd").click(funAdd);
	$("#btnUpdate").click(update);
	$("#btnDelete").click(remove);
	$("#btnSubmit").click(funSubmit);
	$("#btnAddPlan").hide();*/
});

