<%@ page contentType="text/html; charset=UTF-8" %>
<!-- <script type="text/javascript" src="../audit_61/platAudit.js"></script> -->
<script>
function doInit() {
	doInitPlat();
}
</script>
<div>
	<div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <!-- <span style="color:blue; " id="_qymc_"></span> -->
    </div>
    <table>
    	<tr> <td class="hcsx">企业名称：</td><td><span style="color:blue; " id="_qymc_"></span></td></tr>
    	<tr> <td class="hcsx">检查事项：</td><td><span style="color:blue; " id="_hcsxmc_"></span></td></tr>
    	<tr> <td class="hcsx">比对信息来源：</td><td><span style="color:blue; " id="_dbxxly_"></span></td></tr>
    	<tr> <td class="hcsx">检查方法：</td><td><span style="color:blue; " id="_auditApproach_"></span></td></tr>
    </table>
    
   <table id="auditTable" class="easyui-datagrid" data-options="collapsible:true,ctrlSelect:true">
    	<thead>
    	<tr>
    		<th data-options="field:'xm'" halign="center" align="center" width="200" >项目名称</th>
            <th data-options="field:'a'" halign="center" align="center" width="135" >公示系统内容</th>
            <th data-options="field:'b'" halign="center" align="center" width="135" formatter="formatCompareColPlat" styler="stylerRegistPlat">登记/备案内容</th>
            <th data-options="field:'c'" halign="center" align="center" width="135" formatter="formatCompareColPlat" styler="stylerActualPlat">实际内容</th>
            <th data-options="field:'result'" halign="center" align="center" width="80" styler="resultStyler">比对结果</th>
        </tr>
        </thead>
    </table>
</div>

