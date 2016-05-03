

function mainGridButtonHandler() {
	
	var selections = $('#mainGrid').datagrid('getSelections').length;
	if(selections == 0) {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnDownload').linkbutton('disable');
	} else if(selections == 1) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnDownload').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('enable');
		$('#btnDownload').linkbutton('disable');
	}
}

function gridButtonHandler2() {
	var selections = $('#grid2').datagrid('getSelections').length;
	if(selections == 0) {
		$('#btnSuspendOrActive').linkbutton('disable');
		$('#btnDelete2').linkbutton('disable');
	} else {
		if(selections == 1) {
			$('#btnSuspendOrActive').linkbutton('enable');
			var row = $('#grid2').datagrid('getSelected');
			if(row.suspended) {
				$('#btnSuspendOrActive').linkbutton({text: "恢复"});
			} else {
				$('#btnSuspendOrActive').linkbutton({text: "挂起"});
			}
		} else {
			$('#btnSuspendOrActive').linkbutton('disable');
		}
		$('#btnDelete2').linkbutton('enable');
	}
}

function loadSuccess(data) {
	$('#mainGrid').datagrid('unselectAll');
	$('#btnView').linkbutton('disable');
	$('#btnDelete').linkbutton('disable');
	$('#btnDownload').linkbutton('disable');
}


function loadSuccess2(data) {
	$('#grid2').datagrid('unselectAll');
	$('#btnSuspendOrActive').linkbutton('disable');
	$('#btnDelete2').linkbutton('disable');
}

function formatDiagram(val, row) {
	return "<a href='#' onclick='showDiagram(\"" + row.id +"\");'>显示</a>";
}

function showDiagram(processDefinitionId) {
	$("#processDiagram").attr("src", "../sys/processDefinition/trace/" + processDefinitionId);
	$("#processDiagramWindow").window('open')
}


function add(){
	showModalDialog("popWindow1");
}

function view(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			showModalDialog("popWindow");
			var options = $('#grid2').datagrid('options');
			options.url = '../sys/processInstance';
			options.queryParams.processDefinitionId = row.id;
			$("#grid2").datagrid("reload");
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

function remove2(){
	if(!$(this).linkbutton('options').disabled) {
		var selections = $('#grid2').datagrid('getSelections');
		if (selections.length > 0) {
			$.messager.confirm('确认删除', '确认删除选中的流程实例?', function (r) {
				if (r) {
					var param = new Array();
					$.each(selections, function (idx, elem) {
						param.push(elem.id);
					});

					$.ajax({
						url: "../sys/processInstance",
						data: JSON.stringify(param),
						dataType: "json",
						type: "delete",
						contentType: "application/json; charset=utf-8",
						cache: false,
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#grid2').datagrid('reload');
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "流程实例已删除"
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

function download() {
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$("<iframe id='download' style='display:none' src='../sys/processDefinition/download?processDefinitionId=" + row.id + "&resourceName=xml'/>").appendTo("body");
		}
	}
}

function suspendOrActive() {
	if(!$(this).linkbutton('options').disabled) {
		var row =  $('#grid2').datagrid('getSelected');
		if(row) {
			$.getJSON("../sys/processInstance/" + row.id + "/suspend", {suspended: row.suspended}, function (response) {
				if (response.status == SUCCESS) {
					$.messager.show({
						title: '提示',
						msg: "流程挂起/恢复成功"
					});
					$('#grid2').datagrid('reload');
				} else {
					$.messager.alert('提示', '流程挂起/恢复失败: ' + response.message, 'info');
				}
			});
		}
	}
}

function deploy() {
	$("#mainForm").form('submit', {
		url : '../sys/processDefinition',
		onSubmit : function(param) {
			return $(this).form('validate');//对数据进行格式化
		},
		success : function(response) {
			eval("var r = " + response + ";")
			if(r.status == 1) {
				$.messager.show({
					title : '提示',
					msg : "流程定义部署成功"
				});
				$("#mainGrid").datagrid("reload");
				$("#popWindow1").window('close');
			} else {
				$.messager.show({
					title : '提示',
					msg : response.message
				});
			}

		}
	});
}

$(function() {

	$("html").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});
	
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
	$("#btnDelete").click(remove);
	$("#btnDownload").click(download);
	$("#btnSuspendOrActive").click(suspendOrActive);
	$("#btnDelete2").click(remove2);

	$("#btnDeploy").click(deploy);

});