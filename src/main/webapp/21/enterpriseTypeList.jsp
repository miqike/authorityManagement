<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function doEnterpriseTypeListSave() {
		
	}
	
	function doEnterpriseTypeListInit() {
		if (undefined != $.codeListLoader.data.qylxdl) {
	        _initEnterpriseTypeGrid();
	    } else {
	        $.subscribe("INCREMENT_CODELIST_INITIALIZED", _initEnterpriseTypeGrid);
	        $.codeListLoader.getCode("qylxdl");
	    }

		/* var hcrw = $("#grid2").datagrid("getSelected");
		$.getJSON("../common/query?mapper=hcclMapper&queryName=queryForTask",  {
				hcrwId:hcrw.id
			}, function (response) {
			    if (response.status == $.husky.SUCCESS) {
			    	 $("#docGrid").datagrid("loadData",response);
			    }
			});
		
		$.getJSON("../docUpload/" + hcrw.id + "/furtherDocList", function (response) {
			if (response.status == $.husky.SUCCESS) {
				if(response.data.length > 0) {
					$("#furDocgrid").parent().parent().parent().show()
					$("#furDocgrid").datagrid("loadData",response.data);
				}  else {
					$("#furDocgrid").parent().parent().parent().hide();
				}
			}
		}); */
	}
	
	function _initEnterpriseTypeGrid() {
		$("#enterpriseTypeGrid").datagrid("loadData", $.codeListLoader.data.qylxdl);
		$.getJSON("../common/query?mapper=auditItemEnterpriseTypeMapper&queryName=queryForAuditItem",  {
			hcsxId:$("#mainGrid").datagrid("getSelected").id
		}, function (response) {
		    if (response.status == SUCCESS) {
		    	console.log(response)
		    }
		});
	}
	
</script>

<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    
    <table id="enterpriseTypeGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,height:300,width:450,
				ctrlSelect:false,method:'get'">
        <thead>
        <tr>
        	<th data-options="field:'name',checkbox:true"></th>
			<th data-options="field:'value',halign:'center',align:'center'" sortable="true" width="130">企业组织形式编码</th>
            <th data-options="field:'literal',halign:'center',align:'left'" sortable="true" width="250">名称</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
 