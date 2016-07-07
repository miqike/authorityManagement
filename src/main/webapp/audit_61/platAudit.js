function doInitPlat() {
	$("#_auditApproach_").html(auditApproach);

	var auditTask = $('#grid1').datagrid('getSelected');
	/*if(auditTask.dataLoaded == 0) {
		$.alert("首先需要加载数据");
	} else {*/
	var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	var param = {hcrwId: auditItem.hcrwId, hcsxId: auditItem.hcsxId};
	$.post("../audit/getCompareInfo", param,
		function(response){
			if(response.a == null ) {
				$.alert("未找到公示数据");
			} else {
				var data = [];
				for(var i=0; i<auditConfig.length; i++) {
					data.push({
						"xm": auditConfig[i][1],
						"a": response.a == null? "": trans(response.a[auditConfig[i][0]], auditConfig[i][2]),
						"b": response.b == null? "": trans(response.b[auditConfig[i][0]], auditConfig[i][2]),
						"c": response.c == null? "": trans(response.c[auditConfig[i][0]], auditConfig[i][2]),
						"result": _getCompareResultPlat(response.a, response.b, response.c, auditConfig[i][0])
					});
				}
				$("#auditTable").datagrid("loadData",data);
			}
		}); 
	//}
}

function _getCompareResultPlat(a,b,c, config) {
	var compareSource = $("#_dbxxly_").text();
	a=((a==null)?"":a[config]);
	b=((b==null)?"":b[config]);
	c=((c==null)?"":c[config]);
	var result;
	if(compareSource == "登记/备案" ) {
		result = (a==b);
	} else if(compareSource == "实际") {
		result = (a==c);
	} else {
		result = (a==b && a==c);
	}
	return result? "一致": "不一致";
}

function trans(val, codeName) {
	if(codeName != undefined) {
		var code = $.codeListLoader.getCode(codeName, val);
		if(null == code) {
			return val + ": 无法找到编码";
		} else {
			return code.literal;
		}
	} else {
		return val;
	}
}

function resultStyler(val, row) {
	if(val == "一致") {
		return "background-color: lightgreen";
	} else {
		return "background-color: orange";
	}
}

function formatCompareColPlat(val, row) {
	var rc = row.a;
	if(val != null ) {
		if(rc == val) {
			return "<span style='color:green;'>" + val + "</span>";
		} else {
			return "<span style='color:red;'>" + val + "</span>";
		} 
	}
}

function stylerRegistPlat(val, row, index) {
	var compareSource = $("#_dbxxly_").text();
	if(compareSource == "登记/备案" || compareSource == "登记/备案+实际") {
		return "background-color:#white";
	} else {
		return "background-color:#ebeced";
	}
}

function stylerActualPlat(val, row, index) {
	var compareSource = $("#_dbxxly_").text();
	if(compareSource == "实际" || compareSource == "登记/备案+实际") {
		return "background-color:#white";
	} else {
		return "background-color:#ebeced";
	}
}
