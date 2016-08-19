
(function ($) {

    var hash = window.location.hash, start = new Date();

    $(function () {
        window.onbeforeunload = function () { window.jsonSocket.close(); return "您确定要退出本程序？"; };

        window.mainpage.instMainMenus();
        //window.mainpage.instFavoMenus();
        //window.mainpage.instTimerSpan();
        window.mainpage.bindNavTabsButtonEvent();
        window.mainpage.bindToolbarButtonEvent();
        window.mainpage.bindMainTabsButtonEvent();

        var portal = $("#portal"), layout = $("#mainLayout"), navTabs = $("#navTabs"), themeCombo = $("#themeSelector");

        $.util.exec(function () {
            var theme = $.easyui.theme(), themeName = $.cookie("themeName");
            if (themeName && themeName != theme) { window.mainpage.setTheme(themeName, false); }

            layout.removeClass("hidden").layout("resize");

            $("#maskContainer").remove();

            var size = $.util.windowSize();
            //  判断当浏览器窗口宽度小于像素 1280 时，右侧 region-panel 自动收缩
            if (size.width < 1280) { layout.layout("collapse", "east"); }

            //window.mainpage.mainTabs.loadHash(hash);
            var stop = new Date();
            $.easyui.messager.show({ msg: "当前页面加载耗时(毫秒)：" + $.date.diff(start, "ms", stop), position: "bottomRight" });
        });

        $.util.namespace("mainpage.util");
        window.mainpage.util.getUrlResponse = function (url, callback) {
            $.get("./tests/HttpUtility.asmx/GetUrlResponse", { url: url }, function (data) {
                var text = $(data).text();
                if ($.isFunction(callback)) { callback.call(this, text); }
            });
        };
        
        if(initData.userInfo == null) {
    		if(initData.redirect == null) {
    			window.location = "login";
    		} else {
    			window.location = initData.redirect;
    		}
    	} else {
    		window.parent.parent.userInfo = initData.userInfo;
    		if(initData.isRunas){
    			//var pwdLink = $("#pswDiv").children().eq(1);
    			//pwdLink.remove();
    		}

    		var userInfo = initData.userInfo.name;
    		/*
    		if(initData.userInfo.orgName != undefined) {
    			userInfo += " - " ;
    			userInfo += initData.userInfo.orgName;
    		}
    		*/
    		$('#userInfo').text(userInfo);
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
    			$("#msgNum").click(function(){
    				if(parseInt($("#msgNum").text())>0){
    					clearInterval(window.intervalId);
    					//$(this).removeClass("red");
    					showMessageListDialog();
    				}
    			});
    		} else {
    			$("#msgNum").remove();
    		}
    	}
        
        $.easyui.tooltip.init($("#btnSetting"), { content: $("#settingToolbar").html(), trackMouse: false, hideDelay:2000 });

        
        var todoTaskGridOptions = $("#todoTaskGrid").datagrid("options");
        if(userInfo.ext1 == 1) {
        	todoTaskGridOptions.url = './common/query?mapper=hcrwMapper&queryName=queryForUser1';
        } else {
        	todoTaskGridOptions.url = './common/query?mapper=hcrwMapper&queryName=queryForUser2';
        } 
    });
    

})(jQuery);