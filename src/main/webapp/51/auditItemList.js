
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
        	console.log("----------------")
            _auditItemsTabSelectHandler(index)
        } else {
        	console.log("++++++++++++++++")
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
    $.ajax({
        url: "./" + hcrw.id + "/initStatus",
        data: {hcrwId: hcrw.id},
        type: 'GET',
        success: function (response) {
            if (response.status == SUCCESS) {
                if (response.data == 0) {
                    //$.messager.confirm('确认', '检查列表尚未生成,是否认生成检查列表?', function (r) {
                    //    if (r) {
                            $.ajax({
                                url: "./" + hcrw.id + "/init",
                                type: 'POST',
                                success: function (response) {
                                    if (response.status == SUCCESS) {
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
    _funcAnnualAudit();
}

function funcAnnualAudit() {
    if(!$(this).linkbutton('options').disabled) {
        _funcAnnualAudit();
    }
}
function _funcAnnualAudit() {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
        $.alert("未配置比对页面")
    } else {
        $("#auditItemAccordion").accordion("select", 1);
        //showModalDialog("auditWindow");
        $("#auditContent").panel({
            href: '../audit/' + auditItem.page + '.jsp',
            onLoad: function () {
                _doInit("annual");
                doInit();
            }
        });
        /*
         if ($("#auditLog").length == 0) {
         $('<div id="auditLog" style="margin-top:5px;"></div>').appendTo($("#auditWindow"))
         }
         $("#auditLog").panel({
         href: '../audit/log.jsp',
         onLoad: function () {
         //doInit();
         }
         }); */


    }
}

function annualAuditItemInit() {
    var options = $("#annualAuditItemGrid").datagrid().datagrid("options");
    options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
    $('#annualAuditItemGrid').datagrid('load', {
        hcrwId: $('#grid1').datagrid('getSelected').id,
        hclx: 1
    });
    
    //$("#auditItemAccordion").accordion("select", 0)
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
    _funcInstanceAudit();
}

function funcInstanceAudit() {
    if(!$(this).linkbutton('options').disabled) {
        _funcInstanceAudit();
    }
}

function _funcInstanceAudit() {
    var auditItem = $("#instanceAuditItemGrid").datagrid("getSelected");
    if (auditItem.page == null) {
        $.alert("未配置比对页面")
    } else {
        $("#auditItemAccordion").accordion("select", 1);

        //showModalDialog("auditWindow");
        $("#auditContent").panel({
            href: '../audit/' + auditItem.page + '.jsp',
            onLoad: function () {
                _doInit("instance");
                doInit();
            }
        });
        /*
         if ($("#auditLog").length == 0) {
         $('<div id="auditLog" style="margin-top:5px;"></div>').appendTo($("#auditWindow"))
         }
         $("#auditLog").panel({
         href: '../audit/log.jsp',
         onLoad: function () {
         //doInit();
         }
         }); */
    }
}

function instanceAuditItemInit() {
    var options = $("#instanceAuditItemGrid").datagrid("options");
    options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
    $('#instanceAuditItemGrid').datagrid('load', {
        hcrwId: $('#grid1').datagrid('getSelected').id,
        hclx: 2
    });
    //$("#auditItemAccordion").accordion("select", 1)
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

    $("#_qygsnr_").text(auditItem.qygsnr == null ? "" : auditItem.qygsnr);
    $("#_bznr_").text(auditItem.bznr == null ? "" : auditItem.bznr);
    $("#_qymc_").text(qy.hcdwName);
    $("#_hcsxmc_").text(auditItem.name);

    $("#btnSuccess").show();
    $("#btnFail").show();

    $("#btnSuccess").click(pass);
    $("#btnFail").click(fail);

    $("#btnConfirmFail").click(confirmFail);
    $("#btnCancelFail").click(cancelFail);
    $("#btnClose").click(closeAuditWindow);
    cancelFail();
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
        if (response.status == SUCCESS) {
            $.messager.show({
                title: '提示',
                msg: response.message
            });
            $("#annualAuditItemGrid").datagrid("reload");
            closeAuditWindow();
        } else {
            $.messager.alert('错误', response.message, 'error');
        }
    });
};

function fail() {
    $('#auditToolbar').hide();
    $('#failReason').show();
}

function cancelFail () {
    $('#auditToolbar').show();
    $('#failReason').hide();
}

function confirmFail () {
    $.post("../audit/complete", {
        hcrwId: $("#_hcrwId_").text(),
        hcsxId: $("#_hcsxId_").text(),
        hcjg: 2,
        qymc: $("#_qymc_").text(),
        hcsxmc: $("#_hcsxmc_").text(),
        sm:$("#k_failReason").val()
    }, function (response) {
        if (response.status == SUCCESS) {
            $.messager.show({
                title: '提示',
                msg: response.message
            });
            $("#annualAuditItemGrid").datagrid("reload");
            closeAuditWindow();
        } else {
            $.messager.alert('错误', response.message, 'error');
        }
    });
}

function closeAuditWindow() {
    $("#auditContent").empty()
    $("#auditLog").empty()
    $("#auditItemAccordion").accordion("select", 0);
}
