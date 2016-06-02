function doInit() {
	var auditTask = $('#grid1').datagrid('getSelected');
	if(auditTask.dataLoaded == 0) {
		$.alert("首先需要加载数据");
	} else {
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
							"result": response.a[auditConfig[i][0]] == response.b[auditConfig[i][0]] ? "一致": "不一致"
						});
					}
					$("#auditTable").datagrid("loadData",data);
					
				}
			}); 
	}
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

$(function () {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#_hcrwId_").text(auditItem.hcrwId);
    $("#_hcsxId_").text(auditItem.hcsxId);

    $("#_qygsnr_").text(auditItem.qygsnr == null ? "" : auditItem.qygsnr);
    $("#_bznr_").text(auditItem.bznr == null ? "" : auditItem.bznr);
    $("#_qymc_").text(qy.hcdwName);
    $("#_hcsxmc_").text(auditItem.name);

    $("#btnSuccess").click(function () {
        $.post("../audit/complete", {
            hcrwId: $("#_hcrwId_").text(),
            hcsxId: $("#_hcsxId_").text(),
            hcjg: 1,
            qymc: $("#_qymc_").text(),
            hcsxmc: $("#_hcsxmc_").text()
        }, function (response) {
            if (response.status == SUCCESS) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                $("#annualAuditItemGrid").datagrid("reload");
                closeAuditWindow();
            } else {
                $.messager.alert('错误', response.message, 'error');
            }
        });
    });
    $("#btnFail").click(function () {
        $.post("../audit/complete", {
            hcrwId: $("#_hcrwId_").text(),
            hcsxId: $("#_hcsxId_").text(),
            hcjg: 2,
            qymc: $("#_qymc_").text(),
            hcsxmc: $("#_hcsxmc_").text()
        }, function (response) {
            if (response.status == SUCCESS) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                $("#annualAuditItemGrid").datagrid("reload");
                closeAuditWindow();
            } else {
                $.messager.alert('错误', response.message, 'error');
            }
        });
    });
    $("#btnClose").click(closeAuditWindow);
});