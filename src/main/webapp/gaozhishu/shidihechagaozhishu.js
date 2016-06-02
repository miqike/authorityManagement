// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doShidihechagaozhishuInit() {
    // var auditItem = $("#mainGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#shidi_hcrwId").text(qy.id);
    // $("#shidi_hcsxId").text(auditItem.hcsxId);

    $("#shidi_qymc").textbox("setValue", qy.hcdwName);
    $("#shidi_xydm").textbox("setValue", qy.hcdwXydm);
    $("#shidi_hcjg").textbox("setValue", qy.hcjgmc);
    $("#shidi_gljmc").textbox("setValue", qy.hcjgmc);

    $("#btnClose").click(function () {
        $("#gaozhishuWindow").window("close");
    });
    $("#btnPrint").click(function () {
        var columnWidth1 = 60;
        var columnWidth2 = 130;
        var left = 10;
        var top = 10;
        var rowHeight = 0;
        //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
        var LODOP = getLodop();
        //设置纸张
        LODOP.BKIMG_PRINT
        LODOP.PRINT_INITA("5mm", "5mm", "210mm", "297mm", "");
        LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
        LODOP.SET_PRINTER_INDEX(-1);
        LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
        LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
        //LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);

        //开始打印
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", $("#shidi_gljmc").textbox("getValue") + "工商行政管理局");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "企业公示信息实地核查记录表");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        //企业名称
        top = top + 10;
        rowHeight = 20;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上侧橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "企业名称");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_qymc").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
        //注册号
        top = top + rowHeight;
        rowHeight = 20;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "注册号");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_xydm").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
        //法定代表人（负责人）
        top = top + rowHeight;
        rowHeight = 20;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "法定代表人（负责人）");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_fr").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
        //核查实施机关
        top = top + rowHeight;
        rowHeight = 20;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "核查实施机关");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_hcjg").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
        //核查情况
        top = top + rowHeight;
        rowHeight = 80;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "核查情况");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_hcqk").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
        //备注
        top = top + rowHeight;
        rowHeight = 40;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "备注");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_bz").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最下侧橫线
        //企业盖章
        top = top + 50;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "企业盖章：          核查人（签字）：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
        //或法定代表人（负责人）签字
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "或法定代表人（负责人）签字：          核查时间：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
        //见证人签字：
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "见证人签字：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
        //注：个体工商户、农民专业合作社适用此表
        top = top + 20;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "注：个体工商户、农民专业合作社适用此表。");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);

        LODOP.PREVIEW();
        //LODOP.PRINT();
        var data = {};
        data.moduleName = "gaozhishu";
        data.desc = "打印通知书";
        data.message = "打印实地核查告知书";
        data.businessKey = $("#shidi_hcrwId").text();
        $.post("../sys/log", data, function (response) {
            console.log(response.message);
        });

    });
}
