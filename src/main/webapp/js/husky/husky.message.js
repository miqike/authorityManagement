//获取用户消息总数
function getUserMessageCount(message, silence) {
	$.getJSON("./message/inBox/count", function(resp){
		if(parseInt(resp.messageCount)>0){
			$("#msgNum").text(resp.messageCount);
			$("#msgNum").show();
			if(!silence) { 
				var msg = null;
				if(message == undefined) {
					msg = "您有 " + resp.messageCount + " 条未读消息";
					if($("#messageTab").css("display") == "block"){ //正显示着消息对话框,刷新
						loadInboxGrid();
					}
				} else {
					msg = message;
				}
				$.messager.show('提示', msg, 'info', 'bottomRight');
			}
		} else {
			$("#msgNum").hide();
		}
	});
}

function jsonSocketOnOpenHandler() {
	jsonSocket.send(JSON.stringify(["SUBSCRIBE", "MSG_T_cpsi_" + window.userInfo.userId]));//订阅消息
}

function jsonSocketOnMessageHandler(messageEvent) {
	eval("var obj = " + messageEvent.data);
	if(obj.SUBSCRIBE[0] == "message") {
		if(obj.SUBSCRIBE[2] == "kickout") {
			$.messager.alert("警告", "因超出允许的单一账户同时登录数而被踢出,刷新页面即跳转到登录页面!");
		} else if(obj.SUBSCRIBE[2] == "forceLogout") {
			$.messager.alert("警告", "被管理员强行踢出,刷新页面即跳转到登录页面!");
		} else if(obj.SUBSCRIBE[2].startsWith("TODO:")) {
			var welcomeTab = $("#mainTabs").tabs("getSelected");
			if( welcomeTab.panel("options").title == "首页") {
				$("#welcome")[0].contentWindow.refresh();
			}
			getUserMessageCount("您有新的代办任务!");
		} else {
			getUserMessageCount();
		}
	}

	if(obj.SUBSCRIBE[2] == "activiti") {
		$('#mainTabs').tabs('select', "首页").tabs('getSelected').find("iframe")[0].contentWindow.refreshTodoTaskGrid();
	}
}

//取得一个消息并且打开窗口
function showMessageListDialog(){
	$.easyui.showDialog({
        title: "站内消息列表",
        width: 729, height: 459, topMost: false,
        enableSaveButton: false,
        enableApplyButton: false,
        closeButtonText: "返回",
        closeButtonIconCls: "icon-undo" ,
        href: "./sys/messageListDialog.jsp",
        onLoad: function () {
        	doMessageListDialogInit();
        }
    });
}

function writeMessage() {
	
	$.easyui.showDialog({
        title: "新消息",
        width: 600, height: 240, topMost: false,
        enableSaveButton: true,
        enableApplyButton: false,
        enableCloseButton: false,
        saveButtonText: "发送",
        saveButtonIconCls: "icon2 r10_c10",
        href: "./sys/messageDialog.jsp",
        onLoad: function () {
        	$.husky.loadForm("messageTable", {
        		//receiver: getReceivers(oriMsgs),
        		//receiverName: getReceiverNames(oriMsgs),
        		//title: "回复: " 
        	})
        },
        onSave: function () {
        	$.post("./message/", $.husky.getFormData("messageTable"), function(response){
        		if (response.status == $.husky.SUCCESS) {
					$.messager.show("操作提醒", "消息发送成功", "info", "bottomRight");
					return true;
				} else {
					$.messager.alert('错误', '消息发送失败：' + response.message, 'error');
					return false; 
				}
        	}, 'json');
        }
    });
}

function replyMessage() {
	var oriMsgs = $("#inboxGrid").datagrid("getSelections");
	if(oriMsgs.length == 0) {
		$.messager.alert("操作提示", "请选择至少一条消息进行回复", "error");
	} else {
		$.easyui.showDialog({
			title: "回复消息",
			width: 600, height: 240, topMost: false,
			enableSaveButton: true,
			enableApplyButton: false,
			enableCloseButton: false,
			saveButtonText: "发送",
			saveButtonIconCls: "icon2 r10_c10",
			href: "./sys/messageDialog.jsp",
			onLoad: function () {
				$.husky.loadForm("messageTable", {
					receiver: getReceivers(oriMsgs),
					receiverName: getReceiverNames(oriMsgs),
					title: "回复: " 
				})
			},
			onSave: function () {
				$.post("./message/", $.husky.getFormData("messageTable"), function(response){
					if (response.status == $.husky.SUCCESS) {
						$.messager.show("操作提醒", "消息发送成功", "info", "bottomRight");
						return true;
					} else {
						$.messager.alert('错误', '消息发送失败：' + response.message, 'error');
						return false; 
					}
				}, 'json');
			}
		});
	}
}

function getReceivers(msgs) {
	var receivers = new Array();
	for(var i=0; i<msgs.length; i++) {
		if(!receivers.contains(msgs[i].sender)) {
			receivers.push(msgs[i].sender);
		}
		
	}
	return receivers.join(",");
}

function getReceiverNames(msgs) {
	var receivers = new Array();
	for(var i=0; i<msgs.length; i++) {
		if(!receivers.contains(msgs[i].senderName)) {
			receivers.push(msgs[i].senderName);
		}
		
	}
	return receivers.join(",");
}

function markReaded() {
	var selections = $("#inboxGrid").datagrid("getSelections");
    if(selections.length>0) {
    	
    	var param = new Array();
    	$.each(selections, function(idx, elem) {
    		param.push(elem._id);
    	});
    	
        $.ajax({
            url: "./message/inBox/1",
            dataType: 'json',
            data: JSON.stringify(param),
            type: "PUT",
            contentType: "application/json; charset=utf-8",
            cache: false,
            success: function (response) {
            	loadInboxGrid();
            	getUserMessageCount(null, true);
            }
        });
    }
}
function moveFavoriate() {
}
function deleteMessage() {
	var oriMsgs = $("#inboxGrid").datagrid("getSelections");
	if(oriMsgs.length == 0) {
		$.messager.alert("操作提示", "请首先选择至少一条消息进行删除", "error");
	} else {
		$.messager.confirm('确认删除', '确认删除选中的消息?', function (r) {
			if (r) {
				var param = new Array();
				$.each(oriMsgs, function (idx, elem) {
					param.push(elem._id);
				});
	
				$.ajax({
					url: "./message/inBox",
					data: JSON.stringify(param),
					type: "DELETE",
					contentType: "application/json; charset=utf-8",
					cache: false,
					success: function (response) {
						if (response.status == $.husky.SUCCESS) {
							loadInboxGrid();
							$.messager.show("操作提醒", response.message, "info", "bottomRight");
						} else {
							$.messager.alert('提示', '操作失败: ' + response.message, 'error');
						}
					}
				});
			}
		});
	}
}


function messageTabSelectHandler(title, index) {
	if(index == 0) { //选择收件箱
		loadInboxGrid();
	} else if (index == 1) { //选择联系人
		
	} else if (index == 3) { //选择权限TAB
		
	}
}