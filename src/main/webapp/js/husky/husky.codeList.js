/**
 * 应用标准Select
 */
function extend(obj, property){
    obj = obj || {};
    for(var i in property){
        obj[i] = property[i];
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
			if(this.codeNames.length > 0)
				this.loadCodeListData();
		}
	};

	codeListLoader.getCodeListElts = function () {
		return $("select[codeName]");
	};

	codeListLoader.getIncrement = function () {
		var codeListLoader = this;
		codeListLoader._incrementElts = [];
		codeListLoader.incrementCodeNames = [];
		$("select[codeName]").each(function(index) {
			if($.inArray(this, codeListLoader._elts) == -1) {
				codeListLoader._incrementElts.push(this);
				var codeName = $(this).attr("codeName");
				if($.inArray(codeName, codeListLoader.codeNames) == -1 && $.inArray(codeName, codeListLoader.incrementCodeNames) == -1)
					codeListLoader.incrementCodeNames.push(codeName);
			} 
		});
		codeListLoader._elts = codeListLoader.getCodeListElts();
		
	};

	//从后台加载数据
	codeListLoader.loadCodeListData = function () {
		if(codeListLoader.codeNames.length == 0){
			$.publish("CODELIST_INITIALIZED", null);
		} else {
			this.load(false);
		}
	};
	
	//加载增量数据
	codeListLoader.loadIncrementCodeListData = function () {
		var codeListLoader = this;
		if(codeListLoader.incrementCodeNames.length == 0){
			this.rend(this._incrementElts);
			$.publish("CODELIST_INITIALIZED", null);
		} else {
			this.load(true);
		}
	};
	
	codeListLoader.load = function(increment) {
		var codeListLoader = this;
		if(this.codeNames.length > 0)
		$.ajax({
			type: "GET",
			url: "../common/codeList",
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
				$.publish("CODELIST_INITIALIZED", null);
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
	
	codeListLoader.rend = function (_elts) {
		var data = this.data;
		/*
		$(_elts).each(function(index) {
			var codeList = data[$(this).attr("codeName")];
			if(codeList != undefined){//能够取到代码
				//codeList.reverse().push({"literal":"请选择...", name:"", value:null});
				$(this).combobox().combobox('loadData', codeList);
				//$(this).combobox().combobox('setValue', '请选择...');
			}
		});
		*/
		$(_elts).each(function(index) {
			//codeListLoader.addOption(this, "请选择...", '-999');		
			var codeList = data[$(this).attr("codeName")];
			if(codeList != undefined){//能够取到代码
				var _elt = this;
				jQuery.each(codeList, function(idx) {	
//					if (this.value != '')  {
						codeListLoader.addOption(_elt, this.literal, this.value, this.style);
//					}
				});
				if(_elt.defaultValue != undefined)
					_elt.value = element.defaultValue;
			}
		});
	};
	
	codeListLoader.addOption = function(_elt, literal, value, style) {
		var _option = document.createElement("option");
		_option.text = literal;
		_option.value = value;
		if(style != null)
			$(_option).attr('style', style);
		_elt.options.add(_option);
	};
	
	codeListLoader.getCodeNames = function (_elts) {
		var codeNames = [];
		_elts.each(function(index) {
			var codeName = $(this).attr("codeName");
			if($.inArray(codeName, codeNames) == -1)
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
			if(param.length > 0)
			$.ajax({
				async: false,
				type: "GET",
				url: "../common/codeList",
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
	
	codeListLoader.setValue = function(elemId, value) {
		
		var elem = $("#" + elemId);
		if(codeListLoader.INITIALIZED) {
			elem.val(value);
		} else {
			$.subscribe("CODELIST_INITIALIZED", function(){
				elem.val(value);
			});
		}
	};
	
	codeListLoader.dynamicLoad = function(eltName) {
		var _elt = $(eltName);
		var codeName = _elt.attr("codeName");
		if(codeName != undefined)
		$.ajax({
			type: "GET",
			url: "../common/codeList",
			data: {'codeNames': [codeName]},
			dataType: "json",
			success: function(response){
				_elt.empty();
				//codeListLoader.addOption(_elt[0], "请选择...", '-999');	
				jQuery.each(response.data[codeName], function(value, code) {
					codeListLoader.addOption(_elt[0], code.literal, code.value);
				});
			}
		});
	};

	$.extend({codeListLoader: codeListLoader});
})(jQuery);

//转化CODE值
function formatCode(value, codeName) {
	try {
		if(value == null) {
			return "";
		} else {
			var code = $.codeListLoader.getCode(codeName, value);
			var result = code.literal;
			return result;
		}
	} catch(e) {
		return "";
	}
}

$(function(){
	$.codeListLoader.init(false);
});
