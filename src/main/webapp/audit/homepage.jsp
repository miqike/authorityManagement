<%@ page contentType="text/html; charset=UTF-8" %>
<script>

var auditTableColumnsConfig =  [[
	{field:"type",title:"类型",width:100},
	{field:"name",title:"名称",width:150},
	{field:"wz",title:"网址",width:200}
]];
</script>

<div>
    核查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p> 自行查询、网络查询对比</p>
</div>
<%@ include  file="gridAudit.jsp"%> 


