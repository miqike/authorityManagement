window.excludeSaved = false;

function quickSearch(value, name) {
	var row = $('#grid1').datagrid('getSelected');
	$("#grid2").datagrid({
		url:"../common/query?mapper=hcrwMapper&queryName=queryForAuditorM&hcjhId=" + row.jhbh + "&" + name + "=" + value,
		collapsible:true,
		onLoadSuccess:grid2LoadSucessHandler,
		onClickRow:myTaskGridClickHandler,
		singleSelect:true,ctrlSelect:false,method:'get',
		pageSize: 100, pagination: true
	});
}

function grid2LoadSucessHandler(data) {
	if(data.rows.length == 0) {
		$.messager.alert("操作提示", "您尚未认领抽查任务,请到<<计划任务分配管理>>中先认领分配给您的企业名单");
	}
}

function formatZfry(val, row) {
	if(row.ZFRY_NAME1 != null && row.ZFRY_NAME2 != null ) {
		return row.ZFRY_NAME1 + "/" + row.ZFRY_NAME2;
	} else if(row.ZFRY_NAME1 == null ) {
		return row.ZFRY_NAME2;
	} else if(row.ZFRY_NAME2 == null ) {
		return row.ZFRY_NAME1;
	}
}

function docReadyReportFlagStyler(val,row,index) {
	if(val == 1) {
		return "background-color:lightgreen";
	} else {
		return "background-color:lightcoral";
	}
}

function docReadyFlagStyler(val,row,index) {
	if(val == 0) {
		return "background-color:lightgray";
	} else if(val == 1) {
		return "";
	} else if(val == 2)  {
		return "background-color:lightgreen";
	}
}

function grid1LoadSucessHandler(data) {
    $('#grid1').datagrid('selectRow', 0);
    if(window._selectdPlanId_ != undefined) {
    	$("#grid1").datagrid("selectRow", getRowIndex());
    } else {
    	var plan = $("#grid1").datagrid("getSelected");
    	window._selectdPlanId_ = plan.jhbh;
    }
    loadMyTask(_selectdPlanId_);
}

function getRowIndex() {
	var rows = $("#grid1").datagrid("getRows");
	var index;
	for(var i=0; i<rows.length; i++) {
		var row = rows[i];
		if(row.id == window._selectdPlanId_) {
			index = $("#grid1").datagrid("getRowIndex", row);
			break;
		}
	}
	return index;
}

function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        var row = $('#grid1').datagrid('getSelected');
        loadMyTask(row.jhbh);
    }
}

function loadMyTask(jhbh) {
    $("#grid2").datagrid({
		url:"../common/query?mapper=hcrwMapper&queryName=queryForAuditorM&hcjhId=" + jhbh,//+"&docReadyReportFlag=0",
		collapsible:true,
		onLoadSuccess:grid2LoadSucessHandler,
		onClickRow:myTaskGridClickHandler,
		singleSelect:true,ctrlSelect:false,method:'get',
		pageSize: 100, pagination: true
	});
}

function myTaskGridClickHandler() {
	var task = $('#grid2').datagrid('getSelected');
	
	if(task ==null) {
		$('#btnViewDocList').linkbutton('disable');
		$('#btnReportDocReady').linkbutton('disable');
	} else {
		$('#btnViewDocList').linkbutton('enable');
		
		/*if(task.DOC_READY_FLAG == 2 && task.RWZT != 5) {*/
		//取消对文档上传状态的判断
		if(task.RWZT != 5) {
			$('#btnReportDocReady').linkbutton('enable')
		}  else {
			$('#btnReportDocReady').linkbutton('disable')
		}
		
		if(task.DOC_READY_REPORT_FLAG == 0) {
			$('#btnReportDocReady').linkbutton({text: "上报完成"})
		}  else {
			$('#btnReportDocReady').linkbutton({text: "取消完成"})
		}
		
	}
}

function viewDocList() {
	$.easyui.showDialog({
		title : "检查材料",
		width : 800,
		height : 420,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "../51/docListb.jsp",
		onLoad : function() {
			//doDocListInit();
		}
	});
}

function search() {
	loadMyPlan();
}

function firstLoadMyPlan() {
	var options = $("#grid1").datagrid("options")
	options.url = "../common/query?mapper=hcjhMapper&queryName=query" + (userInfo.ext1 == 1 ? "Ext": "");
}

function loadMyPlan() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}


function loadGrid1(hcjhId) {
	window._selectdPlanId_ = hcjhId;
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
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

function reset() {
    clearInput();
    loadGrid1();
}


function reportDocReady() {
	var task = $('#grid2').datagrid('getSelected');
	
	if(task.DOC_READY_FLAG != 2 && $('#btnReportDocReady').linkbutton("options").text == "上报完成") {
		$.messager.confirm('确认', "该企业要求提供的证明材料尚未提供齐全,是否确认上报完成?", function (r) {
			if (r) {
				_reportDocReady(task);
			}
		});
	} else {
		_reportDocReady(task);
	}
}

function _reportDocReady(task) {
	$.post("../51/" + task.ID + "/docReadyReportFlag", {
		docReadyReportFlag: task.DOC_READY_REPORT_FLAG
	},function(response){
		if(response.status == $.husky.FAIL){
			$.messager.alert("操作错误", response.message, "error");
			return true;
		} else if (response.status == $.husky.SUCCESS) {
			$.messager.show("操作提醒", response.message, "info", "bottomRight");
			$("#grid2").datagrid("reload");
			return false;
		}
	});
}

//初始化
$(function () {
	$.husky.getUserInfo();
	var myDate = new Date();
	
	clearInput();
	   
    if (null != window.userInfo) {
    	firstLoadMyPlan();
    } else {
        $.subscribe("USERINFO_INITIALIZED", firstLoadMyPlan);
    }
    
	/*$("#grid1").datagrid("load", {
		nd: myDate.getFullYear()
	});*/

});

