<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function doAuditItemFormInit(operation) {
	$.codeListLoader.parse($("#baseInfo"));
	if(operation == "edit") {
    	$.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
    	$("#p_zxrq").datebox("disable")
	} else {
		var hcsx =  $("#mainGrid").datagrid("getSelected");
		console.log(hcsx);	
	}
}

function docGridClickRowHandler() {
	if($('#docGrid').datagrid('getSelected') != null) {
		$('#btnRemoveDoc').linkbutton('enable');
	} else {
		$('#btnRemoveDoc').linkbutton('disable');
	}
}

</script>
<!-- 
<div>
    <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
    <a href="javascript:void(0);" id="btnPre1" class="easyui-linkbutton" iconCls="icon-previous"
       plain="true">上一个</a>
    <a href="javascript:void(0);" id="btnNext1" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
    <a href="javascript:void(0);" id="btnFirst1" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
    <a href="javascript:void(0);" id="btnLast1" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
    <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"
       plain="true">删除</a>
	<a href="javascript:void(0);" id="btnClose1" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
</div> 
-->
<div id="baseInfo" style="padding:10px">
    <div style="display: none">
        <input class="easyui-validatebox" id="p_id" style="width:200px;"/>
        <input class="easyui-validatebox" id="p_page" style="width:200px;"/>
    </div>

    <table width="100%" id="baseTable">
        <tr>
            <td class="label">检查事项名称</td>
            <td><input class="easyui-validatebox" id="p_name" style="width:192px;" data-options="required:true"/></td>
            <td class="label">检查事项编码</td>
            <td><input class="easyui-validatebox" id="p_code" style="width:192px;" data-options="required:true"/></td>
        </tr>
        <tr>
            <td class="label">对应公示项目</td>
            <td><input class="easyui-validatebox" id="p_gsxm" style="width:192px;" data-options=""/></td>
            <td class="label">企业组织形式</td>
            <td><input class="easyui-combobox" id="p_qyzzxs" style="width:200px;" data-options=""
                       codeName="qyzzxs"/></td>
        </tr>
        <tr>
            <td class="label">描述</td>
            <td colspan="3">
            	<input class="easyui-validatebox" id="p_descript" style="width:553px;" data-options=""/>
            </td>
        </tr>
        <tr>
            <td class="label">检查方法</td>
            <td><input class="easyui-combobox" id="p_hcff" style="width:200px;" data-options="panelHeight:100"
                       codeName="hcfs"/></td>
            <td class="label">检查信息分类</td>
            <td><input class="easyui-combobox" id="p_hcxxfl" style="width:200px;" data-options="panelHeight:100"
                       codeName="hcxxfl"/></td>
        </tr>
        <tr>
            <td class="label">检查类型</td>
            <td><input class="easyui-combobox" id="p_hclx" style="width:200px;" data-options="panelHeight:100"
                       codeName="hclx"/></td>
            <td class="label">是否需要人工核对</td>
            <td><input class="easyui-combobox" id="p_sfxyrghd" style="width:200px;" data-options="panelHeight:100"
                       codeName="yesno"/>
            </td>
        </tr>
        <tr>
            <td class="label">登记/公示信息比对</td>
            <td><input class="easyui-combobox" id="p_xxdb" style="width:200px;" data-options=""
                       codeName="yesno"/></td>
			<td class="label">比对信息来源</td>
            <td><input class="easyui-combobox" id="p_dbxxly" style="width:200px;" data-options=""  codeName="sjly"/></td>                       
        </tr>
        <tr>
            <td class="label">是否必检项</td>
            <td><input class="easyui-combobox" id="p_sfbjxm" style="width:200px;" data-options="panelHeight:100"
                       codeName="yesno"/></td>
            <td class="label">是否需要实地检查</td>
            <td><input class="easyui-combobox" id="p_sfxysdhc" style="width:200px;" data-options="panelHeight:100"
                       codeName="yesno"/>
            </td>
        </tr>
        <tr>
	        <td class="label">结果处理</td>
	            <td><input class="easyui-combobox" id="p_jgcl" style="width:200px;" data-options="panelHeight:100"
	                       codeName="gsjg"/></td>
            <td class="label">改正期限</td>
            <td><input id="p_gzqx" class="easyui-validatebox" data-options="validType:'integer'"
                       style="width:180px;"/><span style="margin-left:6px;">天</span></td>
        </tr>
        <tr>
            <td class="label">注销日期</td>
            <td><input class="easyui-datebox" id="p_zxrq" style="width:200px;" data-options="disabled:true" disabled/></td>
            <td class="label">注销说明</td>
            <td><input class="easyui-validatebox" id="p_zxsm" style="width:192px;" data-options="" disabled/></td>
        </tr>
        <tr>
            <td class="label" style="vertical-align:top">检查材料</td>
            <td colspan="3">
            	<textarea id="p_hccl" cols="70" rows="2" style="width:553px" disabled></textarea></td>
        </tr>
        <tr>
            <td class="label" style="vertical-align:top">检查方法说明</td>
            <td colspan="3">
            	<textarea id="p_hcffsm" cols="70" rows="2" style="width:553px"></textarea></td>
        </tr>
    </table>
</div>