function doInit() {
	
	$("#_auditApproach_").text(auditApproach);
	if($("#_qygsnr_").text() != $("#_bznr_").text()) {
		$("#_bdjg_").text("不一致").css("color", "red");
	} else {
		$("#_bdjg_").text("一致").css("color", "green");
	}
	
}
