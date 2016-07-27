<%@ page contentType="text/html; charset=UTF-8" %>
<!-- <script type="text/javascript" src="../audit_61/gridAudit.js"></script> -->
<script>
function doInit() {
	doInitGrid();
}
</script>
<div>
   
   <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_hcjieguo_"></span>
    </div>
    <table>
    	<tr> <td class="hcsx">企业名称：</td><td><span style="color:blue; " id="_qymc_"></span></td></tr>
    	<tr> <td class="hcsx">检查事项：</td><td><span style="color:blue; " id="_hcsxmc_"></span></td></tr>
    	<tr> <td class="hcsx">比对信息来源：</td><td><span style="color:blue; " id="_dbxxly_"></span></td></tr>
    	<tr> <td class="hcsx">检查方法：</td><td><span style="color:blue; " id="_auditApproach_"></span></td></tr>
    </table>
    
	<div>
		<a href="#" id="btnAutoMatch" class="easyui-linkbutton" iconCls="icon-ok" plain="true">智能匹配</a>
		<a href="#" id="btnShowMatchItems" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">隐藏/显示匹配项目</a>
	</div>
	<div>
	    <table id="auditTableA"
	           data-options="collapsible:true,title:'公示内容',ctrlSelect:true">
	    </table>
	    <table id="auditTableB"
	           data-options="collapsible:true,title:'登记/备案内容',ctrlSelect:true">
	    </table>
	    <table id="auditTableC"
	           data-options="collapsible:true,title:'实际内容',ctrlSelect:true">
	    </table>
	</div>
</div>

