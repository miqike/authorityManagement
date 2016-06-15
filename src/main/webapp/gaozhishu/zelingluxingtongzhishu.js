// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doZelingluxingtongzhishuInit() {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#zeling_hcrwId").text(qy.id);

    $("#zeling_qymc").val(qy.hcdwName);
    $("#zeling_gljmc").val(qy.hcjgmc);
    $("#zeling_gljmc1").val(qy.hcjgmc);
    $("#zeling_tznr").val(auditItem == null ? "" : auditItem.name);
    $("#zeling_sj").val(chinesseDateformatter(new Date()));
}
