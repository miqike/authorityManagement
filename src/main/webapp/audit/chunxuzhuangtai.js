function doInit() {
    //console.log("doinit..........")
}

$(function () {
    var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#_hcrwId_").text(auditItem.hcrwId);
    $("#_hcsxId_").text(auditItem.hcsxId);

    $("#_qygsnr_").text(auditItem.qygsnr == null ? "" : auditItem.qygsnr);
    $("#_bznr_").text(auditItem.bznr == null ? "" : auditItem.bznr);
    $("#_qymc_").text(qy.hcdwName);
    $("#_hcsxmc_").text(auditItem.name);

    $("#btnSuccess").click(function () {
        $.post("../audit/complete", {
            hcrwId: $("#_hcrwId_").text(),
            hcsxId: $("#_hcsxId_").text(),
            hcjg: 1,
            qymc: $("#_qymc_").text(),
            hcsxmc: $("#_hcsxmc_").text()
        }, function (response) {
            if (response.status == SUCCESS) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                $("#annualAuditItemGrid").datagrid("reload");
                closeAuditWindow();
            } else {
                $.messager.alert('错误', response.message, 'error');
            }
        });
    });
    $("#btnFail").click(function () {
        $.post("../audit/complete", {
            hcrwId: $("#_hcrwId_").text(),
            hcsxId: $("#_hcsxId_").text(),
            hcjg: 2,
            qymc: $("#_qymc_").text(),
            hcsxmc: $("#_hcsxmc_").text()
        }, function (response) {
            if (response.status == SUCCESS) {
                $.messager.show({
                    title: '提示',
                    msg: response.message
                });
                $("#annualAuditItemGrid").datagrid("reload");
                closeAuditWindow();
            } else {
                $.messager.alert('错误', response.message, 'error');
            }
        });
    });
    $("#btnClose").click(closeAuditWindow);
});