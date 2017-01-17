document.onkeydown=function(e){
    var keyEvent;
    if(e.keyCode==8){
        var d=e.srcElement||e.target;
        if(d.tagName.toUpperCase()=='INPUT'||d.tagName.toUpperCase()=='TEXTAREA'){
            keyEvent=d.readOnly||d.disabled;
        }else{
            keyEvent=true;
        }
    }else{
        keyEvent=false;
    }
    if(keyEvent){
        e.preventDefault();
    }
}

function refresh() {
	var tab = $("#taskTabPanel").tabs("getSelected");
	if( $('#taskTabPanel').tabs('getTabIndex', tab) == 0) {
		reloadTodoTaskGrid();
	} else {
		$("#taskTabPanel").tabs("select", 0);
	}
}

function reloadTodoTaskGrid() {
	$("#todoTaskGrid").datagrid({"url": "./bpm/task/todo"});
}

/*
function reloadDoneTaskGrid() {
	$("#doneTaskGrid").datagrid({"url": "./bpm/task/done"});
}
*/
function reloadInvolvedProcessInstanceGrid() {
	var processStatus = $("input:radio[name='processStatus']:checked").val();
		
	$("#involvedProcessInstanceGrid").datagrid({"url": "./sys/processInstance/involved?status=" + processStatus});
	if(processStatus == "1") {
		$("#involvedProcessInstanceGrid").datagrid("hideColumn", "endTime")
		$("#involvedProcessInstanceGrid").datagrid("showColumn", "activityId")
		$("#involvedProcessInstanceGrid").datagrid("showColumn", "ended")
	} else {
		$("#involvedProcessInstanceGrid").datagrid("showColumn", "endTime")
		$("#involvedProcessInstanceGrid").datagrid("hideColumn", "activityId")
		$("#involvedProcessInstanceGrid").datagrid("hideColumn", "ended")
	}
}

var isInIframe = function(){
    return parent.document.location != self.document.location;
};

function remove(){
    $('#pp').portal('remove', $('#todoTaskGrid'));
    $('#pp').portal('resize');
}

function formatPriority(val, row) {
    var _val = parseInt(val);
    if(_val <= 30) {
        return "<span style='color:green'><img src='./images/priority-low-16.png'/></span>";
    } else if(_val <= 70) {
        return "<span style='color:orange'><img src='./images/priority-medium-16.png'/></span>";
    } else {
        return "<span style='color:red'><img src='./images/priority-high-16.png'/></span>";
    }
}

function formatTask(val, row) {
    return "<a href='#' onclick='showForm(this, \"" + row.id + "\");'>"  + val + "</a>";
}

function formatUser(val, row) {
	return "<a href='#' onclick='showSendMsgWindow(this, \"" + row.startUserId + "/" + val + "\");'>"  + val + "</a>";
}

function showSendMsgWindow(src, user) {
	if(isInIframe()) {
		parent.window.showSendMsgWindow(user);
	}
}

function showForm(src, taskId) {
    if(isInIframe()) {
        //在父窗口打开新的表单
        var url = "./bpm/form/" + taskId;
        parent.window.addTabPage("999", "我的任务", url, 'icon-tip');
        $(src).tooltip("hide");
    } else {
    }
}

function formatProcessDefinition(val, row) {
	if(row.state == "结束" || row.endTime != null) {
		return "<a href='#' onclick='showProcessDefinition(\"" + row.processDefinitionId +"\");'>"  + val + "</a>";
	} else {
		var processInstanceId = row.processInstanceId != undefined ? row.processInstanceId: row.id;
		return "<a href='#' onclick='showProcessInstance(\"" + processInstanceId +"\");'>"  + val + "</a>";
	}
}

function loadSuccess() {
    if($("#todoTaskGrid").datagrid("getData").rows.length > 0) {
        $.each($("#todoTaskGridDiv div.datagrid div.datagrid-body td[field='name'] div.datagrid-cell a"), function (idx, link) {
            var content = '<span>';
            var messages = $("#todoTaskGrid").datagrid("getData").rows[idx].comment;
            if(messages != null && messages.length > 0) {
                $.each(messages, function (i, message) {
                	if(message.message != "") {
                		if (message.orgId != null) {
                			content += message.orgId;
                			content += " "
                		}
                		content += datetimeFormatter(message.time, false);
                		content += " "
                		content += message.userName;
                		content += ": "
                			if(message.message != null) {
                				content += message.message;
                			}
                		content += "<br/>"
                	}
                });
            } else {
                content += '无批注';
            }
            content += '</span>';
            $(link).tooltip({
                position: 'right',
                content: content,
                onShow: function () {
                    $(this).tooltip('tip').css({
                        backgroundColor: 'orange',
                        borderColor: '#666'
                    });
                }
            });
        });
    }
}

//显示流程状态
function showProcessDefinition(processDefinitionId) {
	$("#processDiagram").attr("src", "./sys/processDefinition/trace/" + processDefinitionId);
	$('#processImageBorder').empty();
	$("#processDiagramWindow").window('open');
}

function showProcessInstance(processInstanceId) {
    $("#processDiagram").attr("src", "./sys/processInstance/trace/" + processInstanceId);
    $.getJSON("./sys/processInstance/trace?pid=" + processInstanceId, function(infos) {
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
        
        $('#processImageBorder').html(positionHtml);

        // 设置每个节点的data
        $('#processDiagramWindow .activity-attr').each(function(i, v) {
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
    
    $("#processDiagramWindow").window('open');
}

//候选任务新增"签收"操作链接
function formatOperation(val, row) {
    if(row.assignee === null) {
        return "<a href='#' onclick='claim(" + row.id + ");'>签收</a>";
    } else {
        return "";
    }
}

function formatProcessInstanceState(val, row) {
	if(val=="挂起") {
		return "<span style='color:red'>挂起</span>";
	} else if(val=="结束") {
		return "<span style='color:blue'>结束</span>";
	} else {
		return val;
	}
}

function formatInvolvedProcessInstanceState(val, row) {
	if(row.ended) {
		return "<span style='color:blue'>结束</span>";
	} else if(row.suspended) {
		return "<span style='color:red'>挂起</span>";
	} else {
		return "流转中";
	}
}

//签收候选任务
function claim(taskId) {
    $.post("./bpm/task/claim/" + taskId, null, function(response) {
        if(response.status == 1) {
            $.messager.show({
                title : '提示',
                msg : "任务已签收"
            });
            $("#todoTaskGrid").datagrid('reload');
        } else {
            $.messager.alert("错误", response.message);
        }
    }, "json");
}

function taskTabSelectHandler(title, index) {
	if(index == 0) {
		reloadTodoTaskGrid();
	} else if (index == 1) {
		//reloadDoneTaskGrid();
		reloadInvolvedProcessInstanceGrid();
	}
}

$(function(){
    $('#pp').portal({
        border:false,
        fit:true
    });
    
    $("input:radio[name='processStatus']").change(reloadInvolvedProcessInstanceGrid);
    
});
