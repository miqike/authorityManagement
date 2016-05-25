<%@ page contentType="text/html; charset=UTF-8"%>
<div id="logGird">
	
	<<!-- table id="logGird" class="easyui-datagrid" 
			data-options="singleSelect:true,collapsible:true,method:'get',
				url:'../sys/log',
				height:450"
		    pageSize="50"
			pagination="true">
			<thead>
				<tr>
					<th data-options="field:'operateTime',halign:'center',align:'center'" width="120" formatter="datetimeFormatter">时间</th>
					<th data-options="field:'operatorName',halign:'center',align:'center'" width="50">姓名</th>
					<th data-options="field:'module',halign:'center',align:'center'" width="50">模块</th>
					<th data-options="field:'remoteAddr',halign:'center',align:'center'" width="70">客户IP</th>
					<th data-options="field:'hostIp',halign:'center',align:'left'" width="100">节点IP</th>
					<th data-options="field:'hostPort',halign:'center',align:'right'" width="40">PORT</th>
					<th data-options="field:'message',halign:'center',align:'left'" width="150">描述</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table -->
	
</div>
<script>
	var auditItem = $("#mainGrid").datagrid("getSelected");
	$('#logGird').datagrid({
	    url:'../sys/log?businessKey=' + auditItem.hcrwId + '-' + auditItem.hcsxId,
	    method:'get',
	    pageSize:"50",
	    pagination:"true",
	    columns:[[
	        {field:'operateTime',title:'时间',width:120, halign:'center',align:'center',formatter:datetimeFormatter},
	        {field:'operatorName',title:'操作人员/系统',width:120,halign:'center',align:'center'},
	        {field:'message',title:'描述',width:200,halign:'center',align:'left',}
	    ]]
	});
</script>
