// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}
//按中文方式取得字符串字符个数（两个英文字符同一个汉字）
function get_length(s) {
    var char_length = 0;
    for (var i = 0; i < s.length; i++) {
        var son_char = s.charAt(i);
        encodeURI(son_char).length > 2
            ? char_length += 1
            : char_length += 0.5;
    }
    return char_length;
}
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
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
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
    // LODOP.PRINT();
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
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
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

    // LODOP.PREVIEW();
    LODOP.PRINT();
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
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
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

    // LODOP.PREVIEW();
    LODOP.PRINT();
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
function writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize ){
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), data[0]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), data[1]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[1];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), data[2]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[2]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[2]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[2];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[3]), toMilli(rowHeight), data[3]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[3]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[3]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[3];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[4]), toMilli(rowHeight), data[4]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[4]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[4]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[4];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[5]), toMilli(rowHeight), data[5]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[5]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[5]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[5];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[6]), toMilli(rowHeight), data[6]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[6]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[6]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[6];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[7]), toMilli(rowHeight), data[7]);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
}
function getDataFromDataList(xh,dataList,zhongDian){
    var data=[];
    var relationShip=[{"source":"购买股权","dest":"企业投资设立企业、购买股权信息"},{"source":"实缴出资","dest":"股东或发起人认缴和实缴的出资额、出资时间、出资方式等信息"},
        {"source":"股权变更信息","dest":"有限公司股东股权转让等股权变更信息"}, {"source":"资产财务","dest":"资产总额（万元）"},
        {"source":"","dest":"负债总额（万元）"},{"source":"","dest":"所有者权益合计（万元）"},
        {"source":"","dest":"营业总收入（万元）"},{"source":"","dest":"主营业务收入（万元）"},
        {"source":"","dest":"利润总额（万元）"},{"source":"","dest":"净利润（万元）"},
        {"source":"","dest":"纳税总额（万元）"},{"source":"对外提供保证担保信息","dest":"对外提供保证担保信息"},
        {"source":"企业通信地址","dest":"企业通信地址"},{"source":"邮政编码","dest":"邮政编码"},
        {"source":"联系电话","dest":"联系电话"},{"source":"电子邮箱","dest":"电子邮箱"},
        {"source":"企业网站网店的名称和网址","dest":"企业网站以及从事网络经营的网店名称、网址等信息"},{"source":"存续状态","dest":"企业开业、歇业、清算等存续状态"},
        {"source":"人员信息","dest":"从业人数"},{"source":"党建信息","dest":"党建信息"}
    ];
    console.log(xh-1);
    console.log(relationShip[xh-1]);
    data[0]=xh;
    data[1]=zhongDian;
    data[2]=relationShip[xh-1].dest;
    data[3]="";
    data[4]="";
    data[5]="";
    data[6]="";
    data[7]="";
    for(var i =0;i<dataList.length;i++){
        if(dataList[i].name==relationShip[xh-1].source){
            data[3]=dataList[i].qygsnr;
            data[4]=dataList[i].bznr;
            data[5]=dataList[i].bznr;
            data[6]=dataList[i].hcjg;
            data[7]=dataList[i].sm;
        }
    }
    return data;
}
function printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(){
    $("#gaozhishuWindow").window("close");
    var columnWidthFull = 200;
    var columnWidths=[15,25,25,25,25,25,25,30];
    var left = 0;
    var top = 0;
    var rowHeight = 0;
    //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    var LODOP = getLodop();
    //设置纸张
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA("5mm", "5mm", "210mm", "297mm", "");
    LODOP.SET_PRINT_PAGESIZE(1, toMilli(210), toMilli(297), "");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
    //LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);

    var qy=$("#grid1").datagrid("getSelected");
    //开始打印
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业年报公示信息核查结果报告");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "计划编号："+qy.jhbh+"    计划名称："+qy.jhmc+"    检查时间："+qy.jhxdrq);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业名称："+qy.hcdwName+"    注册号/社会统一信用代码："+qy.hcdwXydm);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);
    top = top + 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "抽查结果：    检查机关："+qy.hcjgmc);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 12);

    //打印表格头
    var fontSize=10;
    rowHeight=8;
    top = top + rowHeight;
    var colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最上横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "序号");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), "检查信息分类");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[1];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), "检查项目");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[2]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[2]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[2];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[3]), toMilli(rowHeight), "公示内容");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[3]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[3]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[3];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[4]), toMilli(rowHeight), "登记/备案内容");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[4]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[4]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[4];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[5]), toMilli(rowHeight), "实际内容");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[5]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[5]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[5];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[6]), toMilli(rowHeight), "对比结果");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[6]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[6]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[6];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[7]), toMilli(rowHeight), "问题描述");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线

    var dataList=$("#annualAuditItemGrid").datagrid("getData").rows;
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    fontSize=6;
    var data=getDataFromDataList(1,dataList,"重点");//["1","重点","企业投资设立企业、购买股权信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(2,dataList,"");//["2","","股东或发起人认缴和实缴的出资额、出资时间、出资方式等信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(3,dataList,"");//["3","","有限公司股东股权转让等股权变更信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(4,dataList,"");//["4","","资产总额（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(5,dataList,"");//["5","","负债总额（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(6,dataList,"");//["6","","所有者权益合计（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(7,dataList,"");//["7","","营业总收入（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(8,dataList,"");//["8","","主营业务收入（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(9,dataList,"");//["9","","利润总额（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(10,dataList,"");//["10","","净利润（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(11,dataList,"");//["11","","纳税总额（万元）","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(12,dataList,"");//["12","","对外提供保证担保信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(13,dataList,"一般");//["13","一般","企业通信地址","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(14,dataList,"");//["14","","邮政编码","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(15,dataList,"");//["15","","联系电话","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=10;
    colLeft=0;
    data=getDataFromDataList(16,dataList,"");//["16","","电子邮箱","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(17,dataList,"");//["17","","企业网站以及从事网络经营的网店名称、网址等信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(18,dataList,"");//["18","","企业开业、歇业、清算等存续状态","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(19,dataList,"");//["19","","从业人数","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    rowHeight=12;
    colLeft=0;
    data=getDataFromDataList(20,dataList,"");//["20","","党建信息","","","","",""];
    writeQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao(columnWidths,data,LODOP,top,colLeft,columnWidthFull,rowHeight,fontSize);
    top = top + rowHeight;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最下横线

    LODOP.PREVIEW();
    // LODOP.PRINT();
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印企业年报公示信息核查结果报告";
    data.businessKey = $("#zeling_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}
//公示信息更正审批表
function printGongShiXinXiGengZhengBiao(){
    $("#gaozhishuWindow").window("close");
    var columnWidthFull = 200;
    var columnWidths=[50,75,75];
    var left = 0;
    var top = 0;
    var rowHeight ;
    //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    var LODOP = getLodop();
    //设置纸张
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA("5mm", "5mm", "210mm", "297mm", "");
    LODOP.SET_PRINT_PAGESIZE(1, toMilli(210), toMilli(297), "");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
    //LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);

    var qy=$("#grid1").datagrid("getSelected");
    //开始打印
    rowHeight= 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), qy.hcjgmc);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + rowHeight;
    rowHeight= 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "公示信息更正审批表");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

    //打印表格头
    var fontSize=15;
    rowHeight=15;
    top = top + rowHeight;
    var colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最上横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "企业名称");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight), qy.hcdwName);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "注册号");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight), qy.hcdwXydm);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    //循环区域的表头
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "拟更正事项");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), "更正前信息");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[1];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), "更正后信息");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    //循环打印内容
    var dataList=$("#annualAuditItemGrid").datagrid("getData").rows;
    for(var i=0;i<dataList.length;i++){
        if(dataList[i].hcxxfl==1 && dataList[i].hcjg==2){
            fontSize=10;
            top = top + rowHeight;
            rowHeight=10;
            colLeft=0;
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), dataList[i].name);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
            colLeft=colLeft+columnWidths[0];
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), dataList[i].qygsnr);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
            colLeft=colLeft+columnWidths[1];
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), dataList[i].bznr);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
        }
    }
    fontSize=15;
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "初审意见");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "审核意见");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "备注");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最下横线

    top = top + rowHeight;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidthFull), toMilli(rowHeight), "    注：个体工商户、农民专业合作社适用此表。");

    LODOP.PREVIEW();
    // LODOP.PRINT();
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印企业年报公示信息核查结果报告";
    data.businessKey = $("#zeling_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}
//即时核查公示信息更正审批表
function printGongShiXinXiGengZhengBiaoJs(){
    $("#gaozhishuWindow").window("close");
    var columnWidthFull = 200;
    var columnWidths=[50,75,75];
    var left = 0;
    var top = 0;
    var rowHeight ;
    //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    var LODOP = getLodop();
    //设置纸张
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA("5mm", "5mm", "210mm", "297mm", "");
    LODOP.SET_PRINT_PAGESIZE(1, toMilli(210), toMilli(297), "");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
    //LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);

    var qy=$("#myTaskGrid").datagrid("getSelected");
    //开始打印
    rowHeight= 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), qy.hcjgmc);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
    top = top + rowHeight;
    rowHeight= 10;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "公示信息更正审批表");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
    LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);

    //打印表格头
    var fontSize=15;
    rowHeight=15;
    top = top + rowHeight;
    var colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最上横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "企业名称");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight), qy.hcdwName);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "注册号");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight), qy.hcdwXydm);
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    //循环区域的表头
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "拟更正事项");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), "更正前信息");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[1];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), "更正后信息");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    //循环打印内容
    var dataList=$("#annualAuditItemGrid").datagrid("getData").rows;
    for(var i=0;i<dataList.length;i++){
        if(dataList[i].hcxxfl==1 && dataList[i].hcjg==2){
            fontSize=10;
            top = top + rowHeight;
            rowHeight=10;
            colLeft=0;
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), dataList[i].name);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
            colLeft=colLeft+columnWidths[0];
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]), toMilli(rowHeight), dataList[i].qygsnr);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[1]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[1]), 0, 1);//竖线
            colLeft=colLeft+columnWidths[1];
            LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[2]), toMilli(rowHeight), dataList[i].bznr);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
            LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
        }
    }
    fontSize=15;
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "初审意见");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "审核意见");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    rowHeight=15;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 1);//横线
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top + rowHeight), toMilli(colLeft), 0, 2);//最左边竖线
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[0]), toMilli(rowHeight), "备注");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft + columnWidths[0]), toMilli(top + rowHeight ), toMilli(colLeft + columnWidths[0]), 0, 1);//竖线
    colLeft=colLeft+columnWidths[0];
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidths[1]+columnWidths[2]), toMilli(rowHeight),"");
    LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
    LODOP.SET_PRINT_STYLEA(0, "FontSize", fontSize);
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(columnWidthFull), toMilli(top + rowHeight ), toMilli(columnWidthFull), 0, 2);//竖线
    top = top + rowHeight;
    colLeft=0;
    LODOP.ADD_PRINT_LINE(toMilli(top), toMilli(colLeft), toMilli(top), toMilli(columnWidthFull), 0, 2);//最下横线

    top = top + rowHeight;
    LODOP.ADD_PRINT_TEXTA("0", toMilli(top+2), toMilli(colLeft), toMilli(columnWidthFull), toMilli(rowHeight), "    注：个体工商户、农民专业合作社适用此表。");

    // LODOP.PREVIEW();
    LODOP.PRINT();
    var data = {};
    data.moduleName = "gaozhishu";
    data.desc = "打印通知书";
    data.message = "打印企业年报公示信息核查结果报告";
    data.businessKey = $("#zeling_hcrwId").text();
    $.post("../sys/log", data, function (response) {
        console.log(response.message);
    });
}