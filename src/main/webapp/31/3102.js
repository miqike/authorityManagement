window.excludeSaved = false;

function grid2DblClickHandler(index, row) {
    window.selected = index;
    $('#grid2').datagrid('unselectAll').datagrid('selectRow', window.selected);
    var hcrwTj = $('#grid2').datagrid('getSelected');
    $.easyui.showDialog({
		title : "核查任务 - " + hcrwTj.zfryName,
		width : 790,
		height : 420,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./userTaskList.jsp",
		onLoad : function() {
			doUserTaskListInit();
		}
	});
}

function goFirst() {
	$.husky.ramble("first", "grid1", "taskDetailTable");
	loadPlanAbstract();
}

function goLast() {
	$.husky.ramble("last", "grid1", "taskDetailTable");
	loadPlanAbstract();
}

function goPrev() {
	$.husky.ramble("previous", "grid1", "taskDetailTable");
	loadPlanAbstract();
}

function goNext() {
	$.husky.ramble("next", "grid1", "taskDetailTable");
	loadPlanAbstract();
}

function minimizeMyPlanListWindow() {
	loadPlanAbstract();
	$("#myPlanListWindow").window("minimize");
}

function loadPlanAbstract() {
	var row = $('#grid1').datagrid('getSelected');
    if(row.planType==1){
    	planType="双随机";
    }else{
    	planType="日常监管";
    }
    $("#f_planTypeShow").val(planType);
    $("#f_jhmcShow").val(row.jhmc);
    $("#f_jhbhShow").val(row.jhbh);
}

function showPlanListWindow() {
	var options = $("#grid1").datagrid("options")
	options.url = "../common/query?mapper=hcjhMapper&queryName=query" + (userInfo.ext1 == 1 ? "Ext": "");
	
	$("#myPlanListWindow").window({
        title: "我的计划列表", top: 5, left: $.util.windowSize().width-905, width: 900, height: 450,
        iconCls: 'icon2 r5_c20',
        modal:false,
        collapsible:true,
		closable:false,
        minimizable:true,
        border:false,
        autoVCenter: false,     //该属性如果设置为 true，则使窗口保持纵向居中，默认为 true。
        autoHCenter: false,      //该属性如果设置为 true，则使窗口保持横向居中，默认为 true。
		onOpen : function() {
			loadMyPlan();
		}
    });
}

function search() {
	loadMyPlan();
}

function loadMyPlan() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        hcjgmc: $('#f_hcjgmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue"),
        planType: $('#f_planType').combobox("getValue")
    });
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

function collapseHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
	$("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
	$("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
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
	var row = $('#grid1').datagrid('getSelected');
	if (row) {
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
        if (response.status == $.husky.SUCCESS) {
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
    $("#f_hcjgmc").val("");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
    $("#f_planType").combobox("setValue", "");
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

function rest() {
    clearInput();
}

//初始化
$(function() {
	$.husky.getUserInfo();
	$.fn.zTree.init($("#orgTree"), setting);
    clearInput();
    if (null != window.userInfo) {
        showPlanListWindow();
    } else {
        $.subscribe("USERINFO_INITIALIZED", showPlanListWindow);
    }
});

