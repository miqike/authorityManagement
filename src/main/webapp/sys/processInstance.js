function mainGridButtonHandler() {

	var selections = $('#mainGrid').datagrid('getSelections').length;
	if(selections == 0) {
		$('#btnSuspendOrActive').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnViewDiagram').linkbutton('disable');
		$('#btnViewHistory').linkbutton('disable');
	} else {
		if(selections == 1) {
			$('#btnViewDiagram').linkbutton('enable');
			$('#btnViewHistory').linkbutton('enable');
			$('#btnSuspendOrActive').linkbutton('enable');
			var row = $('#mainGrid').datagrid('getSelected');
			if(row.suspended) {
				$('#btnSuspendOrActive').linkbutton({text: "恢复"});
			} else {
				$('#btnSuspendOrActive').linkbutton({text: "挂起"});
			}
		} else {
			$('#btnSuspendOrActive').linkbutton('disable');
		}
		$('#btnDelete').linkbutton('enable');
	}

}

function loadSuccess(data) {
	$('#mainGrid').datagrid('unselectAll');
	$('#btnSuspendOrActive').linkbutton('disable');
	$('#btnDelete').linkbutton('disable');
	$('#btnViewDiagram').linkbutton('disable');
	$('#btnViewHistory').linkbutton('disable');
}

function suspendOrActive() {
	if(!$(this).linkbutton('options').disabled) {
		var row =  $('#mainGrid').datagrid('getSelected');
		if(row) {
			$.getJSON("../sys/processInstance/" + row.id + "/suspend", {suspended: row.suspended}, function (response) {
				if (response.status == SUCCESS) {
					$.messager.show({
						title: '提示',
						msg: "流程挂起/恢复成功"
					});
					$('#mainGrid').datagrid('reload');
				} else {
					$.messager.alert('提示', '流程挂起/恢复失败: ' + response.message, 'info');
				}
			});
		}
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var selections = $('#mainGrid').datagrid('getSelections');
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


function showProcessInstance(processInstanceId) {
    $("#processInstanceDiagram").attr("src", "./processInstance/trace/" + processInstanceId);
    $.getJSON("./processInstance/trace?pid=" + processInstanceId, function(infos) {
        var positionHtml = "";

        // 生成图片
        var varsArray = new Array();
        $.each(infos, function(i, v) {
            var $positionDiv = $('<div/>', {
                'class': 'activity-attr'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
                width: (v.width - 2),
                height: (v.height - 2),
                backgroundColor: 'black',
                opacity: 0,
                zIndex: $.fn.qtip.zindex - 1
            });

            // 节点边框
            var $border = $('<div/>', {
                'class': 'activity-attr-border'
            }).css({
                position: 'absolute',
                left: (v.x - 1),
                top: (v.y - 1),
                width: (v.width - 4),
                height: (v.height - 3),
                zIndex: $.fn.qtip.zindex - 2
            });

            if (v.currentActiviti) {
                $border.addClass('ui-corner-all-12').css({
                    border: '3px solid red'
                });
            }
            positionHtml += $positionDiv.outerHTML() + $border.outerHTML();
            varsArray[varsArray.length] = v.vars;
        });
        
        $('#processInstanceDiagramWindow #processImageBorder').html(positionHtml);

        // 设置每个节点的data
        $('#processInstanceDiagramWindow .activity-attr').each(function(i, v) {
            $(this).data('vars', varsArray[i]);
        });

        $('.activity-attr').qtip({
            content: function() {
                var vars = $(this).data('vars');
                var tipContent = "<table class='need-border'>";
                $.each(vars, function(varKey, varValue) {
                    if (varValue) {
                        tipContent += "<tr><td class='label'>" + varKey + "</td><td>" + varValue + "<td/></tr>";
                    }
                });
                tipContent += "</table>";
                return tipContent;
            },
            position: {
                at: 'bottom left',
                adjust: {
                    x: 3
                }
            }
        });
    });
    
    $("#processInstanceDiagramWindow").window('open');
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

	$("#btnViewDiagram").click(function() {
		var row = $("#mainGrid").datagrid("getSelected");
		showProcessInstance(row.id)
	});

	$("#btnViewHistory").click(function() {
		var row = $("#mainGrid").datagrid("getSelected");
		showModalDialog("popWindow");
		var options = $('#grid2').datagrid('options');
		options.url = '../sys/processInstance/history';
		options.queryParams.processInstanceId = row.id;
		$("#grid2").datagrid("reload");
	});

	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			key: $("#f_key").val(),
			status: $("#f_piStatus").combobox("getValue")
		});
	});
	
	$("#btnReset").click(function(){
		$("#f_key").val("");
	});

	$("#btnSuspendOrActive").click(suspendOrActive);
	$("#btnDelete").click(remove);
});