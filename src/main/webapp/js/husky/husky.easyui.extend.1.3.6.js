/**
 * 针对JEasyUI 1.3.6
 *  定义全局对象，在全局对象上扩展需要的方法
 */
jQuery.easyuiExtendObj = {
    

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
    loadForm:function (formId, data) {
        function dateFormatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        };
        var elem=$('#'+formId);
        
        elem.find("input.easyui-validatebox").val("");
        elem.find("input.easyui-datebox").datebox("clear");
        elem.find("input.easyui-datetimebox").datetimebox("clear");
        elem.find("input.easyui-combobox").combobox("clear");
        elem.find("input.easyui-numberbox").numberbox("clear");
        elem.find("input.easyui-numberspinner").numberspinner("clear");
        elem.find("input.easyui-combotree").combotree("clear");
        elem.find("div.easyui-progressbar").progressbar("clear");
        elem.find("input:hidden").val("");

        if(null != data) {
            $.each(elem.find("input"), function (idx, _elem) {
                var _e = $(_elem);
                if (_e.hasClass("easyui-validatebox")) {
                	
                	$(_elem).val(data[_elem.id.split("_")[1]]);
                         
                    var flag = _e.validatebox('options').readonly;
                    //_e.textbox({disabled: flag});
                    _e.val(data[_elem.id.split("_")[1]]);
                    //_e.val(removeIdBeforeSlash(data[_elem.id.split("_")[1]]));
                } else if (_e.hasClass("easyui-datebox")) {
                    var flag = _e.datebox('options').readonly;
                    _e.datebox({hasDownArrow: !flag, disabled: flag});
                    var dateStr = data[_elem.id.split("_")[1]];
                    if (null != dateStr && undefined != dateStr) {
                        _e.datebox("setValue", dateFormatter(new Date(dateStr)));
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
    setFormReadonly:function (formId, readonly) {
        var elem=$('#'+formId);
        var disable = arguments[2] ? arguments[2] : false;
        $.each(elem.find("input"), function(idx, _elem) {
            if($(_elem).hasClass("easyui-validatebox")) {
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

        $.each(form.find("input:hidden"), function (idx, elem) {
        	data[elem.id.split("_")[1]] = $(elem).val();
        })
        $.each(form.find("input.easyui-validatebox"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).val();
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
        $.each(form.find("textarea"), function (idx, elem) {
            data[elem.id.split("_")[1]] = $(elem).val();
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

        $.each(form.find("input.easyui-validatebox"), function (idx, elem) {
            data[elem.id] = $(elem).val();
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
};

