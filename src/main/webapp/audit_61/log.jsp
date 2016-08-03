<%@ page contentType="text/html; charset=UTF-8"%>
<div id="logGird"></div>
<script>
	var auditItem = $("#mainGrid").datagrid("getSelected");
	$('#logGird').datagrid({
	    url:'../sys/log?businessKey=' + auditItem.hcrwId + '-' + auditItem.hcsxId,
	    method:'get',
	    pageSize:"100",
	    pagination:"true",
	    columns:[[
	        {field:'operateTime',title:'时间',width:120, halign:'center',align:'center',formatter:datetimeFormatter},
	        {field:'operatorName',title:'操作人员/系统',width:120,halign:'center',align:'center'},
	        {field:'message',title:'描述',width:200,halign:'center',align:'left',}
	    ]]
	});
</script>
