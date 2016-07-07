/**
 *  定义全局对象，在全局对象上扩展需要的方法
 */
jQuery.easyuiExtendObj = {
    /**
     * 定位到下一个控件方法
     * @param current
     */
    focusNext : function(current) {
        function _focusNext(){
            var next ;
            var inputElements = $("input.easyui-textbox, input.easyui-datebox, input.easyui-combobox, " +
                "input.easyui-numberbox,input:checkbox, select.easyui-combobox, a.easyui-linkbutton");
            var idx = inputElements.index(current);
            next = $(inputElements[idx + 1]);
            if (next.length > 0) {
                if (next[0].tagName == "A" || next[0].type == "checkbox") {
                    next.focus();
                } else {
                    if(next.textbox('options').disabled || next.textbox('options').readonly) {
                        _focusNext(next);
                    } else {
                        next.next().find(".textbox-text").focus();
                    }
                }
            }
        }
        _focusNext(current);
    },
    /**
     * 针对panel window dialog三个组件调整大小时会超出父级元素的修正
     * 如果父级元素的overflow属性为hidden，则修复上下左右个方向
     * 如果父级元素的overflow属性为非hidden，则只修复上左两个方向
     * @param width
     * @param height
     * @returns
     */
    panelOnResize : function(width, height) {
        if (!$.data(this, 'window') && !$.data(this, 'dialog'))
            return;

        var undef, v = 3, div = document.createElement('div'), all = div.getElementsByTagName('i');
        while (div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->', all[0]);
        var ieVersion= v > 4 ? v : undef;
        if (ieVersion === 8) {
            var data = $.data(this, "window") || $.data(this, "dialog");
            if (data.pmask) {
                var masks = data.window.nextAll('.window-proxy-mask');
                if (masks.length > 1) {
                    $(masks[1]).remove();
                    masks[1] = null;
                }
            }
        }
        if ($(this).panel('options').maximized == true) {
            $(this).panel('options').fit = false;
        }
        $(this).panel('options').reSizing = true;
        if (!$(this).panel('options').reSizeNum) {
            $(this).panel('options').reSizeNum = 1;
        } else {
            $(this).panel('options').reSizeNum++;
        }
        var parentObj = $(this).panel('panel').parent();
        var left = $(this).panel('panel').position().left;
        var top = $(this).panel('panel').position().top;

        if ($(this).panel('panel').offset().left < 0) {
            $(this).panel('move', {
                left : 0
            });
        }
        if ($(this).panel('panel').offset().top < 0) {
            $(this).panel('move', {
                top : 0
            });
        }

        if (left < 0) {
            $(this).panel('move', {
                left : 0
            }).panel('resize', {
                width : width + left
            });
        }
        if (top < 0) {
            $(this).panel('move', {
                top : 0
            }).panel('resize', {
                height : height + top
            });
        }
        if (parentObj.css("overflow") == "hidden") {
            var inline = $.data(this, "window").options.inline;
            if (inline == false) {
                parentObj = $(window);
            }

            if ((width + left > parentObj.width())
                && $(this).panel('options').reSizeNum > 1) {
                $(this).panel('resize', {
                    width : parentObj.width() - left
                });
            }

            if ((height + top > parentObj.height())
                && $(this).panel('options').reSizeNum > 1) {
                $(this).panel('resize', {
                    height : parentObj.height() - top
                });
            }
        }
        $(this).panel('options').reSizing = false;
    },
    /**
     * 针对panel window dialog三个组件拖动时会超出父级元素的修正
     * 如果父级元素的overflow属性为hidden，则修复上下左右个方向
     * 如果父级元素的overflow属性为非hidden，则只修复上左两个方向
     * @param left
     * @param top
     * @returns
     */
    panelOnMove : function(left, top) {
        if ($(this).panel('options').reSizing)
            return;
        var parentObj = $(this).panel('panel').parent();
        var width = $(this).panel('options').width;
        var height = $(this).panel('options').height;

        if (left < 0) {
            $(this).panel('move', {
                left : 0
            });
        }
        if (top < 0) {
            $(this).panel('move', {
                top : 0
            });
        }

        if (parentObj.css("overflow") == "hidden") {
            var inline = $.data(this, "window").options.inline;
            if (inline == false) {
                parentObj = $(window);
            }
            if (left > parentObj.width() - width) {
                $(this).panel('move', {
                    "left" : parentObj.width() - width
                });
            }
            if (top > parentObj.height() - height) {
                $(this).panel('move', {
                    "top" : parentObj.height() - height
                });
            }
        }
    },
    /**
     * 向页面加载数据
     * @param formId
     * @param data
     */
    loadForm:function (formId, data) {
        function dateFormatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        };
        var elem=$('#'+formId);
        elem.find("input.easyui-textbox").textbox("clear");
        elem.find("input.easyui-datebox").datebox("clear");
        elem.find("input.easyui-combobox").combobox("clear");
        elem.find("input.easyui-numberbox").numberbox("clear");
        elem.find("input.easyui-numberspinner").numberspinner("clear");
        elem.find("input.easyui-combotree").combotree("clear");
        elem.find("input:hidden").val("");

        if (null != data) {
            $.each(elem.find("input"), function (idx, _elem) {
                if ($(_elem).hasClass("easyui-textbox")) {
                    $(_elem).textbox("setValue", data[_elem.id.split("_")[1]]);
                } else if ($(_elem).hasClass("easyui-datebox")) {
                    var dateStr = data[_elem.id.split("_")[1]];
                    if (null != dateStr) {
                        var date = new Date(dateStr);
                        $(_elem).datebox("setValue", dateFormatter(date));
                    }
                } else if ($(_elem).hasClass("easyui-combobox")) {
                    $(_elem).combobox("setValue", data[_elem.id.split("_")[1]]);
                } else if ($(_elem).hasClass("easyui-numberbox")) {
                    $(_elem).numberbox("setValue", data[_elem.id.split("_")[1]]);
                } else if ($(_elem).hasClass("easyui-numberspinner")) {
                    $(_elem).numberspinner("setValue", data[_elem.id.split("_")[1]]);
                } else if ($(_elem).hasClass("easyui-combotree")) {
                    $(_elem).combotree("setValue", data[_elem.id.split("_")[1]]);
                } else if ($(_elem).hasClass("easyui-filebox")) {
                    $(_elem).filebox("clear").filebox("disable");
                } else if (_elem.type == "hidden" && _elem.id.match(/^\S*_/g) != null) {
                    $(_elem).val(data[_elem.id.split("_")[1]]);
                }
            });

            $.each(elem.find("textarea"), function (idx, _elem) {
                $(_elem).val(data[_elem.id.split("_")[1]]);
            });
            window.operate = 'update';
        } else {
            window.operate = 'add';
        }
    },
    /**
     * 设置页面元素只读属性
     * @param formId
     * @param readonly
     * @param disable
     */
    setFormReadonly:function (formId, readonly) {
        var elem=$('#'+formId);
        var disable = arguments[2] ? arguments[2] : false;
        $.each(elem.find("input"), function(idx, _elem) {
            if($(_elem).hasClass("easyui-textbox")) {
                $(_elem).textbox({readonly:readonly,disabled:disable});
            } else if($(_elem).hasClass("easyui-numberbox")) {
                $(_elem).numberbox({readonly:readonly,disabled:disable});
            } else if($(_elem).hasClass("easyui-numberspinner")) {
                $(_elem).numberspinner({readonly:readonly,disabled:disable});
            } else if($(_elem).hasClass("easyui-datebox")) {
                $(_elem).datebox({readonly:readonly,disabled:disable});
            } else if($(_elem).hasClass("easyui-combobox")) {
                $(_elem).combobox({readonly:readonly,disabled:disable});
            } else if($(_elem).hasClass("easyui-filebox")) {
                $(_elem).filebox("clear").filebox({readonly:readonly,disabled:disable});
            }
        });

        $.each(elem.find("textarea"), function(idx, _elem) {
            if(readonly) {
                $(_elem).attr("disabled", "disabled");
            } else {
                $(_elem).removeAttr("disabled");
            }
        });
    },
    /**
     * 从页面获取数据，页面元素ID以<字母_>开头
     * @param formElemId
     * @returns {{}}
     */
    drillDownForm:function (formElemId) {
        var form = $("#" + formElemId);
        var data = {};

        $.each(form.find("input.easyui-textbox"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).textbox("getValue");
        });
        $.each(form.find("input.easyui-numberbox"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).numberbox("getValue");
        });
        $.each(form.find("input.easyui-numberspinner"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).numberspinner("getValue");
        });
        $.each(form.find("input.easyui-datebox"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).datebox("getValue");
        });
        $.each(form.find("input.easyui-combobox"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).combobox("getValue");
        })
        return data;
    },
    /**
     * 从页面获取数据
     * @param formElemId
     * @returns {{}}
     */
    drillDownFormNoUnderscore:function (formElemId) {
        var form = $("#" + formElemId);
        var data = {};

        $.each(form.find("input.easyui-textbox"), function (idx, elem) {
            data[elem.id] = $(elem).textbox("getValue");
        });
        $.each(form.find("input.easyui-numberbox"), function (idx, elem) {
            data[elem.id] = $(elem).numberbox("getValue");
        });
        $.each(form.find("input.easyui-numberspinner"), function (idx, elem) {
            data[elem.id] = $(elem).numberspinner("getValue");
        });
        $.each(form.find("input.easyui-datebox"), function (idx, elem) {
            data[elem.id] = $(elem).datebox("getValue");
        });
        $.each(form.find("input.easyui-combobox"), function (idx, elem) {
            data[elem.id] = $(elem).combobox("getValue");
        })
        return data;
    },
    /**
     * 比较DATAGRID数据
     */
    showDiff:function () {
        function _showDiff_(gridView, columnName) {
            var cells = gridView.find("td[field='" + columnName + "'] div");
            var previous = cells[1];
            for(var idx=2; idx<cells.length; idx++) {
                var current = cells[idx];
                if(previous.textContent == current.textContent) {
                    $(previous).parent().css("color", "blue").css("background-color", "white");
                } else {
                    $(previous).parent().css("color", "red").css("background-color", "yellow");
                }
                previous = current;
            }
        }
        var grid = $("#" + this.id);
        var columns = grid.datagrid("options").columns;
        var gridView = grid.parent();
        for(var i=0; i<columns.length; i++) {
            for(var j=0; j<columns[i].length; j++) {
                var column = columns[i][j];
                if(column.field != '' && column.field != 'ver' && ! column.field.startsWith('modify')) {
                    _showDiff_(gridView, column.field);
                }
            }
        }
    },
    /**
     * 数组定位
     * @data 要定位的数组
     * @param el 可以是JSON对象或数值、字符串
     *                    如果是JSON对象，对象中要包含idFieldName和idFieldValue
     *                                               idFieldName要查找的属性名称，idFieldValue要查找的属性值
     * @returns {number}
     */
    arrayLocate:function (data,search){
        var result={};
        result.index=-1;
        for (var i=0; i<data.length; i++){
            var findValue;
            if(typeof search =="object"){
                findValue=data[i][search["idFieldName"]];
                if (findValue === search["idFieldValue"]){
                    result.index=i;
                    result.data=data[i];
                    return result;
                }
            }else{
                findValue=data[i];
                if (findValue === search){
                    result.index=i;
                    result.data=data[i];
                    return result;
                }
            }
        }
        return result;
    },
    /**
     * 在控件上增加提示，设置MouseClick事件显示
     */
    addTooltipClick:function (tooltipId,tooltipContentStr,parentFlag,showNowFlag){
        var obj=$('#'+tooltipId);
        if(parentFlag){
            obj=obj.parent();
        }
        obj.tooltip({
            position: 'right',
            showEvent: 'click',
            content: '<span class="easyui-tooltip">'+tooltipContentStr+'</span>',
            onShow: function(){
                $(this).tooltip('tip').css({
                    backgroundColor: 'orange',
                    borderColor: '#666'
                });
                var t = $(this);
                t.tooltip('tip').unbind().bind('mouseenter', function(){
                    t.tooltip('show');
                }).bind('mouseleave', function(){
                    t.tooltip('hide');
                });
            }
        });
        if(showNowFlag){
            obj.tooltip("show");
        }
    },
    /**
     * EasyUi ToolTip 扩展
     */
    /**
     * 在控件上删除提示方法
     */
    destroyToolTip:function (tooltipId,parentFlag){
        //删除提示
        var obj=$('#'+tooltipId);
        if(parentFlag){
            obj=obj.parent();
        }
        obj.tooltip("destroy");
    },
    /**
     * 在控件上增加提示，设置MouseOver事件显示
     */
    addTooltipMouseOver:function (tooltipId,tooltipContentStr,parentFlag,showNowFlag){
        //添加相应的tooltip
        var obj=$('#'+tooltipId);
        if(parentFlag){
            obj=obj.parent();
        }
        obj.tooltip({
            position: 'right',
            content: '<span class="easyui-tooltip">'+tooltipContentStr+'</span>',
            onShow: function(){
                $(this).tooltip('tip').css({
                    backgroundColor: 'orange',
                    borderColor: '#666'
                });
                var t = $(this);
                t.tooltip('tip').unbind().bind('mouseenter', function(){
                    t.tooltip('show');
                }).bind('mouseleave', function(){
                    t.tooltip('hide');
                });
            }
        });
        if(showNowFlag){
            obj.tooltip("show");
        }
    },
    /**
     * 在控件上增加提示，设置显示时间
     */
    addTooltipTimeOut:function (tooltipId,tooltipContentStr,parentFlag){
        //添加相应的tooltip
        var obj=$('#'+tooltipId);
        if(parentFlag){
            obj=obj.parent();
        }
        obj.tooltip({
            position: 'right',
            showDelay: 5,
            hideDelay: 3000,
            content: '<span class="easyui-tooltip">'+tooltipContentStr+'</span>',
            onShow: function(){
                $(this).tooltip('tip').css({
                    backgroundColor: 'orange',
                    borderColor: '#666'
                });
                if(parentFlag) {
                    setTimeout("$('#" + tooltipId + "')" + ".parent().tooltip('hide')", 3000);
                }else{
                    setTimeout("$('#" + tooltipId + "')" + ".tooltip('hide')", 3000);
                }
            }
        }).tooltip("show");
    },
    /**
     *增加合计行
     * @param dataGridId   datagrid代码
     * @param totalColumnIds  数组 需要计算合计的列
     * @param totalDialplayId 显示合计字样的列
     */
    addTotalRow:function (dataGridId,totalColumnIds,totalDialplayId){
        var data=$("#"+dataGridId).datagrid("getData");
        var row= {};
        for(var j=0;j<totalColumnIds.length;j++){
            row[totalColumnIds[j]]=0.00;
        }
        row[totalDialplayId]="合计";
        for(var i=0;i<data.rows.length;i++){
            for(var key in row){
                for(var j=0;j<totalColumnIds.length;j++){
                    if(key==totalColumnIds[j]){
                        row[key]=parseFloat(row[key])+parseFloat(data.rows[i][key]);
                    }
                }
            }
        }
        $("#"+dataGridId).datagrid("appendRow",row);
    },
    /**
     * datagrid前台分页 DATAGRID中设置好pageSize和pagination属性
     * @param data
     * @returns {*}
     * 例子：$("#dg").datagrid({loadFilter:pagerFilter}).datagrid("loadData",response);
     */
    pagerFilter:function (data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){    // 判断数据是否是数组
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{
                    pageNumber:pageNum,
                    pageSize:pageSize
                });
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }
};

$.fn.window.defaults.onResize = $.easyuiExtendObj.panelOnResize;
$.fn.dialog.defaults.onResize = $.easyuiExtendObj.panelOnResize;
$.fn.window.defaults.onMove = $.easyuiExtendObj.panelOnMove;
$.fn.dialog.defaults.onMove = $.easyuiExtendObj.panelOnMove;

/**
 * easyui中文化处理，与easyui-lang-zh_CN.js内容保持一致
 */
if ($.fn.pagination){
    $.fn.pagination.defaults.beforePageText = '第';
    $.fn.pagination.defaults.afterPageText = '共{pages}页';
    $.fn.pagination.defaults.displayMsg = '显示{from}到{to},共{total}记录';
}
if ($.fn.datagrid){
    $.fn.datagrid.defaults.loadMsg = '正在处理，请稍待。。。';
}
if ($.fn.treegrid && $.fn.datagrid){
    $.fn.treegrid.defaults.loadMsg = $.fn.datagrid.defaults.loadMsg;
}
if ($.messager){
    $.messager.defaults.ok = '确定';
    $.messager.defaults.cancel = '取消';
}
$.map(['validatebox','textbox','filebox','searchbox',
    'combo','combobox','combogrid','combotree',
    'datebox','datetimebox','numberbox',
    'spinner','numberspinner','timespinner','datetimespinner'], function(plugin){
    if ($.fn[plugin]){
        $.fn[plugin].defaults.missingMessage = '该输入项为必输项';
    }
});
if ($.fn.validatebox){
    $.fn.validatebox.defaults.rules.email.message = '请输入有效的电子邮件地址';
    $.fn.validatebox.defaults.rules.url.message = '请输入有效的URL地址';
    $.fn.validatebox.defaults.rules.length.message = '输入内容长度必须介于{0}和{1}之间';
    $.fn.validatebox.defaults.rules.remote.message = '请修正该字段';
}
if ($.fn.calendar){
    $.fn.calendar.defaults.weeks = ['日','一','二','三','四','五','六'];
    $.fn.calendar.defaults.months = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];
}
if ($.fn.datebox){
    $.fn.datebox.defaults.currentText = '今天';
    $.fn.datebox.defaults.closeText = '关闭';
    $.fn.datebox.defaults.okText = '确定';
    $.fn.datebox.defaults.formatter = function(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    };
    $.fn.datebox.defaults.parser = function(s){
        if (!s) return new Date();
        var ss = s.split('-');
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    };
}
if ($.fn.datetimebox && $.fn.datebox){
    $.extend($.fn.datetimebox.defaults,{
        currentText: $.fn.datebox.defaults.currentText,
        closeText: $.fn.datebox.defaults.closeText,
        okText: $.fn.datebox.defaults.okText
    });
}
if ($.fn.datetimespinner){
    $.fn.datetimespinner.defaults.selections = [[0,4],[5,7],[8,10],[11,13],[14,16],[17,19]]
}
/**
 * 扩展EASYUI
 * 不能使用VALIDATEBOX，已经扩展TEXTBOX，增加了验证功能
 */

/**
 * easyui combobox 扩展
 */
$.extend($.fn.combobox.defaults, {
    filter : function (input, row) {
        /**
         汉字拼音首字母列表 本列表包含了20902个汉字,用于配合 ToChineseSpell
         函数使用,本表收录的字符的Unicode编码范围为19968至40869,
         功能:生成与中文字符串相对映的拼音首字母串
         */
        var strChineseFirstPY = "YDYQSXMWZSSXJBYMGCCZQPSSQBYCDSCDQLDYLYBSSJGYZZJJFKCCLZDHWDWZJLJPFYYNWJJTMYHZWZHFLZPPQHGSCYYYNJQYXXGJHHSDSJNKKTMOMLCRXYPSNQSECCQZGGLLYJLMYZZSECYKYYHQWJSSGGYXYZYJWWKDJHYCHMYXJTLXJYQBYXZLDWRDJRWYSRLDZJPCBZJJBRCFTLECZSTZFXXZHTRQHYBDLYCZSSYMMRFMYQZPWWJJYFCRWFDFZQPYDDWYXKYJAWJFFXYPSFTZYHHYZYSWCJYXSCLCXXWZZXNBGNNXBXLZSZSBSGPYSYZDHMDZBQBZCWDZZYYTZHBTSYYBZGNTNXQYWQSKBPHHLXGYBFMJEBJHHGQTJCYSXSTKZHLYCKGLYSMZXYALMELDCCXGZYRJXSDLTYZCQKCNNJWHJTZZCQLJSTSTBNXBTYXCEQXGKWJYFLZQLYHYXSPSFXLMPBYSXXXYDJCZYLLLSJXFHJXPJBTFFYABYXBHZZBJYZLWLCZGGBTSSMDTJZXPTHYQTGLJSCQFZKJZJQNLZWLSLHDZBWJNCJZYZSQQYCQYRZCJJWYBRTWPYFTWEXCSKDZCTBZHYZZYYJXZCFFZZMJYXXSDZZOTTBZLQWFCKSZSXFYRLNYJMBDTHJXSQQCCSBXYYTSYFBXDZTGBCNSLCYZZPSAZYZZSCJCSHZQYDXLBPJLLMQXTYDZXSQJTZPXLCGLQTZWJBHCTSYJSFXYEJJTLBGXSXJMYJQQPFZASYJNTYDJXKJCDJSZCBARTDCLYJQMWNQNCLLLKBYBZZSYHQQLTWLCCXTXLLZNTYLNEWYZYXCZXXGRKRMTCNDNJTSYYSSDQDGHSDBJGHRWRQLYBGLXHLGTGXBQJDZPYJSJYJCTMRNYMGRZJCZGJMZMGXMPRYXKJNYMSGMZJYMKMFXMLDTGFBHCJHKYLPFMDXLQJJSMTQGZSJLQDLDGJYCALCMZCSDJLLNXDJFFFFJCZFMZFFPFKHKGDPSXKTACJDHHZDDCRRCFQYJKQCCWJDXHWJLYLLZGCFCQDSMLZPBJJPLSBCJGGDCKKDEZSQCCKJGCGKDJTJDLZYCXKLQSCGJCLTFPCQCZGWPJDQYZJJBYJHSJDZWGFSJGZKQCCZLLPSPKJGQJHZZLJPLGJGJJTHJJYJZCZMLZLYQBGJWMLJKXZDZNJQSYZMLJLLJKYWXMKJLHSKJGBMCLYYMKXJQLBMLLKMDXXKWYXYSLMLPSJQQJQXYXFJTJDXMXXLLCXQBSYJBGWYMBGGBCYXPJYGPEPFGDJGBHBNSQJYZJKJKHXQFGQZKFHYGKHDKLLSDJQXPQYKYBNQSXQNSZSWHBSXWHXWBZZXDMNSJBSBKBBZKLYLXGWXDRWYQZMYWSJQLCJXXJXKJEQXSCYETLZHLYYYSDZPAQYZCMTLSHTZCFYZYXYLJSDCJQAGYSLCQLYYYSHMRQQKLDXZSCSSSYDYCJYSFSJBFRSSZQSBXXPXJYSDRCKGJLGDKZJZBDKTCSYQPYHSTCLDJDHMXMCGXYZHJDDTMHLTXZXYLYMOHYJCLTYFBQQXPFBDFHHTKSQHZYYWCNXXCRWHOWGYJLEGWDQCWGFJYCSNTMYTOLBYGWQWESJPWNMLRYDZSZTXYQPZGCWXHNGPYXSHMYQJXZTDPPBFYHZHTJYFDZWKGKZBLDNTSXHQEEGZZYLZMMZYJZGXZXKHKSTXNXXWYLYAPSTHXDWHZYMPXAGKYDXBHNHXKDPJNMYHYLPMGOCSLNZHKXXLPZZLBMLSFBHHGYGYYGGBHSCYAQTYWLXTZQCEZYDQDQMMHTKLLSZHLSJZWFYHQSWSCWLQAZYNYTLSXTHAZNKZZSZZLAXXZWWCTGQQTDDYZTCCHYQZFLXPSLZYGPZSZNGLNDQTBDLXGTCTAJDKYWNSYZLJHHZZCWNYYZYWMHYCHHYXHJKZWSXHZYXLYSKQYSPSLYZWMYPPKBYGLKZHTYXAXQSYSHXASMCHKDSCRSWJPWXSGZJLWWSCHSJHSQNHCSEGNDAQTBAALZZMSSTDQJCJKTSCJAXPLGGXHHGXXZCXPDMMHLDGTYBYSJMXHMRCPXXJZCKZXSHMLQXXTTHXWZFKHCCZDYTCJYXQHLXDHYPJQXYLSYYDZOZJNYXQEZYSQYAYXWYPDGXDDXSPPYZNDLTWRHXYDXZZJHTCXMCZLHPYYYYMHZLLHNXMYLLLMDCPPXHMXDKYCYRDLTXJCHHZZXZLCCLYLNZSHZJZZLNNRLWHYQSNJHXYNTTTKYJPYCHHYEGKCTTWLGQRLGGTGTYGYHPYHYLQYQGCWYQKPYYYTTTTLHYHLLTYTTSPLKYZXGZWGPYDSSZZDQXSKCQNMJJZZBXYQMJRTFFBTKHZKBXLJJKDXJTLBWFZPPTKQTZTGPDGNTPJYFALQMKGXBDCLZFHZCLLLLADPMXDJHLCCLGYHDZFGYDDGCYYFGYDXKSSEBDHYKDKDKHNAXXYBPBYYHXZQGAFFQYJXDMLJCSQZLLPCHBSXGJYNDYBYQSPZWJLZKSDDTACTBXZDYZYPJZQSJNKKTKNJDJGYYPGTLFYQKASDNTCYHBLWDZHBBYDWJRYGKZYHEYYFJMSDTYFZJJHGCXPLXHLDWXXJKYTCYKSSSMTWCTTQZLPBSZDZWZXGZAGYKTYWXLHLSPBCLLOQMMZSSLCMBJCSZZKYDCZJGQQDSMCYTZQQLWZQZXSSFPTTFQMDDZDSHDTDWFHTDYZJYQJQKYPBDJYYXTLJHDRQXXXHAYDHRJLKLYTWHLLRLLRCXYLBWSRSZZSYMKZZHHKYHXKSMDSYDYCJPBZBSQLFCXXXNXKXWYWSDZYQOGGQMMYHCDZTTFJYYBGSTTTYBYKJDHKYXBELHTYPJQNFXFDYKZHQKZBYJTZBXHFDXKDASWTAWAJLDYJSFHBLDNNTNQJTJNCHXFJSRFWHZFMDRYJYJWZPDJKZYJYMPCYZNYNXFBYTFYFWYGDBNZZZDNYTXZEMMQBSQEHXFZMBMFLZZSRXYMJGSXWZJSPRYDJSJGXHJJGLJJYNZZJXHGXKYMLPYYYCXYTWQZSWHWLYRJLPXSLSXMFSWWKLCTNXNYNPSJSZHDZEPTXMYYWXYYSYWLXJQZQXZDCLEEELMCPJPCLWBXSQHFWWTFFJTNQJHJQDXHWLBYZNFJLALKYYJLDXHHYCSTYYWNRJYXYWTRMDRQHWQCMFJDYZMHMYYXJWMYZQZXTLMRSPWWCHAQBXYGZYPXYYRRCLMPYMGKSJSZYSRMYJSNXTPLNBAPPYPYLXYYZKYNLDZYJZCZNNLMZHHARQMPGWQTZMXXMLLHGDZXYHXKYXYCJMFFYYHJFSBSSQLXXNDYCANNMTCJCYPRRNYTYQNYYMBMSXNDLYLYSLJRLXYSXQMLLYZLZJJJKYZZCSFBZXXMSTBJGNXYZHLXNMCWSCYZYFZLXBRNNNYLBNRTGZQYSATSWRYHYJZMZDHZGZDWYBSSCSKXSYHYTXXGCQGXZZSHYXJSCRHMKKBXCZJYJYMKQHZJFNBHMQHYSNJNZYBKNQMCLGQHWLZNZSWXKHLJHYYBQLBFCDSXDLDSPFZPSKJYZWZXZDDXJSMMEGJSCSSMGCLXXKYYYLNYPWWWGYDKZJGGGZGGSYCKNJWNJPCXBJJTQTJWDSSPJXZXNZXUMELPXFSXTLLXCLJXJJLJZXCTPSWXLYDHLYQRWHSYCSQYYBYAYWJJJQFWQCQQCJQGXALDBZZYJGKGXPLTZYFXJLTPADKYQHPMATLCPDCKBMTXYBHKLENXDLEEGQDYMSAWHZMLJTWYGXLYQZLJEEYYBQQFFNLYXRDSCTGJGXYYNKLLYQKCCTLHJLQMKKZGCYYGLLLJDZGYDHZWXPYSJBZKDZGYZZHYWYFQYTYZSZYEZZLYMHJJHTSMQWYZLKYYWZCSRKQYTLTDXWCTYJKLWSQZWBDCQYNCJSRSZJLKCDCDTLZZZACQQZZDDXYPLXZBQJYLZLLLQDDZQJYJYJZYXNYYYNYJXKXDAZWYRDLJYYYRJLXLLDYXJCYWYWNQCCLDDNYYYNYCKCZHXXCCLGZQJGKWPPCQQJYSBZZXYJSQPXJPZBSBDSFNSFPZXHDWZTDWPPTFLZZBZDMYYPQJRSDZSQZSQXBDGCPZSWDWCSQZGMDHZXMWWFYBPDGPHTMJTHZSMMBGZMBZJCFZWFZBBZMQCFMBDMCJXLGPNJBBXGYHYYJGPTZGZMQBQTCGYXJXLWZKYDPDYMGCFTPFXYZTZXDZXTGKMTYBBCLBJASKYTSSQYYMSZXFJEWLXLLSZBQJJJAKLYLXLYCCTSXMCWFKKKBSXLLLLJYXTYLTJYYTDPJHNHNNKBYQNFQYYZBYYESSESSGDYHFHWTCJBSDZZTFDMXHCNJZYMQWSRYJDZJQPDQBBSTJGGFBKJBXTGQHNGWJXJGDLLTHZHHYYYYYYSXWTYYYCCBDBPYPZYCCZYJPZYWCBDLFWZCWJDXXHYHLHWZZXJTCZLCDPXUJCZZZLYXJJTXPHFXWPYWXZPTDZZBDZCYHJHMLXBQXSBYLRDTGJRRCTTTHYTCZWMXFYTWWZCWJWXJYWCSKYBZSCCTZQNHXNWXXKHKFHTSWOCCJYBCMPZZYKBNNZPBZHHZDLSYDDYTYFJPXYNGFXBYQXCBHXCPSXTYZDMKYSNXSXLHKMZXLYHDHKWHXXSSKQYHHCJYXGLHZXCSNHEKDTGZXQYPKDHEXTYKCNYMYYYPKQYYYKXZLTHJQTBYQHXBMYHSQCKWWYLLHCYYLNNEQXQWMCFBDCCMLJGGXDQKTLXKGNQCDGZJWYJJLYHHQTTTNWCHMXCXWHWSZJYDJCCDBQCDGDNYXZTHCQRXCBHZTQCBXWGQWYYBXHMBYMYQTYEXMQKYAQYRGYZSLFYKKQHYSSQYSHJGJCNXKZYCXSBXYXHYYLSTYCXQTHYSMGSCPMMGCCCCCMTZTASMGQZJHKLOSQYLSWTMXSYQKDZLJQQYPLSYCZTCQQPBBQJZCLPKHQZYYXXDTDDTSJCXFFLLCHQXMJLWCJCXTSPYCXNDTJSHJWXDQQJSKXYAMYLSJHMLALYKXCYYDMNMDQMXMCZNNCYBZKKYFLMCHCMLHXRCJJHSYLNMTJZGZGYWJXSRXCWJGJQHQZDQJDCJJZKJKGDZQGJJYJYLXZXXCDQHHHEYTMHLFSBDJSYYSHFYSTCZQLPBDRFRZTZYKYWHSZYQKWDQZRKMSYNBCRXQBJYFAZPZZEDZCJYWBCJWHYJBQSZYWRYSZPTDKZPFPBNZTKLQYHBBZPNPPTYZZYBQNYDCPJMMCYCQMCYFZZDCMNLFPBPLNGQJTBTTNJZPZBBZNJKLJQYLNBZQHKSJZNGGQSZZKYXSHPZSNBCGZKDDZQANZHJKDRTLZLSWJLJZLYWTJNDJZJHXYAYNCBGTZCSSQMNJPJYTYSWXZFKWJQTKHTZPLBHSNJZSYZBWZZZZLSYLSBJHDWWQPSLMMFBJDWAQYZTCJTBNNWZXQXCDSLQGDSDPDZHJTQQPSWLYYJZLGYXYZLCTCBJTKTYCZJTQKBSJLGMGZDMCSGPYNJZYQYYKNXRPWSZXMTNCSZZYXYBYHYZAXYWQCJTLLCKJJTJHGDXDXYQYZZBYWDLWQCGLZGJGQRQZCZSSBCRPCSKYDZNXJSQGXSSJMYDNSTZTPBDLTKZWXQWQTZEXNQCZGWEZKSSBYBRTSSSLCCGBPSZQSZLCCGLLLZXHZQTHCZMQGYZQZNMCOCSZJMMZSQPJYGQLJYJPPLDXRGZYXCCSXHSHGTZNLZWZKJCXTCFCJXLBMQBCZZWPQDNHXLJCTHYZLGYLNLSZZPCXDSCQQHJQKSXZPBAJYEMSMJTZDXLCJYRYYNWJBNGZZTMJXLTBSLYRZPYLSSCNXPHLLHYLLQQZQLXYMRSYCXZLMMCZLTZSDWTJJLLNZGGQXPFSKYGYGHBFZPDKMWGHCXMSGDXJMCJZDYCABXJDLNBCDQYGSKYDQTXDJJYXMSZQAZDZFSLQXYJSJZYLBTXXWXQQZBJZUFBBLYLWDSLJHXJYZJWTDJCZFQZQZZDZSXZZQLZCDZFJHYSPYMPQZMLPPLFFXJJNZZYLSJEYQZFPFZKSYWJJJHRDJZZXTXXGLGHYDXCSKYSWMMZCWYBAZBJKSHFHJCXMHFQHYXXYZFTSJYZFXYXPZLCHMZMBXHZZSXYFYMNCWDABAZLXKTCSHHXKXJJZJSTHYGXSXYYHHHJWXKZXSSBZZWHHHCWTZZZPJXSNXQQJGZYZYWLLCWXZFXXYXYHXMKYYSWSQMNLNAYCYSPMJKHWCQHYLAJJMZXHMMCNZHBHXCLXTJPLTXYJHDYYLTTXFSZHYXXSJBJYAYRSMXYPLCKDUYHLXRLNLLSTYZYYQYGYHHSCCSMZCTZQXKYQFPYYRPFFLKQUNTSZLLZMWWTCQQYZWTLLMLMPWMBZSSTZRBPDDTLQJJBXZCSRZQQYGWCSXFWZLXCCRSZDZMCYGGDZQSGTJSWLJMYMMZYHFBJDGYXCCPSHXNZCSBSJYJGJMPPWAFFYFNXHYZXZYLREMZGZCYZSSZDLLJCSQFNXZKPTXZGXJJGFMYYYSNBTYLBNLHPFZDCYFBMGQRRSSSZXYSGTZRNYDZZCDGPJAFJFZKNZBLCZSZPSGCYCJSZLMLRSZBZZLDLSLLYSXSQZQLYXZLSKKBRXBRBZCYCXZZZEEYFGKLZLYYHGZSGZLFJHGTGWKRAAJYZKZQTSSHJJXDCYZUYJLZYRZDQQHGJZXSSZBYKJPBFRTJXLLFQWJHYLQTYMBLPZDXTZYGBDHZZRBGXHWNJTJXLKSCFSMWLSDQYSJTXKZSCFWJLBXFTZLLJZLLQBLSQMQQCGCZFPBPHZCZJLPYYGGDTGWDCFCZQYYYQYSSCLXZSKLZZZGFFCQNWGLHQYZJJCZLQZZYJPJZZBPDCCMHJGXDQDGDLZQMFGPSYTSDYFWWDJZJYSXYYCZCYHZWPBYKXRYLYBHKJKSFXTZJMMCKHLLTNYYMSYXYZPYJQYCSYCWMTJJKQYRHLLQXPSGTLYYCLJSCPXJYZFNMLRGJJTYZBXYZMSJYJHHFZQMSYXRSZCWTLRTQZSSTKXGQKGSPTGCZNJSJCQCXHMXGGZTQYDJKZDLBZSXJLHYQGGGTHQSZPYHJHHGYYGKGGCWJZZYLCZLXQSFTGZSLLLMLJSKCTBLLZZSZMMNYTPZSXQHJCJYQXYZXZQZCPSHKZZYSXCDFGMWQRLLQXRFZTLYSTCTMJCXJJXHJNXTNRZTZFQYHQGLLGCXSZSJDJLJCYDSJTLNYXHSZXCGJZYQPYLFHDJSBPCCZHJJJQZJQDYBSSLLCMYTTMQTBHJQNNYGKYRQYQMZGCJKPDCGMYZHQLLSLLCLMHOLZGDYYFZSLJCQZLYLZQJESHNYLLJXGJXLYSYYYXNBZLJSSZCQQCJYLLZLTJYLLZLLBNYLGQCHXYYXOXCXQKYJXXXYKLXSXXYQXCYKQXQCSGYXXYQXYGYTQOHXHXPYXXXULCYEYCHZZCBWQBBWJQZSCSZSSLZYLKDESJZWMYMCYTSDSXXSCJPQQSQYLYYZYCMDJDZYWCBTJSYDJKCYDDJLBDJJSODZYSYXQQYXDHHGQQYQHDYXWGMMMAJDYBBBPPBCMUUPLJZSMTXERXJMHQNUTPJDCBSSMSSSTKJTSSMMTRCPLZSZMLQDSDMJMQPNQDXCFYNBFSDQXYXHYAYKQYDDLQYYYSSZBYDSLNTFQTZQPZMCHDHCZCWFDXTMYQSPHQYYXSRGJCWTJTZZQMGWJJTJHTQJBBHWZPXXHYQFXXQYWYYHYSCDYDHHQMNMTMWCPBSZPPZZGLMZFOLLCFWHMMSJZTTDHZZYFFYTZZGZYSKYJXQYJZQBHMBZZLYGHGFMSHPZFZSNCLPBQSNJXZSLXXFPMTYJYGBXLLDLXPZJYZJYHHZCYWHJYLSJEXFSZZYWXKZJLUYDTMLYMQJPWXYHXSKTQJEZRPXXZHHMHWQPWQLYJJQJJZSZCPHJLCHHNXJLQWZJHBMZYXBDHHYPZLHLHLGFWLCHYYTLHJXCJMSCPXSTKPNHQXSRTYXXTESYJCTLSSLSTDLLLWWYHDHRJZSFGXTSYCZYNYHTDHWJSLHTZDQDJZXXQHGYLTZPHCSQFCLNJTCLZPFSTPDYNYLGMJLLYCQHYSSHCHYLHQYQTMZYPBYWRFQYKQSYSLZDQJMPXYYSSRHZJNYWTQDFZBWWTWWRXCWHGYHXMKMYYYQMSMZHNGCEPMLQQMTCWCTMMPXJPJJHFXYYZSXZHTYBMSTSYJTTQQQYYLHYNPYQZLCYZHZWSMYLKFJXLWGXYPJYTYSYXYMZCKTTWLKSMZSYLMPWLZWXWQZSSAQSYXYRHSSNTSRAPXCPWCMGDXHXZDZYFJHGZTTSBJHGYZSZYSMYCLLLXBTYXHBBZJKSSDMALXHYCFYGMQYPJYCQXJLLLJGSLZGQLYCJCCZOTYXMTMTTLLWTGPXYMZMKLPSZZZXHKQYSXCTYJZYHXSHYXZKXLZWPSQPYHJWPJPWXQQYLXSDHMRSLZZYZWTTCYXYSZZSHBSCCSTPLWSSCJCHNLCGCHSSPHYLHFHHXJSXYLLNYLSZDHZXYLSXLWZYKCLDYAXZCMDDYSPJTQJZLNWQPSSSWCTSTSZLBLNXSMNYYMJQBQHRZWTYYDCHQLXKPZWBGQYBKFCMZWPZLLYYLSZYDWHXPSBCMLJBSCGBHXLQHYRLJXYSWXWXZSLDFHLSLYNJLZYFLYJYCDRJLFSYZFSLLCQYQFGJYHYXZLYLMSTDJCYHBZLLNWLXXYGYYHSMGDHXXHHLZZJZXCZZZCYQZFNGWPYLCPKPYYPMCLQKDGXZGGWQBDXZZKZFBXXLZXJTPJPTTBYTSZZDWSLCHZHSLTYXHQLHYXXXYYZYSWTXZKHLXZXZPYHGCHKCFSYHUTJRLXFJXPTZTWHPLYXFCRHXSHXKYXXYHZQDXQWULHYHMJTBFLKHTXCWHJFWJCFPQRYQXCYYYQYGRPYWSGSUNGWCHKZDXYFLXXHJJBYZWTSXXNCYJJYMSWZJQRMHXZWFQSYLZJZGBHYNSLBGTTCSYBYXXWXYHXYYXNSQYXMQYWRGYQLXBBZLJSYLPSYTJZYHYZAWLRORJMKSCZJXXXYXCHDYXRYXXJDTSQFXLYLTSFFYXLMTYJMJUYYYXLTZCSXQZQHZXLYYXZHDNBRXXXJCTYHLBRLMBRLLAXKYLLLJLYXXLYCRYLCJTGJCMTLZLLCYZZPZPCYAWHJJFYBDYYZSMPCKZDQYQPBPCJPDCYZMDPBCYYDYCNNPLMTMLRMFMMGWYZBSJGYGSMZQQQZTXMKQWGXLLPJGZBQCDJJJFPKJKCXBLJMSWMDTQJXLDLPPBXCWRCQFBFQJCZAHZGMYKPHYYHZYKNDKZMBPJYXPXYHLFPNYYGXJDBKXNXHJMZJXSTRSTLDXSKZYSYBZXJLXYSLBZYSLHXJPFXPQNBYLLJQKYGZMCYZZYMCCSLCLHZFWFWYXZMWSXTYNXJHPYYMCYSPMHYSMYDYSHQYZCHMJJMZCAAGCFJBBHPLYZYLXXSDJGXDHKXXTXXNBHRMLYJSLTXMRHNLXQJXYZLLYSWQGDLBJHDCGJYQYCMHWFMJYBMBYJYJWYMDPWHXQLDYGPDFXXBCGJSPCKRSSYZJMSLBZZJFLJJJLGXZGYXYXLSZQYXBEXYXHGCXBPLDYHWETTWWCJMBTXCHXYQXLLXFLYXLLJLSSFWDPZSMYJCLMWYTCZPCHQEKCQBWLCQYDPLQPPQZQFJQDJHYMMCXTXDRMJWRHXCJZYLQXDYYNHYYHRSLSRSYWWZJYMTLTLLGTQCJZYABTCKZCJYCCQLJZQXALMZYHYWLWDXZXQDLLQSHGPJFJLJHJABCQZDJGTKHSSTCYJLPSWZLXZXRWGLDLZRLZXTGSLLLLZLYXXWGDZYGBDPHZPBRLWSXQBPFDWOFMWHLYPCBJCCLDMBZPBZZLCYQXLDOMZBLZWPDWYYGDSTTHCSQSCCRSSSYSLFYBFNTYJSZDFNDPDHDZZMBBLSLCMYFFGTJJQWFTMTPJWFNLBZCMMJTGBDZLQLPYFHYYMJYLSDCHDZJWJCCTLJCLDTLJJCPDDSQDSSZYBNDBJLGGJZXSXNLYCYBJXQYCBYLZCFZPPGKCXZDZFZTJJFJSJXZBNZYJQTTYJYHTYCZHYMDJXTTMPXSPLZCDWSLSHXYPZGTFMLCJTYCBPMGDKWYCYZCDSZZYHFLYCTYGWHKJYYLSJCXGYWJCBLLCSNDDBTZBSCLYZCZZSSQDLLMQYYHFSLQLLXFTYHABXGWNYWYYPLLSDLDLLBJCYXJZMLHLJDXYYQYTDLLLBUGBFDFBBQJZZMDPJHGCLGMJJPGAEHHBWCQXAXHHHZCHXYPHJAXHLPHJPGPZJQCQZGJJZZUZDMQYYBZZPHYHYBWHAZYJHYKFGDPFQSDLZMLJXKXGALXZDAGLMDGXMWZQYXXDXXPFDMMSSYMPFMDMMKXKSYZYSHDZKXSYSMMZZZMSYDNZZCZXFPLSTMZDNMXCKJMZTYYMZMZZMSXHHDCZJEMXXKLJSTLWLSQLYJZLLZJSSDPPMHNLZJCZYHMXXHGZCJMDHXTKGRMXFWMCGMWKDTKSXQMMMFZZYDKMSCLCMPCGMHSPXQPZDSSLCXKYXTWLWJYAHZJGZQMCSNXYYMMPMLKJXMHLMLQMXCTKZMJQYSZJSYSZHSYJZJCDAJZYBSDQJZGWZQQXFKDMSDJLFWEHKZQKJPEYPZYSZCDWYJFFMZZYLTTDZZEFMZLBNPPLPLPEPSZALLTYLKCKQZKGENQLWAGYXYDPXLHSXQQWQCQXQCLHYXXMLYCCWLYMQYSKGCHLCJNSZKPYZKCQZQLJPDMDZHLASXLBYDWQLWDNBQCRYDDZTJYBKBWSZDXDTNPJDTCTQDFXQQMGNXECLTTBKPWSLCTYQLPWYZZKLPYGZCQQPLLKCCYLPQMZCZQCLJSLQZDJXLDDHPZQDLJJXZQDXYZQKZLJCYQDYJPPYPQYKJYRMPCBYMCXKLLZLLFQPYLLLMBSGLCYSSLRSYSQTMXYXZQZFDZUYSYZTFFMZZSMZQHZSSCCMLYXWTPZGXZJGZGSJSGKDDHTQGGZLLBJDZLCBCHYXYZHZFYWXYZYMSDBZZYJGTSMTFXQYXQSTDGSLNXDLRYZZLRYYLXQHTXSRTZNGZXBNQQZFMYKMZJBZYMKBPNLYZPBLMCNQYZZZSJZHJCTZKHYZZJRDYZHNPXGLFZTLKGJTCTSSYLLGZRZBBQZZKLPKLCZYSSUYXBJFPNJZZXCDWXZYJXZZDJJKGGRSRJKMSMZJLSJYWQSKYHQJSXPJZZZLSNSHRNYPZTWCHKLPSRZLZXYJQXQKYSJYCZTLQZYBBYBWZPQDWWYZCYTJCJXCKCWDKKZXSGKDZXWWYYJQYYTCYTDLLXWKCZKKLCCLZCQQDZLQLCSFQCHQHSFSMQZZLNBJJZBSJHTSZDYSJQJPDLZCDCWJKJZZLPYCGMZWDJJBSJQZSYZYHHXJPBJYDSSXDZNCGLQMBTSFSBPDZDLZNFGFJGFSMPXJQLMBLGQCYYXBQKDJJQYRFKZTJDHCZKLBSDZCFJTPLLJGXHYXZCSSZZXSTJYGKGCKGYOQXJPLZPBPGTGYJZGHZQZZLBJLSQFZGKQQJZGYCZBZQTLDXRJXBSXXPZXHYZYCLWDXJJHXMFDZPFZHQHQMQGKSLYHTYCGFRZGNQXCLPDLBZCSCZQLLJBLHBZCYPZZPPDYMZZSGYHCKCPZJGSLJLNSCDSLDLXBMSTLDDFJMKDJDHZLZXLSZQPQPGJLLYBDSZGQLBZLSLKYYHZTTNTJYQTZZPSZQZTLLJTYYLLQLLQYZQLBDZLSLYYZYMDFSZSNHLXZNCZQZPBWSKRFBSYZMTHBLGJPMCZZLSTLXSHTCSYZLZBLFEQHLXFLCJLYLJQCBZLZJHHSSTBRMHXZHJZCLXFNBGXGTQJCZTMSFZKJMSSNXLJKBHSJXNTNLZDNTLMSJXGZJYJCZXYJYJWRWWQNZTNFJSZPZSHZJFYRDJSFSZJZBJFZQZZHZLXFYSBZQLZSGYFTZDCSZXZJBQMSZKJRHYJZCKMJKHCHGTXKXQGLXPXFXTRTYLXJXHDTSJXHJZJXZWZLCQSBTXWXGXTXXHXFTSDKFJHZYJFJXRZSDLLLTQSQQZQWZXSYQTWGWBZCGZLLYZBCLMQQTZHZXZXLJFRMYZFLXYSQXXJKXRMQDZDMMYYBSQBHGZMWFWXGMXLZPYYTGZYCCDXYZXYWGSYJYZNBHPZJSQSYXSXRTFYZGRHZTXSZZTHCBFCLSYXZLZQMZLMPLMXZJXSFLBYZMYQHXJSXRXSQZZZSSLYFRCZJRCRXHHZXQYDYHXSJJHZCXZBTYNSYSXJBQLPXZQPYMLXZKYXLXCJLCYSXXZZLXDLLLJJYHZXGYJWKJRWYHCPSGNRZLFZWFZZNSXGXFLZSXZZZBFCSYJDBRJKRDHHGXJLJJTGXJXXSTJTJXLYXQFCSGSWMSBCTLQZZWLZZKXJMLTMJYHSDDBXGZHDLBMYJFRZFSGCLYJBPMLYSMSXLSZJQQHJZFXGFQFQBPXZGYYQXGZTCQWYLTLGWSGWHRLFSFGZJMGMGBGTJFSYZZGZYZAFLSSPMLPFLCWBJZCLJJMZLPJJLYMQDMYYYFBGYGYZMLYZDXQYXRQQQHSYYYQXYLJTYXFSFSLLGNQCYHYCWFHCCCFXPYLYPLLZYXXXXXKQHHXSHJZCFZSCZJXCPZWHHHHHAPYLQALPQAFYHXDYLUKMZQGGGDDESRNNZLTZGCHYPPYSQJJHCLLJTOLNJPZLJLHYMHEYDYDSQYCDDHGZUNDZCLZYZLLZNTNYZGSLHSLPJJBDGWXPCDUTJCKLKCLWKLLCASSTKZZDNQNTTLYYZSSYSSZZRYLJQKCQDHHCRXRZYDGRGCWCGZQFFFPPJFZYNAKRGYWYQPQXXFKJTSZZXSWZDDFBBXTBGTZKZNPZZPZXZPJSZBMQHKCYXYLDKLJNYPKYGHGDZJXXEAHPNZKZTZCMXCXMMJXNKSZQNMNLWBWWXJKYHCPSTMCSQTZJYXTPCTPDTNNPGLLLZSJLSPBLPLQHDTNJNLYYRSZFFJFQWDPHZDWMRZCCLODAXNSSNYZRESTYJWJYJDBCFXNMWTTBYLWSTSZGYBLJPXGLBOCLHPCBJLTMXZLJYLZXCLTPNCLCKXTPZJSWCYXSFYSZDKNTLBYJCYJLLSTGQCBXRYZXBXKLYLHZLQZLNZCXWJZLJZJNCJHXMNZZGJZZXTZJXYCYYCXXJYYXJJXSSSJSTSSTTPPGQTCSXWZDCSYFPTFBFHFBBLZJCLZZDBXGCXLQPXKFZFLSYLTUWBMQJHSZBMDDBCYSCCLDXYCDDQLYJJWMQLLCSGLJJSYFPYYCCYLTJANTJJPWYCMMGQYYSXDXQMZHSZXPFTWWZQSWQRFKJLZJQQYFBRXJHHFWJJZYQAZMYFRHCYYBYQWLPEXCCZSTYRLTTDMQLYKMBBGMYYJPRKZNPBSXYXBHYZDJDNGHPMFSGMWFZMFQMMBCMZZCJJLCNUXYQLMLRYGQZCYXZLWJGCJCGGMCJNFYZZJHYCPRRCMTZQZXHFQGTJXCCJEAQCRJYHPLQLSZDJRBCQHQDYRHYLYXJSYMHZYDWLDFRYHBPYDTSSCNWBXGLPZMLZZTQSSCPJMXXYCSJYTYCGHYCJWYRXXLFEMWJNMKLLSWTXHYYYNCMMCWJDQDJZGLLJWJRKHPZGGFLCCSCZMCBLTBHBQJXQDSPDJZZGKGLFQYWBZYZJLTSTDHQHCTCBCHFLQMPWDSHYYTQWCNZZJTLBYMBPDYYYXSQKXWYYFLXXNCWCXYPMAELYKKJMZZZBRXYYQJFLJPFHHHYTZZXSGQQMHSPGDZQWBWPJHZJDYSCQWZKTXXSQLZYYMYSDZGRXCKKUJLWPYSYSCSYZLRMLQSYLJXBCXTLWDQZPCYCYKPPPNSXFYZJJRCEMHSZMSXLXGLRWGCSTLRSXBZGBZGZTCPLUJLSLYLYMTXMTZPALZXPXJTJWTCYYZLBLXBZLQMYLXPGHDSLSSDMXMBDZZSXWHAMLCZCPJMCNHJYSNSYGCHSKQMZZQDLLKABLWJXSFMOCDXJRRLYQZKJMYBYQLYHETFJZFRFKSRYXFJTWDSXXSYSQJYSLYXWJHSNLXYYXHBHAWHHJZXWMYLJCSSLKYDZTXBZSYFDXGXZJKHSXXYBSSXDPYNZWRPTQZCZENYGCXQFJYKJBZMLJCMQQXUOXSLYXXLYLLJDZBTYMHPFSTTQQWLHOKYBLZZALZXQLHZWRRQHLSTMYPYXJJXMQSJFNBXYXYJXXYQYLTHYLQYFMLKLJTMLLHSZWKZHLJMLHLJKLJSTLQXYLMBHHLNLZXQJHXCFXXLHYHJJGBYZZKBXSCQDJQDSUJZYYHZHHMGSXCSYMXFEBCQWWRBPYYJQTYZCYQYQQZYHMWFFHGZFRJFCDPXNTQYZPDYKHJLFRZXPPXZDBBGZQSTLGDGYLCQMLCHHMFYWLZYXKJLYPQHSYWMQQGQZMLZJNSQXJQSYJYCBEHSXFSZPXZWFLLBCYYJDYTDTHWZSFJMQQYJLMQXXLLDTTKHHYBFPWTYYSQQWNQWLGWDEBZWCMYGCULKJXTMXMYJSXHYBRWFYMWFRXYQMXYSZTZZTFYKMLDHQDXWYYNLCRYJBLPSXCXYWLSPRRJWXHQYPHTYDNXHHMMYWYTZCSQMTSSCCDALWZTCPQPYJLLQZYJSWXMZZMMYLMXCLMXCZMXMZSQTZPPQQBLPGXQZHFLJJHYTJSRXWZXSCCDLXTYJDCQJXSLQYCLZXLZZXMXQRJMHRHZJBHMFLJLMLCLQNLDXZLLLPYPSYJYSXCQQDCMQJZZXHNPNXZMEKMXHYKYQLXSXTXJYYHWDCWDZHQYYBGYBCYSCFGPSJNZDYZZJZXRZRQJJYMCANYRJTLDPPYZBSTJKXXZYPFDWFGZZRPYMTNGXZQBYXNBUFNQKRJQZMJEGRZGYCLKXZDSKKNSXKCLJSPJYYZLQQJYBZSSQLLLKJXTBKTYLCCDDBLSPPFYLGYDTZJYQGGKQTTFZXBDKTYYHYBBFYTYYBCLPDYTGDHRYRNJSPTCSNYJQHKLLLZSLYDXXWBCJQSPXBPJZJCJDZFFXXBRMLAZHCSNDLBJDSZBLPRZTSWSBXBCLLXXLZDJZSJPYLYXXYFTFFFBHJJXGBYXJPMMMPSSJZJMTLYZJXSWXTYLEDQPJMYGQZJGDJLQJWJQLLSJGJGYGMSCLJJXDTYGJQJQJCJZCJGDZZSXQGSJGGCXHQXSNQLZZBXHSGZXCXYLJXYXYYDFQQJHJFXDHCTXJYRXYSQTJXYEFYYSSYYJXNCYZXFXMSYSZXYYSCHSHXZZZGZZZGFJDLTYLNPZGYJYZYYQZPBXQBDZTZCZYXXYHHSQXSHDHGQHJHGYWSZTMZMLHYXGEBTYLZKQWYTJZRCLEKYSTDBCYKQQSAYXCJXWWGSBHJYZYDHCSJKQCXSWXFLTYNYZPZCCZJQTZWJQDZZZQZLJJXLSBHPYXXPSXSHHEZTXFPTLQYZZXHYTXNCFZYYHXGNXMYWXTZSJPTHHGYMXMXQZXTSBCZYJYXXTYYZYPCQLMMSZMJZZLLZXGXZAAJZYXJMZXWDXZSXZDZXLEYJJZQBHZWZZZQTZPSXZTDSXJJJZNYAZPHXYYSRNQDTHZHYYKYJHDZXZLSWCLYBZYECWCYCRYLCXNHZYDZYDYJDFRJJHTRSQTXYXJRJHOJYNXELXSFSFJZGHPZSXZSZDZCQZBYYKLSGSJHCZSHDGQGXYZGXCHXZJWYQWGYHKSSEQZZNDZFKWYSSTCLZSTSYMCDHJXXYWEYXCZAYDMPXMDSXYBSQMJMZJMTZQLPJYQZCGQHXJHHLXXHLHDLDJQCLDWBSXFZZYYSCHTYTYYBHECXHYKGJPXHHYZJFXHWHBDZFYZBCAPNPGNYDMSXHMMMMAMYNBYJTMPXYYMCTHJBZYFCGTYHWPHFTWZZEZSBZEGPFMTSKFTYCMHFLLHGPZJXZJGZJYXZSBBQSCZZLZCCSTPGXMJSFTCCZJZDJXCYBZLFCJSYZFGSZLYBCWZZBYZDZYPSWYJZXZBDSYUXLZZBZFYGCZXBZHZFTPBGZGEJBSTGKDMFHYZZJHZLLZZGJQZLSFDJSSCBZGPDLFZFZSZYZYZSYGCXSNXXCHCZXTZZLJFZGQSQYXZJQDCCZTQCDXZJYQJQCHXZTDLGSCXZSYQJQTZWLQDQZTQCHQQJZYEZZZPBWKDJFCJPZTYPQYQTTYNLMBDKTJZPQZQZZFPZSBNJLGYJDXJDZZKZGQKXDLPZJTCJDQBXDJQJSTCKNXBXZMSLYJCQMTJQWWCJQNJNLLLHJCWQTBZQYDZCZPZZDZYDDCYZZZCCJTTJFZDPRRTZTJDCQTQZDTJNPLZBCLLCTZSXKJZQZPZLBZRBTJDCXFCZDBCCJJLTQQPLDCGZDBBZJCQDCJWYNLLZYZCCDWLLXWZLXRXNTQQCZXKQLSGDFQTDDGLRLAJJTKUYMKQLLTZYTDYYCZGJWYXDXFRSKSTQTENQMRKQZHHQKDLDAZFKYPBGGPZREBZZYKZZSPEGJXGYKQZZZSLYSYYYZWFQZYLZZLZHWCHKYPQGNPGBLPLRRJYXCCSYYHSFZFYBZYYTGZXYLXCZWXXZJZBLFFLGSKHYJZEYJHLPLLLLCZGXDRZELRHGKLZZYHZLYQSZZJZQLJZFLNBHGWLCZCFJYSPYXZLZLXGCCPZBLLCYBBBBUBBCBPCRNNZCZYRBFSRLDCGQYYQXYGMQZWTZYTYJXYFWTEHZZJYWLCCNTZYJJZDEDPZDZTSYQJHDYMBJNYJZLXTSSTPHNDJXXBYXQTZQDDTJTDYYTGWSCSZQFLSHLGLBCZPHDLYZJYCKWTYTYLBNYTSDSYCCTYSZYYEBHEXHQDTWNYGYCLXTSZYSTQMYGZAZCCSZZDSLZCLZRQXYYELJSBYMXSXZTEMBBLLYYLLYTDQYSHYMRQWKFKBFXNXSBYCHXBWJYHTQBPBSBWDZYLKGZSKYHXQZJXHXJXGNLJKZLYYCDXLFYFGHLJGJYBXQLYBXQPQGZTZPLNCYPXDJYQYDYMRBESJYYHKXXSTMXRCZZYWXYQYBMCLLYZHQYZWQXDBXBZWZMSLPDMYSKFMZKLZCYQYCZLQXFZZYDQZPZYGYJYZMZXDZFYFYTTQTZHGSPCZMLCCYTZXJCYTJMKSLPZHYSNZLLYTPZCTZZCKTXDHXXTQCYFKSMQCCYYAZHTJPCYLZLYJBJXTPNYLJYYNRXSYLMMNXJSMYBCSYSYLZYLXJJQYLDZLPQBFZZBLFNDXQKCZFYWHGQMRDSXYCYTXNQQJZYYPFZXDYZFPRXEJDGYQBXRCNFYYQPGHYJDYZXGRHTKYLNWDZNTSMPKLBTHBPYSZBZTJZSZZJTYYXZPHSSZZBZCZPTQFZMYFLYPYBBJQXZMXXDJMTSYSKKBJZXHJCKLPSMKYJZCXTMLJYXRZZQSLXXQPYZXMKYXXXJCLJPRMYYGADYSKQLSNDHYZKQXZYZTCGHZTLMLWZYBWSYCTBHJHJFCWZTXWYTKZLXQSHLYJZJXTMPLPYCGLTBZZTLZJCYJGDTCLKLPLLQPJMZPAPXYZLKKTKDZCZZBNZDYDYQZJYJGMCTXLTGXSZLMLHBGLKFWNWZHDXUHLFMKYSLGXDTWWFRJEJZTZHYDXYKSHWFZCQSHKTMQQHTZHYMJDJSKHXZJZBZZXYMPAGQMSTPXLSKLZYNWRTSQLSZBPSPSGZWYHTLKSSSWHZZLYYTNXJGMJSZSUFWNLSOZTXGXLSAMMLBWLDSZYLAKQCQCTMYCFJBSLXCLZZCLXXKSBZQCLHJPSQPLSXXCKSLNHPSFQQYTXYJZLQLDXZQJZDYYDJNZPTUZDSKJFSLJHYLZSQZLBTXYDGTQFDBYAZXDZHZJNHHQBYKNXJJQCZMLLJZKSPLDYCLBBLXKLELXJLBQYCXJXGCNLCQPLZLZYJTZLJGYZDZPLTQCSXFDMNYCXGBTJDCZNBGBQYQJWGKFHTNPYQZQGBKPBBYZMTJDYTBLSQMPSXTBNPDXKLEMYYCJYNZCTLDYKZZXDDXHQSHDGMZSJYCCTAYRZLPYLTLKXSLZCGGEXCLFXLKJRTLQJAQZNCMBYDKKCXGLCZJZXJHPTDJJMZQYKQSECQZDSHHADMLZFMMZBGNTJNNLGBYJBRBTMLBYJDZXLCJLPLDLPCQDHLXZLYCBLCXZZJADJLNZMMSSSMYBHBSQKBHRSXXJMXSDZNZPXLGBRHWGGFCXGMSKLLTSJYYCQLTSKYWYYHYWXBXQYWPYWYKQLSQPTNTKHQCWDQKTWPXXHCPTHTWUMSSYHBWCRWXHJMKMZNGWTMLKFGHKJYLSYYCXWHYECLQHKQHTTQKHFZLDXQWYZYYDESBPKYRZPJFYYZJCEQDZZDLATZBBFJLLCXDLMJSSXEGYGSJQXCWBXSSZPDYZCXDNYXPPZYDLYJCZPLTXLSXYZYRXCYYYDYLWWNZSAHJSYQYHGYWWAXTJZDAXYSRLTDPSSYYFNEJDXYZHLXLLLZQZSJNYQYQQXYJGHZGZCYJCHZLYCDSHWSHJZYJXCLLNXZJJYYXNFXMWFPYLCYLLABWDDHWDXJMCXZTZPMLQZHSFHZYNZTLLDYWLSLXHYMMYLMBWWKYXYADTXYLLDJPYBPWUXJMWMLLSAFDLLYFLBHHHBQQLTZJCQJLDJTFFKMMMBYTHYGDCQRDDWRQJXNBYSNWZDBYYTBJHPYBYTTJXAAHGQDQTMYSTQXKBTZPKJLZRBEQQSSMJJBDJOTGTBXPGBKTLHQXJJJCTHXQDWJLWRFWQGWSHCKRYSWGFTGYGBXSDWDWRFHWYTJJXXXJYZYSLPYYYPAYXHYDQKXSHXYXGSKQHYWFDDDPPLCJLQQEEWXKSYYKDYPLTJTHKJLTCYYHHJTTPLTZZCDLTHQKZXQYSTEEYWYYZYXXYYSTTJKLLPZMCYHQGXYHSRMBXPLLNQYDQHXSXXWGDQBSHYLLPJJJTHYJKYPPTHYYKTYEZYENMDSHLCRPQFDGFXZPSFTLJXXJBSWYYSKSFLXLPPLBBBLBSFXFYZBSJSSYLPBBFFFFSSCJDSTZSXZRYYSYFFSYZYZBJTBCTSBSDHRTJJBYTCXYJEYLXCBNEBJDSYXYKGSJZBXBYTFZWGENYHHTHZHHXFWGCSTBGXKLSXYWMTMBYXJSTZSCDYQRCYTWXZFHMYMCXLZNSDJTTTXRYCFYJSBSDYERXJLJXBBDEYNJGHXGCKGSCYMBLXJMSZNSKGXFBNBPTHFJAAFXYXFPXMYPQDTZCXZZPXRSYWZDLYBBKTYQPQJPZYPZJZNJPZJLZZFYSBTTSLMPTZRTDXQSJEHBZYLZDHLJSQMLHTXTJECXSLZZSPKTLZKQQYFSYGYWPCPQFHQHYTQXZKRSGTTSQCZLPTXCDYYZXSQZSLXLZMYCPCQBZYXHBSXLZDLTCDXTYLZJYYZPZYZLTXJSJXHLPMYTXCQRBLZSSFJZZTNJYTXMYJHLHPPLCYXQJQQKZZSCPZKSWALQSBLCCZJSXGWWWYGYKTJBBZTDKHXHKGTGPBKQYSLPXPJCKBMLLXDZSTBKLGGQKQLSBKKTFXRMDKBFTPZFRTBBRFERQGXYJPZSSTLBZTPSZQZSJDHLJQLZBPMSMMSXLQQNHKNBLRDDNXXDHDDJCYYGYLXGZLXSYGMQQGKHBPMXYXLYTQWLWGCPBMQXCYZYDRJBHTDJYHQSHTMJSBYPLWHLZFFNYPMHXXHPLTBQPFBJWQDBYGPNZTPFZJGSDDTQSHZEAWZZYLLTYYBWJKXXGHLFKXDJTMSZSQYNZGGSWQSPHTLSSKMCLZXYSZQZXNCJDQGZDLFNYKLJCJLLZLMZZNHYDSSHTHZZLZZBBHQZWWYCRZHLYQQJBEYFXXXWHSRXWQHWPSLMSSKZTTYGYQQWRSLALHMJTQJSMXQBJJZJXZYZKXBYQXBJXSHZTSFJLXMXZXFGHKZSZGGYLCLSARJYHSLLLMZXELGLXYDJYTLFBHBPNLYZFBBHPTGJKWETZHKJJXZXXGLLJLSTGSHJJYQLQZFKCGNNDJSSZFDBCTWWSEQFHQJBSAQTGYPQLBXBMMYWXGSLZHGLZGQYFLZBYFZJFRYSFMBYZHQGFWZSYFYJJPHZBYYZFFWODGRLMFTWLBZGYCQXCDJYGZYYYYTYTYDWEGAZYHXJLZYYHLRMGRXXZCLHNELJJTJTPWJYBJJBXJJTJTEEKHWSLJPLPSFYZPQQBDLQJJTYYQLYZKDKSQJYYQZLDQTGJQYZJSUCMRYQTHTEJMFCTYHYPKMHYZWJDQFHYYXWSHCTXRLJHQXHCCYYYJLTKTTYTMXGTCJTZAYYOCZLYLBSZYWJYTSJYHBYSHFJLYGJXXTMZYYLTXXYPZLXYJZYZYYPNHMYMDYYLBLHLSYYQQLLNJJYMSOYQBZGDLYXYLCQYXTSZEGXHZGLHWBLJHEYXTWQMAKBPQCGYSHHEGQCMWYYWLJYJHYYZLLJJYLHZYHMGSLJLJXCJJYCLYCJPCPZJZJMMYLCQLNQLJQJSXYJMLSZLJQLYCMMHCFMMFPQQMFYLQMCFFQMMMMHMZNFHHJGTTHHKHSLNCHHYQDXTMMQDCYZYXYQMYQYLTDCYYYZAZZCYMZYDLZFFFMMYCQZWZZMABTBYZTDMNZZGGDFTYPCGQYTTSSFFWFDTZQSSYSTWXJHXYTSXXYLBYQHWWKXHZXWZNNZZJZJJQJCCCHYYXBZXZCYZTLLCQXYNJYCYYCYNZZQYYYEWYCZDCJYCCHYJLBTZYYCQWMPWPYMLGKDLDLGKQQBGYCHJXY";
        //此处收录了375个多音字,数据来自于http://www.51window.net/page/pinyin
        var oMultiDiff={"19969":"DZ","19975":"WM","19988":"QJ","20048":"YL","20056":"SC","20060":"NM","20094":"QG","20127":"QJ","20167":"QC","20193":"YG","20250":"KH","20256":"ZC","20282":"SC","20285":"QJG","20291":"TD","20314":"YD","20340":"NE","20375":"TD","20389":"YJ","20391":"CZ","20415":"PB","20446":"YS","20447":"SQ","20504":"TC","20608":"KG","20854":"QJ","20857":"ZC","20911":"PF","20504":"TC","20608":"KG","20854":"QJ","20857":"ZC","20911":"PF","20985":"AW","21032":"PB","21048":"XQ","21049":"SC","21089":"YS","21119":"JC","21242":"SB","21273":"SC","21305":"YP","21306":"QO","21330":"ZC","21333":"SDC","21345":"QK","21378":"CA","21397":"SC","21414":"XS","21442":"SC","21477":"JG","21480":"TD","21484":"ZS","21494":"YX","21505":"YX","21512":"HG","21523":"XH","21537":"PB","21542":"PF","21549":"KH","21571":"E","21574":"DA","21588":"TD","21589":"O","21618":"ZC","21621":"KHA","21632":"ZJ","21654":"KG","21679":"LKG","21683":"KH","21710":"A","21719":"YH","21734":"WOE","21769":"A","21780":"WN","21804":"XH","21834":"A","21899":"ZD","21903":"RN","21908":"WO","21939":"ZC","21956":"SA","21964":"YA","21970":"TD","22003":"A","22031":"JG","22040":"XS","22060":"ZC","22066":"ZC","22079":"MH","22129":"XJ","22179":"XA","22237":"NJ","22244":"TD","22280":"JQ","22300":"YH","22313":"XW","22331":"YQ","22343":"YJ","22351":"PH","22395":"DC","22412":"TD","22484":"PB","22500":"PB","22534":"ZD","22549":"DH","22561":"PB","22612":"TD","22771":"KQ","22831":"HB","22841":"JG","22855":"QJ","22865":"XQ","23013":"ML","23081":"WM","23487":"SX","23558":"QJ","23561":"YW","23586":"YW","23614":"YW","23615":"SN","23631":"PB","23646":"ZS","23663":"ZT","23673":"YG","23762":"TD","23769":"ZS","23780":"QJ","23884":"QK","24055":"XH","24113":"DC","24162":"ZC","24191":"GA","24273":"QJ","24324":"NL","24377":"TD","24378":"QJ","24439":"PF","24554":"ZS","24683":"TD","24694":"WE","24733":"LK","24925":"TN","25094":"ZG","25100":"XQ","25103":"XH","25153":"PB","25170":"PB","25179":"KG","25203":"PB","25240":"ZS","25282":"FB","25303":"NA","25324":"KG","25341":"ZY","25373":"WZ","25375":"XJ","25384":"A","25457":"A","25528":"SD","25530":"SC","25552":"TD","25774":"ZC","25874":"ZC","26044":"YW","26080":"WM","26292":"PB","26333":"PB","26355":"ZY","26366":"CZ","26397":"ZC","26399":"QJ","26415":"ZS","26451":"SB","26526":"ZC","26552":"JG","26561":"TD","26588":"JG","26597":"CZ","26629":"ZS","26638":"YL","26646":"XQ","26653":"KG","26657":"XJ","26727":"HG","26894":"ZC","26937":"ZS","26946":"ZC","26999":"KJ","27099":"KJ","27449":"YQ","27481":"XS","27542":"ZS","27663":"ZS","27748":"TS","27784":"SC","27788":"ZD","27795":"TD","27812":"O","27850":"PB","27852":"MB","27895":"SL","27898":"PL","27973":"QJ","27981":"KH","27986":"HX","27994":"XJ","28044":"YC","28065":"WG","28177":"SM","28267":"QJ","28291":"KH","28337":"ZQ","28463":"TL","28548":"DC","28601":"TD","28689":"PB","28805":"JG","28820":"QG","28846":"PB","28952":"TD","28975":"ZC","29100":"A","29325":"QJ","29575":"SL","29602":"FB","30010":"TD","30044":"CX","30058":"PF","30091":"YSP","30111":"YN","30229":"XJ","30427":"SC","30465":"SX","30631":"YQ","30655":"QJ","30684":"QJG","30707":"SD","30729":"XH","30796":"LG","30917":"PB","31074":"NM","31085":"JZ","31109":"SC","31181":"ZC","31192":"MLB","31293":"JQ","31400":"YX","31584":"YJ","31896":"ZN","31909":"ZY","31995":"XJ","32321":"PF","32327":"ZY","32418":"HG","32420":"XQ","32421":"HG","32438":"LG","32473":"GJ","32488":"TD","32521":"QJ","32527":"PB","32562":"ZSQ","32564":"JZ","32735":"ZD","32793":"PB","33071":"PF","33098":"XL","33100":"YA","33152":"PB","33261":"CX","33324":"BP","33333":"TD","33406":"YA","33426":"WM","33432":"PB","33445":"JG","33486":"ZN","33493":"TS","33507":"QJ","33540":"QJ","33544":"ZC","33564":"XQ","33617":"YT","33632":"QJ","33636":"XH","33637":"YX","33694":"WG","33705":"PF","33728":"YW","33882":"SR","34067":"WM","34074":"YW","34121":"QJ","34255":"ZC","34259":"XL","34425":"JH","34430":"XH","34485":"KH","34503":"YS","34532":"HG","34552":"XS","34558":"YE","34593":"ZL","34660":"YQ","34892":"XH","34928":"SC","34999":"QJ","35048":"PB","35059":"SC","35098":"ZC","35203":"TQ","35265":"JX","35299":"JX","35782":"SZ","35828":"YS","35830":"E","35843":"TD","35895":"YG","35977":"MH","36158":"JG","36228":"QJ","36426":"XQ","36466":"DC","36710":"JC","36711":"ZYG","36767":"PB","36866":"SK","36951":"YW","37034":"YX","37063":"XH","37218":"ZC","37325":"ZC","38063":"PB","38079":"TD","38085":"QY","38107":"DC","38116":"TD","38123":"YD","38224":"HG","38241":"XTC","38271":"ZC","38415":"YE","38426":"KH","38461":"YD","38463":"AE","38466":"PB","38477":"XJ","38518":"YT","38551":"WK","38585":"ZC","38704":"XS","38739":"LJ","38761":"GJ","38808":"SQ","39048":"JG","39049":"XJ","39052":"HG","39076":"CZ","39271":"XT","39534":"TD","39552":"TD","39584":"PB","39647":"SB","39730":"LG","39748":"TPB","40109":"ZQ","40479":"ND","40516":"HG","40536":"HG","40583":"QJ","40765":"YQ","40784":"QJ","40840":"YK","40863":"QJG"};
        //参数,中文字符串
        //返回值:拼音首字母串数组
        function makePy(str){
            if(typeof(str) != "string")
                throw new Error(-1,"函数makePy需要字符串类型参数!");
            var arrResult = new Array(); //保存中间结果的数组
            for(var i=0,len=str.length;i<len;i++){
                //获得unicode码
                var ch = str.charAt(i);
                //检查该unicode码是否在处理范围之内,在则返回该码对映汉字的拼音首字母,不在则调用其它函数处理
                arrResult.push(checkCh(ch));
            }
            //处理arrResult,返回所有可能的拼音首字母串数组
            return mkRslt(arrResult);
        }
        function checkCh(ch){
            var uni = ch.charCodeAt(0);
            //如果不在汉字处理范围之内,返回原字符,也可以调用自己的处理函数
            if(uni > 40869 || uni < 19968)
                return ch; //dealWithOthers(ch);
            //检查是否是多音字,是按多音字处理,不是就直接在strChineseFirstPY字符串中找对应的首字母
            return (oMultiDiff[uni]?oMultiDiff[uni]:(strChineseFirstPY.charAt(uni-19968)));
        }
        function mkRslt(arr){
            var arrRslt = [""];
            for(var i=0,len=arr.length;i<len;i++){
                var str = arr[i];
                var strlen = str.length;
                if(strlen == 1){
                    for(var k=0;k<arrRslt.length;k++){
                        arrRslt[k] += str;
                    }
                }else{
                    var tmpArr = arrRslt.slice(0);
                    arrRslt = [];
                    for(k=0;k<strlen;k++){
                        //复制一个相同的arrRslt
                        var tmp = tmpArr.slice(0);
                        //把当前字符str[k]添加到每个元素末尾
                        for(var j=0;j<tmp.length;j++){
                            tmp[j] += str.charAt(k);
                        }
                        //把复制并修改后的数组连接到arrRslt上
                        arrRslt = arrRslt.concat(tmp);
                    }
                }
            }
            return arrRslt;
        }
        // 清空内容, 则不过滤
        if (input == "")
            return true;

        var matched = false;
        input = input.toUpperCase();
        // 先判断显示值
        var opts = $(this).combobox('options');

        if(row[opts.textField].toUpperCase().match(input) != null) {
            return true;
        } else {
            // 优先用top里共享的拼音检索函数(避免每个页面都加载拼音js)
            var pinyin = makePy(row[opts.textField]);
            $.each(pinyin, function(idx, pinyinItem) {
                exp = input.toUpperCase().split("").join(".*");
                if(pinyinItem.match(exp) != null) {
                    matched = true;
                    return false;
                }
            });
            return matched;
        }

        // 默认不过滤
        return true;
    },
    onHidePanel : function () {
        var el = $(this);
        el.combobox('textbox').focus();

        // 检查录入内容是否在数据里
        var opts = el.combobox("options");
        var data = el.combobox("getData");
        var value = el.combobox("getValue");

        // 有高亮选中的项目, 则不进一步处理
        var panel = el.combobox("panel");
        var items = panel.find(".combobox-item-selected");
        if (items.length > 0) {
            var values = el.combobox("getValues");
            el.combobox("setValues", values);
            return;
        }

        var allowInput = opts.allowInput;
        if (allowInput) {
            // 允许录入, 并且当前下拉没内容(过滤掉了), 则加入下拉列表里
            var idx = data.length;

            data[idx] = [];
            data[idx][opts.textField] = value;
            data[idx][opts.valueField] = value;

            el.combobox("loadData", data);
        } else {
            // 不允许录入任意项, 则清空
            el.combobox("clear");
        }
    }
});
$.extend($.fn.combobox.defaults.keyHandler, {
    query : function (q, evt) {
        var target = this;
        var el = $(this);

        var state = $.data(target, 'combobox');
        var opts = state.options;

        if (opts.mode == 'remote') {

        } else {
            var panel = el.combo('panel');
            panel.find('div.combobox-item-selected,div.combobox-item-hover').removeClass('combobox-item-selected combobox-item-hover');
            panel.find('div.combobox-item,div.combobox-group').hide();
            var data = opts.data;
            var vv = [];
            var qq = opts.multiple ? q.split(opts.separator) : [ q ];
            $.map(qq, function(q) {
                q = $.trim(q);
                for (var i = 0; i < data.length; i++) {
                    var row = data[i];
                    if (opts.filter.call(el, q, row)) {
                        var v = row[opts.valueField];
                        var s = row[opts.textField];
                        var g = row[opts.groupField];
                        var item = opts.finder.getEl(target, v).show();
                        vv.push(v);
                    }
                }
            });

            // 默认高亮第一项
            if (vv.length > 0 && q) {
                var v = vv[0];
                var item = opts.finder.getEl(target, v);
                item.addClass('combobox-item-selected');
            }
        }
    },
    enter: function(e) {
        var enterSeq = $(this).attr("enterSeq");
        if(enterSeq == undefined && $(this).combo("panel").parent().css("display") == "none") {
            enterSeq = 1;
            $(this).combobox('showPanel');
        } else {
            //校验通过
            $(this).combobox('selectedIndex');
        }
    }
});
$.extend($.fn.combobox.methods, {
    selectedIndex: function (jq, index) {
        function getSelectedOptionIndex() {
            var option = $("div.combo-p:visible>div");
            var options = option.find("div.combobox-item");
            var firstVisible = option.find("div.combobox-item-selected");
            var index = options.index(firstVisible);
            return index;
        }
        if (!index) {
            index = getSelectedOptionIndex();
        }
        if(index != -1) {
            $(jq).combobox({
                onLoadSuccess: function () {
                    var opt = $(jq).combobox('options');
                    var data = $(jq).combobox('getData');
                    for (var i = 0; i < data.length; i++) {
                        if (i == index) {
                            $(jq).combobox('select', data[index][opt.valueField]);
                            break;
                        }
                    }

                    $(jq).combobox('validate');
                    if($(jq).combobox('isValid')) {
                        $(jq).combobox('hidePanel');
                        $(this).removeAttr("enterSeq");
                        $.easyuiExtendObj.focusNext($(jq));
                    } else {
                        $(jq).next().find("input.textbox-prompt").focus();
                    }
                }
            });
        }
    },
    getFirstVisibleOptionIndex:function () {
        var option = $("div.combo-p:visible>div");
        var options = option.find("div.combobox-item");
        var firstVisible = option.find("div.combobox-item:visible:first");
        var index = options.index(firstVisible);
        return index;
    }
});

/**
 * EasyUi DataGrid 扩展
 */
$.extend($.fn.datagrid.methods, {
    /**
     * Datagrid动态设置列标题的的扩展方法
     *     $("#dt").datagrid("setColumnTitle",{field:'productid',text:'newTitle});
     */
    setColumnTitle: function(jq, option){
        if(option.field){
            return jq.each(function(){
                var $panel = $(this).datagrid("getPanel");
                var $field = $('td[field='+option.field+']',$panel);
                if($field.length){
                    var $span = $("span",$field).eq(0);
                    $span.html(option.text);
                }
            });
        }
        return jq;
    },
    /**
     * Datagrid根据给定参数选择行，param是JSON对象，内容是字段名称、字段值
     *     $("#dt").datagrid("selectRowByParam",{'filedName':'aaaa','filedValue':'vvvv'});
     */
    selectRowByParam:function(jq, param){
        var rows=$(jq).datagrid("getRows");
        var row=null;
        for(var i=0;i<rows.length;i++){
            if(rows[i][param.filedName]==param.filedValue){
                row=i;
                break;
            }
        }
        if(row!=null){
            $(jq).datagrid("selectRow",i);
        }else{
            $(jq).datagrid("unselectAll");
        }
    },
    /**
     * Datagrid根据给定已经选定的行，重新定位到上一行并返回行，如果当前未选择任何行，自动定位到第一行
     *     $("#dt").datagrid("selectPreviousRow");
     */
    selectPreviousRow:function(jq){
        var row =  $(jq).datagrid('getSelected');
        var rowIndex = $(jq).datagrid('getRowIndex', row);
        if(rowIndex > 0) {
            $(jq).datagrid('unselectAll').datagrid('selectRow', rowIndex - 1);
        }else if(rowIndex==-1){
            $(jq).datagrid('unselectAll').datagrid('selectRow', 0);
            return $(jq).datagrid('getSelected');
        }else{
            $.messager.show({
                title : '提示',
                msg : "已经是第一条记录！"
            });
        }
        return $(jq).datagrid('getSelected');
    },
    /**
     * Datagrid根据给定已经选定的行，重新定位到下一行并返回行，如果当前未选择任何行，自动定位到最后一行
     *     $("#dt").datagrid("selectNextRow");
     */
    selectNextRow:function(jq){
        var row =  $(jq).datagrid('getSelected');
        var rowIndex = $(jq).datagrid('getRowIndex', row);
        if(rowIndex < $(jq).datagrid('getRows').length - 1 && rowIndex>=0) {
            $(jq).datagrid('unselectAll').datagrid('selectRow', rowIndex + 1);
        }else if(rowIndex==-1){
            $(jq).datagrid('unselectAll').datagrid('selectRow', $(jq).datagrid('getRows').length - 1);
            return $(jq).datagrid('getSelected');
        }else{
            $.messager.show({
                title : '提示',
                msg : "已经是最后一条记录！"
            });
        }
        return $(jq).datagrid('getSelected');
    },
    /**
     * Datagrid直接定位到第一行并返回行
     *     $("#dt").datagrid("selectFirstRow");
     */
    selectFirstRow:function(jq){
        $(jq).datagrid('unselectAll').datagrid('selectRow', 0);
        return $(jq).datagrid('getSelected');
    },
    /**
     * Datagrid直接定位到最后一行并返回行
     *     $("#dt").datagrid("selectLastRow");
     */
    selectLastRow:function(jq){
        $(jq).datagrid('unselectAll').datagrid('selectRow', $(jq).datagrid('getRows').length - 1);
        return $(jq).datagrid('getSelected');
    },
    /**
     * 开打提示功能
     * @param {} jq
     * @param {} params 提示消息框的样式
     * @return {}
     */
    doCellTip : function(jq, params) {
        function showTip(data, td, e) {
            if ($(td).text() == "")
                return;
            data.tooltip.text($(td).text()).css({
                top : (e.pageY + 10) + 'px',
                left : (e.pageX + 20) + 'px',
                'z-index' : $.fn.window.defaults.zIndex,
                display : 'block'
            });
        }
        return jq.each(function() {
            var grid = $(this);
            var options = $(this).data('datagrid');
            if (!options.tooltip) {
                var panel = grid.datagrid('getPanel').panel('panel');
                var defaultCls = {
                    'border' : '1px solid #333',
                    'padding' : '1px',
                    'color' : '#333',
                    'background' : '#f7f5d1',
                    'position' : 'absolute',
                    //'max-width' : '200px',
                    'border-radius' : '4px',
                    '-moz-border-radius' : '4px',
                    '-webkit-border-radius' : '4px',
                    'display' : 'none'
                };
                var tooltip = $("<div id='celltip'></div>").appendTo('body');
                tooltip.css($.extend({}, defaultCls, params.cls));
                options.tooltip = tooltip;
                panel.find('.datagrid-body').each(function() {
                    var delegateEle = $(this).find('> div.datagrid-body-inner').length? $(this).find('> div.datagrid-body-inner')[0]: this;
                    $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td', {
                        'mouseover' : function(e) {
                            if (params.delay) {
                                if (options.tipDelayTime)
                                    clearTimeout(options.tipDelayTime);
                                var that = this;
                                options.tipDelayTime = setTimeout(
                                    function() {
                                        showTip(options, that, e);
                                    }, params.delay);
                            } else {
                                showTip(options, this, e);
                            }

                        },
                        'mouseout' : function(e) {
                            if (options.tipDelayTime)
                                clearTimeout(options.tipDelayTime);
                            options.tooltip.css({
                                'display' : 'none'
                            });
                        },
                        'mousemove' : function(e) {
                            var that = this;
                            if (options.tipDelayTime) {
                                clearTimeout(options.tipDelayTime);
                                options.tipDelayTime = setTimeout(
                                    function() {
                                        showTip(options, that, e);
                                    }, params.delay);
                            } else {
                                showTip(options, that, e);
                            }
                        }
                    });
                });
            }
        });
    },
    /**
     * 关闭消息提示功能
     * @param {} jq
     * @return {}
     */
    cancelCellTip : function(jq) {
        return jq.each(function() {
            var data = $(this).data('datagrid');
            if (data.tooltip) {
                data.tooltip.remove();
                data.tooltip = null;
                var panel = $(this).datagrid('getPanel').panel('panel');
                panel.find('.datagrid-body').undelegate('td',
                    'mouseover').undelegate('td', 'mouseout')
                    .undelegate('td', 'mousemove')
            }
            if (data.tipDelayTime) {
                clearTimeout(data.tipDelayTime);
                data.tipDelayTime = null;
            }
        });
    },
    /**
     * 相同连续列合并扩展
     */
    autoMergeCells : function(jq, fields) {
        return jq.each(function() {
            var target = $(this);
            if (!fields) {
                fields = target.datagrid("getColumnFields");
            }
            var rows = target.datagrid("getRows");
            var i = 0, j = 0, temp = {};
            for (i; i < rows.length; i++) {
                var row = rows[i];
                j = 0;
                for (j; j < fields.length; j++) {
                    var field = fields[j];
                    var tf = temp[field];
                    if (!tf) {
                        tf = temp[field] = {};
                        tf[row[field]] = [i];
                    } else {
                        var tfv = tf[row[field]];
                        if (tfv) {
                            tfv.push(i);
                        } else {
                            tfv = tf[row[field]] = [i];
                        }
                    }
                }
            }
            $.each(temp, function(field, colunm) {
                $.each(colunm, function() {
                    var group = this;
                    if (group.length > 1) {
                        var before, after, megerIndex = group[0];
                        for (var i = 0; i < group.length; i++) {
                            before = group[i];
                            after = group[i + 1];
                            if (after && (after - before) == 1) {
                                continue;
                            }
                            var rowspan = before - megerIndex + 1;
                            if (rowspan > 1) {
                                target.datagrid('mergeCells', {
                                    index : megerIndex,
                                    field : field,
                                    rowspan : rowspan
                                });
                            }
                            if (after && (after - before) != 1) {
                                megerIndex = after;
                            }
                        }
                    }
                });
            });
        });
    },
    /**
     * 统计当前页信息
     * @param jq
     */
    statistics: function (jq,field) {
        var opt=$(jq).datagrid('options').columns;
        var rows = $(jq).datagrid("getRows");

        var footer = {};
        footer['sum'] =0.00;
        footer['avg'] =0.00;
        footer['max'] =0.00;
        footer['min'] =0.00;

        for(var i=0; i<opt[0].length; i++){
            if(opt[0][i].field==field){
                footer['sum'] = sum(opt[0][i].field);
                footer['avg'] = avg(opt[0][i].field);
                footer['max'] = max(opt[0][i].field);
                footer['min'] = min(opt[0][i].field);
                break;
            }
        }

        var footerObj = new Array();

        if(footer['sum'] != ""){
            footerObj.push({"name":field+"当页合计","salary":footer['sum']});
        }

        if(footer['avg'] != ""){
            footerObj.push({"name":field+"当页平均值","salary":footer['avg']});
        }

        if(footer['max'] != ""){
            footerObj.push({"name":field+"当页最大值","salary":footer['max']});
        }

        if(footer['min'] != ""){
            footerObj.push({"name":field+"当页最小值","salary":footer['min']});
        };

        console.log(footerObj);
        if(footerObj.length > 0){
            $(jq).datagrid('reloadFooter',footerObj);
        }

        function sum(filed){
            var sumNum = 0;
            for(var i=0;i<rows.length;i++){
                sumNum += Number(rows[i][filed]);
            }
            return sumNum.toFixed(2);
        }

        function avg(filed){
            var sumNum = 0;
            for(var i=0;i<rows.length;i++){
                sumNum += Number(rows[i][filed]);
            }
            return (sumNum/rows.length).toFixed(2);
        }

        function max(filed){
            var maxValue = 0;
            for(var i=0;i<rows.length;i++){
                if(i==0){
                    maxValue = Number(rows[i][filed]);
                }else{
                    maxValue = Math.max(maxValue,Number(rows[i][filed]));
                }
            }
            return maxValue.toFixed(2) ;
        }

        function min(filed){
            var minValue = 0;
            for(var i=0;i<rows.length;i++){
                if(i==0){
                    minValue = Number(rows[i][filed]);
                }else{
                    minValue = Math.min(minValue,Number(rows[i][filed]));
                }
            }
            return minValue.toFixed(2);
        }
    },
    /**
     * 更新 非编辑列值
     * @param rowIndex    : 行索引
     * @param cellName    : 列索引或列名
     * @param cellValue    : 列值
     */
    updateRowCell : function(jq, param) {
        var oGrid = $(jq);
        oGrid.datagrid('updateRow', {
            index : param.rowIndex,
            row : param.row
        });
    }
});

/**
 * datagrid行内编辑时为datetimebox
 * 使用方法：
 <th field="datetime" width="150" editor="datetimebox">datetime</th>
 或者:
 在配置里面
 {
 field:"dataTime",
 editor:"datetimebox"
 }
 */
$.extend($.fn.datagrid.defaults.editors, {
    datetimebox: {// datetimebox就是你要自定义editor的名称
        init: function (container, options) {
            var input = $('<input class="easyuidatetimebox">').appendTo(container);
            return input.datetimebox({
                formatter: function (date) {
                    return new Date(date).format("yyyy-MM-dd hh:mm:ss");
                }
            });
        },
        getValue: function (target) {
            return $(target).parent().find('input.combo-value').val();
        },
        setValue: function (target, value) {
            $(target).datetimebox("setValue", value);
        },
        resize: function (target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else {
                input.width(width);
            }
        }
    }
});

/**
 * treegrid 扩展
 * 扩展树表格级联勾选方法：
 * @param {Object} container
 * @param {Object} options
 * @return {TypeName}
 */
$.extend($.fn.treegrid.methods,{
    /**
     * 级联选择
     * @param {Object} target
     * @param {Object} param
     *      param包括两个参数:
     *          id:勾选的节点ID
     *          deepCascade:是否深度级联
     * @return {TypeName}
     */
    cascadeCheck : function(target,param){
        var opts = $.data(target[0], "treegrid").options;
        if(opts.singleSelect)
            return;
        var idField = opts.idField;//这里的idField其实就是API里方法的id参数
        var status = false;//用来标记当前节点的状态，true:勾选，false:未勾选
        var selectNodes = $(target).treegrid('getSelections');//获取当前选中项
        for(var i=0;i<selectNodes.length;i++){
            if(selectNodes[i][idField]==param.id)
                status = true;
        }
        //级联选择父节点
        selectParent(target[0],param.id,idField,status);
        selectChildren(target[0],param.id,idField,param.deepCascade,status);
        /**
         * 级联选择父节点
         * @param {Object} target
         * @param {Object} id 节点ID
         * @param {Object} status 节点状态，true:勾选，false:未勾选
         * @return {TypeName}
         */
        function selectParent(target,id,idField,status){
            var parent = $(target).treegrid('getParent',id);
            if(parent){
                var parentId = parent[idField];
                if(status)
                    $(target).treegrid('select',parentId);
                else
                    $(target).treegrid('unselect',parentId);
                selectParent(target,parentId,idField,status);
            }
        }
        /**
         * 级联选择子节点
         * @param {Object} target
         * @param {Object} id 节点ID
         * @param {Object} deepCascade 是否深度级联
         * @param {Object} status 节点状态，true:勾选，false:未勾选
         * @return {TypeName}
         */
        function selectChildren(target,id,idField,deepCascade,status){
            //深度级联时先展开节点
            if(!status&&deepCascade)
                $(target).treegrid('expand',id);
            //根据ID获取下层孩子节点
            var children = $(target).treegrid('getChildren',id);
            for(var i=0;i<children.length;i++){
                var childId = children[i][idField];
                if(status)
                    $(target).treegrid('select',childId);
                else
                    $(target).treegrid('unselect',childId);
                selectChildren(target,childId,idField,deepCascade,status);//递归选择子节点
            }
        }
    },
    /**
     * 根据给定已经选定的行，重新定位到上一行并返回行，如果当前未选择任何行，自动定位到第一行
     *     $("#dt").treegrid("selectPreviousRow");
     */
    selectPreviousRow:function(jq){
        var data=$(jq).treegrid('getData');
        var options=$(jq).treegrid("options");
        var id=$(jq).treegrid("getSelected")[options.idField];
        var rowIndex = $.easyuiExtendObj.arrayLocate(data,{"idFieldName":options.idField,"idFieldValue":id}).index;

        if(rowIndex > 0) {
            $(jq).treegrid('unselectAll').treegrid('select', data[rowIndex - 1][options.idField]);
            return $(jq).treegrid('getSelected');
        }else if(rowIndex==-1){
            $(jq).treegrid('unselectAll').treegrid('selectRow', 0);
            return $(jq).treegrid('getSelected');
        }else{
            $.messager.show({
                title : '提示',
                msg : "已经是第一条记录！"
            });
            return $(jq).treegrid('getSelected');
        }

    },
    /**
     * 根据给定已经选定的行，重新定位到下一行并返回行，如果当前未选择任何行，自动定位到最后一行
     *     $("#dt").treegrid("selectNextRow");
     */
    selectNextRow:function(jq){
        var data=$(jq).treegrid('getData');
        var options=$(jq).treegrid("options");
        var id=$(jq).treegrid("getSelected")[options.idField];
        var rowIndex = $.easyuiExtendObj.arrayLocate(data,{"idFieldName":options.idField,"idFieldValue":id}).index;

        if(rowIndex < data.length - 1 && rowIndex>=0) {
            $(jq).treegrid('unselectAll').treegrid('select', data[rowIndex + 1][options.idField]);
        }else if(rowIndex==-1){
            $(jq).treegrid('unselectAll').treegrid('select', data[data.length - 1][options.idField]);
            return $(jq).datagrid('getSelected');
        }else{
            $.messager.show({
                title : '提示',
                msg : "已经是最后一条记录！"
            });
        }
        return $(jq).treegrid('getSelected');
    },
    /**
     * 直接定位到第一行并返回行
     *     $("#dt").treegrid("selectFirstRow");
     */
    selectFirstRow:function(jq){
        $(jq).treegrid('unselectAll').treegrid('select', $(jq).treegrid("getData")[0][$(jq).treegrid('options').idField]);
        return $(jq).treegrid('getSelected');
    },
    /**
     * 直接定位到最后一行并返回行
     *     $("#dt").treegrid("selectLastRow");
     */
    selectLastRow:function(jq){
        var data=$(jq).treegrid("getData");
        $(jq).treegrid('unselectAll').treegrid('select', data[data.length-1][$(jq).treegrid('options').idField]);
        return $(jq).treegrid('getSelected');
    }
});

/**
 * 扩展树表格级联选择（点击checkbox才生效）：
 *      自定义两个属性：
 *      cascadeCheck ：普通级联（不包括未加载的子节点）
 *      deepCascadeCheck ：深度级联（包括未加载的子节点）
 */
$.extend($.fn.treegrid.defaults,{
    onLoadSuccess : function() {
        var target = $(this);
        var opts = $.data(this, "treegrid").options;
        var panel = $(this).datagrid("getPanel");
        var gridBody = panel.find("div.datagrid-body");
        var idField = opts.idField;//这里的idField其实就是API里方法的id参数
        gridBody.find("div.datagrid-cell-check input[type=checkbox]").unbind(".treegrid").click(function(e){
            if(opts.singleSelect) return;//单选不管
            if(opts.cascadeCheck||opts.deepCascadeCheck){
                var id=$(this).parent().parent().parent().attr("node-id");
                var status = false;
                if($(this).attr("checked")) status = true;
                //级联选择父节点
                selectParent(target,id,idField,status);
                selectChildren(target,id,idField,opts.deepCascadeCheck,status);
                /**
                 * 级联选择父节点
                 * @param {Object} target
                 * @param {Object} id 节点ID
                 * @param {Object} status 节点状态，true:勾选，false:未勾选
                 * @return {TypeName}
                 */
                function selectParent(target,id,idField,status){
                    var parent = target.treegrid('getParent',id);
                    if(parent){
                        var parentId = parent[idField];
                        if(status)
                            target.treegrid('select',parentId);
                        else
                            target.treegrid('unselect',parentId);
                        selectParent(target,parentId,idField,status);
                    }
                }
                /**
                 * 级联选择子节点
                 * @param {Object} target
                 * @param {Object} id 节点ID
                 * @param {Object} deepCascade 是否深度级联
                 * @param {Object} status 节点状态，true:勾选，false:未勾选
                 * @return {TypeName}
                 */
                function selectChildren(target,id,idField,deepCascade,status){
                    //深度级联时先展开节点
                    if(status&&deepCascade)
                        target.treegrid('expand',id);
                    //根据ID获取下层孩子节点
                    var children = target.treegrid('getChildren',id);
                    for(var i=0;i<children.length;i++){
                        var childId = children[i][idField];
                        if(status)
                            target.treegrid('select',childId);
                        else
                            target.treegrid('unselect',childId);
                        selectChildren(target,childId,idField,deepCascade,status);//递归选择子节点
                    }
                }
            }
            e.stopPropagation();//停止事件传播
        });
    }
});

/**
 * EasyUi DateBox 扩展
 */
$.extend($.fn.datebox.defaults,{
    inputEvents:{
        keydown: function (e) {
            /**
             判断日期格式是否正确
             返回值是错误信息, 无错误信息即表示合法日期字符串
             */
            function isDateString(strDate){
                var strSeparator = "-"; //日期分隔符
                var strDateArray;
                var intYear;
                var intMonth;
                var intDay;
                var boolLeapYear;
                var ErrorMsg = ""; //出错信息
                strDateArray = strDate.split(strSeparator);
                //没有判断长度,其实2008-8-8也是合理的//strDate.length != 10 ||
                if(strDateArray.length != 3) {
                    ErrorMsg += "日期格式必须为: yyyy-MM-dd";
                    return ErrorMsg;
                }
                intYear = parseInt(strDateArray[0],10);
                intMonth = parseInt(strDateArray[1],10);
                intDay = parseInt(strDateArray[2],10);
                if(isNaN(intYear)||isNaN(intMonth)||isNaN(intDay)) {
                    ErrorMsg += "日期格式错误: 年月日必须为纯数字";
                    return ErrorMsg;
                }
                if(intMonth>12 || intMonth<1) {
                    ErrorMsg += "日期格式错误: 月份必须介于1和12之间";
                    return ErrorMsg;
                }
                if((intMonth==1||intMonth==3||intMonth==5||intMonth==7
                    ||intMonth==8||intMonth==10||intMonth==12)
                    &&(intDay>31||intDay<1)) {
                    ErrorMsg += "日期格式错误: 大月的天数必须介于1到31之间";
                    return ErrorMsg;
                }
                if((intMonth==4||intMonth==6||intMonth==9||intMonth==11)
                    &&(intDay>30||intDay<1)) {
                    ErrorMsg += "日期格式错误: 小月的天数必须介于1到31之间";
                    return ErrorMsg;
                }
                if(intMonth==2){
                    if(intDay < 1) {
                        ErrorMsg += "日期格式错误: 日期必须大于或等于1";
                        return ErrorMsg;
                    }
                    boolLeapYear = false;
                    if((intYear%100) == 0){
                        if((intYear%400) == 0)
                            boolLeapYear = true;
                    }
                    else{
                        if((intYear % 4) == 0)
                            boolLeapYear = true;
                    }
                    if(boolLeapYear){
                        if(intDay > 29) {
                            ErrorMsg += "日期格式错误: 闰年的2月份天数不能超过29";
                            return ErrorMsg;
                        }
                    } else {
                        if(intDay > 28) {
                            ErrorMsg += "日期格式错误: 非闰年的2月份天数不能超过28";
                            return ErrorMsg;
                        }
                    }
                }
                return ErrorMsg;
            };
            if (e.keyCode == 13) {
                var curr = $(this).parent().prev();
                curr.textbox('setValue', $(this).val());
                var errMsg=isDateString($(this).val());
                if (curr.textbox('isValid') && errMsg=="") {
                    $.easyuiExtendObj.focusNext(curr);
                } else {
                    $.messager.show({
                        title: '提示',
                        msg: "内容不正确，未通过验证！"+errMsg,
                        showType: 'show',
                        timeout: 5000
                    });
                }
            } else {
                var validType = $(this).parent().prev().textbox("options").validType;
                var type = null;
                if (null == validType || validType.indexOf('yyyyMMdd') != -1) {
                    type = 'yyyyMMdd';
                } else if (validType.indexOf('yyyyMM') != -1) {
                    type = 'yyyyMM';
                }

                if (null != type && e.keyCode != 8) {
                    var val = $(this).val();
                    if (val.length == 4 || (val.length == 7 && type == 'yyyyMMdd')) {
                        $(this).val(val + "-");
                    } else if (val.length == 7 || val.length == 10) {
                        return false;
                    }
                }
            }
        }
    }
});

/**
 * EasyUi numberbox 扩展
 */
$.extend( $.fn.numberbox.defaults, {
    inputEvents: {
        blur:function(e){
            var t=e.data.target;
            $(t).numberbox("setValue",$(t).numberbox("getText"));
        },
        keydown: function (e) {
            if (e.keyCode == 13) {
                var curr = $(this).parent().prev();
                curr.numberbox('setValue', $(this).val());
                if (curr.numberbox('isValid')) {
                    $.easyuiExtendObj.focusNext(curr);
                } else {
                    $.messager.show({
                        title: '提示',
                        msg: "内容不正确，未通过验证！",
                        showType: 'show',
                        timeout: 5000
                    });
                }
            }
        }
    }
});

/**
 * EasyUi TextBox 扩展
 */
$.extend( $.fn.textbox.defaults, {
    inputEvents: {
        blur: function (e) {
            var t = $(e.data.target);
            var opts = t.textbox("options");
            t.textbox("setValue",opts.value);
        },
        keydown: function (e) {
            var t = $(e.data.target);
            if (e.keyCode == 13) {
                if (t.textbox("options").validType != null) {
                    t.textbox("setValue", t.textbox("getText"));
                    if (t.textbox("isValid")) {
                        $.easyuiExtendObj.focusNext(t);
                    } else {
                        $.messager.show({
                            title: '提示',
                            msg: "内容不正确，未通过验证！",
                            showType: 'show',
                            timeout: 5000
                        });
                    }
                } else {
                    t.textbox("setValue", t.textbox("getText"));
                    $.easyuiExtendObj.focusNext(t);
                }
            }
        }
    },
    /**
     * 验证扩展
     * 用法 data-options="validType:'time'"
     */
    rules: {
        time: {
            validator: function (value) {
                var a = value.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/);
                if (a == null) {
                    return false;
                } else if (a[1] > 24 || a[3] > 60 || a[4] > 60) {
                    return false;
                }
            },
            message: '时间格式不正确，请重新输入。格式HH24:MI:SS'
        },
        date: {
            validator: function (value) {
                var r = value.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
                if (r == null) {
                    return false;
                }
                var d = new Date(r[1], r[3] - 1, r[4]);
                return (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[4]);
            },
            message: '日期格式不正确，请重新输入。格式YYYY-MM-DD'
        },
        datetime: {
            validator: function (value) {
                var r = value.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
                if (r == null) return false;
                var d = new Date(r[1], r[3] - 1, r[4], r[5], r[6], r[7]);
                return (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[4] && d.getHours() == r[5] && d.getMinutes() == r[6] && d.getSeconds() == r[7]);
            },
            message: '日期时间格式不正确，请重新输入。'
        },
        idCard: {// 验证身份证
            validator: function (value) {
                /**
                 * 身份证号验证
                 * @param cardid
                 * @returns {boolean}
                 */
                function isIdCard(cardid) {
                    //日期转字符串 返回日期格式YYYYMMDD
                    function dateToString(date) {
                        if (date instanceof Date) {
                            var year = date.getFullYear();
                            var month = date.getMonth() + 1;
                            month = month < 10 ? '0' + month: month;
                            var day = date.getDate();
                            day = day < 10 ? '0' + day: day;
                            return year + month + day;
                        }
                        return '';
                    }
                    //身份证正则表达式(18位)
                    var isIdCard2 = /^[1-9]\d{5}(19\d{2}|[2-9]\d{3})((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])(\d{4}|\d{3}X)$/i;
                    var stard = "10X98765432"; //最后一位身份证的号码
                    var first = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]; //1-17系数
                    var sum = 0;
                    if (!isIdCard2.test(cardid)) {
                        return false;
                    }
                    var year = cardid.substr(6, 4);
                    var month = cardid.substr(10, 2);
                    var day = cardid.substr(12, 2);
                    var birthday = cardid.substr(6, 8);
                    if (birthday != dateToString(new Date(year + '/' + month + '/' + day))) { //校验日期是否合法
                        return false;
                    }
                    for (var i = 0; i < cardid.length - 1; i++) {
                        sum += cardid[i] * first[i];
                    }
                    var result = sum % 11;
                    var last = stard[result]; //计算出来的最后一位身份证号码
                    if (cardid[cardid.length - 1].toUpperCase() == last) {
                        return true;
                    } else {
                        return false;
                    }
                }
                return isIdCard(value);
            },
            message: '身份证号码格式不正确'
        },
        minLength: {
            validator: function (value, param) {
                return value.length >= param[0];
            },
            message: '请输入至少{0}个字符.'
        },
        maxLength: {
            validator: function (value, param) {
                var len = $.trim(value).length;
                return len >= param[0] && len <= param[1];
            },
            message: "输入内容长度必须介于{0}和{1}之间."
        },
        phone: {// 验证电话号码
            validator: function (value) {
                return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message: '格式不正确,请使用下面格式:0411-88888888'
        },
        mobile: {// 验证手机号码
            validator: function (value) {
                return /^(13|15|18)\d{9}$/i.test(value);
            },
            message: '手机号码格式不正确'
        },
        intOrFloat: {// 验证整数或小数
            validator: function (value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '请输入数字，并确保格式正确'
        },
        currency: {// 验证货币
            validator: function (value) {
                return /^\d+(\.\d{2})$/i.test(value.replace(',', ''));
            },
            message: '货币格式不正确'
        },
        integer: {// 验证整数 可正负数
            validator: function (value) {
                return /^([+]?[0-9])|([-]?[0-9])+\d*$/i.test(value);
            },
            message: '请输入整数'
        },
        age: {// 验证年龄
            validator: function (value) {
                return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
            },
            message: '年龄必须是0到120之间的整数'
        },
        chinese : {// 验证中文
            validator : function(value) {
                return /^[\u0391-\uFFE5]+$/i.test(value);
            },
            message : '请输入中文'
        },
        chineseAndLength : {// 验证中文及长度
            validator : function(value) {
                var len = $.trim(value).length;
                if (len >= param[0] && len <= param[1]) {
                    return /^[\u0391-\uFFE5]+$/i.test(value);
                }
            },
            message : '请输入中文'
        },
        english: {// 验证英语
            validator: function (value) {
                return /^[A-Za-z]+$/i.test(value);
            },
            message: '请输入英文'
        },
        englishAndLength : {// 验证英语及长度
            validator : function(value, param) {
                var len = $.trim(value).length;
                if (len >= param[0] && len <= param[1]) {
                    return /^[A-Za-z]+$/i.test(value);
                }
            },
            message : '请输入英文'
        },
        englishUpperCase : {// 验证英语大写
            validator : function(value) {
                return /^[A-Z]+$/.test(value);
            },
            message : '请输入大写英文'
        },
        unNormal: {// 验证是否包含空格和非法字符
            validator: function (value) {
                return /.+/i.test(value);
            },
            message: '输入值不能为空和包含其他非法字符'
        },
        userId: {// 验证用户名
            validator: function (value) {
                return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
            },
            message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
        },
        faxNo: {// 验证传真
            validator: function (value) {
                //            return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);
                return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message: '传真号码不正确'
        },
        zip: {// 验证邮政编码
            validator: function (value) {
                return /^[1-9]\d{5}$/i.test(value);
            },
            message: '邮政编码格式不正确'
        },
        ip: {// 验证IP地址
            validator: function (value) {
                return /d+.d+.d+.d+/i.test(value);
            },
            message: 'IP地址格式不正确'
        },
        laterThan: {
            validator: function (value, param) {
                function yyyyMMparser(s){
                    if (!s) return new Date();
                    var ss = s.split('-');
                    var y = parseInt(ss[0],10);
                    var m = parseInt(ss[1],10);
                    if (!isNaN(y) && !isNaN(m)) {
                        return new Date(y,m-1);
                    } else {
                        return new Date();
                    }
                };
                if ($(param[0]).val() != "" && value != "") {
                    var vDate = yyyyMMparser(value);
                    var pDate = yyyyMMparser($(param[0]).val());
                    return vDate >= pDate;
                } else {
                    return true;
                }
            },
            message: '截止日期必须晚于起始日期'
        },
        same: {
            validator: function (value, param) {
                if ($("#" + param[0]).val() != "" && value != "") {
                    return $("#" + param[0]).val() == value;
                } else {
                    return true;
                }
            },
            message: '两次输入的密码不一致！'
        },
        codeRule: {// 验证编码规则
            validator: function (value) {
                return /^(\d\-)*(\d)$/i.test(value);
            },
            message: '编码规则格式不正确,请使用下面格式:X-X-....'
        }
    }
});