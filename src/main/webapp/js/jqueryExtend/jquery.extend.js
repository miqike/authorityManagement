//扩展JQuery
jQuery(function($) {
    $.extend({
        /**
         * 表单序列化为Json的方法
         * @param obj
         * @returns {string}
         */
        serializeJSON: function(obj) {
            var t = typeof(obj);
            if(t != "object" || obj === null) {
                // simple data type
                if(t == "string") obj = '"' + obj + '"';
                return String(obj);
            } else {
                // array or object
                var json = [], arr = (obj && obj.constructor == Array);

                $.each(obj, function(k, v) {
                    t = typeof(v);
                    if(t == "string") v = '"' + v + '"';
                    else if (t == "object" & v !== null) v = $.serializeJSON(v);
                    json.push((arr ? "" : '"' + k + '":') + String(v));
                });

                return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
            }
        }
    });
});

$.alert=function(content,fn){
    if(fn){
        $.messager.alert('提示消息',content,'info',fn);
    } else {
        $.messager.alert('提示消息',content,'info');
    }
};

$.confirm=function(content,fn){
    $.messager.confirm('提示消息',content,fn);
};

$.getUrlParam = function(name) {
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r!=null) return unescape(r[2]); return null;
};

$.getCurrentDate=function(){
    var d=new Date();
    var m=d.getMonth()+1;
    var _m=(m<10?("0"+m):m);
    return (d.getFullYear()+"-"+_m+"-"+d.getDate());
};

//设置AJAX请求不缓存
$.ajaxSetup({cache:false});

/// jquery.subscribe
(function($) {
    var _evtGroup = {};

    $.fn.extend({
        subscribe: function(eventName, eventHandler, constArgs) {
            var handlers = _evtGroup[eventName];

            if (!handlers) handlers = this._createEventName(eventName);

            var context = this;

            if (this.subscribers) {
                this.subscribers[eventName] = eventHandler;
                for (var item in handlers) {
                    if (item._fn === eventHandler) return this;
                }
            }

            var handler = function() { return eventHandler.apply(context, constArgs || arguments); }
            handler._fn = eventHandler;

            this._appendHandler(handlers, handler);
            return this;
        },
        unsubscribe: function(eventName, eventHandler) {
            var handlers = _evtGroup[eventName];
            if (!handlers) return false;

            return this._removeHandler(handlers, eventHandler);
        },
        publish: function(eventName, args, context) {
            var handlers = _evtGroup[eventName];
            if (!handlers) return;

            var temp = handlers;
            var j = temp.length;
            _evtGroup[eventName] = [];

            for (var i = 0; i < j; i++) {
                var curr = temp.shift();
                _evtGroup[eventName].push(curr);
                if (curr.apply({}, args || []) === false) {
                    _evtGroup[eventName] = _evtGroup[eventName].concat(temp);
                    return false;
                }
            }
            return true;
        },
        publishOnEvent: function(event, eventName, data) {
            this._createEventName(eventName);

            this.bind(event, data, function(e) {
                $(this).publish(eventName, e.data, e);
            });

            return this;
        },
        _createEventName: function(eventName) {
            if (!_evtGroup[eventName]) {
                _evtGroup[eventName] = [];
            }
            return _evtGroup[eventName];
        },
        _appendHandler: function(handlers, eventHandler) {
            var j = handlers.length;
            for (var i = 0; i < j; i++) {
                if (handlers[i]._fn === eventHandler._fn) return false;
            }

            handlers.push(eventHandler);
            return true;
        },
        _removeHandler: function(handlers, eventHandler) {
            var j = handlers.length;
            if (!eventHandler) handlers = [];

            for (var i = 0; i < j; i++) {
                var curr = handlers.shift();
                if (curr._fn == eventHandler) return true;
                handlers.push(curr);
            }
            return false
        }
    });

    $.extend({
        subscribe: function(eventName, handler, data) {
            return $().subscribe(eventName, handler, data);
        },
        unsubscribe: function(eventName, handler) {
            return $().unsubscribe(eventName, handler);
        },
        publish: function(eventName, data, context) {
            return $().publish(eventName, data, context);
        }
    });
})(jQuery);

jQuery.jqueryExtendObj = {
    /**
     * 动态更新TAB Panel
     * @param initCallback
     * @param tabSelectCallback
     * @private
     */
    initTabContent:function (tabId, url, initCallback, tabSelectCallback) {
        function _init_(initCallback, tabSelectCallback) {
            if(null != initCallback) {
                initCallback();
            }
            if(null != tabSelectCallback) {
                tabSelectCallback();
            }
            $.unsubscribe("INCREMENT_CODELIST_INITIALIZED", _init_);
        }
        var tab = $('#' + tabId).tabs('getSelected');
        var initFlag = tab.attr("initFlag");
        if(initFlag) {
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
    },
    //居中显示窗口，显示窗口之后再设置窗口内容，否则COMBOBX内容显示不正确
    showModalDialog:function (popWinId, title) {
        var win = $("#" + popWinId);
        var option = {
            top: (document.documentElement.clientHeight - win.height()) * 0.5,
            left: (document.documentElement.clientWidth - win.width()) * 0.5
        };

        if(title) {
            option.title = title;
        }
        win.window(option).window('open');
        if(typeof($.codeListLoader)!='undefined') {
            $.codeListLoader.parse(win);
        }
    },
    cancelBack:function (popWinId) {
        $("#" + popWinId).window('close');
    },
    getUserInfo:function () {
        if(window.parent.userInfo == undefined) {
            $.getJSON("../sys/user/getUserInfo", function(response){
                if(response.userInfo == null && response.redirect != undefined) {
                    window.parent.location = response.redirect;
                } else {
                    window.userInfo = response.userInfo;
                    window.parent.userInfo = userInfo;
                    $.publish("USERINFO_INITIALIZED", null);
                }
            });
        } else {
            //尝试从父框架获取
            window.userInfo = window.parent.userInfo;
        }
    }
};




