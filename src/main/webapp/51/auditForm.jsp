<%@ page contentType="text/html; charset=UTF-8" %>
<script>
    /* function saveDoc() {
    	var type = $("#d_type").val();
        $("#btnSaveDoc").linkbutton("disable");
        var hcsx = type==1? $("#docGrid").datagrid("getSelected"): $("#furDocgrid").datagrid("getSelected");
        var data = {};
        data.hcdwXydm = hcsx.HCDW_XYDM;
        data.hcjhnd = hcsx.HCJHND;
        data.name = type==1? hcsx.HCCL_NAME: hcsx.NAME;
        data.hcclId = hcsx.HCCL_ID;
        data.hcsxId = hcsx.HCSX_ID;
        data.hcrwId = hcsx.HCRW_ID;
        data.sfbyx = hcsx.SFBYX;
        data.wjlx = hcsx.WJLX;
        data.yhtg = 1;
        data.ly = 2;
        data.hcsxmc = hcsx.HCSXMC;
        data.mongoId = $("#d_mongoId").val();
        
        if(type == 2) data.id=hcsx.ID;
        var url = type == 1?  "../51/hcclmx" : "../51/docFur2";
        
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            success: function (response) {
                if (response.status == $.husky.SUCCESS) {
                	doDocListInit();
                    $.messager.show('提示',"检查材料保存成功", "info", "bottomRight");
                    $("#documentWindow").window("close");
                } else {
                    $.messager.alert('检查材料保存失败', response.message, 'error');
                }
            }
        });
    }
    */

    function doAuditFormInit() {
    	$.husky.loadForm("auditTable", $("#grid2").datagrid("getSelected"));
    } 

    $(function () {
    	$.codeListLoader.parse($('#auditTable'))
    });
</script>
<div style="padding:5px;">
	<table id="auditTable">
	    <tr>
	        <td class="label">检查机关</td>
	        <td colspan="3">
	        
	            <input type="hidden" id="d_id"/>
	            <input type="hidden" id="d_mongoId"/>
	            <input type="hidden" id="d_type"/><!-- 1:标准材料 2:附加材料 -->
	            <input class="easyui-validatebox" id="d_hcjgmc" style="width:365px;" disabled/>
	    </tr>
	    <tr>
	        <td class="label">企业名称</td>
	        <td colspan="3"><input class="easyui-validatebox" id="d_hcdwName" style="width:365px;" codeName="yesno"  disabled/></td>
	    </tr>
	    <tr>
	        <td class="label">统一社会信用代码</td>
	        <td><input class="easyui-validatebox" id="d_hcdwXydm" disabled/></td>
	        <td class="label">检查时间</td>
	        <td><input class="easyui-datebox" id="d_sjwcrq" data-options="" disabled/></td>
	    </tr>
	    <tr>
	        <td class="label">核查结果</td>
	        <td colspan="3"><input class="easyui-combobox" id="d_auditResult" data-options="panelHeight:200" style="width:365px;" codeName="gsjg" /></td>
	    </tr>
	    <tr>
	        <td class="label">是否列入经营异常名录</td>
	        <td><input class="easyui-combobox" id="d_hcjieguo" data-options="panelHeight:60" codeName="yesno" /></td>
	    </tr>
	    <tr>
	        <td class="label">审核人</td>
	        <td><input class="easyui-validatebox" id="d_auditorName" data-options="" disabled/></td>
	        <td class="label">审核日期</td>
	        <td><input class="easyui-datebox" id="d_hcjieguo" data-options="" disabled/></td>
	    </tr>
	    <tr>
	        <td class="label" valign="top">审核意见</td>
	        <td colspan="3">
	        	<textarea id="d_auditComment" data-options=""  style="width:365px;" />
	        </td>
	    </tr>
	    
	</table>
</div>
