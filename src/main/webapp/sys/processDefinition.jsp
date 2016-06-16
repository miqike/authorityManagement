<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="../css/content.css" rel="stylesheet" />
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.extend.depreciated.js" ></script>

	<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>

	<script type="text/javascript" src="../js/formatter.js"></script>
	<script type="text/javascript" src="./processDefinition.js" ></script>
	<style type="text/css">
		#panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
	</style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="">
	<div style="padding: 5px 10px 0px 10px">
			<p style="margin-top: 0px; margin-bottom: 5px;">
			key:<input id="f_key" style="margin-left:5px;margin-right:8px" value=""/>
			<span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
			</p>
		</div>

		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="singleSelect:false,collapsible:true,onClickRow:mainGridButtonHandler,
				method:'get',pagination:true,pageSize:20,
				url:'../sys/processDefinition',
				toolbar:mainGridToolbar,
			   	onLoadSuccess: loadSuccess,
			   	height:450">
			<thead>
				<tr>
					<th data-options="field:'id',halign:'center',align:'center'" width="220" >流程定义ID</th>
					<th data-options="field:'deploymentId',halign:'center',align:'center'" width="50">部署ID</th>
					<th data-options="field:'name',halign:'center',align:'center'" width="250">流程名</th>
					<th data-options="field:'key',halign:'center',align:'center'" width="150">Key</th>
					<!--<th data-options="field:'version',halign:'center',align:'center'" width="70">版本号</th>-->
					<th data-options="field:'activeInstance',halign:'center',align:'center'" width="50">活动</th>
					<th data-options="field:'diagramResourceName',halign:'center',align:'center'" width="60" formatter="formatDiagram">流程图</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="mainGridToolbar">
			<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">部署</a>
			<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon2 r11_c19" plain="true" disabled="true">实例</a>
			<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
			<a href="#" id="btnDownload" class="easyui-linkbutton" iconCls="icon2 r2_c1" plain="true" disabled="true">下载</a>
		</div>
    </div>

	<div id="processDiagramWindow" class="easyui-window" title="流程图"
		 style="clear: both; width: 750px; height: 400px;"
		 data-options="iconCls:'icon-edit',modal:true,closed:true">
		<div style=" display: inline-block; position: relative;padding:5px 10px">
			<img id="processDiagram" />
		</div>
	</div>

	<div id="popWindow" class="easyui-window" title="活动流程实例"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 750px; height: 440px; padding: 5px;">
		<table id="grid2"
			class="easyui-datagrid"
			data-options="singleSelect:false,collapsible:true,onClickRow:gridButtonHandler2,onLoadSuccess: loadSuccess2,method:'get'"
			toolbar="#grid2Toolbar"
			style="height: 386px;"
			pagination="false">
			<thead>
			<tr>
				<th data-options="field:'id',halign:'center',align:'center'" width="60" >ID</th>
				<th data-options="field:'processDefinitionId',halign:'center',align:'center'" width="150" >流程定义ID</th>
				<th data-options="field:'businessKey',halign:'center',align:'center'" width="280">业务主键</th>
				<th data-options="field:'startUserId',halign:'center',align:'center'" width="50">发起人</th>
				<th data-options="field:'startTime',halign:'center',align:'center'" width="120" formatter="formatDatetime2Min">发起时间</th>
				<th data-options="field:'suspended',halign:'center',align:'center'" width="50" formatter="formatSuspensionState">状态</th>
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="grid2Toolbar">
			<a href="#" id="btnSuspendOrActive" class="easyui-linkbutton" iconCls="icon-add" plain="true">挂起/恢复</a>
			<a href="#" id="btnDelete2" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
		</div>
	</div>

	<div id="popWindow1" class="easyui-window" title="部署流程"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 450px; height: 140px; padding: 5px;">
		<form id="mainForm" method="post" enctype="multipart/form-data">
			<a href="#" id="btnDeploy" class="easyui-linkbutton" iconCls="icon-add" plain="true">部署</a>
			<br/>
			<input class="easyui-filebox" id="f_file" name="file" data-options="required:true,width:315,buttonText:'选择文件'" />
		</form>
	</div>
</body>
</html>