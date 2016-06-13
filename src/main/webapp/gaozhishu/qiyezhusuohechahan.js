// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doQiyezhusuohechahanInit() {
    var qy = $("#grid1").datagrid("getSelected");
    $("#zhusuo_hcrwId").text(qy.id);
    $("#zhusuo_qymc").val(qy.hcdwName);
    $("#zhusuo_gljmc").val(qy.hcjgmc);

}
