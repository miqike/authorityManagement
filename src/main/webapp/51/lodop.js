//打印企业住所核查函
function printQiyezhusuohechahan() {
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zhusuo_gljmc").val() + "工商行政管理局");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业住所（经营场所）检查函");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    //企业名称
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zhusuo_qymc").val() + "：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), "150mm", "　　根据《经营异常名录管理办法》第九条的规定，我局现通过邮寄专用信函的方式对你单位登记的住所（经营场所）进行检查。本函一经签收，视为通过登记的住所（经营场所）取得联系；无人签收的，视为通过登记的住所（经营场所）无法取得联系。");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 60;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　联系人：" + $("#zhusuo_lxr").val());
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　联系电话：" + $("#zhusuo_lxdh").val());
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 90;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　" + $("#zhusuo_gljmc").val() + "　工商行政管理局公章");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　　　年　　月　　日");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 3);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

    top = top + 60;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(leftOri), toMilli(columnWidthFull), toMilli(40), "注：农民专业合作社适用此表。");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);

    LODOP.PREVIEW();
    //LODOP.PRINT();
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印企业住所检查函";
    data.businessKey = $("#zhusuo_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}
//打印实地核查告知书
function printShidihechagaozhishu() {
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", $("#shidi_gljmc").val() + "工商行政管理局");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "企业公示信息实地检查记录表");
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_qymc").val());
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_xydm").val());
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_fr").val());
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
    LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
    //检查实施机关
    top = top + rowHeight;
    rowHeight = 20;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "检查实施机关");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_hcjg").val());
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
    LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 1);//橫线
    //检查情况
    top = top + rowHeight;
    rowHeight = 80;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最上橫线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left), toMilli(top + rowHeight), toMilli(left), 0, 2);//最左侧竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left), toMilli(columnWidth1), "10mm", "检查情况");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1), toMilli(top + rowHeight), toMilli(left + columnWidth1), 0, 1);//竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_hcqk").val());
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top + 2), toMilli(left + columnWidth1), toMilli(columnWidth2), "10mm", $("#shidi_bz").val());
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 16);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(left + columnWidth1 + columnWidth2), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最右侧竖线
    LODOP.ADD_PRINT_LINE(toMilli(top + rowHeight), toMilli(left), toMilli(top + rowHeight), toMilli(left + columnWidth1 + columnWidth2), 0, 2);//最下侧橫线
    //企业盖章
    top = top + 50;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "企业盖章：          检查人（签字）：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
    //或法定代表人（负责人）签字
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidth1 + columnWidth2), "10mm", "或法定代表人（负责人）签字：          检查时间：");
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
    data.message = "打印实地检查告知书";
    data.businessKey = $("#shidi_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });

}
//打印责令履行通知书
function printZelingluxingtongzhishu() {
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_gljmc").val() + "工商行政管理局");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "责令限期履行公示义务通知书");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_wenhao").val() + "（文号）");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    //企业名称
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zeling_qymc").val() + "：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), "150mm", "　　经查，你单位未依法履行　 " + $("#zeling_tznr").val() + "　信息公示义务。根据《企业信息公示暂行条例》第十条、《经营异常名录管理办法》第七条的规定，限你单位在10日 内履行公示义务。逾期不履行的，将依法被列入经营异常名录。");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 90;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　" + $("#zeling_gljmc").val() + "　工商行政管理局公章");
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
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印责令履行公示义务通知书";
    data.businessKey = $("#zeling_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}

//打印企业年报公示信息核查结果报告
function printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(){
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
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业年报公示信息核查结果报告");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "计划编号：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业名称：    注册号/社会统一信用代码：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "抽查结果：   检查机关：");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

    LODOP.PREVIEW();
    //LODOP.PRINT();
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印企业年报公示信息核查结果报告";
    data.businessKey = $("#zeling_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}