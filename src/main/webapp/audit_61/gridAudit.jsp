<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<%--<script type="text/javascript" src="../audit/gridAudit.js"></script>--%>
<div>
	<div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
   <div class="hcsx" style="width: 70px;">检查事项：</div><span style="color:blue; " id="_hcsxmc_"></span><br/>
   <div class="hcsx" style="width: 70px;float:left">检查方法：</div><div style="color:blue; " id="_auditApproach_"></div><br/>
	<div>
		<a href="#" id="btnAutoMatch" class="easyui-linkbutton" iconCls="icon-ok" plain="true">智能匹配</a>
		<a href="#" id="btnShowMatchItems" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">隐藏/显示匹配项目</a>
	</div>
	<div>
	    <table id="auditTableA"
	           data-options="collapsible:true,title:'公示内容',ctrlSelect:true">
	    </table>
	    <table id="auditTableB"
	           data-options="collapsible:true,title:'标准内容',ctrlSelect:true">
	    </table>
	</div>
</div>

