/**
 * Created by YuQingHe on 2015/4/24.
 */
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
/**
 *固定格式列表通用打印，只打印列表式表格，不带有表头，不分布打印
 *宽度定义单位全部是毫米
 * 参数说明
 * params:JSON对象，包含
 * * topMargin--上边距,默认5
 * * leftMargin--左边距,默认5
 * * pageWidth--纸张宽度，默认210
 * * pageHeight--纸张高度，默认297
 * * rowHeight--每行高度，默认6
 * * startRow--开始打印的行数，默认1
 * data:列表数据
 *
 * columnList:JSON对象数组，定义每列的属性，每列中包含
 * * colWidth:列宽度，默认10
 * * fieldName:列标识，根据标识从DATA中取得每列数据
 * * codeName:需要进行代码转换的代码，默认null不转换，其他值则转换,date说明转换日期
 * * fontSize:字号，默认9
 * * fontName:字体，默认宋体
 * * alignment:对齐方式 1--左靠齐 2--居中 3--右靠齐，缺省值是1
 */
function fixedFormatListPrint(params,data,columnList){
    //参数默认值
    var topMarginDef=5;//上边距
    var leftMarginDef=5;//左边距
    var pageHeightDef=297;
    var pageWidthDef=210;
    var rowHeightDef=6;
    var startRowDef=1;
    //取得参数
    var topMargin=params!=null?"topMargin" in params?params.topMargin:topMarginDef:topMarginDef;
    var leftMargin=params!=null?"leftMargin" in params?params.leftMargin:leftMarginDef:leftMarginDef;//左边距
    var pageHeight=params!=null?"pageHeight" in params?params.pageHeight:pageHeightDef:pageHeightDef;
    var pageWidth=params!=null?"pageWidth" in params?params.pageWidth:pageWidthDef:pageWidthDef;
    var rowHeight=params!=null?"rowHeight" in params?params.rowHeight:rowHeightDef:rowHeightDef;
    var startRow=params!=null?"startRow" in params?params.startRow:startRowDef:startRowDef;

    //列默认值
    var colWidthDef=10;
    var colCodeNameDef=null;
    var colFontSizeDef=9;
    var colFontNameDef="宋体";
    var colAlignmentDef=2;

    //计算行数等变量
    var colLeft=0;//列位置
    var printValue="";//打印内容
    var rowTop=0;//行开始位置

    //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
    var LODOP = getLodop();
    //设置纸张
    LODOP.BKIMG_PRINT
    LODOP.PRINT_INITA(topMargin,leftMargin,toMilli(pageWidth),toMilli(pageHeight),"");
    LODOP.SET_PRINT_PAGESIZE(1,toMilli(pageWidth),toMilli(pageHeight),"CreateCustomPage");
    LODOP.SET_PRINTER_INDEX(-1);
    LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
    LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
    //LODOP.SET_PRINT_MODE("POS_BASEON_PAPER", 1);

    rowTop=rowHeight*startRow;//根据给定的开始行数，计算开始打印的行位置
    //循环打印内容
    for(var rowNo=0;rowNo<data.length;rowNo++){
        colLeft = 0;
        for (var headNo = 0; headNo < columnList.length; headNo++) {
            //进行数据转换
            var codeName="codeName" in columnList[headNo]?columnList[headNo].codeName:colCodeNameDef;
            if(codeName!=null){
                if(codeName=="date"){
                    printValue=formatDate(data[rowNo][columnList[headNo].fieldName],null);

                }else{
                    printValue=formatCode(data[rowNo][columnList[headNo].fieldName],columnList[headNo].codeName);
                }
            }else{
                printValue=data[rowNo][columnList[headNo].fieldName];
            }
            //开始打印列
            LODOP.ADD_PRINT_TEXTA("0", toMilli(rowTop), toMilli(colLeft), toMilli("colWidth" in columnList[headNo]?columnList[headNo].colWidth:colWidthDef), toMilli(rowHeight), printValue);
            LODOP.SET_PRINT_STYLEA(0, "Alignment", "alignment" in columnList[headNo]?columnList[headNo].alignment:colAlignmentDef);
            LODOP.SET_PRINT_STYLEA(0, "FontSize", "fontSize" in columnList[headNo]?columnList[headNo].fontSize:colFontSizeDef);
            LODOP.SET_PRINT_STYLEA(0, "FontName", "fontName" in columnList[headNo]?columnList[headNo].fontName:colFontNameDef);
            //计算下一列的位置
            colLeft = colLeft + columnList[headNo].colWidth;
        }
        //计算下一行位置
        rowTop = rowTop + rowHeight;
    }

    // LODOP.PREVIEW();
    LODOP.PRINT();
}
