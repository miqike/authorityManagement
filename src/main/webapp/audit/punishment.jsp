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
	
	XZCFJDSWH VARCHAR2(20)                  行政处罚决定书文号 
	WFLX INTEGER                  违法行为类型 
	XZCFNR VARCHAR2(600) Y               行政处罚内容 
	CFJG  VARCHAR2(500) Y               作出行政处罚决定机关名称 
	CFRQ DATE     Y               作出行政处罚决定日期 
	BZ      VARCHAR2(500) Y               备注      
	GSSJ  DATE     Y               公示时间 
	
]];
</script>

<div>
    核查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>工商处罚信息自查，与相关部门信息进行数据比对，或检查企业的处罚决定书、罚没收据等相关材料。</p>
</div>
<%@ include  file="gridAudit.jsp"%> 