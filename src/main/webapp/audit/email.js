function doInit() {
	var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	$("#_mail_").text(auditItem.qygsnr);
	$("#_mail_").text("coralsea_li@yeah.net");
	$("#btnSentVerifyMail").click(sentVerifyMail);
	$("#btnCloseAuditWindow").click(closeAuditWindow);
}

function sentVerifyMail() {
	var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	$.post("../audit/sentVerifyMail", {
		 hcrwId: auditItem.hcrwId,
		 hcsxId: auditItem.hcsxId,
//		 mail:auditItem.qygsnr
		 mail:"coralsea_li@yeah.net"
     }, function(response) {
    	 if (response.status == SUCCESS) {
			$.messager.show({
				title: '提示',
				msg: response.message
			});
			$('#annualAuditItemGrid').datagrid('reload')
		} else {
			$.messager.alert('错误', response.message, 'error');
		}
     });
}
