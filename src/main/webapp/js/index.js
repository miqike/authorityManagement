var webdis = "";
var menus = null;
var _$cmenu;//grid列头右键菜单 by chenze
var _layoutFullScreen = false;

function documentKeyDownHandler(event){
	var keyEvent;
	if(event.keyCode==8){
		var d=event.srcElement||event.target;
		if(d.tagName.toUpperCase()=='INPUT'||d.tagName.toUpperCase()=='TEXTAREA'){
			keyEvent=d.readOnly||d.disabled;
		} else {
			keyEvent=true;
		}
	} else {
		keyEvent=false;
	}
	if(keyEvent){
		event.preventDefault();
	}
}

//用户关闭浏览器
function closeBrowse(){
	try {
		var n = window.event.screenX - window.screenLeft;
		var b = n > document.documentElement.scrollWidth - 20;
		//可以捕获 点击小叉和 Alt+F4 时浏览器关闭的情况，但是不能捕获在多窗口浏览模式下，用户点多窗口模式的小差关闭浏览器的情况
		if (b && window.event.clientY < 0 || window.event.altKey) {
			logout();
		}
	} catch (e) {}
}

$.fn.addTab=function(options){//添加一个tab
	var setting= $.extend({}, options);
	if(this.tabs('exists', setting.title)){
		$('#tabs').tabs('select', setting.title).tabs('getSelected').find("iframe")[0].contentWindow.location.reload();
	} else if($('#tabs').tabs("tabs").length > 10) {
		$.messager.alert("警告", "您已经打开了太多的页面，请首先关闭一些页面！")
	} else {
		this.tabs('add', {
			id: options.id,
			title: setting.title,
			content: '<iframe src="' + setting.url + '" frameborder=0 style="width:100%;height:100%;border:none"></iframe>',
			closable: setting.closeable || true
		});
	}
};

$.fn.closeTab=function(title){
	if(this.tabs('exists',title)){
		this.tabs('close',title);
	}
};

$.fn.existsTab=function(title){
	return this.tabs('exists',title);
};

function _closeTab(title){
	$("#tabs").closeTab(title);
};

function layoutFullScreen() {
	$("body").layout(window._layoutFullScreen? "unFullScreen": "fullScreen");
	window._layoutFullScreen = !window._layoutFullScreen;
}

//layout组件全屏
$.extend($.fn.layout.methods, {
	fullScreen : function (jq) {
		return jq.each(function () {
			var layout = $(this);
			var center = layout.layout('panel', 'center');
			center.panel('maximize');
			center.parent().css('z-index', 20);
		});
	},
	unFullScreen : function (jq) {
		return jq.each(function () {
			var layout = $(this);
			var center = layout.layout('panel', 'center');
			center.parent().css('z-index', 'inherit');
			center.panel('restore');
			
		});
	}
});

function fullScreen(src) {
	if ($.util.supportsFullScreen) {
		if ($.util.isFullScreen()) {
			$.util.cancelFullScreen();
			$(src).find("span").text("全屏");
			$(src).find("img").attr("src", "./css/themes/icons/arrow_out_longer.png");
		} else {
			$.util.requestFullScreen();
			$(src).find("span").text("恢复");
			$(src).find("img").attr("src", "./css/themes/icons/arrow_in_longer.png");
		}
	} else {
		$.easyui.messager.show("当前浏览器不支持全屏 API，请更换至最新的 Chrome/Firefox/Safari 浏览器或通过 F11 快捷键进行操作。");
	}
}
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
	var d = getMenuById(menus, menuId);
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
function initLeftMenu(data, defaultSelectIndex) {
	if(data != undefined) {
		$.each(data.children, addSubNav);
		if(defaultSelectIndex != undefined) {
			var pp = $('#wnav').accordion('panels');
			var t = pp[defaultSelectIndex].panel('options').title;
			$('#wnav').accordion('select', t);
		}
	} else {
		$.messager.alert("警告", "该用户没有任何资源授权");
	}
	$('#wnav li').on('click', leftMenuItemClickHandler);
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
	addTabPage(menuId, tabTitle, url, 'icon-tip');
	$('#wnav li').removeClass("selected");
	$(this).addClass("selected");
}

//添加Tab选项
function addTabPage(id, title, url, icon) {
	var tabs = $("#tabs");
	tabs.addTab({
		id: id,
		title: title,
		url: url
	});

	var tabPanel = tabs.tabs("getTab", title);
	tabPanel.find("iframe")[0].contentWindow.title = title;
}

function tabsOnSelectHandler(title, index){
	if(title == '欢迎页') {
		/*
		if($("#welcome")[0].src == "") {
			$("#welcome")[0].src="./welcome.jsp";
		} else {
			$("#welcome")[0].contentWindow.refresh();
		}
		*/
//		$("#welcome")[0].src="./calendar/calendar.jsp"
	} else if (title != '我的任务') {
		//tab页ID,即菜单ID
		var tabId = $("#tabs").tabs("getSelected")[0].id;
		//菜单ID第一级，即一级菜单ID
		var menuId = tabId.substring(0, 1);
		//判断是否当前菜单
		var menu = $('#menu_' + menuId);
		if (!menu.hasClass('active')) {
			$('#topMenu li.active').removeClass('active')
			$('#menu_' + menuId).addClass('active')
			clearLeftMenu();
			initLeftMenu(getMenuById(menus, menuId));
		}

		//判断是否当前二级菜单
		var selectedMenuItem = $("#wnav li[ref='" + tabId + "']");
		var accordionTabId = selectedMenuItem.parent().parent().parent().index();
		$('#wnav').accordion('select', accordionTabId);
		$('#wnav').find("li").removeClass("selected");
		selectedMenuItem.addClass("selected");
	}
}

function tabOnContextMenu(e, title) {
	e.preventDefault();
	$('#tabsMenu').menu('show', {
		left : e.pageX,
		top : e.pageY
	}).data("tabTitle", title);
}

//实例化menu的onClick事件
function tabsMenuOnClickHandler(item) {
	handleTabsMenuClick(this, item.name);
}

//几个关闭事件的实现
function handleTabsMenuClick(menu, type) {
	var curTabTitle = $(menu).data("tabTitle");
	var tabs = $("#tabs");
	if (type === "reload") {
		$('#tabs').tabs('getSelected').find("iframe")[0].contentWindow.location.reload();
		return;
	} else if (type === "close") {
		tabs.tabs("close", curTabTitle);
		return;
		    
	} else {
		var allTabs = tabs.tabs("tabs");
		var closeTabsTitle = [];
		$.each(allTabs, function () {
			var opt = $(this).panel("options");
			if (opt.closable && opt.title != curTabTitle && type === "closeOther") {
				closeTabsTitle.push(opt.title);
			} else if (opt.closable && type === "closeAll") {
				closeTabsTitle.push(opt.title);
			}
		});
		for (var i = 0; i < closeTabsTitle.length; i++) {
			tabs.tabs("close", closeTabsTitle[i]);
		}
	}
}



function logout(){
	$.post("./logout", null, function(response){
		window.location = response.redirect;
	}, 'json');
}

function showChangePwdDialog(){
	$.easyui.showDialog({
        title: "修改密码",
        width: 300, height: 230, topMost: false,
        enableApplyButton: false,
        href: "./sys/changePwdDialog.jsp",
        onSave: function (d) {
            var validate = d.form("validate");
            if (validate) {
                /*$.easyui.showOption(d.form("getData"), { title: "您输入的数据为" });*/
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
					$.alert("修改密码成功 ",function(){
						logout();
					});
				} else {
					$.alert("修改密码失败 ",function(){
					});
				}
			}, "json");
		} else {
            $.alert(response.message,function(){
                $('#changePwdDialog').dialog('close');
            });
		}
	}, "json");			
}

function showRunAsDialog(){
	var tabs = $("#tabPanelRunAs").tabs("tabs");
	for (var i = 0; i < tabs.length; i++) {
		tabs[i].panel('options').tab.unbind().bind("click", { index: i }, function (e) {
			$('#tabPanelRunAs').tabs("select", e.data.index);
		});
	}
	$("#f_department1").validatebox("setValue",window.userInfo.orgName);
	$("#f_userName1").validatebox("setValue",window.userInfo.name);
	$("#btnBackTo").linkbutton('disable');
	$.getJSON("./runas", null, function(response){
		if(response==null || response.error!=null){
			$.messager.show({
				title : '警告',
				msg : response.error
			});
		} else {
			$("#t_current").text(window.userInfo.userId + "/" + window.userInfo.name);
			if(response.isRunas){
				$("#t_last").text(response.previousUserId + "/" + response.previousUsername);
				$("#btnBackTo").linkbutton('enable');
				$("#tabPanelRunAs").remove();
			} else {
				$("#t_last").text("");
				$("#btnBackTo").linkbutton('disable');
				renderFromTable(response.fromUserIds);
				renderToTable(response.allUsers, response.toUserIds);
			}
		}
	});

	$("#runAsWindow").window("open");
}

function showChangeThemeDialog(){
	
	$.easyui.showDialog({
        title: "主题切换",
        width: 300, height: 200, topMost: false,
        enableApplyButton: false,
        href: "./sys/changeThemeDialog.jsp",
        onSave: setUserTheme,
        onLoad: function () {
        	var currentTheme = $("#easyuiTheme").attr("href").split("/")[3];
        	$("#userTheme").combobox("setValue", currentTheme);
        	$('#t_themeDialog').window("open");
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
			$.messager.show({
				title : '提示',
				msg : "用户主题设置成功"
			});

			$('#t_themeDialog').window("close");
			window.location.reload();
		}
	});
}


//-------------------------------------------------------------------
/*


//gird 列头右键菜单 by chen ze
$.showColumnMenu=function(e,field){
	var gridId=this.id;
	e.preventDefault();
	if (!_$cmenu){
		_$cmenu=$('<div style="width:100px"/>').appendTo('body');
		_$cmenu.menu({
			onClick: function(item){
				if (item.iconCls == 'icon-ok'){
					$('#'+gridId).datagrid('hideColumn', item.name);
					_$cmenu.menu('setIcon', {
						target: item.target,
						iconCls: 'icon-empty'
					});
				} else {
					$('#'+gridId).datagrid('showColumn', item.name);
					_$cmenu.menu('setIcon', {
						target: item.target,
						iconCls: 'icon-ok'
					});
				}
			}
		});
		var fields = $('#'+gridId).datagrid('getColumnFields');
		for(var i=0; i<fields.length; i++){
			var field = fields[i];
			var col = $('#'+gridId).datagrid('getColumnOption', field);
			if(col.title===undefined) continue;
			_$cmenu.menu('appendItem', {
				text: col.title,
				name: field,
				iconCls: (col.hidden===undefined||col.hidden===false)?'icon-ok':'icon-empty'
			});
		}
	}
	_$cmenu.menu('show', {
		left:e.pageX,
		top:e.pageY
	});
}

// RunAs
function renderFromTable(fromUsers){
	$("#fromUserTable tr").remove();
	var table = $("#fromUserTable")
	$.each(fromUsers, function(index, value) {
		var userValue = value.split("/");
		var userId = userValue[0];
		var userName = userValue[1];
		var tr = "<tr><td>"+ userId +'</td><td>'+ userName +'</td><td><a href="javascript:void(0);" name="btnFromUser" class="easyui-linkbutton" plain="true" iconCls="icon-redo">切换</a></td></tr>';
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

function reloadCallback(resp){
	if(resp && resp.status == 1){
		location.reload();
	} else {
		$.alert({
			title : '错误',
			msg : resp.message
		});
	}
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

//授予/回收身份
function grantOrRevoke(toUserId, operation){
	var prompt = operation == "grant" ? "是否授权用户 '" + toUserId + "' 使用本人的身份?" : "是否收回用户 '" + toUserId + "' 使用本人身份的授权?";
	$.messager.confirm("确认", prompt, function(r){
		if(r) {
			$.getJSON("./runas/" + operation + "?toUserId=" + toUserId, null, function(resp) {
				if(resp && resp.status == 1){
					$.messager.show({
						title : '提示',
						msg : resp.message
					});
					refreshToTable(toUserId);
				} else {
					$.messager.show({
						title : '错误',
						msg : resp.message
					});
				}
			});
		}
	});
}

function showForm(src, taskId, messageId) {
	$.getJSON("./bpm/task/" + taskId + "/" + messageId, function(resp){
		if(resp.message == "Not found") {
			$.messager.alert("警告", "任务已经结束,删除本消息");
			$("#inboxGrid").datagrid("reload");
			getUserMessageCount();
		} else {
			var url = "./bpm/form/" + taskId;
			parent.window.addTabPage("999", "我的任务", url, 'icon-tip');
			$("#msgWindow").window("close");
		}
	});
}

function showSendMsgWindow(user) {
	var temp = user.split("/");
	var userId = temp[0];
	var userName = temp[1];
	$("#receiverId").val(userId);
	$("#receiver").validatebox("setValue", userName);
	$("#sendMsgWindow").window("open");
}

function sendMsg(){
	$.post("./message/", {
		receiverIds: $("#receiverId").val(), 
		title: $("#sendMsg").validatebox("getValue") 
	}, function(response){
		$("#sendMsgWindow").window("close");
	}, 'json');
}

function selectReceiver(e) {
	$('#receiverSelectDialog').dialog('open');
	
	$("#receiverGrid").datagrid({url: "./common/query?mapper=userMapper&queryName=queryUser"});
	//$.getJSON("./sys/user/online/", function(resp){
	//	$("#onlineUserGrid").datagrid({data: resp.data});
	//});
}

function receiverGridDblClickHandler() {
    var row = $('#receiverGrid').datagrid('getSelected');
    if (row != undefined){
	    $("#receiverId").val(row.userId);
	    $("#receiver").validatebox("setValue", row.name);
	    $('#receiverSelectDialog').dialog('close');
    }
}
*/

$(function(){
	var hash = window.location.hash, start = new Date();
	$.util.namespace("window.mainpage");
	$.util.namespace("mainpage.nav");
    $.util.namespace("mainpage.favo");
    $.util.namespace("mainpage.mainTabs");
    
    var homePageTitle = "欢迎页", homePageHref = null, navMenuList = "#navMenu_list",
	    navMenuTree = "#navMenu_Tree", mainTabs = "#mainTabs", navTabs = "#navTabs", favoMenuTree = "#favoMenu_Tree",
	    mainLayout = "#mainLayout", northPanel = "#northPanel", themeSelector = "#themeSelector",
	    westLayout = "#westLayout", westCenterLayout = "#westCenterLayout", westFavoLayout = "#westFavoLayout",
	    westSouthPanel = "#westSouthPanel", homePanel = "#homePanel",
	    btnContact = "#btnContact", btnFullScreen = "#btnFullScreen", btnExit = "#btnExit";
   
	$(window).on('beforeunload', function(){
		window.jsonSocket.close();
	});

	if(initData.userInfo == null) {
		if(initData.redirect == null) {
			window.location = "login";
		} else {
			window.location = initData.redirect;
		}
	} else {
		window.parent.parent.userInfo = initData.userInfo;
		if(initData.isRunas){
			var pwdLink = $("#pswDiv").children().eq(1);
			pwdLink.remove();
		}

		var userInfo = initData.userInfo.name;
		if(initData.userInfo.orgName != undefined) {
			userInfo += " - " ;
			userInfo += initData.userInfo.orgName;
		}
		$('#userInfo').text("欢迎：" + userInfo);
		//加载菜单
		menus = initData.menu;
		initTopMenu(menus);
		initLeftMenu(menus[0], 0);

		//取得WEBDIS URL地址
		webdis=initData.webdis;
		//取得消息
		$.publish("USERINFO_INITIALIZED", null);
		
		if (window.WebSocket) {
			getUserMessageCount();
			window.jsonSocket =  window['MozWebSocket'] ? new MozWebSocket("ws://" + webdis + "/") : new WebSocket("ws://" + webdis + "/");
			jsonSocket.onopen = jsonSocketOnOpenHandler;
			jsonSocket.onmessage = jsonSocketOnMessageHandler;
			jsonSocket.onclose = function() {
				console.info( 'Socket is now closed.' );
			};
		} else {
			$("#msgNum").remove();
		}
	}

	$(document).keydown(documentKeyDownHandler);
	$('#tabsMenu').menu({onClick:tabsMenuOnClickHandler,width:110});
	
	//打开发送消息窗口
	$("#msgIcon").click(function(){
		$("#sendMsgWindow").window("open");
	});
	
	//消息数量点击事件
	$("#msgNum").click(function(){
		if(parseInt($("#msgNum").text())>0){
			clearInterval(window.intervalId);
			$(this).removeClass("red");
			showMessageListDialog();
		}
	});
	$('#btnShowChangePwdDialog').click(showChangePwdDialog);
	$('#btnShowRunAsDialog').click(showRunAsDialog);
	$('#btnShowThemeDialog').click(showChangeThemeDialog);
	

	window.mainpage.bindMainTabsButtonEvent = function () {
	    $("#mainTabs_jumpHome").click(function () { window.mainpage.mainTabs.jumpHome(); });
	    $("#mainTabs_toggleAll").click(function () {layoutFullScreen(); });
	};

	window.mainpage.mainTabs.jumpHome = function () {
		console.log("1111")
		$("#tabs").tabs("select", 0);
		console.log("2222")
	}
	
	window.mainpage.bindMainTabsButtonEvent();
	
	addTabPage("welcome", "欢迎页", "./welcome.jsp" , "");
	/*
	//下一个消息按钮点击事件
	$("#nextMsg").click(function(){
		if(parseInt($("#msgNum").text())>0 && !$(this).linkbutton('options').disabled){
			showMessageListDialog();
		}
	});

	//打开发送消息窗口
	$("#reply").click(function(){
		$("#sendMsgWindow").window("open");
	});

	//发送消息按钮点击事件
	$("#sendMsgBtn").click(sendMsg);
	$("#btnSelectReceiver").click(receiverGridDblClickHandler);

	

	

	window.mainpage.mainTabs.closeTab = function (which) { $(mainTabs).tabs("close", which); };

	window.mainpage.mainTabs.closeCurrentTab = function () {
	    var t = $(mainTabs), index = t.tabs("getSelectedIndex");
	    return t.tabs("closeClosable", index);
	};

	window.mainpage.mainTabs.closeOtherTabs = function (index) {
	    var t = $(mainTabs);
	    if (index == null || index == undefined) { index = t.tabs("getSelectedIndex"); }
	    return t.tabs("closeOtherClosable", index);
	};

	window.mainpage.mainTabs.closeLeftTabs = function (index) {
	    var t = $(mainTabs);
	    if (index == null || index == undefined) { index = t.tabs("getSelectedIndex"); }
	    return t.tabs("closeLeftClosable", index);
	};

	window.mainpage.mainTabs.closeRightTabs = function (index) {
	    var t = $(mainTabs);
	    if (index == null || index == undefined) { index = t.tabs("getSelectedIndex"); }
	    return t.tabs("closeRightClosable", index);
	};

	window.mainpage.mainTabs.closeAllTabs = function () {
	    return $(mainTabs).tabs("closeAllClosable");
	};
	//去掉主内容区上部边框
	$("#tabs div.tabs-panels").css("border-top", "0");
	$("div.layout-panel-west>div.panel-header").css("border-top", "0");
    */
});

$.parser.onComplete = function(){
	$("#Loading").fadeOut("normal",function(){
		$(this).remove();
	});
}


