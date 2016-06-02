window.showFlag = true;
function rowStyler(index,row){
	if (row.matched == undefined){
		return ''; 
	} else if (row.matched){
		return 'background-color:lightgreen;'; 
	} else {
		return 'background-color:orange;';
	}
}

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
					window.dataA = response.a;
					window.dataB = response.b;
					$("#auditTableA").datagrid({
						rowStyler:rowStyler,
						columns:auditTableColumnsConfig,
						data:response.a
					});
					$("#auditTableB").datagrid({
						rowStyler:rowStyler,
						columns:auditTableColumnsConfig,
						data:response.b
					});
				}
			}); 
	}
}

function autoMatch() {
	var dataA = $("#auditTableA").datagrid("getData")
	var dataB = $("#auditTableB").datagrid("getData")
	
	for (var i=0; i<dataA.rows.length; i++) {
		var dataItemA = dataA.rows[i];
		for (var j=0; j<dataB.rows.length; j++) {
			var dataItemB = dataB.rows[j];
			if(dataItemB.matched != true && _.isEqual(dataItemA, dataItemB)	) {
				console.log("matched.....")
				dataItemA.matched = true;
				dataItemB.matched = true;
			} 
		}
	}
	for (var k=0; k<dataA.rows.length; k++) {
		var dataItemA = dataA.rows[k];
		if(dataItemA.matched == undefined) {
			dataItemA.matched = false;
		} 
		var dataItemB = dataB.rows[k];
		if(dataItemB.matched == undefined) {
			dataItemB.matched = false;
		} 
	}
	
	$("#auditTableA").datagrid("loadData",dataA)
	$("#auditTableB").datagrid("loadData",dataB)
}

function showMatchItems() {
	if(showFlag) {
		var dataA = $("#auditTableA").datagrid("getData")
		var dataB = $("#auditTableB").datagrid("getData")
		
		var _dataA = {total: dataA.total, rows:[]};
		var _dataB = {total: dataA.total, rows:[]};
		
		for (var k=0; k<dataA.rows.length; k++) {
			var dataItemA = dataA.rows[k];
			if(!dataItemA.matched) {
				_dataA.rows.push(dataA.rows[k]);
			} 
			var dataItemB = dataB.rows[k];
			if(!dataItemB.matched) {
				_dataB.rows.push(dataB.rows[k]);
			} 
		}
		console.log(_dataA.rows);
		$("#auditTableA").datagrid("loadData",_dataA)
		$("#auditTableB").datagrid("loadData",_dataB)
		window.showFlag = false;
	} else {
		$("#auditTableA").datagrid("loadData",dataA)
		$("#auditTableB").datagrid("loadData",dataB)
		window.showFlag = true;
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

    $("#btnAutoMatch").click(autoMatch)
    $("#btnShowMatchItems").click(showMatchItems)
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