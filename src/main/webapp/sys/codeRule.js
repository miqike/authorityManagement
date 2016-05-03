function mainGridButtonHandler() {
    var row=$('#mainGrid').datagrid('getSelected');
    if(row != null) {
        $('#btnSave').linkbutton('enable');
        $('#descn').textbox('disable').textbox("setValue",row.descn);
        $('#literal').textbox('enable').textbox("setValue",row.literal);
        $('#value').val(row.value);
    } else {
        $('#btnSave').linkbutton('disable');
        $('#descn').textbox('disable').textbox("setValue","");
        $('#literal').textbox('disable').textbox("setValue","");
        $('#value').val("");
    }
}

function saveCode(){
    if($('#literal').textbox("isValid") && !$(this).linkbutton('options').disabled) {
        $.post("../sys/code", {
            name: 'codeRule',
            value: $("#value").val(),
            literal: $("#literal").textbox("getValue"),
            descn: $("#descn").textbox("getValue")
        }, function(response) {
            if(response.status == FAIL){
                $.messager.alert('编码规则保存失败', response.message, 'info');
            } else {
                $("#mainGrid").datagrid("reload");
                $.messager.show({
                    title : '提示',
                    msg : "编码规则保存成功"
                });
            }
        }, "json");
    }else{
        $.messager.show({
            title : '提示',
            msg : "编码规则验证失败"
        });
    }
    return false;
}

$(function () {
    mainGridButtonHandler();
    $("#btnSave").click(saveCode);
})