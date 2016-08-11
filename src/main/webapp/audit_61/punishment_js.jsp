<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = "工商处罚信息自查，与相关部门信息进行数据比对，或检查企业的处罚决定书、罚没收据等相关材料";
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
<%@ include  file="gridAudit_js.jsp"%>