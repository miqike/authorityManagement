function executeFile(file, paramArray) {
    try {
        var _file = file;
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (fso.FileExists(_file)) {
            var shellActiveXObject = new ActiveXObject("WScript.Shell");
            if (!shellActiveXObject) {
                alert('无法创建WScript.Shell');
                return;
            }
            var exePath = file;
            if (null != paramArray) {
                for (var i = 0; i < paramArray.length; i++) {
                    exePath = exePath + " " + paramArray[i];
                }
                alert(exePath);
            }

            shellActiveXObject.Run(exePath, 1, false);
            shellActiveXObject = null;
        }
        else {
            alert("系统检测到未安装" + file);
        }
    }
    catch (errorObject) {
        alert("请将站点设置为可信任站点，并将其安全级别设置为低!");
    }
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

    executeFile("C:/ky1.0/sjp6.exe", null);

    // $("#auditContent").empty();
    // $("#auditLog").empty();
    // $("#auditItemAccordion").accordion("select", 0);
});
