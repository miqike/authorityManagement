<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../audit/platAudit.js"></script>

<div>
	<div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
   <div class="hcsx" style="width: 70px;">检查事项：</div><span style="color:blue; " id="_hcsxmc_"></span><br/>
   <div class="hcsx" style="float:left">检查方法：</div><div style="color:blue; " id="_auditApproach_"></div><br/>
   <table id="auditTable" class="easyui-datagrid" data-options="collapsible:true,ctrlSelect:true">
    	<thead>
    	<tr>
    		<th data-options="field:'xm'" halign="center" align="center" width="200" >项目名称</th>
            <th data-options="field:'a'" halign="center" align="center" width="200" >公式系统内容</th>
            <th data-options="field:'b'" halign="center" align="center" width="200" >标准内容</th>
            <th data-options="field:'result'" halign="center" align="center" width="80" styler="resultStyler">结果</th>
        </tr>
        </thead>
    </table>
</div>

