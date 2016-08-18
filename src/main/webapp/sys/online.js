function mainGridButtonHandler(index, row) {
	
	var status = 'disable';
	var selections = $('#mainGrid').datagrid('getSelections');
	if(selections.length > 0 ) {
		for(var i=0; i<selections.length; i++) {
			var row = selections[i];
			if(row.id == sessionId || row.status != 1) {
				status = 'disable';
				break;
			} else {
				status = 'enable';
			}
		}
	} 
	
	$('#btnInvalidate').linkbutton(status);
}

function loadSuccessHandler(data) {
    if(data.status == $.husky.SUCCESS) {
        $('#mainGrid').datagrid('unselectAll');
        $('#btnInvalidate').linkbutton('disable');
    } else {
        $.messager.alert("警告", combineErrorMessage(data), "warning");
    }
}

function invalidate() {
	if(!$(this).linkbutton('options').disabled) {
		var rows = $('#mainGrid').datagrid('getSelections');
		if (rows.length > 0) {
			$.messager.confirm('踢出', '是否强行踢出用户 ？', function (r) {
                if (r) {
                    var param = new Array();
                    $.each(rows, function (idx, elem) {
                        param.push(elem.id);
                    });

                    $.ajax({
                        url: "../sys/user/online/forceLogout",
                        data: JSON.stringify(param),
                        type: "delete",
                        contentType: "application/json; charset=utf-8",
                        cache: false,
                        success: function (response) {
                            if (response.status == $.husky.SUCCESS) {
                                $('#mainGrid').datagrid('reload');
                                $.messager.show({
                                    title: '提示',
                                    msg: "用户已经被强行踢出!"
                                });
                            } else {
                                $.messager.alert('提示', '操作失败: ' + response.message, 'info');
                            }
                        }
                    });
				}
			});
		}
	}
}

function reset(){
	$("#f_name").val('');
	$("#f_organization").val('');
}

function search(){
	$('#mainGrid').datagrid('load',{
		name: $('#f_name').val()//,
		//organization: processorOrgId($('#f_organization').val())
	});
}

$(function() {
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

});