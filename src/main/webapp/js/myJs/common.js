/**
 * 定义MyJsCommon对象
 * @returns {Object}
 * @constructor
 */
function MyJsCommon(){
    var obj=new Object();
    obj.SUCCESS = "1";
    obj.FAIL = "-1";

    /**
     * 数组定位
     * @data 要定位的数组
     * @param el 可以是JSON对象或数值、字符串
     *                    如果是JSON对象，对象中要包含idFieldName和idFieldValue
     *                                               idFieldName要查找的属性名称，idFieldValue要查找的属性值
     * @returns {number}
     */
    obj.arrayLocate=function (data,search){
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
    };
    /**
     * 身份证号验证
     * @param cardid
     * @returns {boolean}
     */
    obj.isIdCard=function (cardid) {
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
        if (birthday != this.dateToString(new Date(year + '/' + month + '/' + day))) { //校验日期是否合法
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
    };
    //日期转字符串 返回日期格式YYYYMMDD
    obj.dateToString=function (date) {
        if (date instanceof Date) {
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            month = month < 10 ? '0' + month: month;
            var day = date.getDate();
            day = day < 10 ? '0' + day: day;
            return year + month + day;
        }
        return '';
    };
    //取得URL参数
    obj.getRequestParameters=function (paras){
        var url = location.href;
        var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
        var paraObj = {};
        for (var i=0; j=paraString[i]; i++){
            paraObj[j.substring(0,j.indexOf("="))] = j.substring(j.indexOf("=")+1,j.length);
        }
        return paraObj;
    };
    obj.urlDecode=function (zipStr){
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
    };
    obj.StringToAscii=function (str){
        return str.charCodeAt(0).toString(16);
    };
    obj.AsciiToString=function (asccode){
        return String.fromCharCode(asccode);
    };
    obj.combineErrorMessage=function (data) {
        return data.message + '<br/><a href="#" onclick="alert(\'' + data.error + '\');">查看异常码</a>';
    };
    /**
     * 转换中文字符串
     * @param str 要转换的字符串
     * @returns {string} 返回UTF-8格式字符串
     */
    obj.toUtf8=function(str) {
        var out, i, len, c;
        out = "";
        len = str.length;
        for(i = 0; i < len; i++) {
            c = str.charCodeAt(i);
            if ((c >= 0x0001) && (c <= 0x007F)) {
                out += str.charAt(i);
            } else if (c > 0x07FF) {
                out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));
                out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
            } else {
                out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));
                out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
            }
        }
        return out;
    };
    return obj;
}
//创建全局变量
var myJsCommon=new MyJsCommon();
/**
 * 定义Base64对象
 * Base64 encode / decode
 *
 * @email tuhaitao@foxmail.com
 *
 */
function Base64() {
    // private property
    var _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

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
    };
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
    };
    // private method for UTF-8 encoding
    var _utf8_encode = function(string) {
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
    };
    // private method for UTF-8 decoding
    var _utf8_decode = function(utftext) {
        var string = "";
        var i = 0;
        var c = 0;
        var c2 = 0;
        var c3 = 0;
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
