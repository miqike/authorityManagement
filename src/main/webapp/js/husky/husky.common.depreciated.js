//webeye.js/jquery.subscribe.js/base64.js
//JS常量
window.SUCCESS = "1";
window.FAIL = "-1";
window.loginUrl = "https://isc.kysoft.com:9443/cas/login?service=http://ntims.kysoft.com:8080/ntims/cas";

//设置AJAX请求不缓存
$.ajaxSetup({cache:false});

//扩展JQuery
jQuery(function($) {
    $.extend({
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
}

$.confirm=function(content,fn){
    $.messager.confirm('提示消息',content,fn);
}

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

function getRequestParameters(paras){
	var url = location.href;
	var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
	var paraObj = {};
	for (var i=0; j=paraString[i]; i++){
		paraObj[j.substring(0,j.indexOf("="))] = j.substring(j.indexOf("=")+1,j.length);
	}
	return paraObj;
}

function urlDecode(zipStr){
    var uzipStr=""; 
    for(var i=0;i<zipStr.length;i++){ 
        var chr = zipStr.charAt(i); 
        if(chr == "+"){ 
            uzipStr+=" "; 
        }else if(chr=="%"){ 
            var asc = zipStr.substring(i+1,i+3); 
            if(parseInt("0x"+asc)>0x7f){ 
                uzipStr+=decodeURI("%"+asc.toString()+zipStr.substring(i+3,i+9).toString()); 
                i+=8; 
            }else{ 
                uzipStr+=AsciiToString(parseInt("0x"+asc)); 
                i+=2; 
            } 
        }else{ 
            uzipStr+= chr; 
        } 
    } 
    return uzipStr;
} 
 
function StringToAscii(str){ 
    return str.charCodeAt(0).toString(16); 
} 

function AsciiToString(asccode){ 
    return String.fromCharCode(asccode); 
}

String.prototype.format = function(args) {
    var result = this;
    if (arguments.length > 0) {
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if(args[key]!=undefined){
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        } else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
                    var reg = new RegExp("({[" + i + "]})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result;
};

Date.prototype.format = function(fmt) { //author: meizz
  var o = { 
    "M+" : this.getMonth()+1,
    "d+" : this.getDate(),
    "h+" : this.getHours(),
    "m+" : this.getMinutes(),
    "s+" : this.getSeconds(),
    "q+" : Math.floor((this.getMonth()+3)/3),
    "S"  : this.getMilliseconds()
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
};

function showModalDialog(popWinId, title) {
	var win = $("#" + popWinId);
    var option = {
        top: (document.documentElement.clientHeight - win.height()) * 0.5,
        left: (document.documentElement.clientWidth - win.width()) * 0.5
    };

    if(title) {
        option.title = title;
    }
    win.window(option).window('open').window("center");
    $.codeListLoader.parse(win);
}

function cancelBack(popWinId) {
	$("#" + popWinId).window('close');
}

function combineErrorMessage(data) {
    return data.message + '<br/><a href="#" onclick="alert(\'' + data.error + '\');">查看异常码</a>';
}

function getUserInfo() {
    if(window.parent.userInfo == undefined) {
        $.getJSON("../common/userInfo", function(response){
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
    
    $.fn.outerHTML = function() {

        // IE, Chrome & Safari will comply with the non-standard outerHTML, all others (FF) will have a fall-back for cloning
        return (!this.length) ? this : (this[0].outerHTML ||
        (function(el) {
            var div = document.createElement('div');
            div.appendChild(el.cloneNode(true));
            var contents = div.innerHTML;
            div = null;
            return contents;
        })(this[0]));

    };
})(jQuery);

/**
 *
 * Base64 encode / decode
 *
 * @author haitao.tu
 * @date 2010-04-26
 * @email tuhaitao@foxmail.com
 *
 */

function Base64() {

    // private property
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

    // public method for encoding
    this.encode = function(input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;
        input = _utf8_encode(input);
        while (i < input.length) {
            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;
            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }
            output = output + _keyStr.charAt(enc1) + _keyStr.charAt(enc2)
                + _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
        }
        return output;
    }

    // public method for decoding
    this.decode = function(input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (i < input.length) {
            enc1 = _keyStr.indexOf(input.charAt(i++));
            enc2 = _keyStr.indexOf(input.charAt(i++));
            enc3 = _keyStr.indexOf(input.charAt(i++));
            enc4 = _keyStr.indexOf(input.charAt(i++));
            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;
            output = output + String.fromCharCode(chr1);
            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }
        }
        output = _utf8_decode(output);
        return output;
    }

    // private method for UTF-8 encoding
    _utf8_encode = function(string) {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";
        for ( var n = 0; n < string.length; n++) {
            var c = string.charCodeAt(n);
            if (c < 128) {
                utftext += String.fromCharCode(c);
            } else if ((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            } else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }
        return utftext;
    }

    // private method for UTF-8 decoding
    _utf8_decode = function(utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;
        while (i < utftext.length) {
            c = utftext.charCodeAt(i);
            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            } else if ((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i + 1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            } else {
                c2 = utftext.charCodeAt(i + 1);
                c3 = utftext.charCodeAt(i + 2);
                string += String.fromCharCode(((c & 15) << 12)
                    | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }
        }
        return string;
    }
}

function theWeek(date){

    //当前date
    date = date==undefined? new Date():date;

    //每月多少日
    var monthOfFullDay = new Array(31,28,31,30,31,30,31,31,30,31,30,31);

    //当前日，在本年中第几日
    var currentDayOfYear = 0;

    //是否为闰年，即能被4整除
    var isFullYear = false;

    var currentDayOfWeekIsLastDay = false;

    var firstDayOfYearIsFirstDayOfWeek = false;

    //当前年份
    var year = 0;
    if(date.getYear()>=2000)
        year = date.getYear();
    else
        year = date.getYear() + 1900;

    //当前月份
    var month = date.getMonth();

    //当前日
    var day = date.getDate();

    //当前星期几
    var week = date.getDay();

    //为闰年，设isFullYear为true
    if(year%4==0){
        isFullYear = true;
    }


    //循环计算天数
    for(var i=0;i<monthOfFullDay.length;i++){
        //判断数组月份是否小于等于当前月份
        if(i<month){
            //是闰年和2月份
            if(isFullYear && i==1)
                currentDayOfYear = currentDayOfYear + 29;
            else
                currentDayOfYear = currentDayOfYear + monthOfFullDay[i];

        }
        if(i==month)
            currentDayOfYear = currentDayOfYear + day;
    }

    //设置本年1月1日
    var firstDayOfYear = new Date();
    firstDayOfYear.setYear(year);
    firstDayOfYear.setMonth(0);
    firstDayOfYear.setDate(1);

    if(firstDayOfYear.getDay()==0){
        firstDayOfYearIsFirstDayOfWeek = true;
    }

    var weeksOfYear = currentDayOfYear;

    //本星期是否为最后一日，否，则减去本星期所有日
    if(!currentDayOfWeekIsLastDay){
        weeksOfYear = weeksOfYear + firstDayOfYear.getDay();
    }

    //是否第一个星期为第一日（即星期日），否，则减去本星期所有日
    if(!firstDayOfYearIsFirstDayOfWeek){
        weeksOfYear = weeksOfYear + (7-week-1);
    }

    return weeksOfYear/7;
}

if(typeof(hotkeys) != 'undefined') {
	hotkeys.filter = function(event){
	    return true;
	}
	
	// 定义快捷键
	hotkeys('ctrl+f11',function(event,handler){
		top.layoutFullScreen();
});
}
