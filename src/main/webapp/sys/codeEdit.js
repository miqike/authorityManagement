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
    $("#value").textbox("setValue","");
    $("#literal").textbox("setValue","");
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
            $('#btnDelete').linkbutton('enable');
            $("#name").textbox("enable").textbox("setValue", row.name);
            $("#value").textbox("enable").textbox("setValue", row.value);
            $("#literal").textbox("enable").textbox("setValue", row.literal);
            $("#style").textbox("enable").textbox("setValue", row.style);
            $("#descn").textbox("enable").textbox("setValue", row.descn);
            $("#editFlag").textbox("enable").textbox("setValue", row.editFlag);
            $('#btnSave').linkbutton('enable');
            window.operateType = "edit";
        } else {
            $('#btnDelete').linkbutton('disable');
            $("#name").textbox("disable").textbox("setValue", "");
            $("#value").textbox("disable").textbox("setValue", "");
            $("#literal").textbox("disable").textbox("setValue", "");
            $("#style").textbox("disable").textbox("setValue", "");
            $("#descn").textbox("disable").textbox("setValue", "");
            $("#editFlag").textbox("disable").textbox("setValue", "");
            $('#btnSave').linkbutton('disable');
        }
    }else{
        $('#btnDelete').linkbutton('disable');
        $("#name").textbox("disable").textbox("setValue", "");
        $("#value").textbox("disable").textbox("setValue", "");
        $("#literal").textbox("disable").textbox("setValue", "");
        $("#style").textbox("disable").textbox("setValue", "");
        $("#descn").textbox("disable").textbox("setValue", "");
        $("#editFlag").textbox("disable").textbox("setValue", "");
        $('#btnSave').linkbutton('disable');
    }
}

function add(){
    var row=$('#typeGrid').datagrid('getSelected');
    if(row != null) {
        $('#btnSave').linkbutton('enable');
        $("#name").textbox("enable").textbox("setValue",row.name);
        $("#value").textbox("enable").textbox("setValue","");
        $("#literal").textbox("enable").textbox("setValue","");
        $("#style").textbox("enable").textbox("setValue",row.style);
        $("#descn").textbox("enable").textbox("setValue",row.descn);
        $("#editFlag").textbox("enable").textbox("setValue",row.editFlag);
        window.operateType="add";
    } else {
        $.messager.show({
            title : '提示',
            msg : "请先选择编码类型"
        });
    }
}

function remove(){
    if(!$(this).linkbutton('options').disabled) {
        var row = $('#mainGrid').datagrid('getSelected');
        if (row) {
            $.messager.confirm('确认删除', '确认删除代码项', function (r) {
                if (r) {
                    $.ajax({
                        url: "../sys/code/" + row.name + "/" + row.value,
                        type: 'DELETE',
                        success: function (response) {
                            if (response.status == SUCCESS) {
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
            $.messager.show({
                title : '提示',
                msg : "请先选择要删除的数据"
            });
        }
    }
}

function save () {
    if(!$("#btnSave").linkbutton('options').disabled) {
        var row=$('#mainGrid').datagrid('getSelected');
        if($("#value").textbox("getValue") !="" && $("#literal").textbox("getValue")!=""){
            $.post("../sys/code/"+window.operateType, {
                name: $("#name").textbox("getValue"),
                value: window.operateType=="edit"?row.value+"-"+$("#value").textbox("getValue"):$("#value").textbox("getValue"),
                literal: window.operateType=="edit"?row.literal+"-"+$("#literal").textbox("getValue"):$("#literal").textbox("getValue"),
                style: $("#style").textbox("getValue"),
                descn: $("#descn").textbox("getValue"),
                editFlag:1
            }, function(response) {
                if(response.status == FAIL){
                    $.messager.alert('错误', response.message, 'error');
                } else {
                    //$("#mainGrid").datagrid("reload");
                    loadMainGrid();
                    $.messager.show({
                        title : '提示',
                        msg : "保存成功"
                    });
                }
            }, "json");
        }else{
            $.messager.show({
                title : '提示',
                msg : "请输入完整信息"
            });
        }
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

    listPrint(params,mainGridRow,columnList);

}

$(function () {

    $("#btnAdd").click(add);
    $("#btnDelete").click(remove);
    $("#btnSave").click(save);
    $("#btnPrint").click(function(){
        print(10,10,10);
    });
    $("#btnExport").click(function(){
        $("<iframe id='poiExport' style='display:none' src='../sys/code/names/poiExport?names=" + getNames().join('-') + "' />").appendTo("body");
    });
    $(".datagrid-body").niceScroll({
        cursorcolor : "lightblue", // 滚动条颜色
        cursoropacitymax : 3, // 滚动条是否透明
        horizrailenabled : false, // 是否水平滚动
        cursorborderradius : 0, // 滚动条是否圆角大小
        autohidemode : false // 是否隐藏滚动条
    });
})