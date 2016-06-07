<%@ page contentType="text/html; charset=UTF-8" %>
<script>
    var auditApproach = "股东出资";

    var auditTableColumnsConfig = [[
        {field: "gd", title: "股东", width: 100},
        {field: "rjcze", title: "认缴出资额", width: 100},
        {field: "rjczdqsj", title: "认缴出资到期时间", width: 100},
        {field: "rjczfs", title: "认缴出资方式", width: 100},
        {field: "sjcze", title: "实缴出资额", width: 100},
        {field: "sjczsj", title: "出资时间", width: 100},
        {field: "sjczfs", title: "出资方式", width: 100},
        {field: "hcrwId", title: "核查任务代码", width: 100}
    ]];
</script>

<div>
    检查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>
<div>
    <p>股东出资</p>
</div>
<%@ include file="gridAudit.jsp" %>