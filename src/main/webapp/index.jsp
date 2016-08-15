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
        
        function taskStatusStyler(val, row, index) {
        	if (val == 1) {
        		return "background-color:lightgray";
            } else if (val == 2) {
                return "background-color:orange";
            } else if (val == 3) {
                return "background-color:pink";
            } else if (val == 4) {
                return "background-color:red";
            } else if (val == 5) {
                return "background-color:green";
            }
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
        <div id="northPanel" data-options="region: 'north', border: false" style="height: 35px; overflow: hidden;">
            <div id="topbar" class="top-bar">
                <div class="top-bar-left">
                    <div id="logo"></div>
                    <ul id="topMenu"></ul>
                </div>
                <div class="top-bar-right" style="width:450px">
                     <div id="infobar" style="padding-top:8px;">
	                    <span id="userInfo" class="icon-hamburg-user" style="padding-left: 25px; background-position: left center;"></span>
	                </div>
                    <div id="themeSpan" style="float:right">
	                    <a id="btnShowMessageListDialog" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r10_c10'"/>消息</a>
	        			<span id="msgNum" class="notification-bubble" style="background-color: rgb(245, 108, 126); display: inline;"></span>
		       			<a id="btnSetting" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r17_c12'"/>设置</a>
	                    <a id="btnFullScreen" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'">全屏</a>
	                    <a id="btnExit" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-hamburg-sign-out'">退出</a>
	                    <a id="btnShowNorth" class="easyui-linkbutton" data-options="plain: true, iconCls: 'layout-button-down'" style="display: none;"></a>
                    </div>
                </div>
            </div>
        </div>

        <div data-options="region: 'west', title: '菜单导航栏', iconCls: 'icon-standard-map', split: true, minWidth: 250, maxWidth: 500" style="width: 250px; padding: 1px;">
             <div id="navTabs_tools" class="tabs-tool">
                <table>
                    <tr>
                        <td></td>
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
                        <div style="width:70%;height:400px;" class="easyui-panel" data-options="fit:true">
				            <div id="taskTabPanel" class="easyui-tabs" data-options="fit:true">
				                <div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" selected="true">
				                    <table id="todoTaskGrid" class="easyui-datagrid" style="width:auto;"
				                           data-options="fit:true,border:false,singleSelect:true,method:'get',
				                               pagination:true,pageSize:100, idField:'id'">
				                        <thead>
				                        <tr>
                                            <th data-options="field:'planType', halign:'center',align:'left'" codeName="planType" formatter="formatCodeList" width="70" align="center" >计划类型</th>
                                            <th data-options="field:'jhbh', halign:'center',align:'left'" width="70" align="center" >计划编号</th>
				                            <th data-options="field:'jhmc', halign:'center',align:'left'" width="100" align="center" >计划名称</th>
				                            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList" styler="taskStatusStyler">任务状态</th>
				                            <th data-options="field:'hcdwXydm', halign:'center',align:'center'" width="120" >统一社会信用代码</th>
				                            <th data-options="field:'hcdwName', halign:'center',align:'left'" width="200" >被检单位名称</th>
				                            <th data-options="field:'djjgmc', halign:'center',align:'left'" width="100" >登记机关</th>
				                            <th data-options="field:'hcjgmc', halign:'center',align:'left'" width="100" >检查机关</th>
				                            <th data-options="field:'zfryCode1', halign:'center',align:'center'" width="100" formatter="formatZfry">检查人员</th>
				                            <th data-options="field:'jhxdrq', halign:'center',align:'center'" width="70" formatter="formatDate">下达时间</th>
				                            <th data-options="field:'jhwcrq', halign:'center',align:'center'" width="70" formatter="formatDate">计划结束时间</th>
				                            <th data-options="field:'rlrq', halign:'center',align:'center'" width="70" formatter="formatDate">认领时间</th>
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
				            <div title="下载" collapsible="true" closable="true" style="padding:5px;">
				                <div class="t-list"><a href="./help/前端取数(V5.0).doc">&lt;检查告知书&gt;</a></div>
				                <div class="t-list"><a href="./help/手工帐取数操作流程.doc">&lt;实施方案&gt;</a></div>
				            </div>
				            <div title="导航" collapsible="true" closable="true" style="padding:5px;">
				                <img src="images/test.jpg" width="207" height="148" alt="新书架" hspace="10" align="left" usemap="#newbook" border="0">
									<map name="newbook">
										<area shape="rect" coords="56,69,78,139" href="javascript:openTabFromMap('5105', '51/5101a.jsp', '双随机计划核查');" alt="双随机计划核查" title="双随机计划核查">
										<area shape="rect" coords="82,70,103,136" href="javascript:openTabFromMap('4102', '41/4102.jsp', '采集数据导入及验证');"  alt="采集数据导入及验证" title="采集数据导入及验证">
										<area shape="rect" coords="106,68,128,136" href="javascript:xxxxxxx('4101', '41/4101.jsp', '企业抽查资料上报');" alt="企业抽查资料上报" title="企业抽查资料上报">
									</map>
				            </div>
				        </div>
                    </div>
                </div>
            </div>
        </div>
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
<script>

function openTabFromMap(menuId, url, title) {
	$('#wnav li').removeClass("selected");
	window.mainpage.mainTabs.addModule({
		id:menuId, 
		title:title, 
		href:url
	});
}

</script>