function doInitSingle() {
	
	$("#_auditApproach_").html(auditApproach);
	var compareSource = $("#_dbxxly_").text();
	var rc = $("#_qygsnr_").text();
	var reg = $("#_bznr_").text();
	var act = $("#_sjnr_").text();
	
	if(compareSource == "登记/备案" || compareSource == "登记/备案+实际") {
		$("#_bznr_").parent().parent().css("background-color", "white");
	} else {
		$("#_bznr_").parent().parent().css("background-color", "#ebeced");
	}
	
	if(compareSource == "实际" || compareSource == "登记/备案+实际") {
		$("#_sjnr_").parent().parent().css("background-color", "white");
	} else {
		$("#_sjnr_").parent().parent().css("background-color", "#ebeced");
	}
	
	if(rc != "") {
		if(reg != "") {
			if(reg == rc) {
				$("#_bznr_").css("color", "green");
			} else {
				$("#_bznr_").css("color", "red");
				
			}
		}
		if(act != "") {
			if(act == rc) {
				$("#_sjnr_").css("color", "green");
			} else {
				$("#_sjnr_").css("color", "red");
				
			}
		}
	}
}
