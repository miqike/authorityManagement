<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = 
	"<p style='margin: 2px;'> a.检查企业提交的材料或委托专业机构开展相关工作。" +
	"<p style='margin: 2px 2px 2px 72px;'> b.检查材料：审计报告、财务资料、企业章程、对外投资设立企业、购买股权的股东会决议、所投资企业的股东名册等。</p>" +
	"<p style='margin: 2px 2px 2px 72px;'> c.结果处理：存在公示信息与检查情况不一致的，按隐瞒真实情况、弄虚作假处理。</p>"

var auditTableColumnsConfig =  [[
	{field:"tzqymc",title:"投资企业名称",width:250},
	{field:"xydm",title:"统一社会信用代码",width:150}
	
]];
</script>
<%@ include  file="gridAudit.jsp"%> 

