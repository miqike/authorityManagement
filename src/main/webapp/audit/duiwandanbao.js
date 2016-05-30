

var auditTableColumnsConfig =  [[
	{field:"zqr",title:"债权人",width:100},
	{field:"zwr",title:"债务人",width:100},
	{field:"zzqzl",title:"主债权种类",width:100},
	{field:"zzqse",title:"主债权数额",width:100},
	{field:"lxzwqx",title:"履行债务的期限",width:100},
	{field:"bzqj",title:"保证的期间",width:100},
	{field:"bzfs",title:"保证的方式",width:100},
	{field:"bzdbfw",title:"保证担保的范围",width:100}
]]
	

function doInit() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	var param = {hcrwId: auditItem.hcrwId, hcsxId: auditItem.hcsxId};
	$.post("../audit/getCompareInfo", param,
		function(response){
			if(response.a == null || response.b == null) {
				$.alert("首先需要加载数据");
			} else {
				$("#auditTableA").datagrid({
					columns:auditTableColumnsConfig,
					data:response.a
				});
				$("#auditTableB").datagrid({
					columns:auditTableColumnsConfig,
					data:response.b
				});
			}
		}); 
}

$(function () {
    var auditItem = $("#mainGrid").datagrid("getSelected");
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
                $("#mainGrid").datagrid("reload");
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
                $("#mainGrid").datagrid("reload");
                closeAuditWindow();
            } else {
                $.messager.alert('错误', response.message, 'error');
            }
        });
    });
    $("#btnClose").click(closeAuditWindow);
});