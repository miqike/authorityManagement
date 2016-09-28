<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = "审计报告、财务资料、企业章程、对外投资设立企业、购买股权的股东会决议、所投资企业的股东名册等";
var auditTableColumnsConfig =  [[
	{field:"gd",title:"股东",width:100},
	{field:"rjcze",title:"认缴出资额",width:100},
	{field:"rjczdqsj",title:"认缴出资到期时间",width:100},
	{field:"rjczfs",title:"认缴出资方式",width:100},
    {field:"sjcze",title:"实缴出资额",width:100},
    {field:"sjczdqsj",title:"实缴出资到期时间",width:100},
    {field:"sjczfs",title:"实缴出资方式",width:100}
]];
</script>

<%@ include  file="gridAudit.jsp"%> 

