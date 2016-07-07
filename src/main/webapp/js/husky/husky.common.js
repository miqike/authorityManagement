//webeye.js/jquery.subscribe.js/base64.js
//JS常量
window.loginUrl = "https://isc.kysoft.com:9443/cas/login?service=http://ntims.kysoft.com:8080/ntims/cas";

//设置AJAX请求不缓存
$.ajaxSetup({cache:false});

jQuery.husky = {
	SUCCESS: "1",
    FAIL: "-1",
	combineErrorMessage: function(data) {
	    return data.message + '<br/><a href="#" onclick="alert(\'' + data.error + '\');">查看异常码</a>';
	},

	getUserInfo: function() {
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
	},
	
	processorOrgId: function(orgId) {
		var result = orgId;
		while(result.endsWith("00")) {
			result = result.substr(0,result.length - 2);
		}
		return result;
	},
	
	removeIdBeforeSlash: function(text) {
	    if (text != undefined) {
	        var result = "";
	        var array;
	        if (text.contains(";")) {
	            array = text.split(";");
	        } else {
	            array = new Array();
	            array.push(text);
	        }
	        
	        for (var index = 0; index<array.length; index++) {
	        	console.log(index)
	            if (text.contains("/")) {
	                result += array[index].split("/")[1];
	            } else {
	                result += array[index];
	            }
	            if(index < array.length - 1) {
	                result += ";";
	            }
	        }
	        return result;
	    }
	},
	
    /**
     * 向页面加载数据
     * @param formId
     * @param data
     */
	 loadForm: function (formId, data) {
        function dateFormatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        };
        var elem=$('#'+formId);
        
        elem.find("input:hidden").val("");
        elem.find("input.easyui-validatebox").val("");
        elem.find("input.easyui-numberspinner").numberspinner("clear");
        elem.find("input.easyui-datebox").datebox("clear");
        elem.find("input.easyui-datetimebox").datetimebox("clear");
        elem.find("input.easyui-combobox").combobox("clear");
        elem.find("div.easyui-progressbar").progressbar("clear");
        elem.find("textarea").val("");

        if(null != data) {
    		$.each(elem.find("input"), function (idx, _elem) {
    			var _e = $(_elem);
    			if (_elem.type == "hidden" && _elem.id.match(/^\S*_/g) != null) {
    				_e.val(data[_elem.id.split("_")[1]]);
    			} else if (_e.hasClass("easyui-validatebox")) {
    				_e.val(data[_elem.id.split("_")[1]]);
    				//_e.val(removeIdBeforeSlash(data[_elem.id.split("_")[1]]));
    			} else if (_e.hasClass("easyui-numberspinner")) {
    				//var flag = _e.numberspinner('options').readonly;
    				//_e.numberspinner({hasDownArrow: !flag, disabled: flag});
					_e.numberspinner("setValue", data[_elem.id.split("_")[1]]);
    			} else if (_e.hasClass("easyui-datebox")) {
    				//var flag = _e.datebox('options').readonly;
    				//_e.datebox({hasDownArrow: !flag, disabled: flag});
    				var dateStr = data[_elem.id.split("_")[1]];
    				if (null != dateStr && undefined != dateStr) {
    					_e.datebox("setValue", dateFormatter(new Date(dateStr)));
    				}
    			} else if (_e.hasClass("easyui-datetimebox")) {
    				//var flag = _e.datetimebox('options').readonly;
    				//_e.datetimebox({hasDownArrow: !flag, disabled: flag});
    				var dateStr = data[_elem.id.split("_")[1]];
    				if (null != dateStr) {
    					var datetime = new Date(dateStr);
    					_e.datetimebox("setValue", datetimeFormatter(datetime));
    				}
    			} else if (_e.hasClass("easyui-combobox")) {
    				//var flag = _e.combobox('options').readonly;
    				//_e.combobox({hasDownArrow: !flag, disabled: flag});
    				_e.combobox("clear").combobox("setValue", data[_elem.id.split("_")[1]]);
    			} else if (_e.hasClass("easyui-filebox")) {
    				//var flag = _e.filebox('options').readonly;
    				//_e.filebox({hasDownArrow: !flag, disabled: flag});
    				_e.filebox("clear").filebox("disable"); 
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
    		elem.form("validate");
            //window.operate = 'update';
        } else {
            //window.operate = 'add';
        }
    },
    /**
     * 设置页面元素只读属性
     * @param formId
     * @param readonly
     * @param disable
     */
    setFormStatus: function (formId, formStatus) {
        var elem=$('#'+formId);
        var flag = arguments[1] ? arguments[1] : "readonly";
        	
        $.each(elem.find("input"), function(idx, _elem) {
            if($(_elem).hasClass("easyui-validatebox")) {
                if(flag == "editable" || $(_elem).hasClass(flag)) {
		        	$(_elem).removeAttr("readonly").removeAttr("disabled");
		        } else {
		        	$(_elem).attr("readonly", true).attr("disabled", true);
		        }
            } else if($(_elem).hasClass("easyui-numberspinner")) {
                if(flag == "editable" || $(_elem).hasClass(flag)) {
		        	$(_elem).numberspinner("enable");
		        } else {
		        	$(_elem).numberspinner("disable");
		        }
            } else if($(_elem).hasClass("easyui-datebox")) {
            	if(flag == "editable" || $(_elem).hasClass(flag)) {
            		$(_elem).datebox("enable");
            	} else {
            		$(_elem).datebox("disable");
            	}
            } else if($(_elem).hasClass("easyui-datetimebox")) {
            	if(flag == "editable" || $(_elem).hasClass(flag)) {
            		$(_elem).datetimebox("enable");
            	} else {
            		$(_elem).datetimebox("disable");
            	}
            } else if($(_elem).hasClass("easyui-combobox")) {
            	if(flag == "editable" || $(_elem).hasClass(flag)) {
            		$(_elem).combobox("enable");
            	} else {
            		$(_elem).combobox("disable");
            	}
            } else if($(_elem).hasClass("easyui-filebox")) {
            	if(flag == "editable" || $(_elem).hasClass(flag)) {
            		$(_elem).filebox("enable");
            	} else {
            		$(_elem).filebox("disable");
            	}
            }
        });

        $.each(elem.find("textarea"), function(idx, _elem) {
        	if(flag == "editable" || $(_elem).hasClass(flag)) {
	        	$(_elem).removeAttr("readonly").removeAttr("disabled");
	        } else {
	        	$(_elem).attr("readonly", true).attr("disabled", true);
	        }
        });
    },
    /**
     * 从页面获取数据，页面元素ID以<字母_>开头
     * @param formElemId
     * @returns {{}}
     */
    getFormData: function (formElemId, noUnderscore) {
    	
        var form = $("#" + formElemId);
        var data = {};

        $.each(form.find("input:hidden"), function (idx, elem) {
        	if(elem.id != undefined && elem.id != "") {
	        	if(noUnderscore != undefined)
	        		data[elem.id] = $(elem).val();
	        	else 
	        		data[elem.id.split("_")[1]] = $(elem).val();
        	}
        })
        $.each(form.find("input.easyui-validatebox"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).val();
        	else 
        		data[elem.id.split("_")[1]] = $(elem).val();
        });
        $.each(form.find("input.easyui-numberspinner"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).numberspinner("getValue");
        	else 
            	data[elem.id.split("_")[1]] = $(elem).numberspinner("getValue");
        });
        $.each(form.find("input.easyui-datebox"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).datebox("getValue");
        	else 
            	data[elem.id.split("_")[1]] = $(elem).datebox("getValue");
        });
        $.each(form.find("input.easyui-datetimebox"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).datetimebox("getValue");
        	else 
        		data[elem.id.split("_")[1]] = $(elem).datetimebox("getValue");
        });
        $.each(form.find("input.easyui-combobox"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).combobox("getValue");
        	else 
            	data[elem.id.split("_")[1]] = $(elem).combobox("getValue");
        })
        $.each(form.find("textarea"), function (idx, elem) {
        	if(noUnderscore != undefined)
        		data[elem.id] = $(elem).val();
        	else 
            	data[elem.id.split("_")[1]] = $(elem).val();
        })
        return data;
    },

    refreshParent: function(gridId, data) {
    	var grid = $("#" + gridId);
    	var row = grid.datagrid("getSelected");
    	var rowIndex = grid.datagrid("getRowIndex", row);
    	grid.datagrid("updateRow", {index: rowIndex, row: data});
    },
    
    ramble: function(direction, gridId, formId) {
    	var grid = $("#" + gridId);
    	var oriRow, oriRowIndex, targetRow, targetRowIndex, rowCount;
    	rowCount = grid.datagrid("getRows").length;
    	oriRow = grid.datagrid("getSelected");
    	oriRowIndex = grid.datagrid("getRowIndex", oriRow);
    	targetRowIndex = this.getTargetRowIndex(grid, direction, oriRowIndex, rowCount);
    	this.selectRow(grid, formId, oriRowIndex, targetRowIndex);
    },
    
    getTargetRowIndex: function(grid, direction, oriRowIndex, rowCount) {
    	if(oriRowIndex == -1) { //新增状态
    		if(direction == "first" || direction == "previous") {
    			targetRowIndex = 0;
    		} else {
    			targetRowIndex = rowCount - 1;
    		}
    	} else {
    		if(direction == "first") {
    			if(oriRowIndex > 0) {
    				targetRowIndex = 0;
    			} else {
    				$.messager.alert("操作提示", "已经是第一条记录", "error");
    			}
    		} else if(direction == "previous") {
    			if(oriRowIndex > 0) {
    				targetRowIndex = oriRowIndex - 1;
    			} else {
    				$.messager.alert("操作提示", "已经是第一条记录", "error");
    			}
    		} else if(direction == "next") {
    			if(oriRowIndex < rowCount - 1) {
    				targetRowIndex = oriRowIndex + 1;
    			} else {
    				$.messager.alert("操作提示", "已经是最后一条记录", "error");
    			}
    		} else if(direction == "last") {
    			if(oriRowIndex < rowCount - 1) {
    				targetRowIndex = rowCount - 1;
    			} else {
    				$.messager.alert("操作提示", "已经是最后一条记录", "error");
    			}
    		} 
    	}
    	return targetRowIndex;
    },
    
    selectRow: function(grid, formId, oriRowIndex, targetRowIndex) {
    	if(targetRowIndex != null) {
    		grid.datagrid("unselectRow", oriRowIndex)
    		grid.datagrid("selectRow", targetRowIndex)
    		$.husky.loadForm(formId, grid.datagrid("getSelected"));
    	}
    },
    
    /**
     * 比较DATAGRID数据
     */
    showDiff: function () {
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
    }
};

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
    
    $.fn.linkbutton.defaults = {
        id: null,
        disabled: false,
        toggle: false,
        selected: false,
        group: null,
        plain: false,
        text: '',
        iconCls: null,
        iconAlign: 'left',
        size: 'small',	// small,large
        onClick: function () {
        	if(!$(this).linkbutton('options').disabled) {
	        	var btnId = $(this).attr("id");
	        	if(btnId != null && btnId != undefined && btnId != "" && btnId.startsWith("btn")) {
	        		var functionName = btnId.substr(3,1).toLowerCase() + btnId.substring(4);
	        		if(eval("window." + functionName) != undefined && eval("typeof window." +functionName) == "function") {
	        			eval( functionName + "();");
	        		}
	        	}
        	}
        }
    };

})(jQuery);


if(typeof(hotkeys) != 'undefined') {
	hotkeys.filter = function(event){
	    return true;
	}
	
	// 定义快捷键
	hotkeys('ctrl+f11',function(event,handler){
		top.layoutFullScreen();
});
}

