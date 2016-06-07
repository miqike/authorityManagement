// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doQiyezhusuohechahanInit() {
    var auditItem = $("#mainGrid").datagrid("getSelected");
    var qy = $("#grid1").datagrid("getSelected");

    $("#zhusuo_hcrwId").text(qy.id);
    // $("#zhusuo_hcsxId").text(auditItem.hcsxId);

    $("#zhusuo_qymc").val(qy.hcdwName);
    // $("#zhusuo_xydm").val(qy.hcdwXydm);
    // $("#zhusuo_hcjg").val(qy.hcjgmc);
    $("#zhusuo_gljmc").val(qy.hcjgmc);

    /*$("#btnClose").click(function () {
        $("#gaozhishuWindow").window("close");
    });

    $("#btnPrint").click(printQiyezhusuohechahan);*/

}
