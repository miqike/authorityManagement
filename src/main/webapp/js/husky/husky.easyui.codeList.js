/**
 * 应用easyui的CodeList
 */
function extend(obj, property){
    obj = obj || {};
    for(var i in property){
        obj[i] = property[i];
    }
}

function formatCodeList(value, row) {
	var codeName = $("th[data-options*=\"field:'" + this.field + "'\"][codeName]:first").attr("codeName");
	try {
		if(value == null) {
			return "";
		} else {
			var code = $.codeListLoader.getCode(codeName, value);
			var result = code.literal;
			if(code.style != "") {
				result = "<span style=\"" + code.style + "\">" + result + "</span>"
			}
			return result;
		}
	} catch(e) {
		console.log("代码未配置： " + codeName + " - " + value);
	}
}

(function($) {
	var codeListLoader = {};

	codeListLoader.init = function(increment) {
		codeListLoader.INITIALIZED = false;
		if(increment) {
			this.getIncrement();
			this.loadIncrementCodeListData();
		} else {
			this.data = null;
			this._elts = this.getCodeListElts();
			this.codeNames = this.getCodeNames(this._elts);
			this.loadCodeListData();
		}
	};

	codeListLoader.getCodeListElts = function () {
		return $("input.easyui-combobox, th[codeName]");
	};

	codeListLoader.getIncrement = function(elt) {
		var codeListLoader = this;
		codeListLoader._incrementElts = [];
		codeListLoader.incrementCodeNames = [];
		elt.find("input.easyui-combobox, th[codeName]").each(function() {
			if($.inArray($(this), codeListLoader._elts) == -1) {
				codeListLoader._incrementElts.push(this);
				var codeName = $(this).attr("codeName");
				if(typeof codeName != "undefined" && $.inArray(codeName, codeListLoader.codeNames) == -1 && $.inArray(codeName, codeListLoader.incrementCodeNames) == -1) {
					codeListLoader.incrementCodeNames.push(codeName);}
			} 
		});
		codeListLoader._elts = codeListLoader.getCodeListElts();
		
	};

	//从后台加载数据
	codeListLoader.loadCodeListData = function () {
		if(codeListLoader.codeNames.length == 0){
			$.publish("INCREMENT_CODELIST_INITIALIZED", null);
		} else {
			this.load(false);
		}
	};
	
	//加载增量数据
	codeListLoader.loadIncrementCodeListData = function () {
		var codeListLoader = this;
		if(codeListLoader.incrementCodeNames.length == 0){
			this.rend(this._incrementElts);
			$.publish("INCREMENT_CODELIST_INITIALIZED", null);
		} else {
			this.load(true);
		}
	};
	
	codeListLoader.load = function(increment) {
		var codeListLoader = this;
		$.ajax({
			type: "GET",
			url: typeof ctx === "undefined" ? "../common/codeList" : ctx + "/common/codeList",
			data: {'codeNames': increment? this.incrementCodeNames: this.codeNames},
			dataType: "json",
			cache: true,
			success: function(response){
				if(increment) {
					extend(codeListLoader.data, response.data);
					codeListLoader.rend(codeListLoader._incrementElts);
				} else {
					codeListLoader.data = response.data;
					codeListLoader.rend(codeListLoader._elts);
				}

				if(response.userInfo) {
					window.userInfo = response.userInfo;
				}
				$.publish(increment? "INCREMENT_CODELIST_INITIALIZED": "CODELIST_INITIALIZED", null);
				codeListLoader.INITIALIZED = true;
			},
			error:function(xhr, status,e) {
				if(e.code == '1012') {
					console.log("go into your FireFox config panel (type 'about:config') and \nset the following property to 'false' by double clicking on it:\nsecurity.fileuri.strict_origin_policy");
				} else {
					console.error(e.message);
				}
			}
		});
	};
	
	codeListLoader.rend = function(_elts) {
		var data = this.data;
		$(_elts).each(function(index) {
			var _elt = $(this);
			if(_elt[0].tagName != "TH") {
				var codeName = _elt.attr("codeName")
				var codeList = data[codeName];
				if (codeName == undefined) {
					console.log("combobox元素未定义codeList属性: " + _elt[0].outerHTML);
				} else if (codeList != undefined) {//能够取到代码
					try {
						$(this).combobox({
							valueField: 'value',
							textField: 'literal',
							data: codeList//.reverse()
						});
					} catch (e) {
						var value = $(this).val();
						for(var i=0; i<codeList.length; i++) {
							if(codeList[i].value == value){
								$(this).val(codeList[i].literal);
								break;
							}
						}
					}

				} else {
					var param = [];
					param.push(codeName);
					$.ajax({
						async: false,
						type: "GET",
						url: typeof ctx === "undefined" ? "../common/codeList" : ctx + "/common/codeList",
						data: {'codeNames': param},
						dataType: "json",
						success: function (response) {
							extend(codeListLoader.data, response.data);
							codeList = codeListLoader.data[codeName];
							_elt.combobox({
								valueField: 'value',
								textField: 'literal',
								data: codeList//.reverse()
							});
						}
					});
				}
			}
		});
	};

	codeListLoader.parse = function(elt) {
		var codeListLoader = this;
		codeListLoader.getIncrement(elt);
		codeListLoader.loadIncrementCodeListData();
	};
	
	codeListLoader.getCodeNames = function(_elts) {
		var codeNames = [];
		_elts.each(function(index) {
			var codeName = $(this).attr("codeName");
			if(codeName != undefined && $.inArray(codeName, codeNames) == -1)
				codeNames.push(codeName);
		});
		return codeNames;
	};

	codeListLoader.getCode = function(codeName, value) {
		var codeListLoader = this;
		var code = null;
		if(null == this.data)
			this.data = {};
		var codeList = this.data[codeName];
		if(this.data ==null || this.data[codeName] == null) {
			var param = [];
			param.push(codeName);
			$.ajax({
				async: false,
				type: "GET",
				url: typeof ctx === "undefined" ? "../common/codeList" : ctx + "/common/codeList",
				data: {'codeNames': param},
				dataType: "json",
				success: function(response){
					extend(codeListLoader.data, response.data);
					codeList = codeListLoader.data[codeName];
				}
			});
		} 

		for(var i=0; i<codeList.length; i++) {
			if(codeList[i].value == value){
				code = codeList[i];
				break;
			}
		}
		return code;
	};
	codeListLoader.getCodeLiteral = function(codeName, value) {
		var code = codeListLoader.getCode(codeName, value);
		return code == null? "": code.literal;
	};
	
	$.extend({codeListLoader: codeListLoader});
})(jQuery);

function pinyinFilter(input, row) {
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
}

$(function(){
	$.codeListLoader.init(false);
});