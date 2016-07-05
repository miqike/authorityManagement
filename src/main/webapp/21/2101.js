function collapseHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}

//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=scztMapper&queryName=query';
    if(treeNode.id.length==8) {
    	options.queryParams = {
    		qybm: treeNode.id
    	};
    } else {
	    options.queryParams = {
	        dwId: processorOrgId(treeNode.id)
	    };
    }
    $("#mainGrid").datagrid(options);
}

function mainGridButtonHandler() {
    if ($('#mainGrid').datagrid('getSelected') != null) {

    } else {
        $('#btnView').linkbutton('disable');
        $('#btnDelete').linkbutton('disable');
        $('#btnResetPass').linkbutton('disable');
        $('#btnLock').linkbutton('disable');
    }
}

function mainGridDblClickHandler(index, row) {
    window.selected = index;
    $('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
}

function formatZfry(val, row) {
	if(row.zfryName1 != null && row.zfryName2 != null ) {
		return row.zfryName1 + "/" + row.zfryName2;
	} else if(row.zfryName1 == null ) {
		return row.zfryName2;
	} else if(row.zfryName2 == null ) {
		return row.zfryName1;
	}
}

function poiExport() {
    $("<iframe id='poiExport' style='display:none' src='../user/poiExport'>").appendTo("body");
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

$(function () {
    $.fn.zTree.init($("#orgTree"), setting);
    $("#btnView").click(function(){
        showModalDialog("examHistory");
        var qy=$("#mainGrid").datagrid("getSelected");
        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForXydm';
        $('#grid2').datagrid('load', {
            hcdwXydm: qy.xydm
        });
    });
    $("#btnCloseHistory").click(function(){
        $("#examHistory").window("close");
    });
    $("#btnViewHcsxjg").click(function(){
        showModalDialog("examHistoryHcsxjg");
        var rw=$("#grid2").datagrid("getSelected");
        var options = $("#grid3").datagrid("options");
        options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
        $('#grid3').datagrid('load', {
            hcrwId: rw.id
        });
    });
    $("#btnCloseHcsxjg").click(function(){
        $("#examHistoryHcsxjg").window("close");
    });

    $("#btnSearch").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        var selected = treeObj.getSelectedNodes();

        var options = $('#mainGrid').datagrid('options');
        options.url = '../common/query?mapper=scztMapper&queryName=query';
        options.queryParams = {
            dwId: selected.length == 1 ? processorOrgId(selected[0].id) : "",
            jhnd: $("#f_jhnd").val(),
            jhbh: $("#f_jhbh").val(),
            hcry: $("#f_hcry").val(),
            qymc: $("#f_qymc").val(),
            xydm: $("#f_xydm").val(),
            cxwh: $("#f_cxwh").val(),
            hyfl: $("#f_hyfl").combobox("getValue"),
            qy: $("#f_qy").val(),
            zzxs: $("#f_zzxs").combobox("getValue"),
            jyzt: $("#f_jyzt").combobox("getValue"),
            hcjg: $("#f_hcjg").combobox("getValue"),
            jhmc:$("#f_jhmc").val(),
            gsjhbh:$("#f_gsjhbh").val()
        };
        $("#mainGrid").datagrid(options);

    });
    $("#btnReset").click(function () {
        $("#queryTable").form("clear");
        $('#mainGrid').datagrid('loadData', []);
    });
});