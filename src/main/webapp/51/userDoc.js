function doInit() {
    //console.log("doinit..........")
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
    $("#btnShowInMap1").click(showInMap1);
    $("#btnShowInMap2").click(showInMap2);
});