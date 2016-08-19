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
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id),
            order: 1,
            auditResult:0
        });
    } else {
        $.messager.alert("提示","请首先选择计划和单位")
    }
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
    //$("#btnSearch").click(loadGrid1);
    //$("#btnReset").click(funcBtnRest);

    $("#btnPrint").click(function () {
        var data = null;
        var treeObj = $.fn.zTree.getZTreeObj("orgTree");
        var selected = treeObj.getSelectedNodes();
        var hcjh = $('#grid1').datagrid('getSelected');
        var params = {
            "pageTitle": selected[0].name + "工商行政管理局\n抽查结果公示表\n（"+$("#grid1").datagrid("getSelected").cxwh+"）",
            "pageTitleFirst": "1",
            "pageFoot": selected[0].name + "工商行政管理局公章\n        年    月    日",
            "pageFootLast": "1",
            "titleHeight": 40,
            "pageRows": 24,
            "firstPageRows": 15,
            "pageWidth": 297, "pageHeight": 210,
            "pageName": "", "pageOrient": 1
        };
        var columnList = [];
        columnList.push({"fieldName": "hcdwName", "header": "企业名称", "colWidth": 80});
        columnList.push({"fieldName": "hcdwXydm", "header": "注册号", "colWidth": 80});
        columnList.push({"fieldName": "hcjgmc", "header": "检查机关", "colWidth": 80});
        columnList.push({"fieldName": "sjwcrq", "header": "检查时间", "colWidth": 20});
        columnList.push({"fieldName": "hcjieguo", "header": "抽查结果", "colWidth": 30, "codeName": "gsjg"});
        //取得数据
        $.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForOrg&hcjhId=" + hcjh.id + "&organization=" + processorOrgId(selected[0].id) + "&order=1&auditResult=0", null, function (response) {
            if (response.status == 1) {
                data = response.rows;
                if(data.length>0){
                    listPrint(params, data, columnList);
                }else{
                    $.messager.show({
                        title : '提示',
                        msg : "未找到任何数据"
                    });
                }
            }
        });
    });
});

