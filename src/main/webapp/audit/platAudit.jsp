<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../audit/platAudit.js"></script>
<div>
    核查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>

    </div>
    <table id="auditTable" class="easyui-datagrid"
           data-options="collapsible:true,
				ctrlSelect:true">
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
<div class="dialog-button calendar-header" style="height: auto; border-top-color: rgb(195, 217, 224);">
    <a href="#" id="btnSuccess" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>
    <a href="#" id="btnFail" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">不通过</a>
    <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
</div>