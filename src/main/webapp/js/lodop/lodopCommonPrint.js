(function($) {
    // 将长度转换为毫米形式
    var toMilli=function toMilli(length) {
        return length.toString() + "mm";
    };
    $.lodopCommonPrint = function () {};
    $.extend($.lodopCommonPrint,
        {
            /**
             *通用打印，只打印列表式表格，带有表头，可分页打印
             *宽度定义单位全部是毫米，默认值可以不给
             * 参数说明
             * params:JSON对象，包含
             * * pageRows--每页打印行数，默认50
             * * firstPageRows--第一页打印行数，默认50
             * * topMargin--上边距，默认5
             * * leftMargin--左边距，默认5
             * * pageTitle--页头，默认列表打印标题
             * * pageTitleFirst--只在第一页打印页头，默认0 在每页上都打印
             * * pageFoot--页尾，默认页尾
             * * pageFootLast--只在最后一页打印页尾，默认0 在每页上都打印
             * * pageWidth--纸张宽度，默认210
             * * pageHeight--纸张高度，默认297
             * * pageOrient--纸张方向 1---纵(正)向打印，固定纸张；2---横向打印，固定纸张 默认1
             * * pageName--纸张名称 A4 B5 CreateCustomPage  默认""，自定义纸张大小
             * * titleHeight--标题高度，默认15
             * * footHeight--页尾高度，默认15
             * * rowHeight--数据行高度，默认6
             * * outerLineWidth--外边框宽度，默认2，单位是象素
             * * inerLineWidth--内边框宽度，默认1，单位是象素
             * * lineStyle--线条类型，0--实线 1--破折线 2--点线 3--点划线 4--双点划线,默认0
             * * pageTitleFontSize:页标题字号，默认24
             * * pageTitleFontName:页标题字体，默认隶书
             * * pageTitleAlignment:页标题对齐方式 1--左靠齐 2--居中 3--右靠齐，缺省值是2
             * * pageTitleUnderline:页标题字体下划线 1代表有下划线，0代表无下划线，缺省值是1
             * * pageFootFontSize:页尾字号，默认24
             * * pageFootFontName:页尾字体，默认隶书
             * * pageFootAlignment:页尾对齐方式 1--左靠齐 2--居中 3--右靠齐，缺省值是2
             * * pageFootUnderline:页尾字体下划线 1代表有下划线，0代表无下划线，缺省值是1
             * * headFontSize:表格标题字号，默认12
             * * headFontName:表格标题字体，默认宋体
             * * headAlignment:表格标题对齐方式 1--左靠齐 2--居中 3--右靠齐，缺省值是2
             * * headUnderline:表格标题字体下划线 1代表有下划线，0代表无下划线，缺省值是0
             * * headHeight:表格标题行宽度 缺省值是10
             * * spaceBetweenLineText:打印内容与线之间的距离，默认5
             * * spaceBetweenLineHeadText:表格标题打印内容与线之间的距离，默认8
             * data:列表数据
             * columnList:JSON对象数组，定义每列的属性，每列中包含
             * * fieldName:列标识，根据标识从DATA中取得每列数据
             * * header:列名称，打印列标题
             * * colWidth:列宽度，默认10
             * * codeName:需要进行代码转换的代码，默认null不转换，其他值则转换,date说明转换日期
             * * fontSize:字号，默认9
             * * fontName:字体，默认宋体
             * * alignment:对齐方式 1--左靠齐 2--居中 3--右靠齐，缺省值是1
             */
            listPrint: function (params, data, columnList) {
                //参数默认值
                var pageRowsDef = 50;//每页行数
                var firstPageRowsDef = 20;//第一页行数
                var pageTitleDef = "列表打印标题";//每页标题
                var pageTitleFirstDef = "0";//每页标题
                var pageFootDef = "页尾";//每页页尾
                var pageFootLastDef = "0";//每页页尾
                var topMarginDef = 5;//上边距
                var leftMarginDef = 5;//左边距
                var pageHeightDef = 297;
                var pageWidthDef = 210;
                var pageOrientDef = 1;
                var pageNameDef = "";

                var titleHeightDef = 15;
                var footHeightDef = 15;
                var rowHeightDef = 6;
                var outerLineWidthDef = 2;
                var inerLineWidthDef = 1;
                var lineStyleDef = 0;
                var pageTitleFontSizeDef = 24;
                var pageTitleFontNameDef = "隶书";
                var pageTitleAlignmentDef = 2;
                var pageTitleUnderlineDef = 1;
                var pageFootFontSizeDef = 16;
                var pageFootFontNameDef = "隶书";
                var pageFootAlignmentDef = 3;
                var pageFootUnderlineDef = 0;
                var headFontSizeDef = 12;
                var headFontNameDef = "宋体";
                var headAlignmentDef = 2;
                var headUnderlineDef = 0;
                var headHeightDef = 10;
                var spaceBetweenLineTextDef = 2;
                var spaceBetweenLineHeadTextDef = 2;
                //取得参数
                var pageRows = params != null ? "pageRows" in params ? params.pageRows : pageRowsDef : pageRowsDef;//每页行数
                var firstPageRows = params != null ? "firstPageRows" in params ? params.firstPageRows : firstPageRowsDef : firstPageRowsDef;//每页行数
                var pageTitle = params != null ? "pageTitle" in params ? params.pageTitle : pageTitleDef : pageTitleDef;//每页标题
                var pageTitleFirst = params != null ? "pageTitleFirst" in params ? params.pageTitleFirst : pageTitleFirstDef : pageTitleFirstDef;//第一页打印标题
                var pageFoot = params != null ? "pageFoot" in params ? params.pageFoot : pageFootDef : pageFootDef;//每页页尾
                var pageFootLast = params != null ? "pageFootLast" in params ? params.pageFootLast : pageFootLastDef : pageFootLastDef;//最后一页打印页尾
                var topMargin = params != null ? "topMargin" in params ? params.topMargin : topMarginDef : topMarginDef;//上边距
                var leftMargin = params != null ? "leftMargin" in params ? params.leftMargin : leftMarginDef : leftMarginDef;//左边距
                var pageHeight = params != null ? "pageHeight" in params ? params.pageHeight : pageHeightDef : pageHeightDef;
                var pageWidth = params != null ? "pageWidth" in params ? params.pageWidth : pageWidthDef : pageWidthDef;
                var pageOrient = params != null ? "pageOrient" in params ? params.pageOrient : pageOrientDef : pageOrientDef;
                var pageName = params != null ? "pageName" in params ? params.pageName : pageNameDef : pageNameDef;
                var titleHeight = params != null ? "titleHeight" in params ? params.titleHeight : titleHeightDef : titleHeightDef;
                var footHeight = params != null ? "footHeight" in params ? params.footHeight : footHeightDef : footHeightDef;
                var rowHeight = params != null ? "rowHeight" in params ? params.rowHeight : rowHeightDef : rowHeightDef;
                var outerLineWidth = params != null ? "outerLineWidth" in params ? params.outerLineWidth : outerLineWidthDef : outerLineWidthDef;
                var inerLineWidth = params != null ? "inerLineWidth" in params ? params.inerLineWidth : inerLineWidthDef : inerLineWidthDef;
                var lineStyle = params != null ? "lineStyle" in params ? params.lineStyle : lineStyleDef : lineStyleDef;
                var pageTitleFontSize = params != null ? "pageTitleFontSize" in params ? params.pageTitleFontSize : pageTitleFontSizeDef : pageTitleFontSizeDef;
                var pageTitleFontName = params != null ? "pageTitleFontName" in params ? params.pageTitleFontName : pageTitleFontNameDef : pageTitleFontNameDef;
                var pageTitleAlignment = params != null ? "pageTitleAlignment" in params ? params.pageTitleAlignment : pageTitleAlignmentDef : pageTitleAlignmentDef;
                var pageTitleUnderline = params != null ? "pageTitleUnderline" in params ? params.pageTitleUnderline : pageTitleUnderlineDef : pageTitleUnderlineDef;
                var pageFootFontSize = params != null ? "pageFootFontSize" in params ? params.pageFootFontSize : pageFootFontSizeDef : pageFootFontSizeDef;
                var pageFootFontName = params != null ? "pageFootFontName" in params ? params.pageFootFontName : pageFootFontNameDef : pageFootFontNameDef;
                var pageFootAlignment = params != null ? "pageFootAlignment" in params ? params.pageFootAlignment : pageFootAlignmentDef : pageFootAlignmentDef;
                var pageFootUnderline = params != null ? "pageFootUnderline" in params ? params.pageFootUnderline : pageFootUnderlineDef : pageFootUnderlineDef;
                var headFontSize = params != null ? "headFontSize" in params ? params.headFontSize : headFontSizeDef : headFontSizeDef;
                var headFontName = params != null ? "headFontName" in params ? params.headFontName : headFontNameDef : headFontNameDef;
                var headAlignment = params != null ? "headAlignment" in params ? params.headAlignment : headAlignmentDef : headAlignmentDef;
                var headUnderline = params != null ? "headUnderline" in params ? params.headUnderline : headUnderlineDef : headUnderlineDef;
                var headHeight = params != null ? "headHeight" in params ? params.headHeight : headHeightDef : headHeightDef;
                var spaceBetweenLineText = params != null ? "spaceBetweenLineText" in params ? params.spaceBetweenLineText : spaceBetweenLineTextDef : spaceBetweenLineTextDef;
                var spaceBetweenLineHeadText = params != null ? "spaceBetweenLineHeadText" in params ? params.spaceBetweenLineHeadText : spaceBetweenLineHeadTextDef : spaceBetweenLineHeadTextDef;

                //列默认值
                var colWidthDef = 10;
                var colCodeNameDef = null;
                var colFontSizeDef = 9;
                var colFontNameDef = "宋体";
                var colAlignmentDef = 2;

                //计算行数等变量
                var pages = Math.ceil((data.length - firstPageRows) / pageRows) + 1;//总页数
                var dataNo = 1;//数据行号
                var colLeft = 0;//列位置
                var rowTop = 0;//行开始位置
                var printValue = "";//打印内容
                var totalWidth = 0;//总宽度
                var colWidth = 0;//列宽度
                var printedRows = 0;//已经打印的行数
                //计算总宽度
                for (var rw = 0; rw < columnList.length; rw++) {
                    colWidth = "colWidth" in columnList[rw] ? columnList[rw].colWidth : colWidthDef;
                    totalWidth = totalWidth + colWidth;
                }

                //LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
                var LODOP = getLodop();

                //设置纸张
                // LODOP.PRINT_INITA(toMilli(topMargin), toMilli(leftMargin), toMilli(pageWidth), toMilli(pageHeight), pageTitle + "-" + pageNo);
                LODOP.PRINT_INIT("列表打印");
                LODOP.SET_PRINT_PAGESIZE(pageOrient, toMilli(pageWidth), toMilli(pageHeight), pageName);
                LODOP.SET_PRINTER_INDEX(-1);
                LODOP.SET_PRINT_MODE("RESELECT_PRINTER", 0);
                LODOP.SET_PRINT_MODE("AUTO_CLOSE_PREWINDOW", 1);
                LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);

                for (var pageNo = 1; pageNo <= pages; pageNo++) {
                    LODOP.NEWPAGE();
                    rowTop = 0;
                    //每页标题
                    if (pageTitleFirst == "1") {
                        if (pageNo == 1) {
                            LODOP.ADD_PRINT_TEXTA("pageTitle", toMilli(0), toMilli(0), toMilli(totalWidth), toMilli(titleHeight), "    " + pageTitle + "    ");//页头
                            LODOP.SET_PRINT_STYLEA(0, "FontSize", pageTitleFontSize);
                            LODOP.SET_PRINT_STYLEA(0, "FontName", pageTitleFontName);
                            LODOP.SET_PRINT_STYLEA(0, "Alignment", pageTitleAlignment);
                            LODOP.SET_PRINT_STYLEA(0, "Underline", pageTitleUnderline);
                            rowTop = rowTop + titleHeight;
                        }
                    } else {
                        LODOP.ADD_PRINT_TEXTA("pageTitle", toMilli(0), toMilli(0), toMilli(totalWidth), toMilli(titleHeight), "    " + pageTitle + "    ");//页头
                        LODOP.SET_PRINT_STYLEA(0, "FontSize", pageTitleFontSize);
                        LODOP.SET_PRINT_STYLEA(0, "FontName", pageTitleFontName);
                        LODOP.SET_PRINT_STYLEA(0, "Alignment", pageTitleAlignment);
                        LODOP.SET_PRINT_STYLEA(0, "Underline", pageTitleUnderline);
                        rowTop = rowTop + titleHeight;
                    }
                    //打印表头
                    LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(0), toMilli(rowTop), toMilli(totalWidth), lineStyle, outerLineWidth);//最上边的横线
                    LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(0), toMilli(rowTop + rowHeight + spaceBetweenLineHeadText), toMilli(0), lineStyle, outerLineWidth);//最左边的竖线
                    colLeft = 0;
                    for (var headNo = 0; headNo < columnList.length; headNo++) {
                        colWidth = "colWidth" in columnList[headNo] ? columnList[headNo].colWidth : colWidthDef;
                        LODOP.ADD_PRINT_TEXTA("tableHead", toMilli(rowTop + spaceBetweenLineHeadText), toMilli(colLeft), toMilli(colWidth), toMilli(rowHeight + rowHeight + spaceBetweenLineHeadText), columnList[headNo].header);
                        LODOP.SET_PRINT_STYLEA(0, "FontSize", headFontSize);
                        LODOP.SET_PRINT_STYLEA(0, "FontName", headFontName);
                        LODOP.SET_PRINT_STYLEA(0, "Alignment", headAlignment);
                        LODOP.SET_PRINT_STYLEA(0, "Underline", headUnderline);
                        if (headNo == columnList.length - 1) {
                            LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(colLeft + colWidth), toMilli(rowTop + rowHeight + spaceBetweenLineHeadText), toMilli(colLeft + colWidth), lineStyle, outerLineWidth);//最右边的竖线
                        } else {
                            LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(colLeft + colWidth), toMilli(rowTop + rowHeight + spaceBetweenLineHeadText), toMilli(colLeft + colWidth), lineStyle, inerLineWidth);//竖线
                        }
                        colLeft = colLeft + colWidth;
                    }

                    rowTop = rowTop + rowHeight + spaceBetweenLineHeadText;
                    //循环打印表格内容
                    var loopRows = 0;
                    if (pageNo == "1") {
                        loopRows = data.length > firstPageRows ? firstPageRows : data.length;//每页需要循环的行数
                    } else {
                        loopRows = data.length - printedRows < pageRows ? data.length - printedRows : pageRows;//每页需要循环的行数
                    }
                    for (var rowNo = 0; rowNo < loopRows; rowNo++) {
                        dataNo = (pageNo - 1) * pageRows + rowNo;
                        //画线
                        LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(0), toMilli(rowTop), toMilli(totalWidth), lineStyle, inerLineWidth);//横线
                        LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(0), toMilli(rowTop + rowHeight + spaceBetweenLineText), toMilli(0), lineStyle, outerLineWidth);//最左边竖线
                        colLeft = 0;
                        for (var headNo = 0; headNo < columnList.length; headNo++) {
                            //进行数据转换
                            var codeName = "codeName" in columnList[headNo] ? columnList[headNo].codeName : colCodeNameDef;
                            if (codeName != null) {
                                if (codeName == "date") {
                                    printValue = formatDate(data[rowNo][columnList[headNo].fieldName], null);

                                } else {
                                    printValue = formatCode(data[rowNo][columnList[headNo].fieldName], columnList[headNo].codeName);
                                }
                            } else {
                                printValue = data[rowNo][columnList[headNo].fieldName];
                            }
                            //开始打印列
                            colWidth = "colWidth" in columnList[headNo] ? columnList[headNo].colWidth : colWidthDef;
                            LODOP.ADD_PRINT_TEXTA("tableColumn", toMilli(rowTop + spaceBetweenLineText), toMilli(colLeft), toMilli(colWidth), toMilli(rowHeight + rowHeight + spaceBetweenLineText), printValue);
                            LODOP.SET_PRINT_STYLEA(0, "Alignment", "alignment" in columnList[headNo] ? columnList[headNo].alignment : colAlignmentDef);
                            LODOP.SET_PRINT_STYLEA(0, "FontSize", "fontSize" in columnList[headNo] ? columnList[headNo].fontSize : colFontSizeDef);
                            LODOP.SET_PRINT_STYLEA(0, "FontName", "fontName" in columnList[headNo] ? columnList[headNo].fontName : colFontNameDef);
                            //画线
                            if (headNo == columnList.length - 1) {
                                LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(colLeft + colWidth), toMilli(rowTop + rowHeight + spaceBetweenLineText), toMilli(colLeft + colWidth), lineStyle, outerLineWidth);//最右边的竖线
                            } else {
                                LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(colLeft + colWidth), toMilli(rowTop + rowHeight + spaceBetweenLineText), toMilli(colLeft + colWidth), lineStyle, inerLineWidth);//竖线
                            }
                            //计算下一列位置
                            colLeft = colLeft + colWidth;
                        }
                        //计算下一行位置
                        rowTop = rowTop + rowHeight + spaceBetweenLineHeadText;
                        //已经打印的行数
                        printedRows = printedRows + 1;
                    }
                    LODOP.ADD_PRINT_LINE(toMilli(rowTop), toMilli(0), toMilli(rowTop), toMilli(totalWidth), lineStyle, outerLineWidth);//最后的横线
                    //每页页尾
                    if (pageFootLast == "1") {
                        if (pageNo == pages) {
                            rowTop = rowTop + 10;
                            LODOP.ADD_PRINT_TEXTA("pageFoot", toMilli(rowTop), toMilli(0), toMilli(totalWidth), toMilli(footHeight), "    " + pageFoot + "    ");//页头
                            LODOP.SET_PRINT_STYLEA(0, "FontSize", pageFootFontSize);
                            LODOP.SET_PRINT_STYLEA(0, "FontName", pageFootFontName);
                            LODOP.SET_PRINT_STYLEA(0, "Alignment", pageFootAlignment);
                            LODOP.SET_PRINT_STYLEA(0, "Underline", pageFootUnderline);
                        }
                    } else {
                        rowTop = rowTop + 10;
                        LODOP.ADD_PRINT_TEXTA("pageFoot", toMilli(rowTop), toMilli(0), toMilli(totalWidth), toMilli(footHeight), "    " + pageFoot + "    ");//页头
                        LODOP.SET_PRINT_STYLEA(0, "FontSize", pageFootFontSize);
                        LODOP.SET_PRINT_STYLEA(0, "FontName", pageFootFontName);
                        LODOP.SET_PRINT_STYLEA(0, "Alignment", pageFootAlignment);
                        LODOP.SET_PRINT_STYLEA(0, "Underline", pageFootUnderline);
                    }
                }
                LODOP.PREVIEW();
                // LODOP.PRINT();
            },
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
            fixedFormatListPrint: function (params,data,columnList){
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
                LODOP.SET_SHOW_MODE("NP_NO_RESULT", true);
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
        }
    )
})(jQuery);

