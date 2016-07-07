function mainGridButtonHandler() {
    if($('#mainGrid').datagrid('getSelected') != null) {
        $('#btnView').linkbutton('enable');
        $('#btnDelete').linkbutton('enable');
        $('#btnDuplicate').linkbutton('enable');
    } else {
        $('#btnView').linkbutton('disable');
        $('#btnDelete').linkbutton('disable');
        $('#btnDuplicate').linkbutton('disable');
    }
}

function add(){
    $('#popWindow input').val('');
    showModalDialog("popWindow");
    $('#codeTable input.easyui-textbox').textbox("enable").textbox("readonly", false);
    $("#btnEditOrSave").linkbutton({
        iconCls:'icon-save',
        text:'保存'
    });
}

function view(){
    if(!$(this).linkbutton('options').disabled) {
        var row = $('#mainGrid').datagrid('getSelected');
        if (row) {
            $("#name").textbox("setValue", row.name).textbox("readonly", true);
            $("#value").textbox("setValue", row.value);
            $("#literal").textbox("setValue", row.literal);
            $("#style").textbox("setValue", row.style);
            $("#descn").textbox('setValue', row.descn);
            showModalDialog("popWindow");
            $('#popWindow input.easyui-validatebox').validatebox();
        }
        ;
    }
}

function duplicate(){
    if(!$(this).linkbutton('options').disabled) {
        var row = $('#mainGrid').datagrid('getSelected');
        if (row) {
            $("#name").textbox("setValue", row.name).textbox("readonly", "true");
            $("#value").textbox("setValue", "").textbox("readonly", false).textbox("enable");
            $("#literal").textbox("setValue", row.literal).textbox("readonly", false).textbox("enable");
            $("#style").textbox("setValue", row.style).textbox("readonly", false).textbox("enable");
            $("#descn").textbox('setValue', row.descn).textbox("readonly", false).textbox("enable");
            showModalDialog("popWindow");
            $("#btnEditOrSave").linkbutton({
                iconCls: 'icon-save',
                text: '保存'
            });
            $('#popWindow input.easyui-validatebox').validatebox();
        }
        ;
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
                                $('#mainGrid').datagrid('reload');
                            } else {
                                $.messager.alert('删除失败', response, 'info');
                            }
                        }
                    });
                }
            });
        }
    }
}

function editOrSave () {
    if($("#btnEditOrSave").linkbutton("options").text == "编辑") {
        $("#btnEditOrSave").linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });

        $.each($("#codeTable input.easyui-textbox"), function(idx, elem) {
            $(elem).textbox("enable").textbox("readonly", false);
        });
    } else {
        $("#btnEditOrSave").linkbutton({
            iconCls:'icon-edit',
            text:'编辑'
        });
        $.each($("#codeTable input.easyui-textbox"), function(idx, elem) {
            $(elem).textbox("disable").textbox("readonly", true);
        });
        saveCode();
    }
}

function saveCode(){
    if($('#popWindow').form('validate')) {
        $.post("../sys/code", {
            name: $("#name").textbox("getValue"),
            value: $("#value").textbox("getValue"),
            literal: $("#literal").textbox("getValue"),
            style: $("#style").textbox("getValue"),
            descn: $("#descn").textbox("getValue")
        }, function(response) {
            if(response.status == FAIL){
                $.messager.alert('保存失败', response.message, 'info');
            } else {
                $("#mainGrid").datagrid("reload");
                //$.messager.alert('保存成功','保存成功','info');
				$.messager.show({
					title : '提示',
					msg : "保存成功"
				});
            }
        }, "json");
    }
    return false;
}

$(function () {

    $("#btnAdd").click(add);
    $("#btnView").click(view);
    $("#btnDelete").click(remove);
    $("#btnDuplicate").click(duplicate);
    $("#btnEditOrSave").click(editOrSave);
    $("#btnSearch").click(function(){
        $('#mainGrid').datagrid('load',{name: $('#f_name').val().toUpperCase()});
    });
    $(".datagrid-body").niceScroll({
        cursorcolor : "lightblue", // 滚动条颜色
        cursoropacitymax : 3, // 滚动条是否透明
        horizrailenabled : false, // 是否水平滚动
        cursorborderradius : 0, // 滚动条是否圆角大小
        autohidemode : false // 是否隐藏滚动条
    });
})