/**
 * Created by YuQingHe on 2015/2/10.
 * 房屋维修资金票据打印模板
 * ta01.ta01901 地产号
 * ta01.ta01902 缴费类型
 * ta01.ta01903 小区名称
 * ta01.ta01904 房屋面积
 * ta01.ta01905 房屋所在区域
 * ta01.ta01906 房屋坐落
 * ta01.ta01907 联系电话
 */
// 将角分转为汉字
function toPointWord(current1) {
    var current = current1.toString();
    var cur = new Array();
    var curPoint = new Array();

    cur = current.toString().split(".");

    if (cur.length > 1) {
        curPoint = cur[1].split("");
        if (curPoint.length < 2) {
            curPoint[1] = "0";
        }
        if (curPoint.length < 1) {
            curPoint[0] = "0";
            curPoint[1] = "0";
        }
    }
    else {
        curPoint[0] = "0";
        curPoint[1] = "0";
    }

    curPoint[0] = toUpper(curPoint[0]);
    curPoint[1] = toUpper(curPoint[1]);

    return curPoint;
}
// 将金额转为汉字
function toWord(current1) {
    var m_current1=current1;
    if(current1<0)
        current1=current1*-1;

    var current = current1.toString();
    current = current.replace(new RegExp(/(,)/g), "");
    var cur = new Array();
    var upperCur = new Array();
    var curReverse = new Array();

    cur = current.split(".")[0].split("");
    var len = cur.length;

    for (i = 0; i < len; i++) {
        upperCur[i] = toUpper(cur[i]);
        curReverse[len - i - 1] = upperCur[i];
    }

    if(m_current1>0){
        return curReverse;
    }
    else{
        curReverse[len-1]="负"+curReverse[len-1];
        return curReverse;
    }
}

// 将数字转化为大写汉字
function toUpper(digit) {
    digit = digit.replace(new RegExp(/(,)/g), "");
    switch (digit) {
        case '0' :
            return "零";
            break;
        case '1' :
            return "壹";
            break;
        case '2' :
            return "贰";
            break;
        case '3' :
            return "叁";
            break;
        case '4' :
            return "肆";
            break;
        case '5' :
            return "伍";
            break;
        case '6' :
            return "陆";
            break;
        case '7' :
            return "柒";
            break;
        case '8' :
            return "捌";
            break;
        case '9' :
            return "玖";
            break;
    }
}

// 将金额转为财务格式
function toCurrent(money) {
    var m_money=money;
    if(money<0)
        money=money*-1;
    money = money.toString().replace(new RegExp(/(,)/g), "");
    if (/[^0-9\.]/.test(money))
        return '0.00';
    money = money.replace(/^(\d*)$/, "$1.");
    money = (money + "00").replace(/(\d*\.\d\d)\d*/, "$1");
    money = money.replace(".", ",");
    var re = /(\d)(\d{3},)/;
    while (re.test(money)) {
        money = money.replace(re, "$1,$2");
    }
    money = money.replace(/,(\d\d)$/, ".$1");
    //1935
    if(m_money>0)
        return '' + money.replace(/^\./, "0.");
    else
        return '-' + money.replace(/^\./, "0.");
}
//取得长度
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

// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

// 业主姓名
function set_fontSize(s) {// 最多一行24字
    if (get_length(s) > 20)
        return 8;
    if (get_length(s) > 18)
        return 9;
    else
        return 10;
}

// 开发商(产权单位)
function set_fontSize_company(s) {// 最多一行39字
    if (get_length(s) > 31)
        return 5;
    if (get_length(s) > 26)
        return 6;
    if (get_length(s) > 24)
        return 7;
    if (get_length(s) > 20)
        return 8;
    if (get_length(s) > 18)
        return 9;
    else
        return 10;
}

// 项目/小区名称
function set_fontSize_project(s) {// 最多一行37字
    if (get_length(s) > 19)
        return 8;
    if (get_length(s) > 17)
        return 9;
    else
        return 10;
}

// 住宅地址
function set_fontSize_address(s) {// 最多一行35字
    if (get_length(s) > 30)
        return 8;
    if (get_length(s) > 27)
        return 9;
    else
        return 10;
}

//打印票据
function printPage(leftBianJu,topBianJu,ta01,ta02,ta01ds) {
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA(14, 14, 361, 356, "非税票据");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);
    LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW", 1);
    LODOP.SET_SHOW_MODE("BKIMG_LEFT", leftBianJu);
    LODOP.SET_SHOW_MODE("BKIMG_TOP", topBianJu);
    LODOP.SET_PRINT_STYLE("FontColor", "#0000FF");
    LODOP.SET_PRINT_STYLE("FontSize", "10");
    LODOP.SET_PRINT_STYLEA("All", "LineSpacing", "1");

    // 开发商名称-->缴款人名称
    var row = 15 + topBianJu - 14;
    col = 20 + leftBianJu - 14;
    var strCompany = ta01.ta0120;
    LODOP.SET_PRINT_STYLE("FontSize", set_fontSize_company(strCompany));
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(68),toMilli(15), strCompany);
    LODOP.SET_PRINT_STYLE("FontSize", 10); // 恢复10号字
    //管理号 地产号(房屋所在区域+地产号)
    var strLDGLH = ta01.ta01905+ ta01.ta01901;
    strLDGLH.replace(new RegExp(/(@)/g), "");
    strLDGLH.replace("@", "").replace("@", "").replace("@", "")
        .replace("@", "").replace("@", "").replace("@", "")
        .replace("@", "");
    var diChanHaoIndex = strLDGLH.indexOf("@");
    var diChanStr = strLDGLH.substring(0, diChanHaoIndex);

    // 缴费类型
    var JFLX = ta01.ta01902;
    // 房地/管理号
    if (JFLX != "3") {
        col = 120 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(100),toMilli(15), diChanStr);
    }

    // 开发商缴费时,打印项目/小区名称
    row = 19 + topBianJu - 14;
    col = 20 + leftBianJu - 14;
    var strProject = ta01.ta01903;
    LODOP.SET_PRINT_STYLE("FontSize", set_fontSize_project(strProject));
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(65),toMilli(15), strProject);
    LODOP.SET_PRINT_STYLE("FontSize", 10); // 恢复10号字

    // 校验码
    row = 28 + topBianJu - 14;
    col = 132 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(120),toMilli(20), ta02.ta0223);

    // 当前票号
    row = 31 + topBianJu - 14;
    col = 157 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(100),toMilli(15), ta02.ta02707);

    // 收款日期 打印系统当前日期
    row = 36 + topBianJu - 14;
    var fullDate = $.fn.datebox.defaults.formatter(new Date());// dateField的时间字符串
    var splitDate = fullDate.split('-');// 以'-'分割变形成数组
    var Year = splitDate[0];// 年
    var Month = splitDate[1];// 月
    var Day = splitDate[2];// 日
    col = 75 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(30),toMilli(10), Year); // 年
    col = 92 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(10),toMilli(10), Month);// 月
    col = 102 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(10),toMilli(10), Day); // 日

    // 证件号码
    row = 30 + topBianJu - 14;
    col = 20 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(100),toMilli(20), ta01.ta0130);

    // 缴费人
    row = 43.5 + topBianJu - 14;
    col = 44 + leftBianJu - 14;
    var strJFR = ta01.ta0120;
    LODOP.SET_PRINT_STYLE("FontSize", set_fontSize(strJFR));
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(68),toMilli(20), strJFR);
    LODOP.SET_PRINT_STYLE("FontSize", 10); // 恢复10号字

    // 缴费面积
    col = 140 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(25),toMilli(20), ta01.ta01904);

    // (缴费人)
    row = 48 + topBianJu - 14;
    col = 25 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(25),toMilli(10), "(缴费人)");

    // 住宅地址 房屋所在区域+房屋坐落
    row = 52 + topBianJu - 14;
    col = 44 + leftBianJu - 14;
    var strAddress = ta01.ta01905+ ta01.ta01906;
    LODOP.SET_PRINT_STYLE("FontSize", set_fontSize_address(strAddress));
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(100),toMilli(20), strAddress);
    LODOP.SET_PRINT_STYLE("FontSize", 10); // 恢复10号字

    // 联系电话
    col = 152 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(100),toMilli(10), ta01.ta01907);

    // 缴费面积(交存计算)
    row = 68 + topBianJu - 14;
    if (JFLX == "1") {
        col = 63 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), ta01.ta01904);
    }
    if (JFLX == "4") {
        col = 134 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), ta01.ta01904);
    }

    // 工程造价 交存比例（打印固定值）
    row = 75 + topBianJu - 14;
    if (JFLX == "1") {
        col = 60 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), "40");
        col = 99 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), "100");
    }else if (JFLX == "4") {
        col = 117 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), "20");
        col = 157 + leftBianJu - 14;
        LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(20),toMilli(10), "100");
    }

    // 收费金额
    var trueTotal = 0;
    for (var i = 0; i < ta01ds.length; i++) {
        var data = ta01ds[i].ta01d16;
        if (data.total != null) {
            trueTotal = parseFloat(data.total) + trueTotal;
        }
    }
    var realTotal = trueTotal.toFixed(2);
    var strJCJE = realTotal;
    var arrJCJE = toWord(strJCJE);
    var arrPoint = toPointWord(strJCJE);
    row = 86 + topBianJu - 14;
    col = 49 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[6]);
    col = 59 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[5]);
    col = 69 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[4]);
    col = 79 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[3]);
    col = 90 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[2]);
    col = 102 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[1]);
    col = 112 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrJCJE[0]);
    col = 122 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrPoint[0]);
    col = 133 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(16),toMilli(10), arrPoint[1]);
    col = 154 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(80),toMilli(10), toCurrent(strJCJE));

    // 开票人
    row = 94 + topBianJu - 14;
    col = 99 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(30),toMilli(15), userInfo.name);

    // 备注Bold
    LODOP.SET_PRINT_STYLE("FontSize", "14");
    LODOP.SET_PRINT_STYLE("Bold", "1");
    row = 96 + topBianJu - 14;
    col = 159 + leftBianJu - 14;
    LODOP.ADD_PRINT_TEXT(toMilli(row), toMilli(col), toMilli(30),toMilli(15), ta01.remark);
    LODOP.PRINT();
}