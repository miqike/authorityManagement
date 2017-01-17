
//初始化一级菜单
function initTopMenu(menus) {
	$("#topMenu").empty();
	$.each(menus, function(i, menu) {
		$("<li title='" + menu.text + "' id='menu_" + menu.id + (i==0 ? "' class='active'>" : "'>") + menu.text + "</li>")
			.appendTo("#topMenu")
			.click(topMenuClickHandler)
			.find(":first").addClass('active');
	});
}

function topMenuClickHandler() {
	$('#topMenu li').removeClass('active');
	$(this).addClass('active');
	var menuId = $(this).attr('id').split("_")[1];
	var d = getMenuById(initData.menu, menuId);
	clearLeftMenu();
	initLeftMenu(d, 0);
}

function clearLeftMenu() {
	var pp = $('#wnav').accordion('getSelected');
	if (pp) {
		var title = pp.panel('options').title;
		$('#wnav').accordion('unselect', title);
	}

	pp = $('#wnav').accordion('panels');
    for(var i=pp.length; i>0; i--) {
		var index = i-1;
    	var n = pp[index];
        if (n) {
            $('#wnav').accordion('remove', index);
		}
    }
}

function getMenuById(menus, menuId) {
    var menu = null;
    $.each(menus, function(idx, _menu){
        if(_menu.id == menuId) {
            menu = _menu;
            return;
        }});
    return menu;
}

//初始化二三级菜单
function initLeftMenu(data, option) {
	if(data != undefined) {
		$.each(data.children, addSubNav);
		if(option != undefined) {
			var defaultSelectIndex, tabId;
			if(typeof option == "number") {
				defaultSelectIndex = option;
			} else if (typeof option == "string" && option.length > 2) {
				defaultSelectIndex = option.substr(1, 1) - 1;
				tabId = option;
			}
			var pp = $('#wnav').accordion('panels');
			var t = pp[defaultSelectIndex].panel('options').title;
			$('#wnav').accordion('select', t);
			if (typeof option == "string") {
				//setTimeout(function(){highlightMenuItem(tabId)},200 );
				highlightMenuItem(tabId)
			}
		}
		$('#wnav li').on('click', leftMenuItemClickHandler);
	} else {
		$.messager.alert("警告", "该用户没有任何资源授权");
	}
}

function addSubNav(i, sm) {
	var menuList = "";
	menuList += '<ul>';
	$.each(sm.children, function (j, o) {
		menuList += '<li ref="' + o.id + '" rel="'
			+ o.url + '" ><span class="icon ' + o.icon
			+ '" >&nbsp;</span><span class="nav">' + o.text
			+ '</span></li> ';
	});
	menuList += '</ul>';
	$('#wnav').accordion('add', {
		title: sm.text,
		content: menuList,
		iconCls: 'icon ' + sm.icon
	});
}

function leftMenuItemClickHandler() {
	var tabTitle = $(this).find('span.nav').text();
	var url = $(this).attr("rel");
	var menuId = $(this).attr("ref");
	var iconCls = $(this).find("span:first").attr("class");
	$('#wnav li').removeClass("selected");
	$(this).addClass("selected");
	window.mainpage.mainTabs.addModule({
		id:menuId, 
		title:tabTitle, 
		href:url,
		iconCls: iconCls
	});
}

function tabsOnSelectHandler(title, index) { 
	window.mainpage.mainTabs.updateHash(index); 
	
	if(title == '主页') {
	} else if (title != '我的任务') {
		//tab页ID,即菜单ID
		var tabId = $("#mainTabs").tabs("getSelected")[0].id;
		//菜单ID第一级，即一级菜单ID
		var menuId = tabId.substring(0, 1);
		//判断是否当前菜单
		var menu = $('#menu_' + menuId);
		
		if (!menu.hasClass('active')) {
			$('#topMenu li.active').removeClass('active')
			$('#menu_' + menuId).addClass('active')
			clearLeftMenu();
			initLeftMenu(getMenuById(initData.menu, menuId), tabId);
		} else {
			highlightMenuItem(tabId);
		}
	}
	
}

function highlightMenuItem(tabId) {
	var selectedMenuItem = $("#wnav li[ref='" + tabId + "']");
	$('#wnav').find("li").removeClass("selected");
	selectedMenuItem.addClass("selected");
}
/*
function setting() {
	$("#btnSetting").tooltip("show");
}*/


function showChangePwdDialog(){
	$.easyui.showDialog({
        title: "修改密码",
        width: 300, height: 230, topMost: false,
        enableApplyButton: false,
        href: "./sys/changePwdDialog.jsp",
        onSave: function (d) {
            var validate = d.form("validate");
            if (validate) {
                changePwd();
            } else {
                return false;
            }
        },
        onLoad: function () {
        	$('#t_password').val("");
        	$('#t_password2').val("");
        	$('#t_uid').val(initData.userInfo.userId);
        	$('#t_uname').val(initData.userInfo.name);
        	//$('#btnChangePwd').click(changePwd);
            var f = $(this), ret = $.fn.dialog.defaults.onLoad();
            f.form("disableValidation").form("enableValidation");
            return ret;
        },
        buttons: []
    });
}

function changePwd(){
	var r = $("#t_pwdForm").form('validate');
	if (!r) {
		return false;
	}
	var _pwd = new Base64().encode($('#t_password').val());
	//验证密码是否符合密码策略
	$.post('./user/validLoginUserPwd',{pwd: _pwd, _t:(new Date)},function(response){
		if(response && response.status == 1){
			//提交修改
			$.post("./user/changePwd",{pwd: _pwd, _t:(new Date)},function(resp){
				if(resp && resp.status == 1){
					$.messager.alert("操作提醒", "修改密码成功 ,用户将自动退出重新登录", function(){
						logout();
					});
				} else {
					$.messager.alert("错误", "修改密码失败 : " + resp.message, "error");
				}
			}, "json");
		} else {
            $.alert(response.message,function(){
            	$.easyui.closeCurrentDialog()
            });
		}
	}, "json");	
}

function logout(){
	$.post("./logout", null, function(response){
		window.onbeforeunload = null;
        $.util.closeWindowNoConfirm();
		window.location = './login';
	}, 'json');
}

function showRunAsDialog(){
	$.easyui.showDialog({
        title: "身份切换",
        width: 600, height: 430, topMost: false,
        enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
        href: "./sys/runAsDialog.jsp",
        onLoad: function () {
        	$.getJSON("./runas", null, function(response){
        		if(response==null || response.error!=null){
        			$.messager.alert('警告', response.error);
        		} else {
        			$("#t_current").text(window.userInfo.userId + "/" + window.userInfo.name);
        			if(response.isRunas){
        				$("#t_last").text(response.previousUserId + "/" + response.previousUsername);
        				$("#btnBackTo").linkbutton('enable');
        				$("#runAsTab").remove();
        			} else {
        				$("#t_last").text("");
        				$("#btnBackTo").linkbutton('disable');
        				renderFromTable(response.fromUserIds);
        				renderToTable(response.allUsers, response.toUserIds);
        			}
        		}
        	});
        },
        buttons: []
    });
}

function renderFromTable(fromUsers){
	$("#fromUserTable tr").remove();
	var table = $("#fromUserTable")
	$.each(fromUsers, function(index, value) {
		var userValue = value.split("/");
		var userId = userValue[0];
		var userName = userValue[1];
		var tr = "<tr><td>"+ userId +'</td><td>'+ userName +'</td><td><a href="javascript:void(0);" name="btnFromUser" class="easyui-linkbutton" plain="true" iconCls="icon2 r20_c13">切换</a></td></tr>';
		table.append(tr);
	});

	$("a[name='btnFromUser']").linkbutton().click(function(){
		var fromId = $(this).parent().parent().children().eq(0).text();
		switchTo(fromId);
	});
}

function renderToTable(allUsers, toUsers){
	$("#toUserTable tr").remove();
	var table = $("#toUserTable")
	$.each(allUsers, function(index,value){
		var tr = "<tr><td>"+ value.userId +'</td><td>'+ value.name +'</td><td><a href="javascript:void(0);" name="btnToUser" class="easyui-linkbutton" plain="true" iconCls="icon-tip">授权</a></td>';
		table.append(tr);
	});

	$.each(toUsers, function(index,value){
		var tableRows = $("#toUserTable tr");
		$.each(tableRows, function(trIndex,trItem){
			$(trItem).find("td").each(function(tdIndex,tdItem){
				if(tdIndex==0){
					if($(tdItem).text() == value){
						$(tdItem).parent().children().eq(2).html('<a href="javascript:void(0);" name="btnRelease" class="easyui-linkbutton" plain="true" iconCls="icon-cancel">解除</a>');
					}
				}
			});
		});
	});

	$("a[name='btnRelease']").linkbutton().click(function(){
		var relId=$(this).parent().parent().children().eq(0).text();
		grantOrRevoke(relId, "revoke");
	});
	$("a[name='btnToUser']").linkbutton().click(function(){
		var toId=$(this).parent().parent().children().eq(0).text();
		grantOrRevoke(toId, "grant");
	});
}

//切换到上一个身份
function switchBack(){
	$.messager.confirm("确认", "是否切换回上一个身份？", function(r){
		if(r) {
			$.getJSON("./runas/switchBack", null, reloadCallback);
		}
	});
}

//切换身份
function switchTo(fromId){
	$.messager.confirm("确认", "是否切换到该身份？", function(r){
		if(r) {
			$.getJSON("./runas/switchTo?switchToUserId=" + fromId, null, reloadCallback);
		}
	});
}

function reloadCallback(resp){
	if(resp && resp.status == 1){
		location.reload();
	} else {
		$.messager.alert("操作提示", resp.message, "error");
	}
}


//授予/回收身份
function grantOrRevoke(toUserId, operation){
	var prompt = operation == "grant" ? "是否授权用户 '" + toUserId + "' 使用本人的身份?" : "是否收回用户 '" + toUserId + "' 使用本人身份的授权?";
	$.messager.confirm("确认", prompt, function(r){
		if(r) {
			$.getJSON("./runas/" + operation + "?toUserId=" + toUserId, null, function(resp) {
				if(resp && resp.status == 1){
					$.messager.show("操作提示", resp.message, "info", "bottomRight");
					refreshToTable(toUserId);
					return true;
				} else {
					$.messager.alert("操作提示", resp.message, "error");
				}
			});
		}
	});
}

function refreshToTable(toUserId){
	var rows = $("#toUserTable tr");
	$.each(rows, function(index, elem){
		if($(elem).find("td:first").text() == toUserId) {
			var iconTd = $(elem).find("td:nth-child(3)");
			if(iconTd.find("span.l-btn-text").text() == "解除") {
				iconTd.empty().html('<a href="javascript:void(0);" name="btnToUser" class="easyui-linkbutton" plain="true" iconCls="icon-tip">授权</a>');
			} else {
				iconTd.empty().html('<a href="javascript:void(0);" name="btnRelease" class="easyui-linkbutton" plain="true" iconCls="icon-cancel">解除</a>');
			}
			$.parser.parse(iconTd);
		}
	});

	$("a[name='btnRelease']").linkbutton().click(function(){
		var relId=$(this).parent().parent().children().eq(0).text();
		grantOrRevoke(relId, "revoke");
	});
	$("a[name='btnToUser']").linkbutton().click(function(){
		var toId=$(this).parent().parent().children().eq(0).text();
		grantOrRevoke(toId, "grant");
	});
}

function showThemeDialog(){
	
	$.easyui.showDialog({
        title: "主题切换",
        width: 300, height: 200, topMost: false,
        enableApplyButton: false,
        href: "./sys/changeThemeDialog.jsp",
        onSave: setUserTheme,
        onLoad: function () {
        	var currentTheme = $("#easyuiTheme").attr("href").split("/")[3];
        	$("#userTheme").combobox("setValue", currentTheme);
        }
    });
}

function setUserTheme() {
	$.post("./sys/user/profile",{
		userId: userInfo.id,
		type: 'theme',
		value: $("#userTheme").combobox("getValue"),
		literal: $("#userTheme").combobox("getText"),
		typeDesc: '用户主题'
	},function(response){
		if(response.status == $.husky.FAIL){
			$.messager.alert("警告", combineErrorMessage(response), "warning");
		} else {
			$.messager.alert("操作提示","用户主题设置成功,将重新刷新页面", "info");
			window.location.reload();
		}
	});
}

function showMsgDialog() {
}