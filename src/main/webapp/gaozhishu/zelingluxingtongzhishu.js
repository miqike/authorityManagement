// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doZelingluxingtongzhishuInit() {
    var auditItem = $("#mainGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#zeling_hcrwId").text(qy.id);
    // $("#zeling_hcsxId").text(auditItem.hcsxId);

    $("#zeling_qymc").val(qy.hcdwName);
    // $("#zeling_xydm").val(qy.hcdwXydm);
    // $("#zeling_hcjg").val(qy.hcjgmc);
    $("#zeling_gljmc").val(qy.hcjgmc);
    $("#zeling_tznr").val(auditItem == null ? "" : auditItem.name);
/*
    $("#btnClose").click(function () {
        $("#gaozhishuWindow").window("close");
    });

    $("#btnPrint").click(printZelingluxingtongzhishu);
*/
}
