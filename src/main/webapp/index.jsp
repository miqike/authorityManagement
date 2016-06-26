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

    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="./css/jquery-easyui-theme/${theme}/easyui.css">
    <link rel="stylesheet" type="text/css" href="./css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="./css/bubble.css">

    <title>企业公示信息智能检查系统</title>
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

<style type="text/css">
   .validatebox-text {
        border-width: 1px;
        border-style: solid;
        height: 22px;
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
</head>
<body class="easyui-layout" onbeforeunload="closeBrowse();">
<div data-options="region:'north',border:false" class="north">
    <div class="logo" style="margin-top:2px;width:32px;"></div>
    <ul id="topMenu"></ul>
    <div id="pswDiv" style="margin-top:6px;width:450px">
        <a><img src="./images/head_subject.png" style="margin-right:5px;"/><span id="userInfo"></span></a>
        <!-- <a id="msgIcon" style="cursor:pointer;"><img src="./images/icon5.gif" style="margin-right:5px;"/>消息</a> -->
        <span id="msgNum" class="notification-bubble" style="background-color: rgb(245, 108, 126); display: inline;"></span>
        <a class="easyui-tooltip" style="cursor:pointer;" data-options="
                    hideEvent: 'none',
                    content: function(){
                        return $('#toolbar');
                    },
                    onShow: function(){
                        var t = $(this);
                        t.tooltip('tip').focus().unbind().bind('blur',function(){
                            t.tooltip('hide');
                        });
                    }">
            <img src="./images/hammer_screwdriver.png" style="margin-right:5px;"/>设置</a>
            <a onclick='fullScreen(this)' style="cursor:pointer;"><img src="./css/themes/icons/arrow_out_longer.png" style="margin-right:5px;"/>
        	<span>全屏</span></a>
        <a onclick='logout()' style="cursor:pointer;"><img src="./images/head_out.png" style="margin-right:5px;"/>注销</a>
        <br/>
    </div>
</div>
<div data-options="region:'west',split:true,border:true,title:'功能菜单'" style="width:200px;">
	<div id="wnav" class="easyui-accordion" data-options="fit:true,border:false,animate:true"> </div>
</div>
<div data-options="region:'center',border:false" style="margin-left: 0px">
	<div id="mainTabs_tools" class="tabs-tool">
        <table>
            <tr>
                <td><a id="mainTabs_jumpHome" class="easyui-linkbutton easyui-tooltip" title="跳转至欢迎页" data-options="plain: true, iconCls: 'icon-hamburg-home'"></a></td>
                <td><div class="datagrid-btn-separator"></div></td>
                <td><a id="mainTabs_toggleAll" class="easyui-linkbutton easyui-tooltip" title="展开/折叠面板使选项卡最大化" data-options="plain: true, iconCls: 'icon-standard-arrow-inout'"></a></td>
            </tr>
        </table>
    </div>
    <div class="easyui-tabs" id="tabs" data-options="fit:true,tabPosition:'top',tools:'#mainTabs_tools',onSelect:tabsOnSelectHandler,onContextMenu:tabOnContextMenu"></div>
</div>

<div id="tabsMenu" style="width: 120px;">
    <div name="reload" data-options="iconCls:'icon-reload'">刷新选项卡</div>
    <div name="close" data-options="iconCls:'icon-standard-application-form-delete'">关闭选项卡</div>
    <div name="closeOther" data-options="iconCls:'icon-standard-cancel'">关闭其他选项卡</div>
    <div name="closeAll" data-options="iconCls:'icon-standard-cross'">关闭所有选项卡</div>
</div>

<div style="display:none">
    <div id="toolbar" >
        <a id="btnShowChangePwdDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r12_c20',plain:true">修改密码</a>
        <!-- <a id="btnShowRunAsDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r11_c19',plain:true">切换身份</a> -->
        <a id="btnShowThemeDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r16_c15',plain:true">切换主题</a>
    </div>
</div>

<%--
<div id="changePwdDialog"></div>
<div id="changeThemeDialog"></div>
<div id="runAsDialog"></div>
<div id="runAsWindow" class="easyui-window" title="身份切换" style="padding-left:2px;"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true,closable:true,width:600,height:400,center:true">
    <table>
        <tr>
            <td>当前身份:</td>
            <td>
                <span id="t_current" style="margin-right:10px;color:blue;font-weight:bold"></span>
            </td>
            <td>原身份:</td>
            <td>
                <span id="t_last" style="margin-right:10px;color:blueviolet;"></span>
            </td>
            <td>
                <a href="javascript:void(0);" id="btnBackTo" class="easyui-linkbutton" plain="true" iconCls="icon-undo" onclick="switchBack()">切换回原身份</a>
            </td>
        </tr>
    </table>
    <div id="tabPanelRunAs" class="easyui-tabs" style="width:582px;height:328px">
        <div title="切换">
            <table id="fromUserTable" style="padding-left:8px;"></table>
        </div>
        <div title="授权">
            <table id="toUserTable" style="padding-left:8px;"></table>
        </div>
    </div>
</div>



<!-- 
<div id="msgWindow" class="easyui-window" title="消息窗口" style="padding-left:2px;"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true,closable:true,width:600,height:400,center:true">
    <div>
        <a class="easyui-linkbutton" id="nextMsg" iconCls="icon2 r6_c17" plain="true">下一个</a>
        <a class="easyui-linkbutton" id="reply" iconCls="icon2 r10_c20" plain="true">回复</a>
    </div>
    <div style="padding-top:10px;"><span id="readTime"></span></div>
    <div style="padding-top:10px;"><span id="readMsg"></span></div>
</div>
 -->
<div id="sendMsgWindow" class="easyui-window" title="消息窗口" style="padding-left:2px;"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true,closable:true,width:600,height:150,center:true">
    <div>
        <a class="easyui-linkbutton" id="sendMsgBtn" iconCls="icon2 r3_c9" plain="true">发送</a>
    </div>
    <table>
        <tr>
            <td style="text-align: right">接收人</td>
            <td>
            	<input type="hidden" id="receiverId" />
                <input class="easyui-validatebox"
						id="receiver" style="width: 100px"
						data-options="required:true,editable:true,
                            icons:[{
                                iconCls:'icon-man',
                                handler: selectReceiver
                            }]" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right">消息内容</td>
            <td>
                <input type="text" id="sendMsg" value="" class="easyui-validatebox" data-options="width:400"/>
            </td>
        </tr>
    </table>
</div>
 --%>
<div id='Loading' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;
	text-align:center;padding-top: 20%;"><h1><image src='./images/loading.gif'/><font color="#15428B">加载中···</font></h1></div>

</body>
</html>

<%--
<div id="receiverSelectDialog" class="easyui-dialog" title="选择收信人"
	style="clear: both; width: 650px; height: 400px; padding: 5px;"
	data-options="iconCls:'icon-man',modal:true,closed:true">
	<table id="receiverGrid" class="easyui-datagrid"
		data-options="
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                onDblClickRow:receiverGridDblClickHandler,
				toolbar:'#receiverGridToolbar',
                method:'get'"
		style="height: 318px">
		<thead>
			<tr>
				<th data-options="field:'id',halign:'center',align:'left'" width="230">会话ID</th>
				<th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户名</th>
				<th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">姓名</th>
				<th data-options="field:'host',halign:'center',align:'center'" sortable="true" width="100">主机</th>
				<th data-options="field:'userAgent',halign:'center',align:'center'" width="130">浏览器</th>
			</tr>
		</thead>
	</table>
</div>

<div id="receiverGridToolbar">
    <a href="#" id="btnSelectReceiver" class="easyui-linkbutton" iconCls="icon-ok" plain="true" >OK</a>
</div>
 --%>
    
<script type="text/javascript" src="./js/hotkeys.min.js"></script>
<script type="text/javascript" src="./js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="./js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
<script type="text/javascript" src="./js/husky/husky.common.depreciated.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/index.js"></script>
