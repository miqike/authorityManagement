<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function funcSaveDoc() {
		//$("#btnSaveDoc").linkbutton("disable");
		var data = $.easyuiExtendObj.drillDownForm('addDocWindow');
		data.id = $("#d_id").val();
		data.hcsxId = $("#d_hcsxId").val();
		data.hcsxmc = $("#d_hcsxmc").val();
		data.name = $("#d_name").val();
		
	    var type = "POST";
	    var url = "./hccl";
	    $.ajax({
	        url: url,
	        type: type,
	        data: data,
	        success: function (response) {
	            if (response.status == SUCCESS) {
	            	loadDocGrid($("#mainGrid").datagrid("getSelected").id);
	                $("#mainGrid").datagrid("reload");
	                $("#addDocWindow").window("close");
	                $.messager.show({
						title : '提示',
						msg : "检查材料保存成功"
					});
	            } else {
	                $.messager.alert('检查材料保存失败', response.message, 'error');
	            }
	        }
	    }); 
	}
	
	function doInit() {
		$.codeListLoader.parse($("#addDocWindow"));
		var hcsx =  $("#mainGrid").datagrid("getSelected");
		$("#d_hcsxId").val(hcsx.id);
		$("#d_hcsxmc").val(hcsx.name);
	}
	
	function setForm(value) {
		var hccl = null;
		if(value != null) {
			var hcclArray = $("#d_hcclId").combobox("getData");
			for(var i=0; i<hcclArray.length; i++) {
				if(hcclArray[i].id == value) {
					hccl = hcclArray[i];
					break;
				}
			}
		}

		if(hccl == null ) {
    		$("#d_sfbyx").combobox("clear");
    		$("#d_wjlx").combobox("clear");
    		$("#d_yhtg").combobox("clear");
    		$("#btnUpload").linkbutton("disable");
		} else {
			$("#d_sfbyx").combobox("setValue", hccl.sfbyx);
    		$("#d_wjlx").combobox("setValue", hccl.wjlx);
    		$("#d_yhtg").combobox("setValue", hccl.yhtg);
    		$("#d_ly").combobox("setValue", 2);
    		$("#btnUpload").linkbutton("enable");
		}
	}
	
</script>
<div id="addDocWindow" style="padding-left:5px; padding-top:5px;">
    <table>
    	<tr>
    		<td class="label">材料名称</td><td>
    			<input type="hidden" id="d_id" />
    			<input type="hidden" id="d_hcsxId" />
    			<input type="hidden" id="d_hcsxmc" />
    			<input class="easyui-validatebox" id="d_name" /></td>
    	</tr>
    	<tr>
    		<td class="label">文件类型</td><td><input class="easyui-combobox", id="d_wjlx" codeName="wjlx" data-options="panelHeight:100" /></td>
    	</tr>
    	<tr>
    		<td class="label">是否必要项</td><td><input class="easyui-combobox", id="d_sfbyx" codeName="yesno" data-options="panelHeight:70" /></td>
    	</tr>
    	<tr>
    		<td class="label">是否用户提供</td><td><input class="easyui-combobox", id="d_yhtg" codeName="yesno"  data-options="panelHeight:70" /></td>
    	</tr>
    </table>
</div>
