function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
	}
}

function grid2ButtonHandler() {
	if($('#grid2').datagrid('getSelected') != null) {
        $("#btnEditDataPermissionRule").linkbutton('enable');
        if($('#grid2').datagrid('getSelected').isDefault == 1) {
            $("#btnSetDefaultDataPermissionRule").linkbutton('disable');
            $("#btnDeleteDataPermissionRule").linkbutton('disable');
        } else {
            $("#btnSetDefaultDataPermissionRule").linkbutton('enable');
            $("#btnDeleteDataPermissionRule").linkbutton('enable');
        }
	} else {
        $("#btnEditDataPermissionRule").linkbutton('disable');
        $("#btnDeleteDataPermissionRule").linkbutton('disable');
        $("#btnSetDefaultDataPermissionRule").linkbutton('disable');
	}
}

function add(){
	$('#popWindow input').val('');
    $('#p_dataPermId').textbox("readonly", false);
    $('#p_description').textbox("readonly", false);
    $('#p_tableName').textbox("readonly", false);
    $('#p_mapper').textbox("readonly", false);
	showModalDialog("popWindow");
	$('#mainTable input.easyui-textbox').textbox("enable");
	$('#mainTable input.easyui-combobox').combobox("enable");
	$("#btnEditOrSave").linkbutton({
		iconCls:'icon-save',
		text:'保存'
	});
	$('#tabPanel').tabs('select',0 );
}

function addDataPermissionRule(){
	$('#popWindow2 input').val('');
    $('#k_dataPermId').textbox("setValue",$("#p_id").textbox("getValue")).textbox("readonly", true);
    $('#k_description').textbox("readonly", false);
    $("#k_aclType").combobox("enable");
    $('#k_exp').textbox("readonly", false);
	showModalDialog("popWindow2");
	$('#popTable2 input.easyui-textbox').textbox("enable");
	$("#btnEditOrSave2").linkbutton({
		iconCls:'icon-save',
		text:'保存'
	});
}

function view(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$("#p_id").textbox("setValue", row.id).textbox("readonly", "true");
			$("#p_description").textbox("setValue", row.description);
			$("#p_tableName").textbox("setValue", row.tableName);
			$("#p_mapper").textbox('setValue', row.mapper);
			showModalDialog("popWindow");
			$("#btnEditOrSave").parent().css("text-align", "left");
			$('#popWindow input.easyui-validatebox').validatebox();
		}
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		$('#tabPanel').tabs('select', 0);
	}
}

function viewDataPermissionRule(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid2').datagrid('getSelected');
		if (row) {
			$("#k_id").val(row.id);
			$("#k_isDefault").val(row.isDefault);
			$("#k_description").textbox("setValue", row.description);
			$("#k_dataPermId").textbox("setValue", row.dataPermId);
			$("#k_aclType").combobox("setValue", row.aclType).combobox("disable");
            $("#k_exp").textbox('setValue', row.exp);
			showModalDialog("popWindow2");
			$("#btnEditOrSave2").parent().css("text-align", "left");
			$('#popWindow2 input.easyui-validatebox').validatebox();

            $('#popTable2 input.easyui-textbox').textbox("disable");
            $("#btnEditOrSave2").linkbutton({
                iconCls:'icon-edit',
                text:'编辑'
            });
		}
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除该数据级权限定义？', function (r) {
				if (r) {
					$.ajax({
						url: "../sys/dataPermission/" + row.id,
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

function deleteDataPermissionRule(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#grid2').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除该数据权限规则？', function (r) {
				if (r) {
					$.ajax({
						url: "../sys/dataPermission/rule/" + row.id,
						type: 'DELETE',
						success: function (response) {
							if (response.status == SUCCESS) {
                                loadGrid2();
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

function saveDataPermission(){
	if($('#popWindow').form('validate')) {
		$.post("../sys/dataPermission", {
			id: $("#p_id").textbox("getValue"),
			description: $("#p_description").textbox("getValue"),
			tableName: $("#p_tableName").textbox("getValue"),
			mapper: $("#p_mapper").textbox("getValue")
		}, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
		    } else {
		    	$("#mainGrid").datagrid("reload");
				$.messager.show({
					title : '提示',
					msg : "保存成功"
				});
		    }
		}, "json");
	}
	return false;
}

function saveDataPermissionRule(){
	if($('#popWindow2').form('validate')) {
		$.post("../sys/dataPermission/rule", {
			id: $("#k_id").val(),
            isDefault: $("#k_isDefault").val(),
			description: $("#k_description").textbox("getValue"),
			exp: $("#k_exp").textbox("getValue"),
            dataPermId: $("#k_dataPermId").textbox("getValue"),
            aclType: $("#k_aclType").combobox("getValue")
		}, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
		    } else {
                loadGrid2();
				$.messager.show({
					title : '提示',
					msg : "保存成功"
				});
		    }
		}, "json");
	}
	return false;
}

function loadGrid2() {
    $.getJSON("../common/query?mapper=dataPermissionRuleMapper&queryName=queryByDataPermissionId", {
        dataPermissionId: $("#p_id").textbox("getValue")
    }, function(response) {
        $("#grid2").datagrid("loadData", response.rows);
    })
}
function tabSelectHandler(title, index) {
	var dpId = $('#p_id').textbox('getValue');
	if(index == 1) {
		if(dpId != "") {
            loadGrid2();
		} else {
			$.messager.alert("操作错误", "请先保存数据权限基本信息");
			$('#tabPanel').tabs('select',0 );
		}
	}
}

function formatDefaultFlag(val, row) {
    var _val = parseInt(val);
    if(_val == 1) {
        return "<img src='../images/star.png'/>";
    } else {
        return "";
    }
}


function editOrSave() {
	if($("#btnEditOrSave").linkbutton("options").text == "编辑") {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$.each($("#mainTable input.easyui-textbox"), function(idx, elem) {
			if(elem.id != 'p_id') {
				$(elem).textbox("enable").textbox("readonly", false);
			}
		});
	} else {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		$.each($("#mainTable input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox("disable").textbox("readonly", true);
		});
		saveDataPermission();
	}
}

function editOrSavePermissionRule() {
	if($("#btnEditOrSave2").linkbutton("options").text == "编辑") {
		$("#btnEditOrSave2").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$.each($("#popTable2 input.easyui-textbox"), function(idx, elem) {
			if(elem.id != 'k_dataPermId') {
				$(elem).textbox("enable").textbox("readonly", false);
			}
		});
        $("#k_aclType").combobox("enable");
    } else {
		$("#btnEditOrSave2").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		$.each($("#popTable2 input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox("disable").textbox("readonly", true);
		});
        $("#k_aclType").combobox("disable");
		saveDataPermissionRule();
	}
}

function setDefaultDataPermissionRule() {
    if(!$(this).linkbutton('options').disabled) {
        var row = $('#grid2').datagrid('getSelected');
        if (row) {
            $.getJSON("../sys/dataPermission/rule/" + $("#p_id").textbox("getValue") + "/" + row.id + "/setDefault", null, function (response) {
                if (response.status == SUCCESS) {
                    $.messager.show({
                        title: '提示',
                        msg: "设置默认规则成功"
                    });
                    loadGrid2();
                } else {
                    $.messager.alert('提示', '设置默认规则失败: ' + response.message, 'info');
                }
            });
        }
    }
}

$(function() {
	
	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnDelete").click(remove);

	$("#btnEditOrSave").click(editOrSave);

    $("#btnAddDataPermissionRule").click(addDataPermissionRule);
    $("#btnEditDataPermissionRule").click(viewDataPermissionRule);
    $("#btnDeleteDataPermissionRule").click(deleteDataPermissionRule);
    $("#btnSetDefaultDataPermissionRule").click(setDefaultDataPermissionRule);

    $("#btnEditOrSave2").click(editOrSavePermissionRule);

	$("#btnReset").click(function(){
		$("#f_name").val('');
		$("#f_organization").val('');
	});
	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			id: $('#f_id').val()
		});
	});
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

	$("#mainTable td:even").css("text-align", "right");
	$('#orgTypeSelectDialog').dialog('close');
});