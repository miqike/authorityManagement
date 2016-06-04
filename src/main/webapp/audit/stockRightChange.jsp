<%@ page contentType="text/html; charset=UTF-8" %>
<script>

var auditTableColumnsConfig =  [[
	{field:"gd",title:"股东",width:100},
	{field:"bgqGqbl",title:"变更前股权比例",width:100},
	{field:"bghGqbl",title:"变更后股权比例",width:100},
	{field:"bgrq",title:"股权变更日期",width:100, formatter:formatDate}
]];
</script>

<div>
    检查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>a. 股东变更：核对登记系统中登记信息，查看企业章程、股东会决议、股权转让协议、股东名册、审计报告等相关材料。</p>
    <p>b. 股权转让：核对登记系统中备案信息，查看企业章程、股东会决议、股权转让协议、股东名册、审计报告等相关材料，比对股权交易中心相关数据。</p>
</div>
<%@ include  file="gridAudit.jsp"%> 


