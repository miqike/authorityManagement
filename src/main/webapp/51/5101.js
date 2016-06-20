

function collapseHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}


function poiExport() {
    $("<iframe id='poiExport' style='display:none' src='../user/poiExport'>").appendTo("body");
}

function showExamHistory() {
    showModalDialog("examHistory");
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

function loadMyTask() {
    $.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForAuditor",  {
    	nd: $('#f_nd').numberspinner("getValue"),
        hcjhId: $('#f_hcjhId').val(),
        jhmc: $('#f_jhmc').val()
    }, function (response) {
        if (response.status == SUCCESS) {
        	 $("#grid1").datagrid("loadData",response);
        }
    });
}

function grid1ClickHandler() {
    //控制四个按钮显示
    var hcrw = $('#grid1').datagrid('getSelected');
    $('#p_id').val(hcrw.hcjhId);
    $('#p_jhmc').val(hcrw.jhmc);
    $('#p_jhxdrq').datebox("setValue", formatDate(hcrw.jhxdrq));
    $('#p_jhyqwcsj').datebox("setValue", formatDate(hcrw.jhyqwcsj));
    $('#p_hcjieguo').combobox("setValue", hcrw.hcjieguo);

    $('#btnSendHcgzs').linkbutton("enable");
    $('#btnSendZllxtzs').linkbutton("enable");
    $('#btnSendQyzshch').linkbutton("enable");
    $('#btnViewDocument').linkbutton("enable");
    $('#btnPrintHeChaJieGuo').linkbutton("enable");
    $('#btnPrintGongShiXinXiGengZheng').linkbutton("enable");

    if (hcrw.dataLoaded == 0) {
        $('#btnPullData').linkbutton("enable");
    } else {
        $('#btnPullData').linkbutton("disable");
    }
    refreshAuditItemList();
}

function refreshAuditItemList() {
    if ($("#annualAuditItemGrid").length == 0 && $("#instanceAuditItemGrid").length == 0) {
    	console.log("-----------------")
        $("#auditItemList").panel({
            href: './auditItemList.jsp',
            onLoad: function () {
            	console.log("++++++++++++")
                doAuditItemListInit();
            }
        });
    } else {
        doAuditItemListInit();
    }
}

function funcBtnRest() {
    $("#f_nd").val(new Date().getFullYear());
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
}

function clearInput() {
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
    $("#p_id").val("");
    $("#p_jhmc").val("");
    $("#p_xdsj").datebox("setValue", "");
    $("#p_yqwcsj").datebox("setValue", "");
}

function funcBtnPullData() {
    if (!$(this).linkbutton('options').disabled) {
    	_pullData();
    }
}

function _pullData() {
	var row = $("#grid1").datagrid("getSelected");
    $.getJSON("./" + row.id + "/pull", null, function (response) {
        if (response.status == SUCCESS) {
            $.messager.alert("提示", response.message, 'info');
            refreshAuditItemList();
            row.dataLoaded = 1;
        }
    });
}

function funcBtnViewDocument() {
    if (!$(this).linkbutton('options').disabled) {
    	$.easyui.showDialog({
    		title : "检查材料",
    		width : 750,
    		height : 420,
    		topMost : false,
    		iconCls:'icon2 r16_c14',
    		enableSaveButton : false,
    		enableApplyButton : false,
    		closeButtonText : "返回",
    		closeButtonIconCls : "icon-undo",
    		href : "./docList.jsp",
    		onLoad : function() {
    			doDocListInit();
    		}
    	});
    }
}

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
                printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao();
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
					printZelingluxingtongzhishu();
				} else if(title == "年报公示信息核查结果报告") {
                    printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao();
                }else {
					printQiyezhusuohechahan();
				}
			}
		}]
	});
}

$(function () {
    clearInput();
    $("#f_nd").val(new Date().getFullYear());
    $("#btnView").click(showExamHistory);
    loadMyTask();

    $("#btnSearch").click(loadMyTask);
    $("#btnReset").click(funcBtnRest);
    $("#btnPullData").click(funcBtnPullData);
    $("#btnViewDocument").click(funcBtnViewDocument);

    $("#btnSendHcgzs").click(function () {
    	_showDialog("实地检查告知书", "../gaozhishu/shidihecha.jsp");
    });
    $("#btnSendZllxtzs").click(function () {
    	_showDialog("责令履行通知书", "../gaozhishu/zelingluxing.jsp");
    });
    $("#btnSendQyzshch").click(function () {
    	_showDialog("企业住所调查函", "../gaozhishu/qiyezhusuo.jsp");
    });
    $("#btnPrintHeChaJieGuo").click(function () {
        //_showDialog("年报公示信息核查结果报告", "../gaozhishu/qiyenianbaohechajieguo.jsp");
        printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao();
    });
    $("#btnPrintGongShiXinXiGengZheng").click(function () {
        //_showDialog("公示信息更正审批表", "../gaozhishu/gongshixinxigengzheng .jsp");
        printGongShiXinXiGengZhengBiao();
    });

    $("#btnUpdateHcjg").linkbutton("disable");
    $("#btnUpdateHcjg").click(updateHcjg);
    
    $("#btnConfirmUpdateHcjg").click(confirmUpdateHcjg);
    $("#btnConfirmUpdateHcjg").hide();
    
});