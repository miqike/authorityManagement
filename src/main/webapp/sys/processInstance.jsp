<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="../css/content.css" rel="stylesheet" />
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="../js/qtip/jquery.qtip.min.css" />
	
	<script type="text/javascript" src="../js/jquery.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.browser.min.js"></script>
	<script type="text/javascript" src="../js/qtip/jquery.qtip.pack.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/husky.easyui.extend.js" ></script>

	<script type="text/javascript" src="../js/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>

	<script type="text/javascript" src="../js/formatter.js"></script>
	<script type="text/javascript" src="./processInstance.js" ></script>
	
	
	<style type="text/css">
		#panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
	</style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="">
	<div style="padding: 5px 10px 0px 10px">
			<p style="margin-top: 0px; margin-bottom: 5px;">
			关键字<input id="f_key" style="margin-left:5px;margin-right:8px" value=""/>
			<span>状态</span>
			<input id="f_piStatus" class="easyui-combobox" codeName="processInstanceStatus" data-options="panelHeight:80"/>
			<span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
			</p>
		</div>

		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
				method:'get',
				url:'../sys/processInstance',
			   toolbar:mainGridToolbar,
			   onLoadSuccess: loadSuccess,
			   height:450">

			<thead>
				<tr>
					<th data-options="field:'id',halign:'center',align:'center'" width="60" >ID</th>
					<th data-options="field:'processDefinitionId',halign:'center',align:'center'" width="150" >流程定义ID</th>
					<th data-options="field:'processDefinitionName',halign:'center',align:'center'" width="150" >流程名</th>
					<th data-options="field:'businessKey',halign:'center',align:'center'" width="280">业务主键</th>
					<th data-options="field:'startUserId',halign:'center',align:'center'" width="50">发起人</th>
					<th data-options="field:'startTime',halign:'center',align:'center'" width="120" formatter="formatDatetime2Min">发起时间</th>
					<th data-options="field:'suspended',halign:'center',align:'center'" width="50" formatter="formatSuspensionState">状态</th>
					
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="mainGridToolbar">
			<a href="#" id="btnSuspendOrActive" class="easyui-linkbutton" iconCls="icon-add" plain="true">挂起/恢复</a>
			<a href="#" id="btnViewDiagram" class="easyui-linkbutton" iconCls="icon2 r2_c19" plain="true" disabled="true">流程图</a>
			<a href="#" id="btnViewHistory" class="easyui-linkbutton" iconCls="icon2 r4_c19" plain="true" disabled="true">跟踪</a>
			<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
		</div>
    </div>

	<div id="processInstanceDiagramWindow" class="easyui-window" title="流程跟踪"
		 style="clear: both; width: 750px; height: 400px;"
		 data-options="iconCls:'icon-edit',modal:true,closed:true">
		<div style=" display: inline-block; position: relative;">
			<img id="processInstanceDiagram" />
			<div id='processImageBorder'></div>
		</div>
	</div>
	
	<div id="popWindow" class="easyui-window" title="流程历史"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 800px; height: 440px; padding: 5px;">
		<table id="grid2"
			   class="easyui-datagrid"
			   data-options="singleSelect:false,collapsible:true,method:'get'"
			   style="height: 386;"
			   pagination="false">
			<thead>
			<tr>
				<th data-options="field:'activityId',halign:'center',align:'center'" width="80" >ID</th>
				<th data-options="field:'activityName',halign:'center',align:'center'" width="80" >活动名</th>
				<%--<th data-options="field:'activityType',halign:'center',align:'center'" width="100" >活动类型</th>--%>
				<%--<th data-options="field:'executionId',halign:'center',align:'center'" width="80">任务ID</th>--%>
				<th data-options="field:'assignee',halign:'center',align:'center'" width="80">办理人</th>
				<th data-options="field:'assigneeName',halign:'center',align:'center'" width="80">办理人姓名</th>
				<th data-options="field:'startTime',halign:'center',align:'center'" width="120" formatter="formatDatetime2Min">开始时间</th>
				<th data-options="field:'endTime',halign:'center',align:'center'" width="120" formatter="formatDatetime2Min">结束时间</th>
				<th data-options="field:'durationInMillis',halign:'center',align:'center'" width="80" formatter="formatDuration">耗时</th>
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</body>
</html>