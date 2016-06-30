function doInit() {
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
							"a": trans(response.a[auditConfig[i][0]], auditConfig[i][2]),
							"b": trans(response.b[auditConfig[i][0]], auditConfig[i][2]),
							"c": trans(response.c[auditConfig[i][0]], auditConfig[i][2]),
							"result": response.a[auditConfig[i][0]] == response.b[auditConfig[i][0]] ? "一致": "不一致"
						});
					}
					$("#auditTable").datagrid("loadData",data);
					
				}
			}); 
	//}
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
