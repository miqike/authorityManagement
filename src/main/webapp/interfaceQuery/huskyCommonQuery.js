function doInitGrid() {

    //开始根据配置进行查询
    var data={};
    data.tableName=tableConfig.tableName;
    data.huskyCommonWhereList=huskyCommonQueryWheres;

    if(huskyCommonQueryWheres.length>0) {
        $.ajax({
            url: "../common/huskyQuery",
            data: JSON.stringify(data),
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            cache: false,
            success: function (response) {
                if (response.status == 1) {
                    $.messager.show("操作提醒", response.message, "info", "bottomRight");
                    $('#dg').datagrid({
                        columns: tableConfig.columns,
                        height: 450,
                        data: response.data
                    });
                }
            }
        });
    }else{
        $.messager.alert("操作提醒", "请先设置查询条件！");
    }
}
