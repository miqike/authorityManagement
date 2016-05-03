function mainGridButtonHandler() {
	
	var selections = $('#mainGrid').datagrid('getSelections').length;
	if(selections == 0) {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnInvalid').linkbutton('disable');
		$('#btnLock').linkbutton('disable');
	} else if(selections == 1) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnInvalid').linkbutton('enable');
		$('#btnLock').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('enable');
		$('#btnInvalid').linkbutton('enable');
		$('#btnLock').linkbutton('enable');
	}
}

function loadSuccess(data) {
	$('#mainGrid').datagrid('unselectAll');
	$('#btnView').linkbutton('disable');
	$('#btnDelete').linkbutton('disable');
	$('#btnInvalid').linkbutton('disable');
	$('#btnLock').linkbutton('disable');
}

function tabSelectHandler(title, index) {
    //var userId = $('#p_userId').textbox('getValue');
    if(index == 1) { //选择报文模板TAB
        var row = $('#mainGrid').datagrid('getSelected');
        $('#template')[0].src="./outboundInterface/template/" + row.uuid;
    }
}

function selectOrganization() {
    //$('#orgTypeSelectDialog').dialog('open');
}

function add(){
	showModalDialog("popWindow");
}

function view(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			showModalDialog("popWindow");
            loadForm($('#interfaceTable'), row);
            //$('#template')[0].src="./outboundInterface/template?id=" + row.uuid;

        }
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var selections = $('#mainGrid').datagrid('getSelections');
		if (selections.length > 0) {
			$.messager.confirm('确认删除', '确认删除选中的流程定义?', function (r) {
				if (r) {
					var param = new Array();
					$.each(selections, function (idx, elem) {
						param.push(elem.deploymentId);
					});

					$.ajax({
						url: "../sys/processDefinition",
						data: JSON.stringify(param),
						dataType: "json",
						type: "delete",
						contentType: "application/json; charset=utf-8",
						cache: false,
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "流程定义已删除"
								});
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

function lock() {
    if(!$(this).linkbutton('options').disabled) {

        var row = $('#mainGrid').datagrid('getSelected');
        var operate = row.status == 2 ? "解锁" : "锁定";
        if (row) {
            $.messager.confirm('确认' + operate + '用户', '是否' + operate + '该用户？', function (r) {
                if (r) {
                    $.getJSON("../user/" + row.userId + "/lock", null, function (response) {
                        if (response.status == SUCCESS) {
                            $.messager.show({
                                title: '提示',
                                msg: operate + "操作成功"
                            });
                            $('#mainGrid').datagrid('reload');
                        } else {
                            $.messager.alert('提示', operate + '操作失败: ' + response.message, 'info');
                        }
                    });
                }
            });
        }
    }
}

function invlaid() {
	if(!$(this).linkbutton('options').disabled) {
		var row =  $('#grid2').datagrid('getSelected');
		if(row) {
			$.getJSON("../sys/processInstance/" + row.id + "/suspend", {suspended: row.suspended}, function (response) {
				if (response.status == SUCCESS) {
					$.messager.show({
						title: '提示',
						msg: "操作成功"
					});
					$('#grid2').datagrid('reload');
				} else {
					$.messager.alert('提示', '操作失败: ' + response.message, 'info');
				}
			});
		}
	}
}


$(function() {

	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			key: $("#f_key").val()
		});
	});
	
	$("#btnReset").click(function(){
		$("#f_key").val("");
	});

	$("#btnAdd").click(add);
	$("#btnView").click(view);
    $("#btnLock").click(lock);
    $("#btnInvalid").click(invlaid);
    $("#btnDelete").click(remove);


});