<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function funcSaveComment() {
		var data = $.easyuiExtendObj.drillDownForm('addCommentWindow');
		/* data.id = $("#p_id").val();
		data.hcsxId = $("#p_hcsxId").val();
		data.hcsxmc = $("#p_hcsxmc").val();
		data.name = $("#p_name").val(); */
		
	    var type = "POST";
	    var url = "./comment";
	    $.ajax({
	        url: url,
	        type: type,
	        data: data,
	        success: function (response) {
	            if (response.status == SUCCESS) {
	                //$("#commentGrid").datagrid("reload");
	                loadCommentGrid($("#mainGrid").datagrid("getSelected").id);
	                //$("#mainGrid").datagrid("reload");
	                $("#addCommentWindow").window("close");
	                $.messager.show({
						title : '提示',
						msg : "核查事项常见问题保存成功"
					});
	            } else {
	                $.messager.alert('核查事项常见问题保存失败', response.message, 'error');
	            }
	        }
	    }); 
	}
	
	function doInit() {
		$.codeListLoader.parse($("#addCommentWindow"));
		var hcsx =  $("#mainGrid").datagrid("getSelected");
		$("#p_hcsxId").val(hcsx.id);
		var sm= $("#commentGrid").datagrid("getSelected");
		if(sm!=null) {
			$.easyuiExtendObj.loadForm("addCommentWindow", sm);
		}
		//$("#p_hcsxmc").val(hcsx.name);
	}
	/* 
	function setForm(value) {
		var hccl = null;
		if(value != null) {
			var hcclArray = $("#p_hcclId").combobox("getData");
			for(var i=0; i<hcclArray.length; i++) {
				if(hcclArray[i].id == value) {
					hccl = hcclArray[i];
					break;
				}
			}
		}

		if(hccl == null ) {
    		$("#p_sfbyx").combobox("clear");
    		$("#p_wjlx").combobox("clear");
    		$("#p_yhtg").combobox("clear");
    		$("#btnUpload").linkbutton("disable");
		} else {
			$("#p_sfbyx").combobox("setValue", hccl.sfbyx);
    		$("#p_wjlx").combobox("setValue", hccl.wjlx);
    		$("#p_yhtg").combobox("setValue", hccl.yhtg);
    		$("#p_ly").combobox("setValue", 2);
    		$("#btnUpload").linkbutton("enable");
		}
	} */
	
</script>
<div id="addCommentWindow" style="padding-left:15px; padding-top:15px;">
    <table>
		<tr>
			<td class="label">比对信息来源</td><td><input class="easyui-combobox" id="p_dbxxly" style="width:200px;" data-options=""  codeName="sjly"/></td>
		</tr>
    	<tr>
    		<td class="label" valign="top" >常见问题说明</td>
    		<td>
    			<input type="hidden" id="p_id" />
    			<input type="hidden" id="p_hcsxId" />
				<textarea id="p_content" cols="70" rows="2" style="width:475px;font-size:13px"></textarea>
			</td>
    	</tr>
    	<tr>
    		<td class="label">排序权重</td><td><input class="easyui-validatebox" id="p_weight" validType='integer'/></td>
    	</tr>
	</table>
</div>
