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
	console.log(row.rwzt)
	if (row.rwzt == 1){
		return 'background-color:lightgray;'; // return inline style
	} else if (row.rwzt == 2) {
		return 'background-color:orange;';
	} else if (row.rwzt == 3) {
		return 'background-color:lightblue;';
	} else if (row.rwzt == 4) {
		return 'background-color:brown;color:#fff;';
	} else if (row.rwzt == 5) {
		return 'background-color:lightgreen;';
	} else {
		return 'background-color:lightgray;';;
	}
}

function loadMyTask() {
    var options = $("#grid1").datagrid("options");
    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForAuditor';
    $('#grid1').datagrid('load', {
        nd: $('#f_nd').numberspinner("getValue"),
        hcjhId: $('#f_hcjhId').textbox("getValue"),
        jhmc: $('#f_jhmc').textbox("getValue")
    });
}

function grid1ClickHandler() {
    //控制四个按钮显示
    var hcrw = $('#grid1').datagrid('getSelected');
    $('#p_id').textbox("setValue", hcrw.hcjhId);
    $('#p_jhmc').textbox("setValue", hcrw.jhmc);
    $('#p_jhxdrq').datebox("setValue", formatDate(hcrw.jhxdrq));
    $('#p_jhyqwcsj').datebox("setValue", formatDate(hcrw.jhyqwcsj));
    $('#p_hcjieguo').combobox("setValue", hcrw.hcjieguo);

    $('#btnSendHcgzs').linkbutton("enable");
    $('#btnSendZllxtzs').linkbutton("enable");
    $('#btnSendQyzshch').linkbutton("enable");
    $('#btnViewDocument').linkbutton("enable");

    if (hcrw.dataLoaded == 0) {
        $('#btnPullData').linkbutton("enable");
    } else {
        $('#btnPullData').linkbutton("disable");
    }
    refreshAuditItemList();
}

function refreshAuditItemList() {
    if ($("#annualAuditItemGrid").length == 0 && $("#instanceAuditItemGrid").length == 0) {
        $("#auditItemList").panel({
            href: './auditItemList.jsp',
            onLoad: function () {
                doAuditItemListInit();
            }
        });
    } else {
        doAuditItemListInit();
    }
}

function funcBtnRest() {
    $("#f_nd").textbox("setValue", new Date().getFullYear());
    $("#f_hcjhId").textbox("setValue", "");
    $("#f_jhmc").textbox("setValue", "");
}

function clearInput() {
    $("#f_hcjhId").textbox("setValue", "");
    $("#f_jhmc").textbox("setValue", "");
    $("#p_id").textbox("setValue", "");
    $("#p_jhmc").textbox("setValue", "");
    $("#p_xdsj").datebox("setValue", "");
    $("#p_yqwcsj").datebox("setValue", "");
}

function funcBtnPullData() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $("#grid1").datagrid("getSelected");
        $.getJSON("./" + row.id + "/pull", null, function (response) {
            if (response.status == SUCCESS) {
                $.messager.alert("提示", response.message, 'info');
                refreshAuditItemList();
                row.dataLoaded = 1;
            }
        });
    }
}

function funcBtnViewDocument() {
    if (!$(this).linkbutton('options').disabled) {
        showModalDialog("documentWindow");
        $("#docPanel").panel({
            href: './docList.jsp',
            onLoad: function () {
                doInit();
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

$(function () {
    clearInput();
    $("#f_nd").textbox("setValue", new Date().getFullYear());
    $("#btnView").click(showExamHistory);
    loadMyTask();

    $("#btnSearch").click(loadMyTask);
    $("#btnReset").click(funcBtnRest);
    $("#btnPullData").click(funcBtnPullData);
    $("#btnViewDocument").click(funcBtnViewDocument);

    $("#btnSendHcgzs").click(function () {
        showModalDialog("gaozhishuWindow");
        $("#gaozhishuContent").panel({
            href: '../gaozhishu/shidihechagaozhishu.jsp',
            onLoad: function () {
                doShidihechagaozhishuInit();
            }
        });
    });
    $("#btnSendZllxtzs").click(function () {
        showModalDialog("gaozhishuWindow");
        $("#gaozhishuContent").panel({
            href: '../gaozhishu/zelingluxingtongzhishu.jsp',
            onLoad: function () {
                doZelingluxingtongzhishuInit();
            }
        });
    });
    $("#btnSendQyzshch").click(function () {
        showModalDialog("gaozhishuWindow");
        $("#gaozhishuContent").panel({
            href: '../gaozhishu/qiyezhusuohechahan.jsp',
            onLoad: function () {
                doQiyezhusuohechahanInit();
            }
        });
    });

    $("#btnUpdateHcjg").linkbutton("disable");
    $("#btnUpdateHcjg").click(updateHcjg);
    
    $("#btnConfirmUpdateHcjg").click(confirmUpdateHcjg);
    $("#btnConfirmUpdateHcjg").hide();
    
});