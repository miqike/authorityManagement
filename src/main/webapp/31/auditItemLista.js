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
    $("#p_hcjieguo").combobox("disable")
    $("#btnUpdateHcjg").linkbutton("enable");
    $("#btnConfirmUpdateHcjg").hide();

    $("#auditItemAccordion").accordion("select", 0);
    var hcrw = $('#grid1').datagrid('getSelected');
    if(hcrw.nr == 1) {
        $("#auditItemTabs").tabs("enableTab", 0);
        $("#auditItemTabs").tabs("disableTab", 1);
        annualAuditItemInit();
    } else if(hcrw.nr == 2) {
        $("#auditItemTabs").tabs("disableTab", 0);
        $("#auditItemTabs").tabs("enableTab", 1);
        instanceAuditItemInit()
    } else {
        $("#auditItemTabs").tabs("enableTab", 0);
        $("#auditItemTabs").tabs("enableTab", 1);
        annualAuditItemInit()
    }
}

function doAuditItemListInit() {
    window.auditItemDataReady = false;
    var hcrw = $('#grid1').datagrid('getSelected');
    if(null == hcrw) {
    	$("#auditItemList").empty();
    } else {
	    $.ajax({
	        url: "./" + hcrw.id + "/initStatus",
	        data: {hcrwId: hcrw.id},
	        type: 'GET',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	                if (response.data == 0) {
	                    //$.messager.confirm('确认', '检查列表尚未生成,是否认生成检查列表?', function (r) {
	                    //    if (r) {
	                            $.ajax({
	                                url: "./" + hcrw.id + "/init",
	                                type: 'POST',
	                                success: function (response) {
	                                    if (response.status == $.husky.SUCCESS) {
	                                        $.publish("AUDITITEM_DATA_INITIALIZED", null);
	                                        window.auditItemDataReady = true;
	                                        initAuditItemList();
	                                    } else {
	                                        //$.messager.alert('删除失败', response, 'info');
	                                    }
	                                }
	                            });
	                    //    }
	                    //});
	                } else {
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

function annualAuditItemInit() {
	$.getJSON("../common/query?mapper=hcsxjgMapper&queryName=queryForTask",  {
		hcrwId: $('#grid1').datagrid('getSelected').id,
        hclx: 1
    }, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	 $("#annualAuditItemGrid").datagrid("loadData",response);
        }
    });
}
//---------------annual end and instance begin

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
    
    _initPromptForAuditItem(auditItem)
    cancelFail();
}

function closeAuditWindow() {
	if($("#_hcjieguo_").text() != 1) {
		fail();
	}
	_closeAuditWindow();
}

function _closeAuditWindow() {
	$("#auditContent").empty()
	$("#auditLog").empty()
	$("#auditItemAccordion").accordion("select", 0);
}
