window.operateType = "";//操作类型

var setting = {
    data: {
        key: {
            title: "parentId",
            name: "nameWithId"
        }
    },
    async: {
        enable: true,
        type: "get",
        url: "../sys/organization/getSub",
        autoParam: ["id"]
    },
    callback: {
        beforeClick: beforeTreeClick,
        onClick: onTreeClick,
        onAsyncSuccess: zTreeOnAsyncSuccess
    }
};

var log, className = "dark";
//树加载成功后事件
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {

}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "" : "dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=zfryMapper&queryName=query';
    options.queryParams = {
        dwId: processorOrgId(treeNode.id)
    };
    $("#mainGrid").datagrid(options);

    setReadOnlyStatus();
}

function mainGridButtonHandler(index,row) {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnTrans').linkbutton('enable');
		$('#btnDeleteZfry').linkbutton('enable');
		if($('#mainGrid').datagrid('getSelected').zt == 1) {
			$('#btnLock').linkbutton({
				text:'注销'
			}).linkbutton('enable');
		} else {
			$('#btnLock').linkbutton({
				text:'取消注销'
			}).linkbutton('enable');
		}
		if($('#mainGrid').datagrid('getSelected').userId == null) {
			$('#btnAddSysUser').linkbutton('enable');
		} else {
			$('#btnAddSysUser').linkbutton('disable');
		}
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnLock').linkbutton('disable');
		$('#btnAddSysUser').linkbutton('disable');
		$('#btnTrans').linkbutton('disable');
		$('#btnDeleteZfry').linkbutton('disable');
	}
}

//设置页面为编辑状态
function setEditStatus() {
    $("#btnAdd").linkbutton('disable');
    $("#btnSave").linkbutton('enable');
    $("#btnCancel").linkbutton('enable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
        $("#btnView").linkbutton("enable");
        $("#btnLock").linkbutton("enable");
        $("#btnTrans").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnLock").linkbutton("disable");
        $("#btnTrans").linkbutton("disable");
    }

    $("#zfryTable input.easyui-validatebox").removeAttr("readonly");
    $("#zfryTable input.easyui-datebox").datebox("enable");
    $("#zfryTable input.easyui-combobox").combobox("enable");
    $("#zfryTable input.easyui-combotree").combotree("enable");
}
//设置页面为不可编辑状态
function setReadOnlyStatus() {
    $("#btnAdd").linkbutton('enable');
    $("#btndelete").linkbutton('disable');
    $("#btnSave").linkbutton('disable');
    $("#btnCancel").linkbutton('disable');
    if ($("#mainGrid").datagrid("getSelected") != null) {
    	 $("#btndelete").linkbutton('enable');
        $("#btnView").linkbutton("enable");
        $("#btnLock").linkbutton("enable");
        $("#btnTrans").linkbutton("enable");
    } else {
        $("#btnView").linkbutton("disable");
        $("#btnLock").linkbutton("disable");
        $("#btnTrans").linkbutton("disable");
        $("#btnDelete").linkbutton('disable');
    }
    $("#zfryTable input.easyui-validatebox").attr("readonly", true);
    $("#zfryTable input.easyui-datebox").datebox("disable");
    $("#zfryTable input.easyui-combobox").combobox("disable");
    $("#zfryTable input.easyui-combotree").combotree("disable");
}


//删除按钮点击事件
function lock() {
    var row = $('#mainGrid').datagrid('getSelected');
	var operate = row.zt == 1 ? "注销" : "取消注销";
	var msg = '是否 ' + operate + ' 执法人员 ' + row.name + ' ?';
	if (row) {
		$.messager.confirm('确认', msg, function (r) {
			if (r) {
				$.getJSON("../21/2102/" + row.code + "/lock", null, function (response) {
					if (response.status == $.husky.SUCCESS) {
						$.messager.show("操作提醒", '执法人员 ' + row.code + ' ' + operate + '成功', "info", "bottomRight");
						$('#mainGrid').datagrid('reload');
					} else {
						$.messager.alert('提示', '执法人员 ' + row.code + ' ' + operate + '失败: ' + response.message, 'error');
					}
				});
			}
		});
	}
}




function addSysUser () {
	$.easyui.showDialog({
        title: "请输入操作员编号",
        width: 300, height: 120, topMost: false,
        href: "./addSysUserDialog.jsp",
        enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		
        onSave: function (d) {
        	console.log("2222-----------")
        	var userId = $("#k_userId").val();
        	var zfry = $("#mainGrid").datagrid("getSelected");
        	if(userId != "") {
        		$.post("./2102/" + zfry.code + "/" + userId, function(response){
        			if(response.status == $.husky.FAIL){
        				$.messager.alert("操作错误", response.message, "error");
        				$("#mainGrid").datagrid("reload");
        				return true;
        			} else if (response.status == $.husky.SUCCESS) {
        				$.messager.show("操作提醒", response.message, "info", "bottomRight");
        				return false;
        			}
        		});
        	} else {
        		$.messager.alert("用户名不能为空!");
        		return false;
        	}
        }
    });

}

function add(){
	$('#mainGrid').datagrid('unselectAll');
	showZfryForm("add");
}




function view(){
	var row = $('#mainGrid').datagrid('getSelected');
	if (row) {
		showZfryForm("update", row);
	}
}
//增加本级按钮点击事件
function showZfryForm(operation, data) {
	$.easyui.showDialog({
		title : "执法人员信息",
		width : 750,
		height : 320,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./zfryForm.jsp",
		onLoad : function() {
			zfryFormInitHandler(operation, data);
		},
		onSave: function() {
			zfryFormSaveHandler(operation);
			return false;
		},
        toolbar: [
  			{ text: "新增", iconCls:"icon-add", handler: zfryFormAddHandler },
  			"-",
  			{ text: "首个", iconCls:"icon-first", handler: function () { $.husky.ramble("first", "mainGrid", "zfryTable"); } },
  			{ text: "上一个", iconCls:"icon-previous", handler: function () { $.husky.ramble("previous", "mainGrid", "zfryTable"); } },
  			{ text: "下一个", iconCls:"icon-next", handler: function () { $.husky.ramble("next", "mainGrid", "zfryTable"); } },
  			{ text: "末个", iconCls:"icon-last", handler: function () { $.husky.ramble("last", "mainGrid", "zfryTable"); } }
  		]
	});
}


function zfryFormInitHandler(operation, data) {
	$.codeListLoader.parse($('#zfryTable'))
	if(operation == "add"){
		zfryFormAddHandler();
	} else {
		if(null != data) {
			setTimeout(function() {
				$.husky.loadForm("zfryTable", data);
				$.husky.setFormStatus("zfryTable", operation);
			}, 300);
		}
	}
}

function zfryFormSaveHandler(operation){
	if( $('#zfryTable').form('validate')) {
		save(operation);
	}
}

//通用保存函数
function save(operation) {
    var data = $.husky.getFormData("zfryTable");
    var type = "";
    var url = "";
    if (operation == "add") {//增加本级
        type = "POST";
        url = "../21/2102";
    }
    if (operation == "update") {//修改
        type = "POST";
        data._method = "put";
        url = "../21/2102";
    }
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: function (response) {
            if (response.status == $.husky.SUCCESS) {
                setReadOnlyStatus();
                var grid = $("#mainGrid");
		    	var row = grid.datagrid("getSelected");
		    	if(null==row) { //新增,设置查找条件,重新加载grid,选中
		    		$("#mainGrid").datagrid("reload");
		    	} else {
		    		$.husky.refreshParent("mainGrid", data);
		    	}
		    	$.messager.show("操作提醒", response.message, "info", "bottomRight");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });
}

function zfryFormAddHandler(){
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();
    
    if(selected.length != 1) {
    	$.messager.alert("操作提示", "请首先选择单位");
    } else {
    	$.husky.loadForm("zfryTable", {
    		dwId:selected[0].id,
    		dwName:selected[0].name//todo
    	});
    	$.husky.setFormStatus("zfryTable", "add");
    	$("#mainGrid").datagrid("unselectAll");
    }
}

function loadMainGrid() {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();

    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=zfryMapper&queryName=query';
    options.queryParams = {
        dwId: selected.length == 1 ? processorOrgId(selected[0].id) : "",
        name: $("#f_name").val(),
        zflx: $("#f_zflx").combobox("getValue"),
        jhid: $("#f_jhid").val(),
        userId:$("#f_userId").val()
       
    };
    $("#mainGrid").datagrid(options);
}

function reset() {
    $("#queryTable").form("clear");
    loadMainGrid();
}

function selectOrgDialog() {
	$.easyui.showDialog({
		title : "管辖单位选择",
		width : 450,
		height : 400,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : true,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./gxdwSelectDialog.jsp",
		onLoad : function() {
			 $("#gxdwGrid").datagrid({
				 singleSelect:true, method:'get',
				 queryParams: {parentId: $("#p_dwId").val()},
				 url: "../common/query?mapper=sysOrganizationMapper&queryName=queryGxdwByOrgId"
			 });
		},
		onSave: function() {
			//zfryFormSaveHandler(operation);
			var gxdw = $("#gxdwGrid").datagrid("getSelected");
			$("#p_gxdwId").val(gxdw.id);
			$("#p_gxdwName").val(gxdw.name);
		}
	});
}

$(function () {
    $.fn.zTree.init($("#orgTree"), setting);

    setReadOnlyStatus();
/*
    $("#mainGrid").datagrid({"singleSelect": "true"}).datagrid({
        onSelect: function (index, row) {
            $("#btnTrans").linkbutton("enable");
            $("#btnView").linkbutton("enable");
            $("#btnLock").linkbutton("enable");
            $("#baseInfo").form('clear');
            //$.easyuiExtendObj.loadForm("baseInfo", row);
            $("#baseInfo").form("load", row);
        },
        onUnselect: function (index, row) {
            $("#btnView").linkbutton("disable");
            $("#btnLock").linkbutton("disable");
            $("#btnAddSysUser").linkbutton("disable");
            $("#btnTrans").linkbutton("disable");
            $("#baseInfo").form('clear');
        }
    });*/
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=zfryMapper&queryName=query';
    $("#mainGrid").datagrid(options);

    
});

function deleteZfry(){
	 
	    	var row = $("#mainGrid").datagrid("getSelected");
	    	console.info(row);
			if(null != row) {
				$.messager.confirm("请确人是否删除该检查项?", function (c) { if(c){
					$.ajax({
				        url: "../21/2102?code="+row.code,
				        type: "DELETE",
				        success: function (response) {
				            if (response.status =='1') {
				                
				                $("#btnView").linkbutton("disable");
				                $("#btnDelete").linkbutton("disable");
				                $("#mainGrid").datagrid("reload");
				                $.messager.alert('成功', response.message, 'info');
				            } else {
				                $.messager.alert('失败', response.message, 'info');
				            }
				        }
				    });
					
				}});
			}
	    }

