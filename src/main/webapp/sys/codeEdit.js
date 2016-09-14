function getNames(){
    var rows = $("#typeGrid").datagrid("getSelections");
    var names = new Array();
    for (var i = 0; i < rows.length; i++) {
        names.push(rows[i].name);
    }
    return names;
}
function loadMainGrid(){
    var names=getNames();
    if(names.length>0) {
        $.ajax({
            url: "../sys/code/names",
            dataType: 'json',
            data: JSON.stringify(names),
            type: "PUT",
            contentType: "application/json; charset=utf-8",
            cache: false,
            success: function (response) {
                $("#mainGrid").datagrid("loadData", response);
            }
        });
        if(names.length>1){
            $("#btnAdd").linkbutton("disable");
        }else{
            $("#btnAdd").linkbutton("enable");
        }
    }else{
        $("#mainGrid").datagrid("loadData", []);
        $("#btnAdd").linkbutton("disable");
    }
}
function mainGridLoadSuccessHandler(){
    //$('#mainGrid').datagrid("selectRow",0);
    $("#value").val("");
    $("#literal").val("");
}
function typeGridButtonHandler() {
    loadMainGrid();
    mainGridButtonHandler();
}

function mainGridButtonHandler() {
    var names=getNames();
    if(names.length==1) {
        var row = $('#mainGrid').datagrid('getSelected');
        if (row != null) {
            $('#btnRemove').linkbutton('enable');
            $("#name").removeAttr("readonly").removeAttr("disabled").val(row.name);
            $("#value").attr("readonly", true).attr("disabled", true).val(row.value);
            $("#literal").removeAttr("readonly").removeAttr("disabled").val(row.literal);
            $("#style").removeAttr("readonly").removeAttr("disabled").val(row.style);
            $("#descn").removeAttr("readonly").removeAttr("disabled").val(row.descn);
            $("#editFlag").removeAttr("readonly").removeAttr("disabled").val(row.editFlag);
            $('#btnSave').linkbutton('enable');
        } else {
            $('#btnRemove').linkbutton('disable');
            $("#name").attr("readonly", true).attr("disabled", true).val("");
            $("#value").attr("readonly", true).attr("disabled", true).val("");
            $("#literal").attr("readonly", true).attr("disabled", true).val("");
            $("#style").attr("readonly", true).attr("disabled", true).val("");
            $("#descn").attr("readonly", true).attr("disabled", true).val("");
            $("#editFlag").attr("readonly", true).attr("disabled", true).val("");
            $('#btnSave').linkbutton('disable');
        }
    }else{
        $('#btnRemove').linkbutton('disable');
        $("#name").attr("readonly", true).attr("disabled", true).val("");
        $("#value").attr("readonly", true).attr("disabled", true).val("");
        $("#literal").attr("readonly", true).attr("disabled", true).val("");
        $("#style").attr("readonly", true).attr("disabled", true).val("");
        $("#descn").attr("readonly", true).attr("disabled", true).val("");
        $("#editFlag").attr("readonly", true).attr("disabled", true).val("");
        $('#btnSave').linkbutton('disable');
    }
}

function add(){
    var row=$('#typeGrid').datagrid('getSelected');
    if(row != null) {
        $('#btnSave').linkbutton('enable');
        $("#name").removeAttr("readonly").removeAttr("disabled").val(row.name);
        $("#value").removeAttr("readonly").removeAttr("disabled").val("");
        $("#literal").removeAttr("readonly").removeAttr("disabled").val("");
        $("#style").removeAttr("readonly").removeAttr("disabled").val(row.style);
        $("#descn").removeAttr("readonly").removeAttr("disabled").val(row.descn);
        $("#editFlag").removeAttr("readonly").removeAttr("disabled").val(row.editFlag);
    } else {
    	$.messager.alert("操作提示", "请先选择编码类型");
    }
}

function remove(){
    var row = $('#mainGrid').datagrid('getSelected');
    if (row) {
        $.messager.confirm('确认删除', '确认删除代码项', function (r) {
            if (r) {
                $.ajax({
                    url: "../sys/code/" + row.name + "/" + row.value,
                    type: 'DELETE',
                    success: function (response) {
                        if (response.status == $.husky.SUCCESS) {
                            //$('#mainGrid').datagrid('reload');
                            loadMainGrid();
                        } else {
                            $.messager.alert('删除失败', response.message, 'info');
                        }
                    }
                });
            }
        });
    }else{
    	$.messager.alert("操作提示", "请先选择要删除的编码");
    }
}

function save () {
    var row=$('#mainGrid').datagrid('getSelected');
    if($("#value").val() !="" && $("#literal").val()!=""){
        $.post("../sys/code", {
            name: $("#name").val(),
            value: $("#value").val(),
            literal: $("#literal").val(),
            style: $("#style").val(),
            descn: $("#descn").val(),
            editFlag:1
        }, function(response) {
            if(response.status == $.husky.FAIL){
                $.messager.alert('错误', response.message, 'error');
            } else {
                loadMainGrid();
                $.messager.show("操作提醒", "编码保存成功", "info", "bottomRight");
            }
        }, "json");
    }else{
        $.messager.alert("操作提醒", "请输入完整信息", "error");
    }
}

//打印
function print(leftBianJu,topBianJu,pageRows){
    var mainGridRow=$("#mainGrid").datagrid("getRows");//取得要打印的数据

    var columnList=[];
    columnList.push({"header":"编码类型","fieldName":"descn","codeName":null,"colWidth":30});
    columnList.push({"header":"编码","fieldName":"value","codeName":null,"colWidth":20});
    columnList.push({"header":"编码名称","fieldName":"literal","codeName":null,"colWidth":50});

    var params={};
    params["pageRows"]=10;
    params["pageTitle"]="编码类型";
    params["topMargin"]=3;
    params["leftMargin"]=6;

    $.lodopCommonPrint.listPrint(params,mainGridRow,columnList);
}

