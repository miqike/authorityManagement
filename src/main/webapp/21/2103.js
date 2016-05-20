window.operateType = "";
function mainGridButtonHandler() {

}

function mainGridDblClickHandler(index, row) {

}

function add() {
    $('#detailWindow input').val('');
    $('#detailTable input.easyui-textbox').textbox("enable");
    $('#detailTable input.easyui-combobox').combobox("enable");
    $("#btnEditOrSave").linkbutton({
        iconCls: 'icon-save',
        text: '保存'
    });
    window.operateType = "new";
    showModalDialog("detailWindow");
}

function view() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $('#mainGrid').datagrid('getSelected');
        console.log(row);
        loadForm($("#detailWindow"), row);
        window.operateType = "edit";
        showModalDialog("detailWindow");
    }
}
function view1() {
	if (!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		console.log(row);
		loadForm($("#detailWindow1"), row);
		window.operateType = "edit";
		showModalDialog("detailWindow1");
	}
}

function remove() {
    if (!$(this).linkbutton('options').disabled) {

        var row = $('#mainGrid').datagrid('getSelected');
        if (row) {
            $.messager.confirm('确认', '确认删除此数据？', function (r) {
                if (r) {
                    var index = $("#mainGrid").datagrid("getRowIndex", row);
                    $("#mainGrid").datagrid("deleteRow", index);
                }
            });
        }
    }
}

function editOrSave() {
    if ($('#detailWindow').form('validate')) {
        if (window.operateType == "new") {
            var data = drillDownForm("detailWindow");
            $("#mainGrid").datagrid("appendRow", data);
        } else {
            var row = $('#mainGrid').datagrid('getSelected');
            var index = $("#mainGrid").datagrid("getRowIndex", row);
            var data = drillDownForm("detailWindow");
            $("#mainGrid").datagrid("updateRow", {
                    index: index,
                    row: data
                }
            );
        }
    }
    return false;
}

function poiExport() {

}

$(function () {

    $("#btnAdd").click(add);
    $("#btnView").click(view);
    $("#btnView1").click(view1);
    $("#btnDelete").click(remove);
    $("#btnExport").click(poiExport);
    $("#btnClose").click(function () {
        $("#detailWindow").window("close");
    });
    $("#btnEditOrSave").click(editOrSave);

    $("#btnReset").click(function () {
        $("#s_name").val('');
    });
    $("#btnSearch").click(function () {
    });

    $(".datagrid-body").niceScroll({
        cursorcolor: "lightblue", // 滚动条颜色
        cursoropacitymax: 3, // 滚动条是否透明
        horizrailenabled: false, // 是否水平滚动
        cursorborderradius: 0, // 滚动条是否圆角大小
        autohidemode: false // 是否隐藏滚动条
    });

    $("#detailTable td:even").css("text-align", "right");
    var data = {
        "CommonQuery": true,
        "_": "1462340087792",
        "_orgId": "0304",
        "_userId": "yqh",
        "mapper": "userMapper",
        "message": "查询成功",
        "orderby": "asc",
        "page": 1,
        "pageIndex": "0",
        "pageNumber": "1",
        "pageSize": "20",
        "queryName": "queryUser"
        ,
        "records": 2,
        "rows": [
            {
                "id": "1001",
                "name": "通信地址",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "口头询问或由企业提供相关材料",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "1002",
                "name": "邮政编码",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "自行查询",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "1003",
                "name": "联系电话",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "询问了解或拨打企业公示电话",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "1004",
                "name": "电子邮箱",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "由企业向工商监管部门指定邮箱发送邮件",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "1005",
                "name": "企业网站",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "自行查询、网络查询",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "1006",
                "name": "存续状态",
                "type": "一般检查信息",
                "desc": "无",
                "material": "无",
                "method": "现场查询或书页检查",
                "handle": "10日内改正，逾期未改的，按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "2001",
                "name": "企业投资设立企业、购买股权信息",
                "type": "重点检查信息",
                "desc": "检查企业提交的材料或委托专业机构开展相关工作",
                "material": "审核报告、财务资料、企业章程、对外投资设立企业、购买股权的股东会决议",
                "method": "检查企业提交的材料或委托专业机构开展相关工作",
                "handle": "按隐瞒真实情况、弄虚作假处理。"
            },
            {
                "id": "2002",
                "name": "股东或发起人认缴和实缴的出资额",
                "type": "重点检查信息",
                "desc": "",
                "material": "检查对认缴企业出资到位情况",
                "method": "核对企业申报年度的自有章程、登记系统中申报年度的相关登记备案信息",
                "handle": "按隐瞒真实情况、弄虚作假处理。发现被告实缴制的27类行业的企业以及中外合作经营企业、外商独资企业存在两虚一逃违法行为的，同时应依法查处。"
            }
        ],
        "status": 1,
        "total": 26
    };
    $("#mainGrid").datagrid("loadData", data.rows);
});