//扩展JQUERY AJAX方法
(function($){
    //备份jquery的ajax方法
    var _ajax=$.ajax;
    //重写jquery的ajax方法
    $.ajax=function(opt){
        //备份opt中error和success方法
        var fn = {
            error:function(XMLHttpRequest, textStatus, errorThrown){},
            success:function(data, textStatus){},
            beforeSend:function(XHR){},
            complete:function(XHR, TS){}
        };
        if(opt.error){
            fn.error=opt.error;
        }
        if(opt.success){
            fn.success=opt.success;
        }
        if(opt.beforeSend){
            fn.beforeSend=opt.beforeSend;
        }
        if(opt.complete){
            fn.complete=opt.complete;
        }
        //扩展增强处理
        var _opt = $.extend(opt,{
            error:function(xhr, textStatus, errorThrown){
                //错误方法增强处理
                fn.error(xhr, textStatus, errorThrown);
            },
            success:function(data, textStatus){
                //成功回调方法增强处理
                if(data.status == 302) {
                	var errMsg = null;
					if(data.redirect=="/login"){
						errMsg = "超时，重新登录";
					} else if(data.redirect == "/login?kickout=1") {
						errMsg = "因超出允许的单一账户同时登录数而被踢出";
    				} else if(data.redirect == "/login?forceLogout=1") {
    					errMsg = "被管理员强行踢出";
    				}
					console.log(errMsg)
					$.messager.alert("警告", errMsg,'info',function(){
						redirect(data.redirect);
					});
                } else if (data.status!=1 && data.message) {
                    $.messager.show({
                        title: '提示',
                        msg: data.message
                    });
                }
                fn.success(data, textStatus);
            },
            beforeSend:function(xhr){
                //提交前回调方法
                //$('body').append("<div id='ajaxInfo' style=''>正在请求数据,请稍等...</div>");
                fn.beforeSend(xhr);
            },
            complete:function(xhr, TS){
                fn.complete(xhr,TS);
            }
        });
        _ajax(_opt);
    };
})(jQuery);

if(!('contains' in String.prototype)) {
    String.prototype.contains = function(str, startIndex) {
        return -1 !== String.prototype.indexOf.call(this, str, startIndex);
    };
}

function redirect(redirect) {
	if (self != top) {  
		window.top.location = window.parent.location.href.substr(0,window.parent.location.href.lastIndexOf("/")) + redirect;
	} else {
		window.parent.location = window.parent.location.href.substr(0,window.parent.location.href.lastIndexOf("/")) + redirect;
	}
	
}
/**
 * validateobx
 */
$.extend($.fn.validatebox.defaults.rules, {
    idcard: {// 验证身份证
        validator: function (value) {
            return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
        },
        message: '身份证号码格式不正确'
    },
    minLength: {
        validator: function (value, param) {
            return value.length >= param[0];
        },
        message: '请输入至少（2）个字符.'
    },
    length: {
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
    qq: {// 验证QQ,从10000开始
        validator: function (value) {
            return /^[1-9]\d{4,9}$/i.test(value);
        },
        message: 'QQ号码格式不正确'
    },
    integer: {// 验证整数 可正负数
        validator: function (value) {
            //return /^[+]?[1-9]+\d*$/i.test(value);

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
    chinese: {// 验证中文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value);
        },
        message: '请输入中文'
    },
    english: {// 验证英语
        validator: function (value) {
            return /^[A-Za-z]+$/i.test(value);
        },
        message: '请输入英文'
    },
    unnormal: {// 验证是否包含空格和非法字符
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
    faxno: {// 验证传真
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
    name: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
        },
        message: '请输入姓名'
    },
    date: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            //格式yyyy-MM-dd或yyyy-M-d
            return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
        },
        message: '请输入合适的日期格式'
    },
    yyyyMM: {// 验证姓名，可以是中文或英文
        validator: function (value) {
            //格式yyyy-MM-dd或yyyy-M-d
            return /^\b[1-3]\d{3}-(0[1-9]|1[0-2])$/i.test(value);
        },
        message: '请输入合适的格式'
    },
    msn: {
        validator: function (value) {
            return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
        },
        message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
    },
    laterThan: {
        validator: function (value, param) {
            if ($(param[0]).val() != "" && value != "") {
                if (value.contains(" ")) {
                    return datetimeParser(value) >= datetimeParser($("#" + param[0]).datetimebox("getValue"));
                } else {
                    return yyyyMMparser(value) >= yyyyMMparser($("#" + param[0]).datebox("getValue"));
                }
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
});

/**
 * combobox
 */
$.extend($.fn.combobox.defaults, {
    filter: pinyinFilter,
    onHidePanel: onComboboxHidePanel
});

$.extend($.fn.combobox.defaults.keyHandler, {
    query: doQuery,
    enter: function (e) {
        var enterSeq = $(this).attr("enterSeq");
        if (enterSeq == undefined && $(this).combo("panel").parent().css("display") == "none") {
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
        if (!index) {
            index = getSelectedOptionIndex();
        }
        if (index != -1) {
            $(jq).combobox({
                onLoadSuccess: function () {
                    var opt = $(jq).combobox('options');
                    var data = $(jq).combobox('getData');
                    for (var i = 0; i < data.length; i++) {
                        if (i == index) {
                            $(jq).combobox('select', eval('data[index].' + opt.valueField));
                            break;
                        }
                    }

                    $(jq).combobox('validate');
                    if ($(jq).combobox('isValid')) {
                        $(jq).combobox('hidePanel');
                        $(this).removeAttr("enterSeq");
                        focusNext($(jq));
                    } else {
                        $(jq).next().find("input.textbox-prompt").focus();
                    }
                }
            });
        }
    }
});

function doQuery(q, evt) {
    var target = this;
    var el = $(this);

    var state = $.data(target, 'combobox');
    var opts = state.options;

    if (opts.mode == 'remote') {

    } else {
        var panel = el.combo('panel');
        panel.find('div.combobox-item-selected,div.combobox-item-hover')
            .removeClass('combobox-item-selected combobox-item-hover');
        panel.find('div.combobox-item,div.combobox-group').hide();
        var data = opts.data;
        var vv = [];
        var qq = opts.multiple ? q.split(opts.separator) : [q];
        $.map(qq, function (q) {
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
}

function pinyinFilter(input, row) {
    // 清空内容, 则不过滤
    if (input == "")
        return true;

    var matched = false;
    input = input.toUpperCase();
    // 先判断显示值
    var opts = $(this).combobox('options');

    if (row[opts.textField].toUpperCase().match(input) != null) {
        return true;
    } else {
        // 优先用top里共享的拼音检索函数(避免每个页面都加载拼音js)
        var pinyin = makePy(row[opts.textField]);
        $.each(pinyin, function (idx, pinyinItem) {
            exp = input.toUpperCase().split("").join(".*");
            if (pinyinItem.match(exp) != null) {
                matched = true;
                return false;
            }
        });
        return matched;
    }
    // 默认不过滤
    return true;
}

function onComboboxHidePanel() {
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

function getFirstVisibleOptionIndex() {
    var option = $("div.combo-p:visible>div");
    var options = option.find("div.combobox-item");
    var firstVisible = option.find("div.combobox-item:visible:first");
    var index = options.index(firstVisible);
    return index;
}

function getSelectedOptionIndex() {
    var option = $("div.combo-p:visible>div");
    var options = option.find("div.combobox-item");
    var firstVisible = option.find("div.combobox-item-selected");
    var index = options.index(firstVisible);
    return index;
}

/**
 * datebox
 */
function dateboxKeydownHandler(e) {
    if (e.keyCode == 13) {
        var curr = $(this).parent().prev();
        curr.textbox('setValue', $(this).val());
        curr.textbox('validate');
        if (curr.textbox('isValid')) {
            focusNext(curr);
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

$(function () {
    $("input.easyui-datebox").datebox({
        inputEvents: $.extend({}, $.fn.datebox.defaults.inputEvents, {
            keydown: dateboxKeydownHandler
        })
    });

    $("input.husky-datebox").textbox({
        inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
            keydown: dateboxKeydownHandler
        })
    });
});


/**
 * 扩展树表格级联勾选方法：
 * @param {Object} container
 * @param {Object} options
 * @return {TypeName}
 */
$.extend($.fn.treegrid.methods, {
    /**
     * 级联选择
     * @param {Object} target
     * @param {Object} param
     *      param包括两个参数:
     *          id:勾选的节点ID
     *          deepCascade:是否深度级联
     * @return {TypeName}
     */
    cascadeCheck: function (target, param) {
        var opts = $.data(target[0], "treegrid").options;
        if (opts.singleSelect)
            return;
        var idField = opts.idField;//这里的idField其实就是API里方法的id参数
        var status = false;//用来标记当前节点的状态，true:勾选，false:未勾选
        var selectNodes = $(target).treegrid('getSelections');//获取当前选中项
        for (var i = 0; i < selectNodes.length; i++) {
            if (selectNodes[i][idField] == param.id)
                status = true;
        }
        //级联选择父节点
        selectParent(target[0], param.id, idField, status);
        selectChildren(target[0], param.id, idField, param.deepCascade, status);
        /**
         * 级联选择父节点
         * @param {Object} target
         * @param {Object} id 节点ID
         * @param {Object} status 节点状态，true:勾选，false:未勾选
         * @return {TypeName}
         */
        function selectParent(target, id, idField, status) {
            var parent = $(target).treegrid('getParent', id);
            if (parent) {
                var parentId = parent[idField];
                if (status)
                    $(target).treegrid('select', parentId);
                else
                    $(target).treegrid('unselect', parentId);
                selectParent(target, parentId, idField, status);
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
        function selectChildren(target, id, idField, deepCascade, status) {
            //深度级联时先展开节点
            if (!status && deepCascade)
                $(target).treegrid('expand', id);
            //根据ID获取下层孩子节点
            var children = $(target).treegrid('getChildren', id);
            for (var i = 0; i < children.length; i++) {
                var childId = children[i][idField];
                if (status)
                    $(target).treegrid('select', childId);
                else
                    $(target).treegrid('unselect', childId);
                selectChildren(target, childId, idField, deepCascade, status);//递归选择子节点
            }
        }
    }
});

/**
 * 扩展树表格级联选择（点击checkbox才生效）：
 *      自定义两个属性：
 *      cascadeCheck ：普通级联（不包括未加载的子节点）
 *      deepCascadeCheck ：深度级联（包括未加载的子节点）
 */
$.extend($.fn.treegrid.defaults, {
    onLoadSuccess: function () {
        var target = $(this);
        var opts = $.data(this, "treegrid").options;
        var panel = $(this).datagrid("getPanel");
        var gridBody = panel.find("div.datagrid-body");
        var idField = opts.idField;//这里的idField其实就是API里方法的id参数
        gridBody.find("div.datagrid-cell-check input[type=checkbox]").unbind(".treegrid").click(function (e) {
            if (opts.singleSelect) return;//单选不管
            if (opts.cascadeCheck || opts.deepCascadeCheck) {
                var id = $(this).parent().parent().parent().attr("node-id");
                var status = false;
                if ($(this).attr("checked")) status = true;
                //级联选择父节点
                selectParent(target, id, idField, status);
                selectChildren(target, id, idField, opts.deepCascadeCheck, status);
                /**
                 * 级联选择父节点
                 * @param {Object} target
                 * @param {Object} id 节点ID
                 * @param {Object} status 节点状态，true:勾选，false:未勾选
                 * @return {TypeName}
                 */
                function selectParent(target, id, idField, status) {
                    var parent = target.treegrid('getParent', id);
                    if (parent) {
                        var parentId = parent[idField];
                        if (status)
                            target.treegrid('select', parentId);
                        else
                            target.treegrid('unselect', parentId);
                        selectParent(target, parentId, idField, status);
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
                function selectChildren(target, id, idField, deepCascade, status) {
                    //深度级联时先展开节点
                    if (status && deepCascade)
                        target.treegrid('expand', id);
                    //根据ID获取下层孩子节点
                    var children = target.treegrid('getChildren', id);
                    for (var i = 0; i < children.length; i++) {
                        var childId = children[i][idField];
                        if (status)
                            target.treegrid('select', childId);
                        else
                            target.treegrid('unselect', childId);
                        selectChildren(target, childId, idField, deepCascade, status);//递归选择子节点
                    }
                }
            }
            e.stopPropagation();//停止事件传播
        });
    }
});


function formatProgress(val, row) {
    var per = val == 0 ? val : Math.floor(10000 / val);
    var bgColor = "green";
    var textColor = "blue";

    if (val < 15) {
        bgColor = "red";
        textColor = "blue";
    } else if (val < 50) {
        bgColor = "orange";
        textColor = "black";
    } else if (val < 85) {
        bgColor = "yellow";
        textColor = "blue";
    } else {
        bgColor = "lightgreen";
        textColor = "white";
    }

    var html =
        '<div class="easyui-progressbar progressbar" style="height: 16px;">'
        + '<div class="progressbar-text" style="width:100%; height:16px;line-height:16px;color:' + textColor + ';">' + val + '%</div>'
        + '<div class="progressbar-value" style="width:' + val + '%;height:16px;line-height:16px;">'
        + '<div class="progressbar-text" style="width:' + per + '%; height:16px;line-height:16px;color:' + textColor + ';background-color:' + bgColor + ';">' + val + '%</div>'
        + '</div>'
        + '</div>';
    return html;

}


function loadForm(elem, data) {
    elem.find("input.easyui-textbox").textbox("clear");
    elem.find("input.easyui-datebox").datebox("clear");
    elem.find("input.easyui-datetimebox").datebox("clear");
    elem.find("input.easyui-combobox").combobox("clear");
    elem.find("input.easyui-numberbox").numberbox("clear");
    elem.find("input.easyui-numberspinner").numberspinner("clear");
    elem.find("input.easyui-combotree").combotree("clear");
    elem.find("div.easyui-progressbar").progressbar("clear");
    elem.find("input:hidden").val("");

    if(null != data) {
        $.each(elem.find("input"), function (idx, _elem) {
            var _e = $(_elem);
            if (_e.hasClass("easyui-textbox")) {
                var flag = _e.textbox('options').readonly;
                _e.textbox({disabled: flag});
                _e.textbox("setValue", data[_elem.id.split("_")[1]]);
                _e.textbox("setText", removeIdBeforeSlash(data[_elem.id.split("_")[1]]));
            } else if (_e.hasClass("easyui-datebox")) {
                var flag = _e.datebox('options').readonly;
                _e.datebox({hasDownArrow: !flag, disabled: flag});
                var dateStr = data[_elem.id.split("_")[1]];
                if (null != dateStr) {
                    var date = new Date(dateStr);
                    _e.datebox("setValue", dateFormatter(date));
                }
            } else if (_e.hasClass("easyui-datetimebox")) {
                var flag = _e.datetimebox('options').readonly;
                _e.datetimebox({hasDownArrow: !flag, disabled: flag});
                var dateStr = data[_elem.id.split("_")[1]];
                if (null != dateStr) {
                    var datetime = new Date(dateStr);
                    _e.datetimebox("setValue", datetimeFormatter(datetime));
                }
            } else if (_e.hasClass("easyui-combobox")) {
                var flag = _e.combobox('options').readonly;
                _e.combobox({hasDownArrow: !flag, disabled: flag});
                _e.combobox("setValue", data[_elem.id.split("_")[1]]);
            } else if (_e.hasClass("easyui-numberbox")) {
                var flag = _e.numberbox('options').readonly;
                _e.numberbox({hasDownArrow: !flag, disabled: flag});
                _e.numberbox("setValue", data[_elem.id.split("_")[1]]);
            } else if (_e.hasClass("easyui-numberspinner")) {
                var flag = _e.numberspinner('options').readonly;
                _e.numberspinner({hasDownArrow: !flag, disabled: flag});
                _e.numberspinner("setValue", data[_elem.id.split("_")[1]]);
            } else if (_e.hasClass("easyui-combotree")) {
                _e.combotree("setValue", data[_elem.id.split("_")[1]]);
            } else if (_e.hasClass("easyui-filebox")) {
                var flag = _e.filebox('options').readonly;
                _e.filebox({hasDownArrow: !flag, disabled: flag});
                _e.filebox("clear").filebox("disable");
            } else if (_elem.type == "hidden" && _elem.id.match(/^\S*_/g) != null) {
                _e.val(data[_elem.id.split("_")[1]]);
            }
        });

        $.each(elem.find("div.husky-progressbar"), function (idx, _elem) {
            var _e = $(_elem);
            _e.html(formatProgress(data[_elem.id.split("_")[1]]));
            if (_e.attr("editable") && _e.attr("editable") != "false") {
                _e.click(function () {
                    alert("弹出对话框,修改数值")
                });
            }

        });

        $.each(elem.find("textarea"), function (idx, _elem) {
            $(_elem).val(data[_elem.id.split("_")[1]]);
        });
        window.operate = 'update';
    } else {
        window.operate = 'add';
    }
}

function setFormReadonly(elem, readonly) {
    //var disable = readonly ? "disable" : "enable";
    $.each(elem.find("input"), function (idx, _elem) {
        //var _e = $(_elem);
        setInputFieldReadonly($(_elem), readonly);
    });

    $.each(elem.find("textarea"), function (idx, _elem) {
        if (readonly) {
            $(_elem).attr("disabled", "disabled");
        } else {
            $(_elem).removeAttr("disabled");
        }
    });
}

function setInputFieldReadonly(_e, readonly) {
    var disable = readonly ? "disable" : "enable";
    if (_e.hasClass("easyui-textbox")) {
        _e.textbox("readonly", readonly).textbox(disable);
    } else if (_e.hasClass("easyui-numberbox")) {
        _e.numberbox("readonly", readonly).numberbox(disable);
    } else if (_e.hasClass("easyui-numberspinner")) {
        _e.numberspinner("readonly", readonly).numberspinner(disable);
    } else if (_e.hasClass("easyui-datebox")) {
        _e.datebox("readonly", readonly).datebox(disable);
    } else if (_e.hasClass("easyui-datetimebox")) {
        _e.datetimebox("readonly", readonly).datetimebox(disable);
    } else if (_e.hasClass("easyui-combobox")) {
        _e.combobox("readonly", readonly).combobox(disable);
    } else if (_e.hasClass("easyui-filebox")) {
        _e.filebox("clear").filebox("disable");
    }
}

function drillDownForm(formElemId) {
    var form = $("#" + formElemId);
    var data = {};

    $.each(form.find("input:hidden"), function (idx, elem) {
        if (elem.id.contains("_") && $(elem).val() != "") {
            data[elem.id.split("_")[1]] = $(elem).val();
        }
    });
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
    $.each(form.find("input.easyui-datetimebox"), function (idx, elem) {
        data[elem.id.split("_")[1]] = $(elem).datetimebox("getValue");
    });
    $.each(form.find("input.easyui-combobox"), function (idx, elem) {
        data[elem.id.split("_")[1]] = $(elem).combobox("getValue");
    })
    return data;
}

function showDiff() {
    var grid = $("#" + this.id);
    var columns = grid.datagrid("options").columns;
    var gridView = grid.parent();
    for (var i = 0; i < columns.length; i++) {
        for (var j = 0; j < columns[i].length; j++) {
            var column = columns[i][j];
            if (column.field != '' && column.field != 'ver' && !column.field.startsWith('modify')) {
                _showDiff_(gridView, column.field);
            }
        }
    }
}

function _showDiff_(gridView, columnName) {
    var cells = gridView.find("td[field='" + columnName + "'] div");
    var previous = cells[1];
    for (var idx = 2; idx < cells.length; idx++) {
        var current = cells[idx];
        if (previous.textContent == current.textContent) {
            $(previous).parent().css("color", "blue").css("background-color", "white");
        } else {
            $(previous).parent().css("color", "red").css("background-color", "yellow");
        }
        previous = current;
    }
}

function _init_(initCallback, tabSelectCallback) {
    if (null != initCallback) {
        initCallback();
    }
    if (null != tabSelectCallback) {
        tabSelectCallback();
    }
    $.unsubscribe("INCREMENT_CODELIST_INITIALIZED", _init_);
}

//动态更新TAB Panel
function initTabContent(tabId, url, initCallback, tabSelectCallback) {
    var tab = $('#' + tabId).tabs('getSelected');
    var initFlag = tab.attr("initFlag");
    if (initFlag) {
        tabSelectCallback();
    } else {
        //$('<div class="panel-loading">Loading...</div>').appendTo($(tab))
        tab.panel({
            href: url,
            onLoad: function () {
                $.subscribe("INCREMENT_CODELIST_INITIALIZED", _init_, [initCallback, tabSelectCallback]);
                $.codeListLoader.parse(tab);
            }
        });
        tab.attr("initFlag", true);
    }
}

//DataGrid导航
function datagridNavigate(datagridId, iconCls) {
    var datagrid = $('#'+datagridId);
    if(iconCls == "icon-first" || iconCls == "icon-last") {
        datagrid.datagrid('unselectAll').datagrid('selectRow', iconCls == "icon-first" ? 0: (datagrid.datagrid('getRows').length - 1));
    } else {
        var currentRow = datagrid.datagrid('getSelected');
        var currentRowIndex = datagrid.datagrid('getRowIndex', currentRow);
        if (iconCls == "icon-previous") {
            if(currentRowIndex > 0) {
                datagrid.datagrid('unselectAll').datagrid('selectRow', currentRowIndex - 1);
            } else {
                $.messager.show({
                    title : '提示',
                    msg : "已经是第一条记录！"
                });
            }
        } else {
            if(currentRowIndex < $('#'+datagridId).datagrid('getRows').length - 1) {
                datagrid.datagrid('unselectAll').datagrid('selectRow', currentRowIndex + 1);
            } else {
                $.messager.show({
                    title : '提示',
                    msg : "已经是最后一条记录！"
                });
            }
        }

    }
    return datagrid.datagrid('getSelected');
}

function treegridNavigate(treegridId, iconCls) {
    var treegrid = $('#'+treegridId);
    var data = treegrid.treegrid('getData');
    var currentRowId = treegrid.treegrid("getSelected").id;

    if(iconCls == "icon-first" || iconCls == "icon-last") {
        treegrid.treegrid('select', iconCls == "icon-first" ? data[0].id: data[data.length-1].id);
    } else {
        var currentRowIndex = data.indexOf({"idFieldName":"id","idFieldValue":currentRowId}).index;
        if (iconCls == "icon-previous") {

            if(currentRowIndex > 0) {
                treegrid.treegrid('unselectAll').treegrid('selectRow', data[currentRowIndex - 1].id);
            } else {
                $.messager.show({
                    title : '提示',
                    msg : "已经是第一条记录！"
                });
            }
        } else {
            if(currentRowIndex < data.length - 1) {
                treegrid.treegrid('unselectAll').treegrid('selectRow', data[currentRowIndex + 1].id);
            } else {
                $.messager.show({
                    title : '提示',
                    msg : "已经是最后一条记录！"
                });
            }
        }

    }

    return treegrid.treegrid('getSelected');

}

function getButtonStatusStatement(status) {
    return status == 1? 'enable': 'disable'
}

function getContextMenuItemStatusStatement(status) {
    return status == 1? 'enableItem': 'disableItem'
}

