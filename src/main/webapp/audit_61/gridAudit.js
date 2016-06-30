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
	$("#_auditApproach_").html(auditApproach);
	
	$("#btnAutoMatch").click(autoMatch);
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
					$("#auditTableC").datagrid({
						rowStyler:rowStyler,
						columns:auditTableColumnsConfig,
						data:response.c
					});
				}
			}); 
	}
}

function autoMatch() {
	var dataA = $("#auditTableA").datagrid("getData")
	var dataB = $("#auditTableB").datagrid("getData")
	var dataC = $("#auditTableB").datagrid("getData")
	
	if(dataB.rows.length > 0) {
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
	}
	
	$("#auditTableA").datagrid("loadData",dataA)
	$("#auditTableB").datagrid("loadData",dataB)
	$("#auditTableB").datagrid("loadData",dataC)
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
		$("#auditTableA").datagrid("loadData",_dataA)
		$("#auditTableB").datagrid("loadData",_dataB)
		window.showFlag = false;
	} else {
		$("#auditTableA").datagrid("loadData",dataA)
		$("#auditTableB").datagrid("loadData",dataB)
		window.showFlag = true;
	}
}
