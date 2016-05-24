

window.excludeSaved = false;




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

function grid1clickHandler() {
	if($('#grid1').datagrid('getSelected') != null) {
		$('#btnModify').linkbutton('enable');
		$('#btnAudit').linkbutton('enable');
		$('#btnViewCheckList').linkbutton('enable');
		if($('#grid1').datagrid('getSelected').status == 2) {
			$('#btnAudit').linkbutton({
				text:'审核',
				iconCls: 'icon2 r14_c2'
			});
		} else {
			$('#btnAudit').linkbutton({
				text:'取消审核',
				iconCls: 'icon2 r14_c1'
			});
		}
	} else {
		$('#btnModify').linkbutton('disable');
		$('#btnAudit').linkbutton('disable');
		$('#btnViewCheckList').linkbutton('disable');
	}
}

function add() {
	$('#planWindow input').val('');
	showModalDialog("planWindow");
	$('#planTable input.easyui-textbox').textbox("enable");
	$('#planTable input.easyui-combobox').combobox("enable");
	$("#btnEditOrSave").linkbutton({
		iconCls:'icon-save',
		text:'保存'
	});
	$('#tabPanel').tabs('select',0 );
}

function modify() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid1').datagrid('getSelected');
		if (row) {
			$.easyuiExtendObj.loadForm("planTable", row);
			showModalDialog("planWindow");
			/*$("#btnEditOrSave").parent().css("text-align", " left");
			$('#userWindow input.easyui-validatebox').validatebox();*/
		}
		;
		/*$("#tg").parent().find("input:checkbox").attr("disabled", true);
		$("#grid2").parent().find("input:checkbox").attr("disabled", true);*/
		$('#tabPanel').tabs('select', 0);
	}
}

function audit() {
	
}

function formatZfry(val, row) {
	return row.zfryName1 + "/" + row.zfryName2 ;
}

function tabSelectHandler(title, index) {
	var planId = $('#p_id').textbox('getValue');
	if(index == 1) { //选择角色TAB
		if(planId != "") {
			$.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForPlan", {planId:planId }, function(response) {
				$("#grid3").datagrid("loadData", response.rows);
				
			});
		} else {
			$.messager.alert("操作错误", "请先保存用户基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	}
}

function viewCheckList(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $("#grid1").datagrid('getSelected');
		
		showModalDialog("checklistWindow");
		var options = $("#grid4").datagrid("options");
		options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlan';
		$('#grid4').datagrid('load',{
			hcjhId: row.id
		});
	}
}

function funcAdd4() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $("#grid1").datagrid('getSelected');
		
		showModalDialog("addChecklistWindow");
		var options = $("#grid5").datagrid("options");
		options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlanCandidate';
		$('#grid5').datagrid('load',{
			hcjhId: row.id
		});
	}
}

function funcClose4() {
	$("#checklistWindow").window("close");
}

function funcSave5() {
	
	var checkedRows = $('#grid5').datagrid('getSelections');
	var param = new Array();
	$.each(checkedRows, function(idx, elem) {
		param.push(elem.id);
	});

	$.ajax({
		url:"./hcjh/hcsx/" + $('#grid1').datagrid('getSelected').id,
		data:JSON.stringify(param),
		type:"put",
		contentType: "application/json; charset=utf-8",
		cache:false,
		success: function(response) {
			if(response.status == SUCCESS) {
				//$.messager.alert("提示", "用户角色保存成功");
				
				$('#grid4').datagrid('reload')
				$('#grid5').datagrid('reload')
				/*$.messager.show({
					title : '提示',
					msg : "用户角色保存成功"
				});*/
			} else {
				$.messager.alert("错误", "核查事项保存失败");
			}
		}
	});
	
	$("#grid5").datagrid("reload");
	//$("#addChecklistWindow").window("close");
}


function funcClose5() {
	$("#addChecklistWindow").window("close");
}


//初始化
$(function() {
	$.fn.zTree.init($("#orgTree"), setting);
    $("#btnAdd").click(add);
	$("#btnModify").click(modify);
	$("#btnAudit").click(audit);
	$("#btnViewCheckList").click(viewCheckList);
	$("#btnAdd4").click(funcAdd4);
	$("#btnClose4").click(funcClose4);
	$("#btnSave5").click(funcSave5);
	$("#btnClose5").click(funcClose5);
	/*
	$("#btnAddPlan").hide();*/
});

