<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = "<p>检查企业的相关许可证或批准文件，或与相关部门信息进行数据比对</p>";
var auditTableColumnsConfig =  [[
	{field:"xkwjmc",title:"许可文件名称",width:230},
	{field:"yxq_ks",title:"有效期自",width:100},
	{field:"yxq_js",title:"有效期至",width:100}
]];
</script>

<div>
    检查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>检查企业的相关许可证或批准文件，或与相关部门信息进行数据比对</p>
</div>
<%@ include  file="gridAudit_js.jsp"%>
