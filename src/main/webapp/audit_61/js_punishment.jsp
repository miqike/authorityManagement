<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = "工商处罚信息自查，与相关部门信息进行数据比对，或检查企业的处罚决定书、罚没收据等相关材料";
var auditTableColumnsConfig =  [[
	{field:"xzcfjdswh",title:"行政处罚决定书文号",width:100},
	{field:"wflx",title:"违法行为类型",width:100},
	{field:"xzcfnr",title:"行政处罚内容",width:100},
	{field:"cfjg",title:"作出行政处罚决定机关名称",width:100},
	{field:"cfrq",title:"作出行政处罚决定日期",width:100}
]];
</script>
<%@ include  file="gridAudit_js.jsp"%>