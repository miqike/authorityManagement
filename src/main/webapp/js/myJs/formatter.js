/**
 * 数组定位
 * @param el 可以是JSON对象或数值、字符串
 *                    如果是JSON对象，对象中要包含idFieldName和idFieldValue
 *                                               idFieldName要查找的属性名称，idFieldValue要查找的属性值
 * @returns {number}
 */
Array.prototype.indexOf = function(el){
    var result={};
    result.index=-1;
    for (var i=0; i<this.length; i++){
        var findValue;
        if(typeof el =="object"){
            findValue=this[i][el["idFieldName"]];
            if (findValue === el["idFieldValue"]){
                result.index=i;
                result.data=this[i];
                return result;
            }
        }else{
            findValue=el;
            if (findValue === el){
                result.index=i;
                result.data=this[i];
                return result;
            }
        }
    }
    return result;
};

//两端去空格函数
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g,"");
};

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

// 时间格式化
Date.prototype.format = function (format) {
	/*
	 * eg:format="yyyy-MM-dd hh:mm:ss";
	 */
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}

	var o = {
		"M+": this.getMonth() + 1, // month
		"d+": this.getDate(), // day
		"h+": this.getHours(), // hour
		"m+": this.getMinutes(), // minute
		"s+": this.getSeconds(), // second
		"q+": Math.floor((this.getMonth() + 3) / 3), // quarter
		"S": this.getMilliseconds()
		// millisecond
	};

	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	}

	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};
//Extend the default Number object with a formatMoney() method:
// usage: someVar.formatMoney(decimalPlaces, symbol, thousandsSeparator, decimalSeparator)
// defaults: (2, "$", ",", ".")
Number.prototype.formatMoney = function (places, symbol, thousand, decimal) {
    places = !isNaN(places = Math.abs(places)) ? places : 2;
    symbol = symbol !== undefined ? symbol : "$";
    thousand = thousand || ",";
    decimal = decimal || ".";
    var number = this,
        negative = number < 0 ? "-" : "",
        i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
        j = (j = i.length) > 3 ? j % 3 : 0;
    return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
};
/**
 * 定义Formatter对象
 * @constructor
 */
function Formatter() {
    var dateFormatter=function (date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    };
    //只显示日期
    this.formatDate=function (val, row) {
        if(val == undefined || val=="") {
            return "";
        } else {
            var date = new Date(val);
            return dateFormatter(date);
        }
    };
    this.timeOnlyFormatter=function (date, showSec){
        var h = date.getHours();
        var min = date.getMinutes();
        var result = (h<10?('0'+h):h) + ":" + (min<10?('0'+min):min);
        if(showSec == true) {
            var sec = date.getSeconds();
            var msec = date.getMilliseconds();
            result = result + ":"
                + (sec<10?('0'+sec):sec) + "."
                + (msec<10?('0'+msec):msec);
        }
        return result;
    };
    //只显示时间
    this.formatTimeOnly=function (val, row) {
        if(val == undefined || val=="") {
            return "";
        } else {
            var date = new Date(val);
            return this.timeOnlyFormatter(date, true);
        }
    };
    this.datetimeFormatter=function (dateStr, showSec){
        var date = new Date(dateStr)
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        var h = date.getHours();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        var msec = date.getMilliseconds();
        var result = y+'-'+(m<10?('0'+m):m)+'-'
            + (d<10?('0'+d):d) + " "
            + (h<10?('0'+h):h) + ":"
            + (min<10?('0'+min):min);
        if(showSec == true) {
            result = result + ":"
                + (sec<10?('0'+sec):sec) + "."
                + (msec<10?('0'+msec):msec);
        }
        return result;
    };
    //显示日期及时间
    this.formatDatetime=function (val, row) {
        if(val == undefined || val=="") {
            return "";
        } else {
            var date = new Date(val);
            return this.datetimeFormatter(date, true);
        }
    };
    //显示日期及时间，时间到分钟
    this.formatDatetime2Min=function (val, row) {
        if(val == undefined || val=="") {
            return "";
        } else {
            var date = new Date(val);
            return this.datetimeFormatter(date, false);
        }
    };
    this.datetimeParser=function (s){
        if (!s) return new Date();
        var kk = s.split(' ');

        var ss = kk[0].split('-');
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);

        var yy = kk[1].split(":");
        var h = parseInt(yy[0].startsWith("0")?yy[0][1]:yy[0]);
        var min = parseInt(yy[1].startsWith("0")?yy[1][1]:yy[1]);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d, h, min);
        } else {
            return new Date();
        }
    };
    this.chinesseDateformatter=function (date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'年'+(m<10?('0'+m):m)+'月'+(d<10?('0'+d):d)+'日';
    };
    this.formatAuditStatus=function (val, row) {
        if(val == undefined || val == 0) {
            return "";
        } else {
            return '<span class="icon2 r1_c1"></span>';
        }
    };
    //格式化货币
    this.currencyFormatter=function (val) {
        if(val == undefined || val=="") {
            return "";
        } else {
            return parseFloat(val).formatMoney(2, "");
        }
    };
    this.currencyFormatterWithYuan=function (val) {
        if(val == undefined || val=="") {
            return "";
        } else {
            return '¥' + parseFloat(val).formatMoney(2, "");
        }
    };
    /**
     * 金额转汉字写法
     * @param currencyDigits
     * @returns {*}
     */
    this.convertCurrency=function (currencyDigits) {
        var flag="";
        if(typeof currencyDigits== 'string'){
            flag=currencyDigits.indexOf("-")==-1?"":"负";//正负标志
            currencyDigits=currencyDigits.indexOf("-")!=-1?currencyDigits.substring(1):currencyDigits;
        }else{
            if(currencyDigits<0){
                flag="负";
                currencyDigits=currencyDigits*-1;
            }else{
                flag="";
            }
        }
        // Constants:
        var MAXIMUM_NUMBER = 99999999999.99;
        // Predefine the radix characters and currency symbols for output:
        var CN_ZERO = "零";
        var CN_ONE = "壹";
        var CN_TWO = "贰";
        var CN_THREE = "叁";
        var CN_FOUR = "肆";
        var CN_FIVE = "伍";
        var CN_SIX = "陆";
        var CN_SEVEN = "柒";
        var CN_EIGHT = "捌";
        var CN_NINE = "玖";
        var CN_TEN = "拾";
        var CN_HUNDRED = "佰";
        var CN_THOUSAND = "仟";
        var CN_TEN_THOUSAND = "万";
        var CN_HUNDRED_MILLION = "亿";
        var CN_SYMBOL = "";
        var CN_DOLLAR = "元";
        var CN_TEN_CENT = "角";
        var CN_CENT = "分";
        var CN_INTEGER = "整";

        // Variables:
        var integral; // Represent integral part of digit number.
        var decimal; // Represent decimal part of digit number.
        var outputCharacters; // The output result.
        var parts;
        var digits, radices, bigRadices, decimals;
        var zeroCount;
        var i, p, d;
        var quotient, modulus;

        // Validate input string:
        currencyDigits = currencyDigits.toString();
        if (currencyDigits == "") {
            //alert("Empty input!");
            return "";
        }
        if (currencyDigits.match(/[^,.\d]/) != null) {
            alert("Invalid characters in the input string!");
            return "";
        }
        if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
            alert("Illegal format of digit number!");
            return "";
        }

        // Normalize the format of input digits:
        currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma
        // delimiters.
        currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the
                                                            // beginning.
        // Assert the number is not greater than the maximum number.
        if (Number(currencyDigits) > MAXIMUM_NUMBER) {
            alert("Too large a number to convert!");
            return "";
        }

        // Process the coversion from currency digits to characters:
        // Separate integral and decimal parts before processing coversion:
        parts = currencyDigits.split(".");
        if (parts.length > 1) {
            integral = parts[0];
            decimal = parts[1];
            // Cut down redundant decimal digits that are after the second.
            decimal = decimal.substr(0, 2);
        } else {
            integral = parts[0];
            decimal = "";
        }
        // Prepare the characters corresponding to the digits:
        digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE,
            CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
        radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
        bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
        decimals = new Array(CN_TEN_CENT, CN_CENT);
        // Start processing:
        outputCharacters = "";
        // Process integral part if it is larger than 0:
        if (Number(integral) > 0) {
            zeroCount = 0;
            for (i = 0; i < integral.length; i++) {
                p = integral.length - i - 1;
                d = integral.substr(i, 1);
                quotient = p / 4;
                modulus = p % 4;
                if (d == "0") {
                    zeroCount++;
                } else {
                    if (zeroCount > 0) {
                        outputCharacters += digits[0];
                    }
                    zeroCount = 0;
                    outputCharacters += digits[Number(d)] + radices[modulus];
                }
                if (modulus == 0 && zeroCount < 4) {
                    outputCharacters += bigRadices[quotient];
                }
            }
            outputCharacters += CN_DOLLAR;
        }
        // Process decimal part if there is:
        if (decimal != "") {
            for (i = 0; i < decimal.length; i++) {
                d = decimal.substr(i, 1);
                if (d != "0") {
                    outputCharacters += digits[Number(d)] + decimals[i];
                }
            }
        }
        // Confirm and return the final output string:
        if (outputCharacters == "") {
            outputCharacters = CN_ZERO + CN_DOLLAR;
        }
        if (decimal == "") {
            outputCharacters += CN_INTEGER;
        }
        outputCharacters = CN_SYMBOL +flag+ outputCharacters;
        return outputCharacters;
    };
}
var formatter=new Formatter();