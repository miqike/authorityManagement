<%@ page contentType="text/html; charset=UTF-8" %>
<script>

var auditTableColumnsConfig =  [[
	{field:"zqr",title:"债权人",width:100},
	{field:"zwr",title:"债务人",width:100},
	{field:"zzqzl",title:"主债权种类",width:100},
	{field:"zzqse",title:"主债权数额",width:100},
	{field:"lxzwqx",title:"履行债务的期限",width:100},
	{field:"bzqj",title:"保证的期间",width:100},
	{field:"bzfs",title:"保证的方式",width:100},
	{field:"bzdbfw",title:"保证担保的范围",width:100}
]];
</script>

<div>
    检查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>核对企业的保证担保合同、董事会、股东会决议等相关材料</p>
</div>
<%@ include  file="gridAudit.jsp"%> 