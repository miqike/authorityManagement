

function doInit() {
	//console.log("doinit..........")
}

function sentVerifyMail() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
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
		} else {
			$.messager.alert('错误', response.message, 'error');
		}
     });
}

$(function() {
	var auditItem = $("#mainGrid").datagrid("getSelected");
	$("#_mail_").text(auditItem.qygsnr);
	$("#_mail_").text("coralsea_li@yeah.net");
	$("#btnSentVerifyMail").click(sentVerifyMail);
	$("#btnCloseAuditWindow").click(closeAuditWindow);
});