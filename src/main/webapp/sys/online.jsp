<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>在线用户列表</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.extend.depreciated.js"></script>

    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="./online.js"></script>
    <style>
        body {
            margin:0;
            padding:5px;
            font:13px/1.5 \5b8b\4f53, Arial, sans-serif;
        }

        div .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}

        div#tabPanel .datagrid-wrap{ border-top: 0px;}
    </style>
    
    <script>
	    if(top == self) {
	    	<% Subject currentUser = SecurityUtils.getSubject(); %>
	        var sessionId = '<%=currentUser.getSession().getId() %>';
	    } else {
	    	var sessionId = top.sessionId;
	    }
    </script>
    
</head>
<body>
<div id="panel" class="easyui-panel" title="" >
    <div style="margin-bottom:3px;margin-top:5px;">
        <span style="margin-left:8px;margin-right:0px;">用户名/姓名:</span>
        <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>

        <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
               iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
               iconCls="icon2 r3_c10">重置</a>
			</span>
    </div>

    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="singleSelect:false,collapsible:true,onClickRow:mainGridButtonHandler,onLoadSuccess:loadSuccessHandler,
				method:'get',
				url:'../common/query?mapper=userOnlineMapper&queryName=query'"
				url:'../sys/user/online/'"
           toolbar="#mainGridToolbar"
           style="height: 500px"
           pageSize="100"
           pagination="true">
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="230">会话ID</th>
            <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="65">用户名</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="65">姓名</th>
            <th data-options="field:'host',halign:'center',align:'right'" sortable="true" width="100">IP</th>
            <th data-options="field:'userAgent',halign:'center',align:'center'" sortable="true" width="120">浏览器</th>
            <th data-options="field:'systemHost',halign:'center',align:'right'" sortable="true" width="130">服务节点</th>
            <th data-options="field:'startTimestamp',halign:'center',align:'left'" sortable="true" width="160" formatter="formatDatetime">起始时间</th>
            <th data-options="field:'lastAccessTime',halign:'center',align:'left'" sortable="true" width="160" formatter="formatDatetime">刷新时间</th>
            <th data-options="field:'timeout',halign:'center',align:'center'" sortable="true" width="50" formatter="formatDuration">超时</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userOnlineStatus" formatter="formatCodeList">状态</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnInvalidate" class="easyui-linkbutton" iconCls="icon2 r8_c3" plain="true" disabled="true">踢出</a>
    </div>
</div>

</body>
</html>