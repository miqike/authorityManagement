<%@ page contentType="text/html; charset=UTF-8" %>
<script>

var auditTableColumnsConfig =  [[
	{field:"czrmc",title:"出质人名称 ",width:100},
	{field:"zl",title:"种类",width:100},
	{field:"qymc",title:"企业名称",width:100},
	{field:"zqrmc",title:"质权人名称",width:100},
	{field:"zqdjrq",title:"质权登记期限",width:100},
	{field:"zt",title:"状态",width:100},
	{field:"gssj",title:"公示时间",width:100},
	{field:"bhqk",title:"变化情况",width:100}
]];
</script>

<div>
    核查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>检查企业的商标权、著作权（版权）、专利权质押登记书等相关材料，或与相关部门信息进行数据比对。</p>
</div>
<%@ include  file="gridAudit.jsp"%> 

