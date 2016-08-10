<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function doEnterpriseTypeListSave() {
		var hcsx = $("#mainGrid").datagrid("getSelected");
		var selectedNodes = $("#enterpriseTypeGrid").datagrid("getSelections");

		var param = new Array();
		$.each(selectedNodes, function(idx, elem) {
			param.push(elem.QYLX_ID);
		});
		
		$.ajax({
			url: "./auditItemEnterpriseType/" + hcsx.id,
			data: JSON.stringify(param),
			type: "post",
			contentType: "application/json; charset=utf-8",
			cache: false,
			success: function (response) {
				if (response.status == SUCCESS) {
					$('#grid2').datagrid('reload');
					//$.messager.alert("提示", "操作成功", 'info');
					$.messager.show("操作提醒", response.message, "info", "bottomRight");
				} else {
					$.messager.alert('提示', response.message, 'error');
				}
			}
		});
	}

	function doEnterpriseTypeListInit() {
		$.getJSON("../common/query?mapper=auditItemEnterpriseTypeMapper&queryName=queryForAuditItem",  {
			hcsxId:$("#mainGrid").datagrid("getSelected").id
		}, function (response) {
		    if (response.status == SUCCESS) {
		    	$("#enterpriseTypeGrid").datagrid("loadData", response.rows);
		    	for(var i=0; i<response.rows.length; i++) {
		    		var row = response.rows[i];
		    		if(row.HCSX_ID != undefined) {
		    			$("#enterpriseTypeGrid").datagrid('selectRow', i);
		    		}
		    	}
		    }
		});
	}
	
</script>

<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcsxId_"></span>
    </div>
    
    <table id="enterpriseTypeGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,height:300,width:450,
				ctrlSelect:false,method:'get'">
        <thead>
        <tr>
        	<th data-options="field:'HCSX_ID',checkbox:true"></th>
			<th data-options="field:'QYLX_ID',halign:'center',align:'center'" sortable="true" width="100">企业类型编码</th>
            <th data-options="field:'QYLX_NAME',halign:'center',align:'left'" sortable="true" width="250">企业类型名称</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
 