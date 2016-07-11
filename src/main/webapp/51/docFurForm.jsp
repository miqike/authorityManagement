<%@ page contentType="text/html; charset=UTF-8"%>
<script>

function doInitDocFurForm() {
	$.codeListLoader.parse($("#addDocFurWindow"));
	var hcrw = $("#grid1").datagrid("getSelected");
	//var hcsx = getAuditItem();
	$("#d_hcjhnd").val(hcrw.nd);
	$("#d_hcdwXydm").val(hcrw.hcdwXydm);
	$("#d_hcrwId").val(hcrw.id);
	
	$("#d_hcsxId").combobox({url: "./" + hcrw.id + "/hcsx", method:'get',valueField: 'VALUE', textField: 'LITERAL',
		onLoadSuccess: function() { $("#d_hcclId").combobox("loadData" , []);},
	});
}
 
function doSaveDocFur() {
	var data = $.husky.getFormData('addDocFurWindow');
	data.hcsxmc = $("#d_hcsxId").combobox("getText");
    var type = "POST";
    var url = "./docFur";
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: function (response) {
            if (response.status == $.husky.SUCCESS) {
                doDocFurListInit();
                $("#addDocFurWindow").window("close");
                $.messager.show('操作提示', "附加检查材料保存成功", "info", "bottomRight");
            } else {
                $.messager.alert('附加检查材料保存失败', response.message, 'error');
            }
        }
    });
}
	
</script>
<div id="addDocFurWindow" style="padding:10px;height:175px;">
    <table>
    	<tr>
    		<td class="label">检查计划年度</td><td>
    			<input type="hidden" id="d_id" />
    			<input class="easyui-validatebox" id="d_hcjhnd" disabled/>
    		<td class="label">统一社会信用代码</td><td><input class="easyui-validatebox" id="d_hcdwXydm" disabled/></td>
    	</tr>
    	<tr>
    		<td class="label">检查任务编号</td><td><input class="easyui-validatebox" id="d_hcrwId" disabled/></td>
    		<td class="label">检查事项</td><td><input class="easyui-combobox" id="d_hcsxId" data-options=""/></td>
    	</tr>
    	<tr>
    		<td class="label">材料名称</td><td colspan="3"><input class="easyui-validatebox" id="d_name" style="width:400px;"/ ></td>
    	</tr>
    	<tr>
    		<td class="label">是否必要项</td><td><input class="easyui-combobox" id="d_sfbyx" codeName="yesno" data-options="panelHeight:70" /></td>
    		<td class="label">文件类型</td><td><input class="easyui-combobox" id="d_wjlx" codeName="wjlx" data-options="panelHeight:100" /></td>
    	</tr>
		<!-- <tr>
			<td>说明</td><td colspan="3"><textarea rows="3" style="width:400px;"/></td>
		</tr> -->
    </table>
</div>
