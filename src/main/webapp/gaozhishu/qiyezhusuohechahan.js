// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doQiyezhusuohechahanInit() {
    var auditItem = $("#mainGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#zhusuo_hcrwId").text(qy.id);
    // $("#zhusuo_hcsxId").text(auditItem.hcsxId);

    $("#zhusuo_qymc").textbox("setValue", qy.hcdwName);
    // $("#zhusuo_xydm").textbox("setValue", qy.hcdwXydm);
    // $("#zhusuo_hcjg").textbox("setValue", qy.hcjgmc);
    $("#zhusuo_gljmc").textbox("setValue", qy.hcjgmc);

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
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zhusuo_gljmc").textbox("getValue") + "工商行政管理局");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "企业住所（经营场所）核查函");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        //企业名称
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), $("#zhusuo_qymc").textbox("getValue") + "：");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), "150mm", "　　根据《经营异常名录管理办法》第九条的规定，我局现通过邮寄专用信函的方式对你单位登记的住所（经营场所）进行核查。本函一经签收，视为通过登记的住所（经营场所）取得联系；无人签收的，视为通过登记的住所（经营场所）无法取得联系。");
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 60;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　联系人：" + $("#zhusuo_lxr").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 10;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　联系电话：" + $("#zhusuo_lxdh").textbox("getValue"));
        LODOP.SET_PRINT_STYLEA(0, "Alignment", 1);
        LODOP.SET_PRINT_STYLEA(0, "FontName", "宋体");
        LODOP.SET_PRINT_STYLEA(0, "FontSize", 20);
        top = top + 90;
        LODOP.ADD_PRINT_TEXTA("0", toMilli(top), toMilli(left), toMilli(columnWidthFull), toMilli(rowHeight), "　　" + $("#zhusuo_gljmc").textbox("getValue") + "　工商行政管理局公章");
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
        data.message = "打印企业住所核查函";
        data.businessKey = $("#zhusuo_hcrwId").text();
        $.post("../sys/log", data, function (response) {
            console.log(response.message);
        });
    });

}
