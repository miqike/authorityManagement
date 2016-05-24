

function doInit() {
	//console.log("doinit..........")
}

function sentVerifyMail() {
	 $.post("../audit/sentVerifyMail", {
         type: $(srcEle).attr('dicttype')
     }, function(resp) {
         $(srcEle).html(resp);
     });
	console.log("doinit..........")
}

$(function() {
	console.log("lllllllllllllllll")
	$("#btnSentVerifyMail").click(sentVerifyMail);
	$("#btnCloseAuditWindow").click(closeAuditWindow);
});