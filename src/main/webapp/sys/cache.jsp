<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>缓存监控列表</title>
	<link href="../css/content.css" rel="stylesheet" />
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.extend.depreciated.js" ></script>

	<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
	<script type="text/javascript" src="../js/datagrid-detailview.js" ></script>
	<script type="text/javascript" src="./cache.js" ></script>
	<style>
		div #panel .datagrid-wrap{ border: 0px;}
		div #popWindow .datagrid-wrap{ border: 0px;}
	</style>
</head>
<body style="padding-top: 5px; padding-left:5px;">
	<div id="panel" class="easyui-panel" title="缓存列表" >
		<table id="mainGrid"
			class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
				method:'get',url:'../sys/cache'"
			toolbar="#mainGridToolbar"
			style="height: 500px"
			pagination="false">
			<thead>
				<tr>
					<th data-options="field:'cacheName',halign:'center',align:'center'" sortable="true" width="200">名字</th>
                    <th data-options="field:'objectCount',halign:'center',align:'right'" sortable="true" width="100">总对象数</th>
					<th data-options="field:'cacheHits',halign:'center',align:'right'" sortable="true" width="70">命中数</th>
					<th data-options="field:'cacheHitPercent',halign:'center',align:'right'" sortable="true" width="70" formatter="formatPercentage">命中率 %</th>
					<th data-options="field:'cacheMisses',halign:'center',align:'right'" sortable="true" width="70">未命中数</th>
					<th data-options="field:'cacheMissesPercent',halign:'center',align:'right'" sortable="true" width="70" formatter="formatPercentage">未命中率 %</th>
					<!--<th data-options="field:'searchesPerSecond',halign:'center',align:'center'" sortable="true" width="150">最后一秒查询完成的执行数</th>
					<th data-options="field:'averageSearchTime',halign:'center',align:'center'" sortable="true" width="150">最后一次采样的平均执行时间</th>
					<th data-options="field:'averageGetTime',halign:'center',align:'left'" sortable="true" width="150">平均获取时间</th>-->

				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="mainGridToolbar">
			<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon2 r2_c10" plain="true" disabled="true">详细</a>
			<a href="#" id="btnClear" class="easyui-linkbutton" iconCls="icon-clear" plain="true" >清空</a>
			<a href="#" id="btnRefresh" class="easyui-linkbutton" iconCls="icon-reload" plain="true" >刷新</a>
		</div>
	</div>

	<!-- --------弹出窗口--------------- -->
	<div id="popWindow" class="easyui-window" title="缓存详细信息"
		data-options="modal:true,closed:true,iconCls:'icon-search'"
		style="width: 780px; height: 400px;">
		<table id="cacheGrid"
			   class="easyui-datagrid"
			   data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler, method:'post'"
			   toolbar="#cacheGridToolbar"
			   style="height: 350px"
			   pagination="false">
			<thead>
			<tr>
				<th data-options="field:'key',halign:'center',align:'center'" sortable="true" width="150">Key</th>
				<th data-options="field:'hitCount',halign:'center',align:'center'" sortable="true" width="70">命中数</th>
				<th data-options="field:'size',halign:'center',align:'center'" sortable="true" width="70">大小</th>
				<th data-options="field:'lastAccessTime',halign:'center',align:'center'" sortable="true" width="130">最后访问时间</th>
				<th data-options="field:'expirationTime',halign:'center',align:'center'" sortable="true" width="100">过期时间</th>
				<th data-options="field:'timeToIdle',halign:'center',align:'center'" sortable="true" width="60">空闲间隔</th>
				<th data-options="field:'timeToLive',halign:'center',align:'center'" sortable="true" width="60">失效间隔</th>
				<th data-options="field:'version',halign:'center',align:'center'" sortable="true" width="50">版本</th>
			</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="cacheGridToolbar">
			<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
			<a href="#" id="btnRefresh1" class="easyui-linkbutton" iconCls="icon-reload" plain="true" >刷新</a>
		</div>
	</div>

</body>
</html>