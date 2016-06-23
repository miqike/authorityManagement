<%--
<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../audit/finicial.js"></script>
<script>
var auditApproach = 
	"<p style='margin: 2px;'> a.核查财务数据</p>" +
	"<p style='margin: 2px 2px 2px 142px;'> b.歇业：可参考提交的税务报停手续或其他资料。</p>" +
	"<p style='margin: 2px 2px 2px 142px;'> c.清算：dddd要求企业提交清算法定事由产生的文件，如股东会决议、清算组备案手续、企业注销公告、司法文书、政府文件等。</p>"
	
</script>
 --%>

<%@ page contentType="text/html; charset=UTF-8" %>
<script>
var auditApproach = 
	"<p style='margin: 2px;'> a.核查财务数据</p>" +
	"<p style='margin: 2px 2px 2px 70px;'> b.歇业：可参考提交的税务报停手续或其他资料。</p>" +
	"<p style='margin: 2px 2px 2px 70px;'> c.清算：要求企业提交清算法定事由产生的文件，如股东会决议、清算组备案手续、企业注销公告、司法文书、政府文件等。</p>"

var auditConfig = [
	["syzqyhj", "所有者权益合计"], 
	["lrze", "利润总额"], 
	["zyywsr", "营业总收入中主营业务收入"], 
	["jlr", "净利润"], 
	["nsze", "纳税总额"], 
	["fzze", "负债总额"], 
	["zcze", "资产总额"], 
	["yyzsr", "营业总收入"]
];
</script>
<%@ include  file="platAudit.jsp"%>