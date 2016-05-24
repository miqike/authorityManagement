<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<link rel="stylesheet" type="text/css" href="./css/themes/${theme}/easyui.css">
	<link rel="stylesheet" type="text/css" href="./css/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="./css/portal.css">
	<link rel="stylesheet" type="text/css" href="./js/qtip/jquery.qtip.min.css" />
	<style type="text/css">
		.title{
			font-size:14px;
			padding:5px;
			overflow:hidden;
			border-bottom:1px solid #ccc;
			height:26px;
		}
		.t-list{
			padding:5px;
		}
		#taskTabPanel .tabs-header {
			border-top:0px;
			border-left:0px;
		}
		#taskTabPanel .tabs-panels {
			border-left:0px;
			border-bottom:0px;
		}
	</style>
</head>
<body class="easyui-layout">
	<div region="north" class="title" border="false" >
		<div style="margin-top:5px;margin-left:10px;"></div>
	</div>
	<div region="center" border="false">
		<div id="pp" style="position:relative">
			<div style="width:65%;">
			<%--
				<div id="taskTabPanel" class="easyui-tabs" data-options="onSelect:taskTabSelectHandler">
					<div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" style="height:420px;" selected="true">
						<table id="todoTaskGrid" class="easyui-datagrid" style="width:650px;height:auto"
							   data-options="fit:true,border:false,singleSelect:true,method:'get',
	           					pagination:true,pageSize:20, onLoadSuccess: loadSuccess,idField:'id'">
							<thead>
							<tr>
								<th data-options="field:'priority', halign:'center',align:'right'" width="30" formatter="formatPriority"></th>
								<!-- <th data-options="field:'id', halign:'center',align:'right'" width="60" >任务编号</th> -->
								<th data-options="field:'processInstanceId', halign:'center',align:'left'" width="60" align="center" >流程编号</th>
								<th data-options="field:'processDefinition', halign:'center',align:'left'" width="100" formatter="formatProcessDefinition">流程名</th>
								<th data-options="field:'name', halign:'center',align:'left'" width="100" formatter="formatTask">任务名称</th>
								<th data-options="field:'processInstanceStartTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">流程创建时间</th>
								<th data-options="field:'createTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">任务创建时间</th>
								<th data-options="field:'dueDate', halign:'center',align:'left'" width="120" align="right" formatter="formatDatetime2Min">到期时间</th>
								<th data-options="field:'startUserName', halign:'center',align:'center'" width="70" formatter="formatUser">发起人</th>
								<th data-options="field:'id', halign:'center',align:'left'" width="60" align="center" formatter="formatOperation"></th>
							</tr>
							</thead>
						</table>
					</div>
					<div id="involvedProcessInstanceGridDiv" title="相关流程" data-options="closable:false,collapsible:true" style="height:420px;" selected="false">
			        	<input type="radio" name="processStatus" value="1" checked>流转中</input>
			        	<input type="radio" name="processStatus" value="0" >结束</input>
						<table id="involvedProcessInstanceGrid" class="easyui-datagrid" style="width:650px;height:auto"
							   data-options="fit:true,border:false,singleSelect:true,method:'get',
	           					pagination:true,pageSize:20, onLoadSuccess: loadSuccess,idField:'id'">
							<thead>
							<tr>
								<!-- <th data-options="field:'priority', halign:'center',align:'right'" width="30" formatter="formatPriority"></th> -->
								<th data-options="field:'id', halign:'center',align:'left'" width="60" align="center" >流程编号</th>
								<th data-options="field:'processDefinition', halign:'center',align:'left'" width="100" formatter="formatProcessDefinition">流程名</th>
								<th data-options="field:'startUserName', halign:'center',align:'center'" width="70">发起人</th>
								<th data-options="field:'activityId', halign:'center',align:'left'" width="100" >活动任务</th>
								<th data-options="field:'processInstanceStartTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">流程创建时间</th>
								<th data-options="field:'endTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">流程完成时间</th>
								<th data-options="field:'ended', halign:'center',align:'center'" width="70" formatter="formatInvolvedProcessInstanceState">状态</th>
							</tr>
							</thead>
						</table>
					</div>
					<!-- 
					<div id="doneTaskGridDiv" title="已办任务" data-options="closable:false,collapsible:true" style="height:420px;" selected="false">
						<input type="radio" name="processStatus" value="all" checked style="margin-bottom: 8px;">全部</input>
			        	<input type="radio" name="processStatus" value="active" >流转</input>
			        	<input type="radio" name="processStatus" value="completed" >结束</input>
						<table id="doneTaskGrid" class="easyui-datagrid" style="width:650px;height:auto"
							   data-options="fit:true,border:false,singleSelect:true,method:'get',
	           					pagination:true,pageSize:20, onLoadSuccess: loadSuccess,idField:'id'">
							<thead>
							<tr>
								<th data-options="field:'priority', halign:'center',align:'right'" width="30" formatter="formatPriority"></th>
								<th data-options="field:'processInstanceId', halign:'center',align:'left'" width="60" align="center" >流程编号</th>
								<th data-options="field:'processDefinition', halign:'center',align:'left'" width="100" formatter="formatProcessDefinition">流程名</th>
								<th data-options="field:'name', halign:'center',align:'left'" width="100" >任务名称</th>
								<th data-options="field:'endTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">任务完成时间</th>
								<th data-options="field:'startUserName', halign:'center',align:'center'" width="70">发起人</th>
								<th data-options="field:'processInstanceStartTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">流程创建时间</th>
								<th data-options="field:'processInstanceEndTime', halign:'center',align:'left'" width="100" align="right" formatter="formatDatetime2Min">流程完成时间</th>
								<th data-options="field:'state', halign:'center',align:'center'" width="70" formatter="formatProcessInstanceState">状态</th>
							</tr>
							</thead>
						</table>
					</div>
					 -->
				</div>
			 --%>
			</div>
			<div style="width:20%;">
				<div title="帮助" collapsible="true" closable="true" style="height:430px;padding:5px;">
					<div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-layout.html">非税业务管理信息系统简介</a></div>
					<div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-panel.html">财政端操作手册</a></div>
					<div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-accordion.html">票管业务手册</a></div>
					<div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-tabs1.html">执收单位业务手册</a></div>
					<div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-tabs2.html">基本操作规则</a></div>
				</div>
			</div>
		</div>
	</div>
	<div id="processDiagramWindow" class="easyui-window" title="流程跟踪"
		 style="clear: both; width: 750px; height: 400px;"
		 data-options="iconCls:'icon-edit',modal:true,closed:true">
		<div style=" display: inline-block; position: relative;">
			<img id="processDiagram" />
			<div id='processImageBorder'></div>
		</div>
	</div>
</body>

</html>

<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.browser.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/jquery.portal.js"></script>
<script type="text/javascript" src="./js/husky.common.js"></script>
<script type="text/javascript" src="./js/qtip/jquery.qtip.pack.js"></script>
<script type="text/javascript" src="./js/welcome.js"></script>
