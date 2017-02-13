function queryPlan(node) {
    var _orgId = $("#f_deptName").combobox("getValue");
    if (_orgId != "") {
        var orgId = new Array();
        orgId.push(_orgId);
        xxxx(orgId);
    } else if (window.orgTreeObj) {
        queryPlanFromTree();
    }
}
function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnModify').linkbutton('enable');
        $('#btnAudit').linkbutton('enable');
        $('#btnViewCheckList').linkbutton('enable');
        if ($('#grid1').datagrid('getSelected').shzt != 2) {
            $('#btnModify').linkbutton('enable');
            $('#btnAudit').linkbutton({
                text: '审核',
                iconCls: 'icon2 r14_c2'
            });
        } else {
            $('#btnModify').linkbutton('disable');
            $('#btnAudit').linkbutton({
                text: '取消审核',
                iconCls: 'icon2 r14_c1'
            });
        }
    } else {
        $('#btnModify').linkbutton('disable');
        $('#btnAudit').linkbutton('disable');
        $('#btnViewCheckList').linkbutton('disable');
    }
    $('#grid2').datagrid("loadData", {total: 0, rows: []})
}

function grid2ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnShowDetail').linkbutton('enable');
    } else {
        $('#btnShowDetail').linkbutton('disable');
    }
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

function search() {
	loadMyPlan();
}

function firstLoadMyPlan() {
	var options = $("#grid1").datagrid("options")
	options.url = "../common/query?mapper=hcjhMapper&queryName=query" + (userInfo.ext1 == 1 ? "Ext": "");
	loadMyPlan();
}

function loadMyPlan() {
	
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        //hcjgmc: $('#f_hcjgmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")//,
        //planType: $('#f_planType').combobox("getValue")
    });
}


function loadGrid1() {
    var options = $("#grid1").datagrid("options");
    options.url = '../common/query?mapper=hcjhMapper&queryName=query';
    $('#grid1').datagrid('load', {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}

function clearInput() {
    $("#f_nd").val("");
    $("#f_id").val("");
    $("#f_jhbh").val( "");
    $("#f_gsjhbh").val( "");
    $("#f_jhmc").val( "");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function reset() {
    clearInput();
    loadGrid1();
}
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes()
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {

        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=statistics1';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id)
        });
    } else {
        $.messager.alert("提示","请首先选择计划和单位")
    }
}
//格式化统计1结果
function formatStatisticsFail1(val, row, rowIndex){
    return "<a class='easyui-linkbutton' onclick='loadStatisticsFail1(\"" + rowIndex + "\");' href='javascript:void(0);'>"+val+"</a>";
}
function loadStatisticsFail1(rowIndex){
    var hcjh = $('#grid1').datagrid('getSelected');
    var data=$("#grid2").datagrid("getData").rows[rowIndex];
    var options = $("#grid3").datagrid("options");
    options.url = '../common/query?mapper=hcrwMapper&queryName=statistics2';
    $('#grid3').datagrid('load', {
        hcjhId: hcjh.id,
        organization: data.HCJG
    });
    $("#statisticsWindow1").dialog("open");
}
function formatStatisticsFail2(val, row, rowIndex){
    return "<a class='easyui-linkbutton' onclick='loadStatisticsFail2(\"" + rowIndex + "\");' href='javascript:void(0);'>"+val+"</a>";
}
function loadStatisticsFail2(rowIndex){
    var hcjh = $('#grid1').datagrid('getSelected');
    var data=$("#grid3").datagrid("getData").rows[rowIndex];
    var options = $("#grid4").datagrid("options");
    options.url = '../common/query?mapper=hcrwMapper&queryName=statistics3';
    $('#grid4').datagrid('load', {
        hcjhId: hcjh.id,
        organization: data.HCJG,
        hcjieguo:data.HCJIEGUO
    });
    $("#statisticsWindow2").dialog("open");
}
function formatStatisticsFail3(val, row, rowIndex){
    return "<a class='easyui-linkbutton' onclick='loadStatisticsFail3(\"" + rowIndex + "\");' href='javascript:void(0);'>"+val+"</a>";
}
function loadStatisticsFail3(rowIndex){
    var hcjh = $('#grid1').datagrid('getSelected');
    var data=$("#grid4").datagrid("getData").rows[rowIndex];
    var options = $("#grid5").datagrid("options");
    options.url = '../common/query?mapper=hcrwMapper&queryName=statistics4';
    $('#grid5').datagrid('load', {
        hcjhId: hcjh.id,
        organization: data.HCJG,
        hcjieguo:data.HCJIEGUO,
        hcsxId:data.HCSX_ID
    });
    $("#statisticsWindow3").dialog("open");
}
//初始化
$(function () {
	$.husky.getUserInfo();
    $.fn.zTree.init($("#orgTree"), setting);
    clearInput();
    if (null != window.userInfo) {
    	firstLoadMyPlan();
    } else {
        $.subscribe("USERINFO_INITIALIZED", firstLoadMyPlan);
    }
});

