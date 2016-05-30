<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function doInit(operation) {
	$.codeListLoader.parse($("#baseInfo"));
	$("#btnSaveAuditItem").click(funcSaveAuditItem);
	
	if(operation == "edit") {
    	$.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
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

function funcSaveAuditItem() {
	
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
<div id="baseInfo">
    <div style="display: none">
        <input class="easyui-textbox" id="p_id" style="width:200px;"/>
    </div>

    <table width="100%" id="baseTable">
        <tr>
            <td>
                <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" iconCls="icon-save"
                   plain="true">保存</a>
            </td>
            <td colspan="3"></td>
        </tr>
        <tr>
            <td class="label">核查事项名称</td>
            <td><input class="easyui-textbox" id="p_name" style="width:200px;" data-options=""/></td>
            <td class="label">类型</td>
            <td><input class="easyui-combobox" id="p_type" style="width:200px;" data-options=""
                       codeName="hclx"/></td>
        </tr>
        <tr>
            <td class="label">描述</td>
            <td><input class="easyui-textbox" id="p_descript" style="width:200px;" data-options=""/>
            </td>
            <td class="label">核查材料</td>
            <td><input class="easyui-textbox" id="p_hccl" style="width:200px;" data-options=""/></td>
        </tr>
        <tr>
            <td class="label">核查方法</td>
            <td><input class="easyui-combobox" id="p_hcff" style="width:200px;" data-options=""
                       codeName="hcfs"/></td>
            <td class="label">核查信息分类</td>
            <td><input class="easyui-combobox" id="p_hcxxfl" style="width:200px;" data-options=""
                       codeName="hcxxfl"/></td>
        </tr>
        <tr>
            <td class="label">核查类型</td>
            <td><input class="easyui-combobox" id="p_hclx" style="width:200px;" data-options=""
                       codeName="hclx"/></td>
            <td class="label">企业组织形式</td>
            <td><input class="easyui-combobox" id="p_qyzzxs" style="width:200px;" data-options=""
                       codeName="qyzzxs"/></td>
        </tr>
        <tr>
            <td class="label">对应公示项目</td>
            <td><input class="easyui-textbox" id="p_gsxm" style="width:200px;" data-options=""/></td>
            <td class="label">是否必检项</td>
            <td><input class="easyui-combobox" id="p_sfbjxm" style="width:200px;" data-options=""
                       codeName="yesno"/></td>
        </tr>
        <tr>
            <td class="label">结果处理</td>
            <td><input class="easyui-combobox" id="p_jgcl" style="width:200px;" data-options=""
                       codeName="gsjg"/></td>
            <td class="label">登记信息和公示信息比对</td>
            <td><input class="easyui-combobox" id="p_xxdb" style="width:200px;" data-options=""
                       codeName="yesno"/></td>
        </tr>
        <tr>
            <td class="label">比对信息来源</td>
            <td><input class="easyui-textbox" id="p_dbxxly" style="width:200px;" data-options=""/></td>
            <td class="label">是否需要实地核查</td>
            <td><input class="easyui-combobox" id="p_sfxysdhc" style="width:200px;" data-options=""
                       codeName="yesno"/>
            </td>
        </tr>
        <tr>
            <td class="label">是否需要人工核对</td>
            <td><input class="easyui-combobox" id="p_sfxyrghd" style="width:200px;" data-options=""
                       codeName="yesno"/>
            </td>
            <td class="label">改正期限</td>
            <td><input class="easyui-numberbox" id="p_gzqx" data-options="min:0,precision:0"
                       style="width:200px;"/></td>
        </tr>
        <tr>
            <td class="label">注销日期</td>
            <td><input class="easyui-datebox" id="p_zxrq" style="width:200px;" data-options=""/></td>
            <td class="label">注销说明</td>
            <td><input class="easyui-textbox" id="p_zxsm" style="width:200px;" data-options=""/></td>
        </tr>
        <tr>
            <td class="label" style="vertical-align:top">核查方法说明</td>
            <td colspan="3"><input class="easyui-textbox" id="p_hcffsm" 
                                   data-options="multiline:true,width:580,height:70"/></td>
        </tr>
    </table>
</div>