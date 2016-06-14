<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = "审计报告、财务资料、企业章程、对外投资设立企业、购买股权的股东会决议、所投资企业的股东名册等";
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

<%@ include  file="gridAudit.jsp"%> 

