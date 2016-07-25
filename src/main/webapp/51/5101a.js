function formatZfry(val, row) {
	var result = row.zfryName1 == null? "": row.zfryName1;
	if(row.zfryName2 != null) {
		result =  result + "/" + row.zfryName2;
	}
	return result;
}

function hcrwStyler(index,row){
	if (row.rwzt == 1){
		return ''; // return inline style
	} else if (row.rwzt == 2) {
		return 'background-color:orange;';
	} else if (row.rwzt == 3) {
		return 'background-color:lightblue;';
	} else if (row.rwzt == 4) {
		return 'background-color:brown;color:#fff;';
	} else if (row.rwzt == 5) {
		return 'background-color:lightgreen;';
	} else {
		return '';;
	}
}

function taskStatusStyler(val, row, index) {
	if (val == 1) {
		return "background-color:lightgray";
    } else if (val == 2) {
        return "background-color:orange";
    } else if (val == 3) {
        return "background-color:pink";
    } else if (val == 4) {
        return "background-color:red";
    } else if (val == 5) {
        return "background-color:lightgreen";
    }
}


function clearInput() {
	$("#f_nd").val("");
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
    $("#p_id").val("");
    $("#p_jhbh").val("");
    $("#p_jhmc").val("");
    $('#p_hcdwXydm').val("");
    $('#p_hcdwName').val("");
    $("#p_xdsj").datebox("setValue", "");
    $("#p_yqwcsj").datebox("setValue", "");
}

function reset() {
    $("#f_nd").val("");
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
    loadMyTask();
}

function checkParam(param) {
	return param.planType != undefined;
}

function loadMyTask() {
    $("#grid1").datagrid("load",  {
		planType: planType,
		nd: $('#f_nd').val(),
		hcjhId: $('#f_hcjhId').val(),
		jhmc: $('#f_jhmc').val()
	});;
}

function myTaskGridClickHandler() {
    //控制四个按钮显示
    var hcrw = $('#grid1').datagrid('getSelected');
    $('#p_jhbh').val(hcrw.jhbh);
    $('#p_jhmc').val(hcrw.jhmc);
    $('#p_hcdwXydm').val(hcrw.hcdwXydm);
    $('#p_hcdwName').val(hcrw.hcdwName);
    $('#p_jhxdrq').datebox("setValue", formatDate(hcrw.jhxdrq));
    $('#p_jhwcrq').datebox("setValue", formatDate(hcrw.jhwcrq));
    $('#p_hcjieguo').combobox("setValue", hcrw.hcjieguo);

    $('#btnSendHcgzs').linkbutton("enable");
    $('#btnSendZllxtzs').linkbutton("enable");
    $('#btnSendQyzshch').linkbutton("enable");
    $('#btnOpenEtlTool').linkbutton("enable");
    $('#btnViewDocument').linkbutton("enable");
    $('#btnPrintHeChaJieGuo').linkbutton("enable");
    $('#btnPrintGongShiXinXiGengZheng').linkbutton("enable");

    if (hcrw.dataLoaded == 0) {
        $('#btnPullData').linkbutton("enable");
    } else {
        $('#btnPullData').linkbutton("enable");
    }
    refreshAuditItemList();
}

function goFirst() {
	$.husky.ramble("first", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goLast() {
	$.husky.ramble("last", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goPrev() {
	$.husky.ramble("previous", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function goNext() {
	$.husky.ramble("next", "grid1", "taskDetailTable");
	refreshAuditItemList();
}

function refreshAuditItemList() {
    if ($("#annualAuditItemGrid").length == 0 && $("#instanceAuditItemGrid").length == 0) {
        $("#auditItemList").panel({
        	fit:true,
            href: './auditItemLista.jsp',
            onLoad: function () {
                doAuditItemListInit();
            }
        });
    } else {
        doAuditItemListInit();
    }
}





function showTaskListWindow() {
	var options = $("#grid1").datagrid("options")
	options.url = "../common/query?mapper=hcrwMapper&queryName=queryForAuditor" + (userInfo.ext1 == 1 ? 1: 2);
	
	$("#myTaskListWindow").window({
        title: "我的任务列表", top: 5, left: $.util.windowSize().width-755, width: 750, height: 450,
        modal:false,
        collapsible:true,
		closable:false,
        minimizable:true,
        border:false,
        autoVCenter: false,     //该属性如果设置为 true，则使窗口保持纵向居中，默认为 true。
        autoHCenter: false,      //该属性如果设置为 true，则使窗口保持横向居中，默认为 true。
		onOpen : function() {
			loadMyTask();
		}
    });
}

function pullData() {
	$.easyui.loading();
	var row = $("#grid1").datagrid("getSelected");
	$.getJSON("./" + row.id + "/pull", null, function (response) {
		$.easyui.loaded();
		$.messager.alert("提示", response.message, 'info');
		if (response.status == $.husky.SUCCESS) {
			refreshAuditItemList();
			row.dataLoaded = 1;
		}
	});
}

function openEtlTool() {
	$.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
		var qy = $("#grid1").datagrid("getSelected");
		//用户名&salt&加密后的密码&计划编号&企业注册号&企业名称
		//liexplorer://v00056&123qwe!@#QWE&5e9593e655d55b5cd553735a00961ce1&undefined&610403100018125&杨凌固凌机械科技有限公司
		var param = "liexplorer://" + response.userId + "&" + response.salt + "&" + response.password + "&" + qy.jhbh + "&" + qy.hcdwXydm + "&" + qy.hcdwName;
		console.log(param);
		location.replace(param);
	});
}

function viewDocument() {
	$.easyui.showDialog({
		title : "检查材料",
		width : 720,
		height : 420,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./docLista.jsp",
		onLoad : function() {
			//doDocListInit();
		}
	});
}

function sendHcgzs() {
	_showDialog("实地检查告知书", "../gaozhishu/shidihecha.jsp");
}

function sendZllxtzs() {
	_showDialog("责令履行通知书", "../gaozhishu/zelingluxing.jsp");
}

function sendQyzshch() {
	_showDialog("企业住所调查函", "../gaozhishu/qiyezhusuo.jsp");
}

function printAuditReport() {
	printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao();
}
//==============================


//=============================
//=============================


function updateHcjg() {
	$("#btnConfirmUpdateHcjg").show().linkbutton("enable");
	$("#p_hcjieguo").combobox("enable").combobox("showPanel");
}

function confirmUpdateHcjg() {
	var row = $("#grid1").datagrid("getSelected");
	$.post("../51/" + row.id + "/jieguo", {"jieguo": $("#p_hcjieguo").combobox("getValue")}, function (response) {
		$.messager.alert("提示", response.message, 'info');
		
		$("#btnUpdateHcjg").linkbutton("enable");
	    $("#btnConfirmUpdateHcjg").hide();
		$("#p_hcjieguo").combobox("disable");
		loadMyTask();
	})
}

function getAuditItem() {
	return $("#auditItemTabs").tabs("getSelected").find(".easyui-datagrid").datagrid("getSelected")
}

function _showDialog(title, url) {
	$.easyui.showDialog({
		title : title,
		width : 650,
		height : 520,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : url,
		onLoad : function() {
            if(title == "实地检查告知书") {
                doShidihechagaozhishuInit();
            } else if(title == "责令履行通知书") {
                doZelingluxingtongzhishuInit();
            } else if(title == "年报公示信息核查结果报告") {
            	printAuditReport();
            }else if(title == "公示信息更正审批表") {
                printGongShiXinXiGengZhengBiao();
            }else {
                doQiyezhusuohechahanInit();
            }

		},
		buttons:[{
			text:'打印',
			iconCls:'icon-print',
			handler:function(){
				if(title == "实地检查告知书") {
					printShidihechagaozhishu();
				} else if(title == "责令履行通知书") {
					setTaskStatus( $("#grid1").datagrid("getSelected").id, 4);
					printZelingluxingtongzhishu();
				} else if(title == "年报公示信息核查结果报告") {
					printAuditReport();
                }else {
					printQiyezhusuohechahan();
				}
			}
		}]
	});
}

function setTaskStatus(taskId, statusCode) {
	$.post("../51/" + taskId + "/" + statusCode, null, function() {
		
	});
}

$(function () {
	$.husky.getUserInfo();
	clearInput();
	if (null != window.userInfo) {
        showTaskListWindow();
    } else {
        $.subscribe("USERINFO_INITIALIZED", showTaskListWindow);
    }
});