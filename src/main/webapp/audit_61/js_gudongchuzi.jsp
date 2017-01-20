<%@ page contentType="text/html; charset=UTF-8" %>
<script>
    var auditApproach = "股东出资";
    var auditTableColumnsConfig = [[
        {field: "gd", title: "股东", width: 100},
        {field: "rje", title: "认缴额", width: 100},
        {field: "sje", title: "实缴额", width: 100},
        {field: "rjcze", title: "认缴出资额", width: 100},
        {field: "rjczrq", title: "认缴出资日期", width: 100},
        {field: "rjczfs", title: "认缴出资方式", width: 100},
        {field: "sjcze", title: "实缴出资额", width: 100},
        {field: "sjczrq", title: "实缴出资日期", width: 100,formatter:formatDatetime},
        {field: "sjczfs", title: "出资方式", width: 100},
        {field: "hcrwId", title: "核查任务代码", width: 100}
    ]];
</script>
<%@ include file="gridAudit_js.jsp" %>