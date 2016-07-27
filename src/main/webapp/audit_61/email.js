var auditApproach = "电子邮件检查过程:发送测试邮件到客户邮箱,客户收到邮件后点击相应的链接即可完成,若5日内未完成则该项验证失败";

function doInit() {
	//var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	//$("#_auditApproach_").html(auditApproach);
	//$("#_mail_").text(auditItem.qygsnr);

	doInitSingle();
	
	$("#btnSentVerifyMail").click(sentVerifyMail);
//	$("#btnCloseAuditWindow").click(closeAuditWindow);
//	$("#btnSuccess").hide();
//	$("#btnFail").hide();
	
}

function sentVerifyMail() {
	var auditItem = $("#annualAuditItemGrid").datagrid("getSelected");
	$.post("../audit/sentVerifyMail", {
		 hcrwId: auditItem.hcrwId,
		 hcsxId: auditItem.hcsxId,
		 mail:auditItem.qygsnr
//		 mail:"coralsea_li@yeah.net"
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
