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
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
    <![endif]-->
    <meta http-equiv="X-UA-Compatible" content="IE=100" />
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="./css/themes/${theme}/easyui.css">
    <link rel="stylesheet" type="text/css" href="./css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="./css/bubble.css">

    <title>工商公示核查平台</title>
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
    </script></head>
<body class="easyui-layout" onbeforeunload="closeBrowse();">
<div data-options="region:'north',border:false" class="north">
    <div class="logo" style="margin-top:2px;"></div>
    <ul id="topMenu"></ul>
    <div id="pswDiv" style="margin-top:6px;">
        <a><img src="./images/head_subject.png" style="margin-right:5px;"/><span id="userInfo"></span></a>

        <a id="msgIcon" style="cursor:pointer;"><img src="./images/icon5.gif" style="margin-right:5px;"/>消息</a>
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
<!-- <div data-options="region:'west',split:true,border:true,title:''" style="width:180px;"> -->
<div data-options="region:'west',split:true,border:true,title:'功能菜单'" style="width:200px;">
	<div id="navTabs" class="easyui-tabs" data-options="fit: true, border: false">
		<div data-options="title: '导航栏', iconCls: 'icon-standard-application-view-tile', refreshable: false, selected: true">
		    <div id="wnav" class="easyui-accordion" data-options="fit:true,border:false,animate:true"> </div>
		</div>
		<div data-options="title: '收藏栏', iconCls: 'icon-hamburg-star', refreshable: false">
		    <div id="westFavoLayout" class="easyui-layout" data-options="fit: true">
		        <div data-options="region: 'north', split: false, border: false" style="height: 33px;">
		            <div class="easyui-toolbar">
		                <a id="favoMenu_Favo" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-undo'">取消收藏</a>
		                <a id="favoMenu_Rename" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon-edit'">重命名</a>
		            </div>
		        </div>
		        <div data-options="region: 'center', border: false">
		            <ul id="favoMenu_Tree" style="padding-top: 2px; padding-bottom: 2px;"></ul>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
    
</div>
<div data-options="region:'center',border:false" style="margin-left: 0px">
	<div id="mainTabs_tools" class="tabs-tool">
        <table>
            <tr>
                <td><a id="mainTabs_jumpHome" class="easyui-linkbutton easyui-tooltip" title="跳转至欢迎页" data-options="plain: true, iconCls: 'icon-hamburg-home'"></a></td>
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
    <div class="easyui-tabs" id="tabs" data-options="fit:true,tabPosition:'top',tools:'#mainTabs_tools',onSelect:tabsOnSelectHandler,onContextMenu:tabOnContextMenu">
        <div title="欢迎页" data-options="cache:true" >
            <iframe id="welcome" scrolling="no" frameborder="0" style="width: 100%; height: 100%;"></iframe>
        </div>
    </div>
</div>

<div id="tabsMenu" style="width: 120px;">
    <div name="reload" data-options="iconCls:'icon-reload'">刷新选项卡</div>
    <div name="close" data-options="iconCls:'icon-standard-application-form-delete'">关闭选项卡</div>
    <div name="closeOther" data-options="iconCls:'icon-standard-cancel'">关闭其他选项卡</div>
    <div name="closeLeft" data-options="iconCls:'icon-standard-tab-close-left'">关闭左侧选项卡</div>
    <div name="closeRight" data-options="iconCls:'icon-standard-tab-close-right'">关闭右侧选项卡</div>
    <div name="closeAll" data-options="iconCls:'icon-standard-cross'">关闭所有选项卡</div>
</div>

<div style="display:none">
    <div id="toolbar" >
        <a id="btnShowChangePwdDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r12_c20',plain:true">修改密码</a>
        <a id="btnShowRunasDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r11_c19',plain:true">切换身份</a>
        <a id="btnShowThemeDialog" class="easyui-linkbutton easyui-tooltip" data-options="iconCls:'icon2 r16_c15',plain:true">切换主题</a>
    </div>
</div>

<div id="t_vaildateUser" class="easyui-dialog" data-options="title:'修改密码', width:300, height:160, closed:true, cache:false, modal:true, onClose:validateUserDialogCloseHandler">
    <form id="t_pwdForm">
        <div>
            <a class="easyui-linkbutton savebutton" id="btnChangePwd" iconCls="icon-save" plain="true">提交</a>
            <a class="easyui-linkbutton savebutton" iconCls="icon-undo" plain="true" onclick="$('#t_password').val('');$('#t_vaildateUser').dialog('close')">取消</a>
        </div>
        <table>
            <tr align="center">
                <td>用户名</td>
                <td> <input type="text" id="t_uname" value="" class="easyui-textbox" readonly="readonly" /></td>
            </tr>
            <tr align="center">
                <td>新密码</td>
                <td> <input type="password" id="t_password" class="easyui-textbox" data-options="required:true" maxlength="60"/></td>
            </tr>
            <tr align="center">
                <td>确认密码 </td>
                <td> <input type="password" id="t_password2" class="easyui-textbox" data-options="required:true" maxlength="60" validType="same['t_password']" invalidMessage="两次输入密码不匹配"/></td>
            </tr>
        </table>
    </form>
</div>

<div id="t_themeDialog" class="easyui-window" title="主题切换" style="padding-left:20px;padding-top:15px;"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true,closable:true,width:250,height:100,center:true">
    <div>
        <select id="userTheme" class="easyui-combobox" codeName="theme" style="width:150px;">
            <option value="default">默认</option>
            <option value="black">黑色</option>
            <option value="bootstrap">BootStrap</option>
            <option value="ui-cupertino">加州Cupertino</option>
            <option value="ui-dark-hive">黑色蜂巢</option>
            <option value="gray">灰色</option>
            <option value="metro">Metro默认</option>
            <option value="metro-blue">Metro蓝色</option>
            <option value="metro-gray">Metro灰色</option>
            <option value="metro-green">Metro绿色</option>
            <option value="metro-orange">Metro橙色</option>
            <option value="metro-red">Metro红色</option>
            <option value="ui-pepper-grinder">胡椒研磨机</option>
            <option value="ui-sunny">阳光</option>
        </select>
        <a class="easyui-linkbutton" id="btnSetUserTheme" iconCls="icon-save" plain="true">确认</a>
    </div>

</div>

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


<div id="msgWindow" class="easyui-window" title="站内消息" style="padding-left:2px;"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true,closable:true,width:750,height:450,center:true">
    
<!--     <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler"> -->
    <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" >
        <div title="收件箱" style="padding:5px;" selected="true">
        	<input type="radio" name="messageStatus" value="all" checked style="margin-bottom: 8px;">全部</input>
        	<input type="radio" name="messageStatus" value="readed" >已读</input>
        	<input type="radio" name="messageStatus" value="unread" >未读</input>
        	
            <table id="inboxGrid"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false,
                       method:'get',
                       pageSize:20,
           			   pagination:true,
                   	   toolbar: '#inboxGridToolbar'"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'sender'" halign="center" align="center" width="100" formatter="formatSender">发件人</th>
                    <th data-options="field:'title'" halign="center" align="center" width="200" formatter="formatMessageTitle">标题</th>
                    <th data-options="field:'operateTime'" halign="center" align="center" width="120" formatter="formatDatetime2Min">发件时间</th>
                    <th data-options="field:'state'" halign="center" align="center" width="40" formatter="formatMessageStatus">状态</th>
                </tr>
                </thead>
            </table>
            <div id="inboxGridToolbar">
		        <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true">回复</a>
		        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">已读</a>
		        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">收藏</a>
		        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">删除</a>
		    </div>
        </div>
        <div title="发件箱" style="width:700px;">
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   toolbar="#grid2Toolbar"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true,disabled:true"></th>
                    <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th>
                    <th data-options="field:'name'" halign="center" align="center" width="100">角色名</th>
                    <th data-options="field:'role'" halign="center" align="left" width="100">标识</th>
                    <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
                </tr>
                </thead>
            </table>
        </div>
        <div title="草稿箱" style="width:700px;padding:5px;">
        </div>
        <div title="收藏夹" style="width:700px;padding:5px;">
        </div>

        <div title="联系人">
            <a href="#" id="btnEditOrSaveUserRole" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
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
                <input class="easyui-textbox"
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
                <input type="text" id="sendMsg" value="" class="easyui-textbox" data-options="width:400"/>
            </td>
        </tr>
    </table>
</div>

<div id='Loading' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;
text-align:center;padding-top: 20%;"><h1><image src='./images/loading.gif'/><font color="#15428B">加载中···</font></h1></div>

</body>
</html>


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
    
<!-- 
onDblClickRow:personTreeGridDblClickHandler,
onLoadSuccess:btnPersonFilterHandler,
 -->
<script type="text/javascript" src="./js/hotkeys.min.js"></script>
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="./js/husky.common.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/index.js"></script>
<script type="text/javascript" src="./js/index-startup.js"></script>

