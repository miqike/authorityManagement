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

function doInitGrid() {
	$("#_auditApproach_").html(auditApproach);
	
	$("#btnAutoMatch").click(autoMatch);
	// var auditTask = $('#grid1').datagrid('getSelected');
	var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	var param = {hcrwId: auditItem.hcrwId, hcsxId: auditItem.hcsxId};
	$.post("../audit/getCompareInfo", param,
		function(response){
			if(response.a == null ) {
				$.messager.alert("未找到公示数据");
			} else {
				window.dataA = response.a;
				window.dataB = response.b;
				window.dataC = response.c;
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
	/*if(auditTask.dataLoaded == 0) {
		$.messager.alert('失败', "首先需要加载数据", 'info');
	} else {

	}*/
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
						dataItemC.matched = true;
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
			var dataItemC = dataC.rows[k];
			if(dataItemC.matched == undefined) {
				dataItemC.matched = false;
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
		var dataC = $("#auditTableC").datagrid("getData")
		
		var _dataA = {total: dataA.total, rows:[]};
		var _dataB = {total: dataA.total, rows:[]};
		var _dataC = {total: dataA.total, rows:[]};
		
		for (var k=0; k<dataA.rows.length; k++) {
			var dataItemA = dataA.rows[k];
			if(!dataItemA.matched) {
				_dataA.rows.push(dataA.rows[k]);
			} 
			var dataItemB = dataB.rows[k];
			if(!dataItemB.matched) {
				_dataB.rows.push(dataB.rows[k]);
			} 
			var dataItemC = dataC.rows[k];
			if(!dataItemC.matched) {
				_dataC.rows.push(dataC.rows[k]);
			} 
		}
		$("#auditTableA").datagrid("loadData",_dataA)
		$("#auditTableB").datagrid("loadData",_dataB)
		$("#auditTableC").datagrid("loadData",_dataC)
		window.showFlag = false;
	} else {
		$("#auditTableA").datagrid("loadData",dataA)
		$("#auditTableB").datagrid("loadData",dataB)
		$("#auditTableC").datagrid("loadData",dataC)
		window.showFlag = true;
	}
}
