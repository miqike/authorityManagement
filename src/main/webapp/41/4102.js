window.excludeSaved = false;


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
    //$('#grid1').datagrid('selectRow', 0);
    if(window._selectdPlanId_ != undefined) {
    	$("#grid1").datagrid("selectRow", getRowIndex());
    	//loadMyTask(_selectdPlanId_);
    } else {
    	/*
    	var plan = $("#grid1").datagrid("getSelected");
    	window._selectdPlanId_ = plan.jhbh;
    	*/
    }
    //loadMyTask(_selectdPlanId_);
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
		url:"../common/query?mapper=hcrwMapper&queryName=queryForAuditorM&hcjhId=" + jhbh+"&docReadyReportFlag=1",
		collapsible:true,
		onLoadSuccess:grid2LoadSucessHandler,
		onClickRow:myTaskGridClickHandler,
		singleSelect:true,ctrlSelect:false,method:'get',
		pageSize: 100, pagination: false
	});
}

function grid2LoadSucessHandler(data) {
	if(data.rows.length == 0) {
		$.messager.alert("操作提示", "请到<<企业上传资料催报管理>>中检查核查企业是否已经执行上报完成");
	}
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
		width : 790,
		height : 420,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./docListb.jsp",
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
	$.post("./" + task.ID + "/docReadyReportFlag", {
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

//鼎信诺调用按钮事件
function importFinancial(){
    //财务电子数据导入
    var jh=$("#grid1").datagrid("getSelected");
    var rw=$("#grid2").datagrid("getSelected");
	//取得已经上传文件的MONGOID
	var mongoId=rw.MONGOID_1==undefined?'':rw.MONGOID_1;
	if(mongoId==''){
		$.messager.show("操作提醒", '文件编码未取到！', "info", "bottomRight");
	}

    if(null==jh || null ==rw){
        $.messager.show("操作提醒", '请选择核查计划及核查任务！', "info", "bottomRight");
    }else {
        var hcfl=rw.HCFL==1?"定向":"不定向";
        $.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
			//2:用户名&salt&加密后的密码&计划编号&企业注册号&企业名称&计划名称&计划年度&检查分类&检查机关&核查人&法人代表/负责人&文件类型(2)&mongoId
			var param = "lieKysoft://2:" + response.userId + "&" + response.salt + "&" + response.password+"&"+rw.JHBH+"&"+rw.HCDW_XYDM+"&" +rw.HCDW_NAME+"&"+rw.JHMC+"&"+rw.ND+"&"+hcfl+"&"+rw.HCJGMC+"&"+rw.ZFRY_NAME1+"&"+rw.FR+"/"+rw.FR+"&2"+"&"+mongoId;
            console.log(param);
            location.replace(param);
        });
    }
}
function importSelfCheck(){
    //企业公示信息自查表导入
    var jh=$("#grid1").datagrid("getSelected");
    var rw=$("#grid2").datagrid("getSelected");
	//取得已经上传文件的MONGOID
	var mongoId=rw.MONGOID_2==undefined?'':rw.MONGOID_2;
	if(mongoId==''){
		$.messager.show("操作提醒", '文件编码未取到！', "info", "bottomRight");
	}
    if(null==jh || null ==rw){
        $.messager.show("操作提醒", '请选择核查计划及核查任务！', "info", "bottomRight");
    }else {
        var hcfl=rw.HCFL==1?"定向":"不定向";
        $.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
			//2:用户名&salt&加密后的密码&计划编号&企业注册号&企业名称&计划名称&计划年度&检查分类&检查机关&核查人&法人代表/负责人&文件类型(1)&mongoId
			var param = "lieKysoft://2:" + response.userId + "&" + response.salt + "&" + response.password+"&"+rw.JHBH+"&"+rw.HCDW_XYDM+"&" +rw.HCDW_NAME+"&"+rw.JHMC+"&"+rw.ND+"&"+hcfl+"&"+rw.HCJGMC+"&"+rw.ZFRY_NAME1+"&"+rw.FR+"/"+rw.FR+"&1"+"&"+mongoId;
            console.log(param);
            location.replace(param);
        });
    }
}
function financialValidate(){
    //财务数据验证
    var jh=$("#grid1").datagrid("getSelected");
    var rw=$("#grid2").datagrid("getSelected");
    if(null==jh || null ==rw){
        $.messager.show("操作提醒", '请选择核查计划及核查任务！', "info", "bottomRight");
    }else {
        /**
         * 1表示登陆 2表示导入 可能后期还有3,4,5
         * */
        $.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
            //1:用户名&salt&加密后的密码&计划编号&企业注册号&企业名称&计划名称&计划年度&检查分类&检查机关&核查人&法人代表/负责人
            var hcfl=rw.HCFL==1?"定向":"不定向";
            console.log(hcfl);
            var param = "lieKysoft://1:" + response.userId + "&" + response.salt + "&" + response.password+"&"+rw.JHBH+"&"+rw.HCDW_XYDM+"&" +rw.HCDW_NAME+"&"+rw.JHMC+"&"+rw.ND+"&"+hcfl+"&"+rw.HCJGMC+"&"+rw.ZFRY_NAME1+"&"+rw.FR+"/"+rw.FR;
            console.log(param);
            location.replace(param);
        });
    }
}
//初始化
$(function () {
    $.husky.getUserInfo();
    clearInput();
    if (null != window.userInfo) {
    	firstLoadMyPlan();
    } else {
        $.subscribe("USERINFO_INITIALIZED", firstLoadMyPlan);
    }
   $("#btnViewDocList").hide();
   $("#btnReportDocReady").hide();
});

