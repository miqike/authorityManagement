// 将长度转换为毫米形式
function toMilli(length) {
    return length.toString() + "mm";
}

function doShidihechagaozhishuInit(dataGridId) {
    var qy = $("#"+dataGridId).datagrid("getSelected");
    $("#shidi_hcrwId").text(qy.id);
    $("#shidi_qymc").val(qy.hcdwName);
    $("#shidi_xydm").val(qy.hcdwXydm);
    $("#shidi_hcjg").val(qy.hcjgmc);
    $("#shidi_gljmc").val(qy.hcjgmc);
}
