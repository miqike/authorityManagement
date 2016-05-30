// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doInit() {
    var auditItem = $("#mainGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    // $("#zeling_hcrwId").text(auditItem.hcrwId);
    // $("#zeling_hcsxId").text(auditItem.hcsxId);

    $("#zeling_qymc").textbox("setValue", qy.hcdwName);
    // $("#zeling_xydm").textbox("setValue", qy.hcdwXydm);
    // $("#zeling_hcjg").textbox("setValue", qy.hcjgmc);
    $("#zeling_gljmc").textbox("setValue", qy.hcjgmc);
    $("#zeling_tznr").textbox("setValue", auditItem == null ? "" : auditItem.name);

    $("#btnClose").click(function () {
        $("#gaozhishuWindow").window("close");
    });

    $("#btnPrint").click(function () {
        var columnWidthFull = 190;
        var columnWidth = 0;
        var leftOri = 10;
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
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_gljmc").textbox("getValue") + "工商行政管理局");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "责令限期履行公示义务通知书");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_wenhao").textbox("getValue") + "（文号）");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        //企业名称
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_qymc").textbox("getValue") + "：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), "150mm", "　　经查，你单位未依法履行　 " + $("#zeling_tznr").textbox("getValue") + "　信息公示义务。根据《企业信息公示暂行条例》第十条、《经营异常名录管理办法》第七条的规定，限你单位在10日 内履行公示义务。逾期不履行的，将依法被列入经营异常名录。");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 90;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　" + $("#zeling_gljmc").textbox("getValue") + "　工商行政管理局公章");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　　　年　　月　　日");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

        top = top + 20;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "送达回证");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

        top = top + 10;
        rowHeight = 10;
        left = leftOri;
        columnWidth = 30;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidthFull), 0, 2);//最上侧橫线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "送达地点");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 80;
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 30;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "送达方式");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(leftOri + columnWidthFull), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(leftOri), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 1);//橫线

        top = top + rowHeight;
        left = leftOri;
        rowHeight = 30;
        columnWidth = 30;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "收件人");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 40;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "（签名或者盖章）　　　年　月　日");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 40;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "见证人");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 70;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "（签名或者盖章）　　年　月　日");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(leftOri + columnWidthFull), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(leftOri), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 1);//橫线

        top = top + rowHeight;
        left = leftOri;
        rowHeight = 10;
        columnWidth = 30;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "送达人");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        columnWidth = 100;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "（签名或者盖章）　　年　月　日");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(leftOri + columnWidthFull), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(leftOri), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 1);//橫线

        top = top + rowHeight;
        left = leftOri;
        rowHeight = 10;
        columnWidth = 30;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth), toMilli(rowHeight), "备注");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
        left = left + columnWidth;
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 1);//竖线
        LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(leftOri + columnWidthFull), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 2);//最右侧竖线
        LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(leftOri), toMilli(top + rowHeight), toMilli(leftOri + columnWidthFull), 0, 1);//橫线

        top = top + 20;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(leftOri), toMilli(columnWidthFull), toMilli(40), "注：本文书一式两份，一份送达，一份归档。");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);

        LODOP.PREVIEW();
        //LODOP.PRINT();
    });

}
