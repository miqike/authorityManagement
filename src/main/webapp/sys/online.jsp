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
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

	<script type="text/javascript" src="../js/husky/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
	<script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./online.js"></script>
    <style>

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
<body style="padding:5px;">
	<div id="panel" class="easyui-panel" title="">
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
				method:'get',offset: {height: -48, width:-20},height:400,
				url:'../common/query?mapper=userOnlineMapper&queryName=query'"
           toolbar="#mainGridToolbar"
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