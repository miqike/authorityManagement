/**
 * Created by YuQingHe on 2015/2/10.
 * 银行代收罚没票据打印模板
 */
//打印票据
// 小写转大写方法
function DX(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
        return "数据非法";
    var unit = "仟佰拾亿仟佰拾万仟佰拾元角分", str = "";
    n += "00";
    var p = n.indexOf('.');
    if (p >= 0)
        n = n.substring(0, p) + n.substr(p + 1, 2);
    unit = unit.substr(unit.length - n.length);
    for (var i = 0; i < n.length; i++)
        str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
    return str.replace(/零(仟|佰|拾|角)/g, "零").replace(/(零)+/g, "零")
        .replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2")
        .replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
}
// 获取字符串真实长度
function getStrLeng(str) {
    var realLength = 0;
    var len = str.length;
    var charCode = -1;
    for (var i = 0; i < len; i++) {
        charCode = str.charCodeAt(i);
        if (charCode >= 0 && charCode <= 128) {
            realLength += 1;
        }else {
            // 如果是中文则长度加3
            realLength += 3;
        }
    }
    return realLength;
}
//在票据上打印金额小写字符串
function CreateFaMoXiaoXieJinE(recordTotal, row, leftBianJu) {
    // 将金额转换为字符串
    var strRecordTotal = recordTotal.toString();
    // 各个位置字符串初始化
    var qianWan = "";
    var baiWan = "";
    var shiWan = "";
    var wan = "";
    var qian = "";
    var bai = "";
    var shi = "";
    var yuan = "";
    var jiao = "0";
    var fen = "0";
    // 小数点之前的数字
    var beforePoint = "";
    var recordTotalLength = getStrLeng(strRecordTotal);
    // 获取小数点位置的index
    var pointIndex = recordTotal.toString().indexOf(".");
    // 如果有小数点的话
    // 如果有小数点并且小数点的位置+3为长度的话 也就是有角有分
    if (pointIndex > 0 && pointIndex + 3 == recordTotalLength) {
        beforePoint = strRecordTotal.substring(0, pointIndex);
        jiao = strRecordTotal.substring(pointIndex + 1,recordTotalLength - 1);
        fen = strRecordTotal.substring(pointIndex + 2,recordTotalLength);
    }
    // 有角无分
    else if (pointIndex > 0 && pointIndex + 3 != recordTotalLength) {
        beforePoint = strRecordTotal.substring(0, pointIndex);
        jiao = strRecordTotal.substring(pointIndex + 1,recordTotalLength);
    }
    // 无角无分
    else if (pointIndex == -1) {
        beforePoint = strRecordTotal;
    }
    // 将去掉小数点之后剩下的数字转换为数组;
    var beforeOpintArray = beforePoint.split("");
    switch (beforeOpintArray.length) {
        case 1 :
            var shi = "￥";
            var yuan = beforeOpintArray[0];
            break;
        case 2 :
            var bai = "￥";
            var shi = beforeOpintArray[0];
            var yuan = beforeOpintArray[1];
            break;
        case 3 :
            var qian = "￥";
            var bai = beforeOpintArray[0];
            var shi = beforeOpintArray[1];
            var yuan = beforeOpintArray[2];
            break;
        case 4 :
            var wan = "￥";
            var qian = beforeOpintArray[0];
            var bai = beforeOpintArray[1];
            var shi = beforeOpintArray[2];
            var yuan = beforeOpintArray[3];
            break;
        case 5 :
            var shiWan = "￥";
            var wan = beforeOpintArray[0];
            var qian = beforeOpintArray[1];
            var bai = beforeOpintArray[2];
            var shi = beforeOpintArray[3];
            var yuan = beforeOpintArray[4];
            break;
        case 6 :
            var baiWan = "￥";
            var shiWan = beforeOpintArray[0];
            var wan = beforeOpintArray[1];
            var qian = beforeOpintArray[2];
            var bai = beforeOpintArray[3];
            var shi = beforeOpintArray[4];
            var yuan = beforeOpintArray[5];
            break;
        case 7 :
            var qianWan = "￥";
            var baiWan = beforeOpintArray[0];
            var shiWan = beforeOpintArray[1];
            var wan = beforeOpintArray[2];
            var qian = beforeOpintArray[3];
            var bai = beforeOpintArray[4];
            var shi = beforeOpintArray[5];
            var yuan = beforeOpintArray[6];
            break;
    }
    // 千万位
    LODOP.ADD_PRINT_TEXT(row, 231 + leftBianJu, 500, 15, qianWan);// 百万
    // 百万位
    LODOP.ADD_PRINT_TEXT(row, 243 + leftBianJu, 500, 15, baiWan);// 百万
    // 十万位
    LODOP.ADD_PRINT_TEXT(row, 255 + leftBianJu, 500, 15, shiWan);// 十万
    // 万位
    LODOP.ADD_PRINT_TEXT(row, 267 + leftBianJu, 500, 15, wan);// 万
    // 千位
    LODOP.ADD_PRINT_TEXT(row, 279 + leftBianJu, 500, 15, qian);// 千
    // 百位
    LODOP.ADD_PRINT_TEXT(row, 291 + leftBianJu, 500, 15, bai);// 百
    // 十位
    LODOP.ADD_PRINT_TEXT(row, 303 + leftBianJu, 500, 15, shi);// 十
    // 个位
    LODOP.ADD_PRINT_TEXT(row, 315 + leftBianJu, 500, 15, yuan);// 元
    // 角位
    LODOP.ADD_PRINT_TEXT(row, 327 + leftBianJu, 500, 15, jiao);// 角
    // 分位
    LODOP.ADD_PRINT_TEXT(row, 339 + leftBianJu, 500, 15, fen);// 分
}
//打印罚没票据
function printPage(leftBianJu,topBianJu,ta01,ta02,ta01ds) {
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA(14, 14, 361, 356, "罚没票据");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);
    LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW", 1);
    LODOP.SET_SHOW_MODE("BKIMG_LEFT", leftBianJu);
    LODOP.SET_SHOW_MODE("BKIMG_TOP", topBianJu);
    LODOP.SET_PRINT_STYLE("FontColor", "#0000FF");
    LODOP.ADD_PRINT_SETUP_BKIMG("<img border='0' src='img/FaMoReal.jpg'>");
    // 票号
    var row;
    row = 40 + topBianJu - 14;
    LODOP.ADD_PRINT_TEXT(row, 500 + leftBianJu - 14, 200, 40,+ta02.ta02707);// 当前票号
    // 收款日期
    row = 102 + topBianJu - 14;
    // piaoJuDate时间转换
    var fullDate = $.fn.datebox.defaults.formatter(new Date());// dateField的时间字符串
    var splitDate = fullDate.split('-');// 以'-'分割变形成数组
    var Year = splitDate[0];// 年
    var Month = splitDate[1];// 月
    var Day = splitDate[2];// 日
    LODOP.ADD_PRINT_TEXT(row, 245 + leftBianJu - 14, 50, 15, Year);// 年
    LODOP.ADD_PRINT_TEXT(row, 300 + leftBianJu - 14, 30, 15, Month);// 月
    LODOP.ADD_PRINT_TEXT(row, 340 + leftBianJu - 14, 30, 15, Day);// 日
    LODOP.ADD_PRINT_TEXT(row, 370 + leftBianJu - 14, 200, 40, "校验码："+ ta02.ta0223);// 校验码
    // 行政机关
    row = 125 + topBianJu - 14;
    LODOP.ADD_PRINT_TEXT(row, 192 + leftBianJu - 14, 250, 15,ta01.ta01801);// 执收单位名称
    // 处罚决定书
    LODOP.ADD_PRINT_TEXT(row, 500 + leftBianJu - 14, 130, 18,ta01.ta01703);// 业务流水号
    row = 145 + topBianJu - 14;
    LODOP.ADD_PRINT_TEXT(row, 192 + leftBianJu - 14, 300, 15,ta01.ta0120);// 缴款人姓名
    // 计算总金额
    var recordTotal = parseFloat(ta01ds[0].ta01d16)+parseFloat(ta01ds[1].ta01d16);
    var faMoRecordTotal=parseFloat(ta01ds[0].ta01d16);
    CreateFaMoXiaoXieJinE(faMoRecordTotal, 190 + topBianJu - 14,leftBianJu - 14);// 罚款金额
    var zhiNaRecordTotal = 0;
    if(ta01ds.length>1){
        zhiNaRecordTotal=parseFloat(ta01ds[1].ta01d16);
        if (zhiNaRecordTotal != 0) {
            CreateFaMoXiaoXieJinE(zhiNaRecordTotal, 212 + topBianJu - 14,leftBianJu - 14);// 滞纳金
        }
    }
    CreateFaMoXiaoXieJinE(recordTotal, 232 + topBianJu - 14, leftBianJu- 14);// 总金额
    // 大写金额合计
    row = 255 + topBianJu - 14;
    if (recordTotal == 0) {
        LODOP.ADD_PRINT_TEXT(row, 215 + leftBianJu - 14, 500, 15, "零元");// 金额
    }else {
        LODOP.ADD_PRINT_TEXT(row, 215 + leftBianJu - 14, 500, 15,DX(recordTotal));// 金额
    }
    // 网点号
    row = 275 + topBianJu - 14;
    LODOP.ADD_PRINT_TEXT(row, 470 + leftBianJu - 14, 100, 20, "网点号："+ userInfo.orgId);
    // 操作员
    row = 290 + topBianJu - 14;
    LODOP.ADD_PRINT_TEXT(row, 470 + leftBianJu - 14, 100, 20, "操作员："+ userInfo.name);
    LODOP.PRINT();
}