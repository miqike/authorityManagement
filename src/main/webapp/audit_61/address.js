var auditApproach = "自行查询";

function doInit() {
	$("#_auditApproach_").text(auditApproach);
    $("#btnShowInMap1").click(showInMap1);
    $("#btnShowInMap2").click(showInMap2);
    /*
    if($("#_qygsnr_").text() != $("#_bznr_").text()) {
		$("#_bdjg_").text("不一致").css("color", "red");
	} else {
		$("#_bdjg_").text("一致").css("color", "green");
	}*/
}

function showInMap(elem) {
	myGeo.getPoint($(elem).text(), function(point){
		if (point) {
			map.centerAndZoom(point, 14);
			map.addOverlay(new BMap.Marker(point));
		}else{
			alert("您选择地址没有解析到结果!");
		}
	});
	
	$("#mapPanel").panel("expand");
}

function showInMap1() {
	myGeo.getPoint($("#_qygsnr_").text(), function(point){
		if (point) {
			map.centerAndZoom(point, 14);
			map.addOverlay(new BMap.Marker(point));
		}else{
			alert("您选择地址没有解析到结果!");
		}
	});
	
	$("#mapPanel").panel("expand");
}

function showInMap2() {
	myGeo.getPoint($("#_bznr_").text(), function(point){
		if (point) {
			map.centerAndZoom(point, 14);
			map.addOverlay(new BMap.Marker(point));
		}else{
			alert("您选择地址没有解析到结果!");
		}
	});
	
	$("#mapPanel").panel("expand");
}

