

function doInit() {
	//console.log("doinit..........")
}

function sentVerifyMail() {
	 $.post("../audit/sentVerifyMail", {
		 hcrwId: "1",
		 hcsxId: "1d7e3138a58a4709bb3a328fb767a82e",
		 mail:"coralsea@gmail.com"
     }, function(response) {
    	 if (response.status == SUCCESS) {
			$.messager.alert('验证邮件已经发送', response, 'info');
		} else {
			$.messager.alert('删除失败', response, 'info');
		}
     });
	console.log("doinit..........")
}

$(function() {
	console.log("lllllllllllllllll")
	$("#btnSentVerifyMail").click(sentVerifyMail);
	$("#btnCloseAuditWindow").click(closeAuditWindow);
});