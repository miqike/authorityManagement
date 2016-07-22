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

function grid2ClickHandler() {
    if ($('#grid2').datagrid('getSelected') != null) {
        $('#btnShowAuditDialog').linkbutton('enable');
    } else {
        $('#btnShowAuditDialog').linkbutton('disable');
    }
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
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id),
            order: 1
        });
    } else {
        $.messager.alert("提示","请首先选择计划和单位")
    }
}

function showAuditDialog() {
	
	$.easyui.showDialog({
		title : "核查结果审核",
		width : 520,
		height : 310,
		topMost : false,
		iconCls:'icon2 r12_c19',
		enableSaveButton : true,
		enableApplyButton : false,
		saveButtonText : "审核",
		closeButtonText : "取消",
		closeButtonIconCls : "icon-undo",
		href : "./auditForm.jsp",
		onLoad : function() {
			doAuditFormInit();
		},
		onSave: function() {
			auditHcwr();
		}
	});
}

//初始化
$(function () {
    $.fn.zTree.init($("#orgTree"), setting);
    clearInput();
    loadGrid1();
});

