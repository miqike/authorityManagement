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
	var year = $("#f_year").val();
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
        organization: processorOrgId(selected[0].id)
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
    if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid1').datagrid('getSelected');
		if (row) {
			showAuditItemList(row);
		}
	}
}

function showAuditItemList(data) {
	$.easyui.showDialog({
		title : "检查事项",
		width : 750,
		height : 400,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./auditItemList.jsp",
		onLoad : function() {
			doAuditItemListInit(data);
		}
	});
}

function doAuditItemListInit(data) {
	$.codeListLoader.parse($('#auditItemListWindow'))
	if(null != data) {
		loadAuditItemList();
		$("#btnAdd4").hide();
		$("#btnDelete4").hide();
	}
}


function loadAuditItemList() {
	$.getJSON('../common/query?mapper=hcsxMapper&queryName=queryForPlan',  {
		hcjhId: $("#grid1").datagrid('getSelected').id
    }, function (response) {
        if (response.status == SUCCESS) {
        	 $("#grid4").datagrid("loadData",response);
        }
    });
}

function clearInput() {
	$("#f_nd").val("");
	$("#f_id").val("");
    $("#f_jhbh").val("");
    $("#f_gsjhbh").val("");
    $("#f_jhmc").val("");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function loadGrid1() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
	
}

function funcBtnRest() {
	//$("#f_nd").val( new Date().getFullYear());
    clearInput();
}

//初始化
$(function() {
	getUserInfo();
	$.fn.zTree.init($("#orgTree"), setting);
	$("#btnSearch").click(loadGrid1);
	$("#btnReset").click(funcBtnRest);
    $("#btnViewCheckList").click(viewCheckList);

    //$("#f_nd").val( new Date().getFullYear());
    clearInput();
    loadGrid1();
});

