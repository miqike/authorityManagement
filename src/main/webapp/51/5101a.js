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
    $("#f_hcdwXydm").val("");
    $("#f_hcdwName").val("");
    $("#p_id").val("");
    $("#p_jhbh").val("");
    $("#p_jhmc").val("");
    $('#p_hcdwXydm').val("");
    $('#p_hcdwName').val("");
    $("#p_jhnd").val("");
    $("#p_djjgmc").val("");
}

function reset() {
    $("#f_nd").val("");
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
    $("#f_hcdwXydm").val("");
    $("#f_hcdwName").val("");
    loadMyTask();
}

function minimizeMyTaskWindow() {
	$("#myTaskListWindow").window("minimize");
}

function checkParam(param) {
	return param.planType != undefined;
}

function loadMyTask() {
    var rwztWCFlag=$('input[name="rwztWCFlag"]:checked ').val();
    if(rwztWCFlag=="1") {
        $("#grid1").datagrid("load", {
            planType: planType,
            nd: $('#f_nd').val(),
            hcjhId: $('#f_hcjhId').val(),
            jhmc: $('#f_jhmc').val(),
            hcdwXydm: $('#f_hcdwXydm').val(),
            hcdwName: $('#f_hcdwName').val(),
            rwztWCFlag:5
        });
    }else if(rwztWCFlag=="0"){
        $("#grid1").datagrid("load", {
            planType: planType,
            nd: $('#f_nd').val(),
            hcjhId: $('#f_hcjhId').val(),
            jhmc: $('#f_jhmc').val(),
            hcdwXydm: $('#f_hcdwXydm').val(),
            hcdwName: $('#f_hcdwName').val(),
            rwztWWCFlag:1
        });
    }else{
        $("#grid1").datagrid("load", {
            planType: planType,
            nd: $('#f_nd').val(),
            hcjhId: $('#f_hcjhId').val(),
            jhmc: $('#f_jhmc').val(),
            hcdwXydm: $('#f_hcdwXydm').val(),
            hcdwName: $('#f_hcdwName').val()
        });
    }
}

function myTaskGridLoadSucessHandler(data) {
	if(data.rows.length == 0) {
		$.messager.alert("操作提示", "请到<<企业上传资料催报管理>>中检查核查企业是否已经执行上报完成");
	} else {
	    if($('#p_jhbh').val() != "") {
	    	$("#grid1").datagrid("selectRow", getRowIndex($('#p_jhbh').val()));
            myTaskGridClickHandler();
	    }
	}
}

function myTaskGridLoadSucessHandlerb(data) {
	if(data.rows.length == 0) {
		$.messager.alert("操作提示", "当前不存在要核查的任务,请到<<计划任务分配管理>>中建立任务选择要核查的移出企业名单", function (x) {
			$.util.getTop().mainpage.mainTabs.closeCurrentTab()
		});
	} else {
		if($('#p_jhbh').val() != "") {
			$("#grid1").datagrid("selectRow", getRowIndex($('#p_jhbh').val()));
		}
	}
}

function getRowIndex(jhbh) {
	var rows = $("#grid1").datagrid("getRows");
	var index;
	for(var i=0; i<rows.length; i++) {
		var row = rows[i];
		if(row.jhbh == jhbh) {
			index = $("#grid1").datagrid("getRowIndex", row);
			break;
		}
	}
	return index;
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
    $('#p_jhnd').val(hcrw.jhnd);
    $('#p_djjgmc').val(hcrw.djjgmc);
    $('#p_nd').val(hcrw.nd);

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
    minimizeMyTaskWindow();
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
	var options = $("#grid1").datagrid("options");
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
            $("input[name=rwztWCFlag]:eq('0')").attr("checked",'checked');
			// loadMyTask();
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
    //财务数据验证
	$.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
	    debugger;
		var qy = $("#grid1").datagrid("getSelected");
        $.getJSON("../21/2101/xydm",{"xydm":qy.hcdwXydm},function(responseQy){
            debugger;
            if(responseQy.status==$.husky.SUCCESS) {
                var hcfl=qy.hcfl == 1 ? "定向" : "不定向";
                //1:用户名&salt&加密后的密码&计划编号&企业注册号&企业名称&计划名称&计划年度&检查分类&检查机关&核查人&法人代表/负责人
                var param = "lieKysoft://1:" + response.userId + "&" + response.salt + "&" + response.password + "&" + qy.jhbh + "&" + qy.hcdwXydm + "&" + qy.hcdwName + "&" + qy.jhmc + "&" + qy.jhnd + "&" + hcfl + "&" + qy.hcjgmc + "&" + qy.zfryName1 + "&" + responseQy.data.fr + "/" + responseQy.data.fr;
                location.replace(param);
            }else{
                $.messager.alert("提示", response.message, 'info');
            }
        });
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
	printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao("grid1");
}

function confirmUpdateHcjg() {
    var row = $("#grid1").datagrid("getSelected");
    if(row.auditResult != null) {
        $.messager.alert("操作提示", "检查结果已经审核通过,不能修改!");
    } else {
        var rowIndex=$("#grid1").datagrid("getRowIndex",row);
        $.post("../51/" + row.id + "/jieguo", {"jieguo": $("#p_hcjieguo").combobox("getValue")}, function (response) {
            $.messager.alert("提示", response.message, 'info');
            if(response.status ==1 ){
                row.hcjieguo= $("#p_hcjieguo").combobox("getValue");
                $("#grid1").datagrid("updateRow", {
                        index: rowIndex,
                        row: row
                    }
                );
                // loadMyTask();
            }
            // loadMyTask();
        })
    }
}

function deleteUpdateHcjg() {
    var row = $("#grid1").datagrid("getSelected");
    var rowIndex=$("#grid1").datagrid("getRowIndex",row);
    $.post("../51/" + row.id + "/jieguo", null, function (response) {
        $.messager.alert("提示", response.message, 'info');
        if(response.status ==1 ){
            row.hcjieguo= null;
            $("#grid1").datagrid("updateRow", {
                    index: rowIndex,
                    row: row
                }
            );
            $("#p_hcjieguo").combobox("setValue",null);
            // loadMyTask();
        }
        // loadMyTask();
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
                doShidihechagaozhishuInit("grid1");
            } else if(title == "责令履行通知书") {
                doZelingluxingtongzhishuInit("grid1");
            } else if(title == "年报公示信息核查结果报告") {
            	printAuditReport();
            }else if(title == "公示信息更正审批表") {
                printGongShiXinXiGengZhengBiao();
            }else {
                doQiyezhusuohechahanInit("grid1");
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