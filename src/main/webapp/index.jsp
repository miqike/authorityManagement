﻿<%@ page import="com.alibaba.fastjson.JSON" %>
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
    <!-- <link href="./css/jquery-easyui-theme/default/easyui.css" rel="stylesheet" type="text/css" /> -->
    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="./css/jquery-easyui-theme/${theme}/easyui.css">
    <link href="./js/jeasyui-extensions-release/icons/icon-all.css" rel="stylesheet" type="text/css" />
    <script src="./js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="./js/jquery-easyui-1.3.6/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="./js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script src="./js/jeasyui-extensions-release/jquery.jdirk.min.js" type="text/javascript"></script>
    <link href="./js/jeasyui-extensions-release/jeasyui.extensions.min.css" rel="stylesheet" type="text/css" />
    <script src="./js/jeasyui-extensions-release/jeasyui.extensions.all.min.js" type="text/javascript"></script>
    <script src="./js/formatter.js" type="text/javascript"></script>
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
    	var ctx = ".";
    	
        eval("var initData = " + '<%= initData %>');
        var sessionId = '<%=currentUser.getSession().getId() %>';
        
        function formatZfry(val, row) {
        	var result = row.zfryName1 == null? "": row.zfryName1;
        	if(row.zfryName2 != null) {
        		result =  result + "/" + row.zfryName2;
        	}
            return result;
        }
    </script>
    
    <!--导入首页启动时需要的相应资源文件(首页相应功能的 js 库、css样式以及渲染首页界面的 js 文件)-->
    <script src="./common/index.js" type="text/javascript"></script>
    <link href="./common/index.css" rel="stylesheet" />
    <link href="./css/jquery-easyui-theme/icon.css" rel="stylesheet" type="text/css" />
    <link href="./css/bubble.css" rel="stylesheet" type="text/css" >
    <style>
    	.validatebox-text {
	        border-width: 1px;
	        border-style: solid;
	        line-height: 17px;
	        padding-top: 1px;
	        padding-left: 3px;
	        padding-bottom: 2px;
	        padding-right: 3px;
	        background-attachment: scroll;
	        background-size: auto;
	        background-origin: padding-box;
	        background-clip: border-box;
	    }
	
	    .validatebox-invalid {
	        border-color: ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: fff3f3;
	        background-image: url("");
	    }
    </style>
    <script src="./js/husky/husky.common.js" type="text/javascript" ></script>
    <script src="./js/husky/husky.message.js" type="text/javascript" ></script>
    <script src="./js/husky/husky.easyui.codeList.js" type="text/javascript" ></script>
    <script src="./js/husky/husky.index.js" type="text/javascript"></script>
    <script src="./common/index-startup.js"></script>
</head>
<body>

    <div id="maskContainer">
        <div class="datagrid-mask" style="display: block;"></div>
        <div class="datagrid-mask-msg" style="display: block; left: 50%; margin-left: -52.5px;">正在加载...</div>
    </div>

    <div id="mainLayout" class="easyui-layout hidden" data-options="fit: true">
        <!-- <div id="northPanel" data-options="region: 'north', border: false" style="height: 64px; overflow: hidden;"> -->
        <div id="northPanel" data-options="region: 'north', border: false" style="height: 35px; overflow: hidden;">
            <div id="topbar" class="top-bar">
                <div class="top-bar-left">
                    <div id="logo"></div>
                    <ul id="topMenu"></ul>
                </div>
                <div class="top-bar-right">
                    <!-- <div id="timerSpan" style="float:right"></div> 
                    <div id="themeSpan" style="float:right">
                        <span style="display:inline-block;height:20px;padding-top:2px;" >更换皮肤风格：</span>
                        <select id="themeSelector"></select>
                        <a id="btnHideNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-up'"></a>
                    </div>
                    -->
                    <div id="themeSpan" style="float:right">
                        <!-- 
                        <input id="topSearchbox" name="topSearchbox" class="easyui-searchbox" data-options="width: 350, height: 26, prompt: '请输入您要查找的内容关键词'" />
	                     -->
	                    <a id="btnShowMessageListDialog" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r10_c10'"/>消息</a>
	        			<span id="msgNum" class="notification-bubble" style="background-color: rgb(245, 108, 126); display: inline;"></span>
		       			<a id="btnSetting" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r17_c12'"/>设置</a>
	                    <a id="btnFullScreen" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'">全屏切换</a>
	                    <a id="btnExit" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-sign-out'">退出系统</a>
	                    <a id="btnShowNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-down'" style="display: none;"></a>
                    </div>
                </div>
            </div>
            <!-- 
            <div id="toolbar" class="panel-header panel-header-noborder top-toolbar">
                <div id="infobar">
                    <span id="userInfo" class="icon-hamburg-user" style="padding-left: 25px; background-position: left center;"></span>
                </div>
                <div id="buttonbar">
                    <a id="btnShowMessageListDialog" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r10_c10'"/>消息</a>
        			<span id="msgNum" class="notification-bubble" style="background-color: rgb(245, 108, 126); display: inline;"></span>
	       			<a id="btnSetting" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r17_c12'"/>设置</a>
                    <a id="btnFullScreen" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'">全屏切换</a>
                    <a id="btnExit" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-sign-out'">退出系统</a>
                    <a id="btnShowNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-down'" style="display: none;"></a>
                </div>
            </div> 
                 -->
        </div>

        <div data-options="region: 'west', title: '菜单导航栏', iconCls: 'icon-standard-map', split: true, minWidth: 250, maxWidth: 500" style="width: 250px; padding: 1px;">
             <div id="navTabs_tools" class="tabs-tool">
                <table>
                    <tr>
                        <td><!-- <a id="navMenu_refresh" class="easyui-linkbutton easyui-tooltip" title="刷新该选项卡及其导航菜单" data-options="plain: true, iconCls: 'icon-hamburg-refresh'"></a> --></td>
                    </tr>
                </table>
            </div>
            <div id="wnav" class="easyui-accordion" data-options="fit:true,border:false,animate:true"> </div>
        </div>

        <div data-options="region: 'center'" style="padding: 1px;">
            <div id="mainTabs_tools" class="tabs-tool">
                <table>
                    <tr>
                        <td><a id="mainTabs_jumpHome" class="easyui-linkbutton easyui-tooltip" title="跳转至主页选项卡" data-options="plain: true, iconCls: 'icon-hamburg-home'"></a></td>
                        <td><div class="datagrid-btn-separator"></div></td>
                        <td><a id="mainTabs_toggleAll" class="easyui-linkbutton easyui-tooltip" title="展开/折叠面板使选项卡最大化" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'"></a></td>
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
            <div id="mainTabs" class="easyui-tabs" data-options="fit: true, border: true, showOption: true, enableNewTabMenu: true, tools: '#mainTabs_tools', enableJumpTabMenu: true, onSelect:tabsOnSelectHandler">
                <div id="homePanel" data-options="title: '主页', iconCls: 'icon-hamburg-home'">
                    <div id="portal" class="easyui-portal" data-options="fit: true, border: false">
                        <div style="width:70%;height:520px;" class="easyui-panel" data-options="fit:true">
				            <div id="taskTabPanel" class="easyui-tabs" data-options="fit:true">
				                <div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" selected="true">
				                    <table id="todoTaskGrid" class="easyui-datagrid" style="width:auto;"
				                           data-options="fit:true,border:false,singleSelect:true,method:'get',
				                               pagination:true,pageSize:20, idField:'id'">
				                        <thead>
				                        <tr>
				                            <th data-options="field:'jhmc', halign:'center',align:'left'" width="100" align="center" >计划名称</th>
				                            <th data-options="field:'hcdwXydm', halign:'center',align:'center'" width="120" >统一社会信用代码</th>
				                            <th data-options="field:'hcdwName', halign:'center',align:'left'" width="200" >被检单位名称</th>
				                            <th data-options="field:'djjgmc', halign:'center',align:'left'" width="100" >登记机关</th>
				                            <th data-options="field:'hcjgmc', halign:'center',align:'left'" width="100" >检查机关</th>
				                            <!-- <th data-options="field:'qymc', halign:'center',align:'left'" width="100" >区域名称</th> -->
				                            <th data-options="field:'zfryCode1', halign:'center',align:'center'" width="100" formatter="formatZfry">检查人员</th>
				                            <th data-options="field:'jhxdrq', halign:'center',align:'center'" width="100" formatter="formatDate">下达时间</th>
				                            <th data-options="field:'jhwcrq', halign:'center',align:'center'" width="100" formatter="formatDate">计划结束时间</th>
				                            <th data-options="field:'rlrq', halign:'center',align:'center'" width="120" formatter="formatDate">认领时间</th>
				                            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList">任务状态</th>
				                            <!-- 
				                            <th data-options="field:'hcjg', halign:'center',align:'left'" width="60" align="center" codeName="hcjg" formatter="formatCodeList">检查结果</th> --> 
				                        </tr>
				                        </thead>
				                    </table>
				                </div>
				            </div>
				        </div>
				        <div style="width:30%;height:auto"  data-options="fit:true">
				            <div title="帮助" collapsible="true" closable="true" style="padding:5px;">
				                <div class="t-list"><a href="./help/前端取数(V5.0).doc">数据加载说明</a></div>
				                <div class="t-list"><a href="./help/手工帐取数操作流程.doc">手工帐取数操作流程</a></div>
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
    
    <div style="display:none">
	    <div id="settingToolbar" >
	        <a id="btnShowChangePwdDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r12_c20',plain:true" onClick="javascript:showChangePwdDialog();">修改密码</a>
	        <a id="btnShowRunAsDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r11_c19',plain:true" onClick="javascript:showRunAsDialog();">切换身份</a>
	        <a id="btnShowThemeDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r16_c15',plain:true" onClick="javascript:showThemeDialog();">切换主题</a>
	    </div>
	</div>
</body>
</html>
