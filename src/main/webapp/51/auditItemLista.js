function formatCompareCol(val, row) {
	var rc = row.qygsnr;
	if(val != null ) {
		if(val == "...") {
			return val;
		} else {
			if(rc == val) {
				return "<span style='color:green;'>" + val + "</span>";
			} else {
				return "<span style='color:red;'>" + val + "</span>";
			} 
		}
	}
}

function stylerRegist(val, row, index) {
	var compareSource = row.dbxxly;
	if(compareSource == 1 || compareSource == 3) {
		return "";
	} else if(compareSource == 2) {
		return "background-color:#ebeced";
	}
}

function stylerActual(val, row, index) {
	var compareSource = row.dbxxly;
	if(compareSource == 2 || compareSource == 3) {
		return "";
	} else {
		return "background-color:#ebeced;";
	} 
}

function stylerHczt(val, row, index) {
    if (val == 1) {
        return "";
    } else if (val == 2) {
        return "background-color:yellow";
    } else if (val == 3) {
        return "background-color:lightgreen";
    }
}

function stylerHcjg(val, row, index) {
    if (val == 1) {
        return "background-color:lightgreen";
    } else if (val == 2) {
        return "background-color:pink";
    } else {
        return "";
    }
}

function addAnnualDocFur() {
	_addDocFur();
}

function addInstanceDocFur() {
	_addDocFur();
}

function _addDocFur() {
	$.easyui.showDialog({
        title: "附加核查材料列表",
        width: 705, height: 410, topMost: false,
        href: "./addDocFur.jsp",
        enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		onLoad : function() {
			doDocFurListInit();
		}
    });
}

function auditItemsTabSelectHandler(title,index) {
    if(canBeSelected(index)) {
        if(window.auditItemDataReady) {
            _auditItemsTabSelectHandler(index)
        } else {
            $.subscribe("AUDITITEM_DATA_INITIALIZED", _auditItemsTabSelectHandler, [index]);
        }
    }
}

function _auditItemsTabSelectHandler(index) {
    if(canBeSelected(index)) {
        var tabPanel = $("#auditItemTabs").tabs("getTab", index);
        if(index == 0) {
            annualAuditItemInit();
        } else {
            instanceAuditItemInit()
        }
    }
}

function canBeSelected(index) {
    var hcrw = $('#grid1').datagrid('getSelected');
    return hcrw.nr == 3 || (hcrw.nr == 1 && index == 0) || (hcrw.nr == 2 && index == 1);
}

function initAuditItemList() {
    $("#p_hcjieguo").combobox("disable");
    $("#btnUpdateHcjg").linkbutton("enable");
    $("#btnConfirmUpdateHcjg").hide();

    $("#auditItemAccordion").accordion("select", 0);
    var hcrw = $('#grid1').datagrid('getSelected');
    if(hcrw.nr == 1) {
        $("#auditItemTabs").tabs("enableTab", 0);
        $("#auditItemTabs").tabs("disableTab", 1);
        $("#auditItemTabs").tabs("select", 0);
        annualAuditItemInit();
    } else if(hcrw.nr == 2) {
        $("#auditItemTabs").tabs("disableTab", 0);
        $("#auditItemTabs").tabs("enableTab", 1);
        $("#auditItemTabs").tabs("select", 1);
        instanceAuditItemInit()
    } else {
        $("#auditItemTabs").tabs("enableTab", 0);
        $("#auditItemTabs").tabs("enableTab", 1);
        $("#auditItemTabs").tabs("select", 0);
        annualAuditItemInit()
    }
}

function doAuditItemListInit() {
    $.easyui.loading();
    window.auditItemDataReady = false;
    var hcrw = $('#grid1').datagrid('getSelected');
    if(null == hcrw) {
    	$("#auditItemList").empty();
        $.easyui.loaded();
    } else {
	    $.ajax({
	        url: "./" + hcrw.id + "/initStatus",
	        data: {hcrwId: hcrw.id},
	        type: 'GET',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	                if (response.data == 0) {
                        $.ajax({
                            url: "./" + hcrw.id + "/init",
                            type: 'POST',
                            success: function (response) {
                                $.easyui.loaded();
                                if (response.status == $.husky.SUCCESS) {
                                    $.publish("AUDITITEM_DATA_INITIALIZED", null);
                                    window.auditItemDataReady = true;
                                    initAuditItemList();
                                } else {
                                    $.messager.alert('加载数据', response.message, 'info');
                                    $("#annualAuditItemGrid").datagrid("loadData",[]);
                                    $("#instanceAuditItemGrid").datagrid("loadData",[]);
                                }
                            }
                        });
	                } else {
                        $.easyui.loaded();
	                    $.publish("AUDITITEM_DATA_INITIALIZED", null);
	                    window.auditItemDataReady = true;
	                    initAuditItemList();
	                }
	            }
	        }
	    });
    }
}

//-----------annual
function annualAuditItemClickHandler() {
    if ($('#annualAuditItemGrid').datagrid('getSelected') != null) {
        $('#btnAnnualAudit').linkbutton('enable');
    } else {
        $('#btnAnnualAudit').linkbutton('disable');
    }
}

function annualAuditItemDblClickHandler(index, row) {
    window.selected = index;
    $('#annualAuditItemGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
    annualAudit();
}

function annualAudit() {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
        $.messager.alert("未配置比对页面")
    } else {
        $("#auditItemAccordion").accordion("select", 1);
        $("#taskDetailLayout").layout("collapse", "north");
        $("#auditContent").panel({
            href: '../audit_' + customer + '/' + auditItem.page + '.jsp',
            onLoad: function () {
                _doInit("annual");
                doInit();
            }
        });
    }
}

function annualAuditItemInit() {
	$.getJSON("../common/query?mapper=hcsxjgMapper&queryName=queryForTask",  {
		hcrwId: $('#grid1').datagrid('getSelected').id,
        hclx: 1
    }, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	$("#annualAuditItemGrid").datagrid("loadData",response);
        	if(!checkFinicialDataImport(response.rows)) {
        		$.messager.alert("操作提示", "您尚未导入财务报表数据信息,请执行<<采集数据导入及验证>>后再核查");
        	}
        }
    });
}

function checkFinicialDataImport(data) {
	var result = false;
	for(var i=0; i<data.length; i++) {
		if (data[i].page == "finicial" && data[i].sjnr != null && data[i].sjnr != "" && data[i].sjnr != undefined ) {
			result = true;
			break;
		}
	}
	return result;
}
//---------------annual end and instance begin

function instanceAuditItemGridClickHandler() {
    if ($('#instanceAuditItemGrid').datagrid('getSelected') != null) {
        $('#btnInstanceAudit').linkbutton('enable');
    } else {
        $('#btnInstanceAudit').linkbutton('disable');
    }
}

function instanceAuditItemGridDblClickHandler(index, row) {
    window.selected = index;
    $('#instanceAuditItemGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
    instanceAudit();
}

function instanceAudit() {
    var auditItem = $("#instanceAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
        $.messager.alert("未配置比对页面")
    } else {
        $("#auditItemAccordion").accordion("select", 1);
        $("#auditContent").panel({
            href: '../audit_' + customer + '/' + auditItem.page + '.jsp',
            onLoad: function () {
                _doInit("instance");
                doInit();
            }
        });
    }
}

function instanceAuditItemInit() {
    $.getJSON("../common/query?mapper=hcsxjgMapper&queryName=queryForTask",  {
		hcrwId: $('#grid1').datagrid('getSelected').id,
        hclx: 2
    }, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	 $("#instanceAuditItemGrid").datagrid("loadData",response);
        }
    });
}

//================instance end=========
function _doInit(type) {
    var auditItem = null;
    if(type=="annual") {
        auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    }  else {
        auditItem = $("#instanceAuditItemGrid").datagrid("getSelected");
    }
    var qy = $("#grid1").datagrid("getSelected");

    $("#_hcrwId_").text(auditItem.hcrwId);
    $("#_hcsxId_").text(auditItem.hcsxId);
    ///debugger;
    $("#_hcjieguo_").text(auditItem.hcjg);
//--------------
    $("#_qygsnr_").text(auditItem.qygsnr == null ? "" : auditItem.qygsnr);
    $("#_bznr_").text(auditItem.bznr == null ? "" : auditItem.bznr);
    $("#_sjnr_").text(auditItem.sjnr == null ? "" : auditItem.sjnr);
    $("#_qymc_").text(qy.hcdwName);
    $("#_hcsxmc_").text(auditItem.name);
    $("#_dbxxly_").text($.codeListLoader.getCodeLiteral("sjly", auditItem.dbxxly));
    
    if(auditItem.hcjg != "1") {
		$("#_bdjg_").text("不一致").css("color", "red");
	} else {
		$("#_bdjg_").text("一致").css("color", "green");
	}
 
    
    $("#btnPass").show();
    $("#btnFail").show();

    $("#k_failReason").val(auditItem.sm);
    
    _initPromptForAuditItem(auditItem);
    cancelFail();
}

function _initPromptForAuditItem(auditItem) {
	var url = "../common/query?mapper=auditItemCommentMapper&queryName=queryForAuditItem&hcsxId=" + auditItem.hcsxId;
	$.getJSON(url, null, function(response){
		$.easyui.tooltip.init($("#btnShowPrompt"), { 
	    	content: constructPromptContent(response.rows), 
	    	position:"right",showEvent:null,hideEvent:null,
	    	trackMouse: false
		});
	});
}

function constructPromptContent(rows) {
	var content = "";
	for(var i=0; i<rows.length; i++) {
		content += "<span class='commentItem' ondblclick ='addComment(this);'>";
		content += rows[i].content;
		content += "</span></br>";
	}
	return content;
}

function addComment(elem) {
	var content = $(elem).text();
	$("#k_failReason").val($("#k_failReason").val() + "\n" + content);
}

//==通用,通过,失败,返回===
function pass() {
    $.post("../audit/complete", {
        hcrwId: $("#_hcrwId_").text(),
        hcsxId: $("#_hcsxId_").text(),
        hcjg: 1,
        qymc: $("#_qymc_").text(),
        hcsxmc: $("#_hcsxmc_").text(),
        sm: "正常"
    }, function (response) {
        if (response.status == $.husky.SUCCESS) {
            $.messager.show("操作提示", response.message, "info", "bottomRight");
            //$("#annualAuditItemGrid").datagrid("reload");
            annualAuditItemInit();
            _closeAuditWindow();
            $("#btnShowPrompt").tooltip("hide");
        } else {
            $.messager.alert('错误', response.message, 'error');
        }
    });
};

function fail() {
    $('#auditToolbar').hide();
    //$('#failReason').show();
    //$('#k_failReason').val("");
    confirmFail();
}

function cancelFail () {
    $('#auditToolbar').show();
    //$('#failReason').hide();
    $("#btnShowPrompt").tooltip("hide");
}

function showPrompt () {
	$("#btnShowPrompt").tooltip("show");
}

function confirmFail () {
	$("#btnShowPrompt").tooltip("hide");
	$.post("../audit/complete", {
		hcrwId: $("#_hcrwId_").text(),
		hcsxId: $("#_hcsxId_").text(),
		hcjg: 2,
		qymc: $("#_qymc_").text(),
		hcsxmc: $("#_hcsxmc_").text(),
		sm:$("#k_failReason").val()
	}, function (response) {
		if (response.status == $.husky.SUCCESS) {
			$.messager.show('操作提示', response.message, 'info', "bottomRight");
//			$("#annualAuditItemGrid").datagrid("reload");
            annualAuditItemInit();
            _closeAuditWindow();
		} else {
			$.messager.alert('错误', response.message, 'error');
		}
	});
}

function closeAuditWindow() {
    $("#btnShowPrompt").tooltip("hide");
	if($("#_hcjieguo_").text() != 1) {
		fail();
	}
	_closeAuditWindow();
}

function _closeAuditWindow() {
	$("#auditContent").empty();
	$("#auditLog").empty();
	$("#auditItemAccordion").accordion("select", 0);
}
