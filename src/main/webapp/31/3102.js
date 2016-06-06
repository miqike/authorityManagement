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
	 var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	    var selected = treeObj.getSelectedNodes();
	    var hcjh = $('#grid1').datagrid('getSelected');
	    if (selected.length == 1 && hcjh != null) {
	    	loadGrid2();

	        $("#btnViewDetail").linkbutton("enable");
	    } else {
	        $("#btnViewDetail").linkbutton("disable");
	    }
}

function loadGrid2() {
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()
	var options = $("#grid2").datagrid("options");
	var hcjh = $('#grid1').datagrid('getSelected');
    options.url = '../common/query?mapper=hcrwTjMapper&queryName=queryForOrg';
    $('#grid2').datagrid('load', {
        hcjhId: hcjh.id,
        organization: selected[0].id
    });
}

function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnViewCheckList').linkbutton('enable');
    } else {
        $('#btnViewCheckList').linkbutton('disable');
    }
    $('#grid2').datagrid("loadData", {total: 0, rows: []})
}

function viewCheckList() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $("#grid1").datagrid('getSelected');

        showModalDialog("checklistWindow");
        var options = $("#grid4").datagrid("options");
        options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlan';
        $('#grid4').datagrid('load', {
            hcjhId: row.id
        });
    }
}

function clearInput() {
    $("#f_id").val("");
    $("#f_jhbh").textbox("setValue", "");
    $("#f_gsjhbh").textbox("setValue", "");
    $("#f_jhmc").textbox("setValue", "");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function loadGrid1() {
    var options = $("#grid1").datagrid("options");
    options.url = '../common/query?mapper=hcjhMapper&queryName=query';
    $('#grid1').datagrid('load', {
        nd: $('#f_nd').numberspinner("getValue"),
        jhbh: $('#f_jhbh').textbox("getValue"),
        gsjhbh: $('#f_gsjhbh').textbox("getValue"),
        jhmc: $('#f_jhmc').textbox("getValue"),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}

function funcBtnRest() {
    $("#f_nd").textbox("setValue", new Date().getFullYear());
    clearInput();
}

//初始化
$(function() {
	$.fn.zTree.init($("#orgTree"), setting);
    $("#btnViewCheckList").click(viewCheckList);

    $("#f_nd").textbox("setValue", new Date().getFullYear());
    clearInput();
    loadGrid1();
    $("#btnSearch").click(loadGrid1);
    $("#btnReset").click(funcBtnRest);
});

