<%@ page import="com.alibaba.fastjson.JSON" %>
<%@ page import="com.google.common.collect.Maps" %>
<%@ page import="net.sf.husky.menu.service.MenuRepository" %>
<%@ page import="net.sf.husky.message.service.MessageService" %>
<%@ page import="net.sf.husky.utils.SpringUtils" %>
<%@ page import="net.sf.husky.utils.WebUtils" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--[if lt IE 7]>
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/><![endif]-->
    <meta http-equiv="X-UA-Compatible" content="IE=100" />
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>企业公示信息智能检查系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="./js/jquery-easyui-theme/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="./js/jquery-easyui-theme/icon.css" rel="stylesheet" type="text/css" />
    <link href="./js/jeasyui-extensions-release/icons/icon-all.css" rel="stylesheet" type="text/css" />
    <script src="./js/jquery/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="./js/jquery-easyui-1.3.6/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="./js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="./js/jeasyui-extensions-release/jquery.jdirk.min.js" type="text/javascript"></script>
    <link href="./js/jeasyui-extensions-release/jeasyui.extensions.min.css" rel="stylesheet" type="text/css" />
    <script src="./js/jeasyui-extensions-release/jeasyui.extensions.all.min.js" type="text/javascript"></script>
    <!--<script src="release/jeasyui.icons.all.min.js"></script>-->


   <%
        MenuRepository menuRepository = SpringUtils.getBean(MenuRepository.class);
        MessageService messageService = SpringUtils.getBean(MessageService.class);
        Map<String, Object> result = Maps.newHashMap();
        Subject currentUser = SecurityUtils.getSubject();
        if(!currentUser.isAuthenticated() || null == currentUser.getPrincipal()) {
            result.put("userInfo", null);
        } else {
            result.put("isRunas", currentUser.isRunAs());
            result.put("userInfo", WebUtils.getCurrentUser());
            result.put("menu", menuRepository.getMenu());
            result.put("webdis", messageService.getWebdisURL());
        }
        String initData = JSON.toJSONString(result);
    %>
    <script>
        eval("var initData = " + '<%= initData %>');
        var sessionId = '<%=currentUser.getSession().getId() %>';
    </script>
    
    <!--导入首页启动时需要的相应资源文件(首页相应功能的 js 库、css样式以及渲染首页界面的 js 文件)-->
    <script src="./common/index.js" type="text/javascript"></script>
    <link href="./common/index.css" rel="stylesheet" />
    <script src="./common/index-startup.js"></script>
    <style>
    
    div#logo {
	    background: rgba(0, 0, 0, 0) url("./images/logo.jpg") no-repeat scroll 0 0 / 30px 30px;
	    float: left;
	    height: 30px;
	    margin-left: 15px;
	    margin-top:3px;
	    width: 40px;
    }
    
    #topMenu {
	    float: left;
	    margin: 0 0 0 5px;
	    padding: 0;
	}
	#topMenu li {
	    background-color: #6caef5;
	    color: #000;
	    cursor: pointer;
	    float: left;
	    font-size: 14px;
	    line-height: 35px;
	    list-style-type: none;
	    padding: 0 10px;
	}
	#topMenu li:hover {
	    background-color: #7a9bbf;
	    color: #fff;
	}
	#topMenu li.active {
	    background-color: orange;
	    color: black;
	}
    </style>
    <script type="text/javascript">
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
    
    $(function(){
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
			//initLeftMenu(menus[0], 0);
		}
    });
    </script>
</head>
<body>

    <div id="maskContainer">
        <div class="datagrid-mask" style="display: block;"></div>
        <div class="datagrid-mask-msg" style="display: block; left: 50%; margin-left: -52.5px;">正在加载...</div>
    </div>

    <div id="mainLayout" class="easyui-layout hidden" data-options="fit: true">
        <div id="northPanel" data-options="region: 'north', border: false" style="height: 80px; overflow: hidden;">
        
        	
            <div id="topbar" class="top-bar">
                <div class="top-bar-left">
                    <!-- <h1 style="margin-left: 10px; margin-top: 10px;">jQuery & jEasyUI Extensions</h1> -->
                    <div id="logo"></div>
                    <ul id="topMenu"></ul>
                </div>
                <div class="top-bar-right">
                    <!-- <div id="timerSpan" style="float:right"></div> -->
                    <div id="themeSpan" style="float:right">
                        <span>更换皮肤风格：</span>
                        <select id="themeSelector"></select>
                        <a id="btnHideNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-up'"></a>
                    </div>
                </div>
            </div>
            <div id="toolbar" class="panel-header panel-header-noborder top-toolbar">
                <div id="infobar">
                    <span class="icon-hamburg-user" style="padding-left: 25px; background-position: left center;">
                        此处可以放置登录用户账户信息
                    </span>
                </div>
                <div id="searchbar">
                    <input id="topSearchbox" name="topSearchbox" class="easyui-searchbox" data-options="width: 350, height: 26, prompt: '请输入您要查找的内容关键词', menu: '#topSearchboxMenu'" />
                    <div id="topSearchboxMenu" style="width: 85px;">
                        <div data-options="name:'0', iconCls: 'icon-hamburg-zoom'">查询类型</div>
                        <div data-options="name:'1'">测试类型1</div>
                        <div data-options="name:'2'">测试类型2</div>
                        <div data-options="name:'3'">测试类型3</div>
                        <div data-options="name:'4'">测试类型4</div>
                    </div>
                </div>
                <div id="buttonbar">
                    <a id="btnContact" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-contact', tooltip: '前往作者关于该插件集合的博客专文；可以进行问题反馈提交或留言操作。'">博客留言</a>
                    <a id="btn2" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-bug'">按钮2</a>
                    <a id="btn3" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-archives'">按钮3</a>
                    <a id="btnFullScreen" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'">全屏切换</a>
                    <a id="btnExit" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-sign-out'">退出系统</a>
                    <a id="btnShowNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-down'" style="display: none;"></a>
                </div>
            </div> 
            <!-- 
            -->
        </div>

        <div data-options="region: 'west', title: '菜单导航栏', iconCls: 'icon-standard-map', split: true, minWidth: 250, maxWidth: 500" style="width: 250px; padding: 1px;">
            <div id="navTabs_tools" class="tabs-tool">
                <table>
                    <tr>
                        <td><a id="navMenu_refresh" class="easyui-linkbutton easyui-tooltip" title="刷新该选项卡及其导航菜单" data-options="plain: true, iconCls: 'icon-hamburg-refresh'"></a></td>
                    </tr>
                </table>
            </div>
            <div id="navTabs" class="easyui-tabs" data-options="fit: true, border: true, tools: '#navTabs_tools'">
                <div data-options="title: '导航菜单', iconCls: 'icon-standard-application-view-tile', refreshable: false, selected: true">
                    <div id="westLayout" class="easyui-layout" data-options="fit: true">
                        <div data-options="region: 'center', border: false" style="border-bottom-width: 1px;">
                            <div id="westCenterLayout" class="easyui-layout" data-options="fit: true">
                                <div data-options="region: 'north', split: false, border: false" style="height: 33px;">
                                    <div class="easyui-toolbar">
                                        <a id="navMenu_expand" class="easyui-splitbutton" data-options="iconCls: 'icon-metro-expand2', menu: '#navMenu_toggleMenu'">展开</a>
                                        <a id="navMenu_Favo" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-feed-add'">收藏</a>
                                        <a id="navMenu_Rename" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-pencil'">重命名</a>
                                        <div id="navMenu_toggleMenu" class="easyui-menu">
                                            <div id="navMenu_collapse" data-options="iconCls: 'icon-metro-contract2'">折叠当前</div>
                                            <div class="menu-sep"></div>
                                            <div id="navMenu_collapseCurrentAll" data-options="iconCls: 'icon-metro-expand'">展开当前所有</div>
                                            <div id="navMenu_expandCurrentAll" data-options="iconCls: 'icon-metro-contract'">折叠当前所有</div>
                                            <div class="menu-sep"></div>
                                            <div id="navMenu_collapseAll" data-options="iconCls: 'icon-standard-arrow-out'">展开所有</div>
                                            <div id="navMenu_expandAll" data-options="iconCls: 'icon-standard-arrow-in'">折叠所有</div>
                                        </div>
                                    </div>
                                </div>
                                <div data-options="region: 'center', border: false">
                                    <ul id="navMenu_Tree" style="padding-top: 2px; padding-bottom: 2px;"></ul>
                                </div>
                            </div>
                        </div>
                        <div id="westSouthPanel" data-options="region: 'south', border: false, split: true, minHeight: 32, maxHeight: 275" style="height: 275px; border-top-width: 1px;">
                            <ul id="navMenu_list"></ul>
                        </div>
                    </div>
                </div>
                <div data-options="title: '个人收藏', iconCls: 'icon-hamburg-star', refreshable: false">
                    <div id="westFavoLayout" class="easyui-layout" data-options="fit: true">
                        <div data-options="region: 'north', split: false, border: false" style="height: 33px;">
                            <div class="easyui-toolbar">
                                <a id="favoMenu_expand" class="easyui-splitbutton" data-options="iconCls: 'icon-metro-expand2', menu: '#favoMenu_toggleMenu'">展开</a>
                                <a id="favoMenu_Favo" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-feed-delete'">取消收藏</a>
                                <a id="favoMenu_Rename" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-pencil'">重命名</a>
                                <div id="favoMenu_toggleMenu" class="easyui-menu">
                                    <div id="favoMenu_collapse" data-options="iconCls: 'icon-metro-contract2'">折叠当前</div>
                                    <div class="menu-sep"></div>
                                    <div id="favoMenu_collapseCurrentAll" data-options="iconCls: 'icon-metro-expand'">展开当前所有</div>
                                    <div id="favoMenu_expandCurrentAll" data-options="iconCls: 'icon-metro-contract'">折叠当前所有</div>
                                    <div class="menu-sep"></div>
                                    <div id="favoMenu_collapseAll" data-options="iconCls: 'icon-standard-arrow-out'">展开所有</div>
                                    <div id="favoMenu_expandAll" data-options="iconCls: 'icon-standard-arrow-in'">折叠所有</div>
                                </div>
                            </div>
                        </div>
                        <div data-options="region: 'center', border: false">
                            <ul id="favoMenu_Tree" style="padding-top: 2px; padding-bottom: 2px;"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region: 'center'" style="padding: 1px;">
            <div id="mainTabs_tools" class="tabs-tool">
                <table>
                    <tr>
                        <td><a id="mainTabs_jumpHome" class="easyui-linkbutton easyui-tooltip" title="跳转至主页选项卡" data-options="plain: true, iconCls: 'icon-hamburg-home'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_toggleAll" class="easyui-linkbutton easyui-tooltip" title="展开/折叠面板使选项卡最大化" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_jumpTab" class="easyui-linkbutton easyui-tooltip" title="在新页面中打开该选项卡" data-options="plain: true, iconCls: 'icon-standard-shape-move-forwards'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_closeTab" class="easyui-linkbutton easyui-tooltip" title="关闭当前选中的选项卡" data-options="plain: true, iconCls: 'icon-standard-application-form-delete'"></a></td>
                        <td><a id="mainTabs_closeOther" class="easyui-linkbutton easyui-tooltip" title="关闭除当前选中外的其他所有选项卡" data-options="plain: true, iconCls: 'icon-standard-cancel'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_closeLeft" class="easyui-linkbutton easyui-tooltip" title="关闭左侧所有选项卡" data-options="plain: true, iconCls: 'icon-standard-tab-close-left'"></a></td>
                        <td><a id="mainTabs_closeRight" class="easyui-linkbutton easyui-tooltip" title="关闭右侧所有选项卡" data-options="plain: true, iconCls: 'icon-standard-tab-close-right'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_closeAll" class="easyui-linkbutton easyui-tooltip" title="关闭所有选项卡" data-options="plain: true, iconCls: 'icon-standard-cross'"></a></td>
                    </tr>
                </table>
            </div>
            <div id="mainTabs" class="easyui-tabs" data-options="fit: true, border: true, showOption: true, enableNewTabMenu: true, tools: '#mainTabs_tools', enableJumpTabMenu: true, onSelect: function (title, index) { window.mainpage.mainTabs.updateHash(index); }">
                <div id="homePanel" data-options="title: '主页', iconCls: 'icon-hamburg-home'">
                    <div class="easyui-layout" data-options="fit: true">
                        <div data-options="region: 'north', split: false, border: false" style="height: 33px;">
                            <div class="easyui-toolbar">
                                <a id="A1" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-add'">添加一列</a>
                                <a id="A2" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-delete'">删除一列</a>
                                <span>-</span>
                                <a id="A3" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-for-job'">测试操作01</a>
                                <span>-</span>
                                <a id="A4" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-config'">测试操作02</a>
                            </div>
                        </div>
                        <div data-options="region: 'center', border: false" style="overflow: hidden;">
                            <div id="portal" class="easyui-portal" data-options="fit: true, border: false">
                                <div style="width: 33%;">
                                    <div data-options="title: '项目信息', height: 260, collapsible: true, closable: true">
                                        <ul class="portlet-list">
                                        </ul>
                                    </div>
                                    <div data-options="title: '功能简介', height: 370, collapsible: true, closable: true">
                                    </div>
                                </div>
                                <div style="width: 33%;">
                                    <div data-options="title: '关于本项目', height: 300, collapsible: true, closable: true" style="padding: 10px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!-- 
        <div data-options="region: 'east', title: '日历', iconCls: 'icon-standard-date', split: false, minWidth: 200, maxWidth: 500" style="width: 220px;">
            <div id="eastLayout" class="easyui-layout" data-options="fit: true">
                <div data-options="region: 'north', split: false, border: false" style="height: 220px;">
                    <div class="easyui-calendar" data-options="fit: true, border: false"></div>
                </div>
                <div id="linkPanel" data-options="region: 'center', border: false, title: '友情链接', iconCls: 'icon-hamburg-link', tools: [{ iconCls: 'icon-hamburg-refresh', handler: function () { window.link.reload(); } }]">
                    <ul id="linkList" class="portlet-list link-list"></ul>
                </div>
            </div>
        </div>
        <div data-options="region: 'south', title: '关于...', iconCls: 'icon-standard-information', collapsed: true, border: false" style="height: 70px;">
            <div style="color: #4e5766; padding: 6px 0px 0px 0px; margin: 0px auto; text-align: center; font-size:12px; font-family:微软雅黑;">
                @2013-2014 Copyright: ChenJianwei Personal.&nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="http://www.chenjianwei.org" target="_blank" style="text-decoration: none;">关于 ChenJianwei</a><br />
                建议使用&nbsp;
                <a href="http://windows.microsoft.com/zh-CN/internet-explorer/products/ie/home" target="_blank" style="text-decoration: none;">IE(Version 9/10/11)</a>/
                <a href="https://www.google.com/intl/zh-CN/chrome/browser/" target="_blank" style="text-decoration: none;">Chrome</a>/
                <a href="http://firefox.com.cn/download/" target="_blank" style="text-decoration: none;">Firefox</a>
                &nbsp;系列浏览器。
                <script type="text/javascript">
                    var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
                    document.write(unescape("%3Cspan id='cnzz_stat_icon_5654850'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s9.cnzz.com/stat.php%3Fid%3D5654850%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));
                </script>
            </div>
        </div>
 -->


    </div>
</body>
</html>
