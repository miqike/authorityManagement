<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>计划任务进度管理</title>
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link href="../css/content.css" rel="stylesheet"/>
	<style>
		
		td.label{text-align: right}
		
		#layout>div.layout-panel-west>div.panel-header {
			border-width: 1px 1px 1px 0px;
		}

		#layout>div.layout-panel-west>div.panel-body {
			border-width: 0px 1px 0px 0px;
		}

		#layout>div.layout-panel-center>div.panel-body {
			border-width: 0px;
		}

		#layout>div.layout-panel-center div.datagrid-wrap {
			border-width: 1px 0px 0px 0px;
		}
	</style>
</head>
<body style="margin:5px;">
<div id="panel" class="easyui-panel" title="" style="overflow: hidden;height:600px;">
	<div style="padding: 5px 10px 0px 10px">
		<table id="queryTable">
			<tr>
				<td class="label">计划年度</td>
				<td><input id="p_recallLimits" class="easyui-numberspinner" data-options="min:2000,max:2017"/>
				</td>
				<td class="label">计划编号</td>
				<td><input id="f_errorNo" class="easyui-textbox"/></td>
				<td class="label">公示系统计划编号</td>
				<td><input id="f_operator" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td class="label">计划名称</td>
				<td><input id="f_module" class="easyui-textbox"/></td>
				<td class="label">核查内容</td>
				<td><input id="f_deptName" class="easyui-combobox" codeName="hcnr"
					data-options="panelHeight:80,width:143,onChange:queryPlan" style="" /></td>
				<td class="label">核查分类</td>
				<td><input id="f_deptName" class="easyui-combobox" codeName="hcfl" 
					data-options="panelHeight:60,width:143,onChange:queryPlan" style="" /></td>
				<td colspan="2" style="text-align-right;">
					<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
					<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
				</td>
			</tr>
		</table>
	</div>
	<div>
<!-- 				onUnselect:disableUpdateAndDeleteButton" -->
		<table id="grid1"
			class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,
				method:'get',url:'../common/query?mapper=hcjhMapper&queryName=query',
				onSelect:showPlanDetail"
			   toolbar="#gridToolbar1"
			   style="height: 250px"
			   sortOrder="asc">
			<thead>
			<tr>
				<th data-options="field:'nd'" halign="center" align="left" sortable="true" width="50">计划年度</th>
				<th data-options="field:'id'" halign="center" align="left" sortable="true" width="70">计划编号</th>
				<th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示系统计划编号</th>
				<th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="130" >计划名称</th>
				<th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">下达日期</th>
				<th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">要求完成时间</th>
				<th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl" formatter="formatCodeList">核查分类</th>
				<th data-options="field:'nr'" halign="center" align="left" sortable="true" width="150" >核查内容</th>
				<th data-options="field:'hcrwsl'" halign="center" align="left" sortable="true" width="60" >任务数量</th>
				<th data-options="field:'ypfsl'" halign="center" align="left" sortable="true" width="60" >已派发</th>
				<th data-options="field:'yrlsl'" halign="center" align="left" sortable="true" width="60" >已认领</th>
				<th data-options="field:'wrlsl'" halign="center" align="left" sortable="true" width="60" >未认领</th>
				<th data-options="field:'jhshr'" halign="center" align="left" sortable="true" width="90" >审核人</th>
				<th data-options="field:'jhxdr'" halign="center" align="left" sortable="true" width="90" >下达人</th>
				<th data-options="field:'sm'" halign="center" align="left" sortable="true" width="250" >说明</th>
			</tr>
			</thead>
		</table>
		<div id="gridToolbar1">
			<a href="#" id="btnUpdate1" class="easyui-linkbutton" iconCls="icon2 r16_c8" plain="true">导入</a>
			<a href="#" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
			<a href="#" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-options="disabled:true">修改</a>
			<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" data-options="disabled:true">审核/取消审核</a>
			<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" data-options="disabled:true">核查事项</a>
		</div>
	</div>
	
	<div id="layout" class="easyui-layout" data-options="fit:true">
		<!-- <div data-options="region:'west',title:'单位列表',onCollapse:collapseHandler,onExpand:expandHandler" style="width:200px">
			<div style="float:left;margin:0px 5px;border: 1px solid lightgray;">
                <ul id='orgTree' class="ztree" ></ul>
			</div>
		</div> -->
		<div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
			<ul id="orgTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center'">
					<!-- onUnselect:disableUpdateAndDeleteButton" -->
			<table id="grid2"
				class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,
					method:'get',
					onSelect:showPlanDetail"
				   toolbar="#planGridToolbar"
				   style="height: 250px"
				   sortOrder="asc">
				<thead>
				<tr>
					<!-- <th data-options="field:'id'" halign="center" align="left" sortable="true" width="30">序号</th> -->
					<th data-options="field:'ba01861'" halign="center" align="left" sortable="true" width="150">检查机关</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70">检查人员</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">检查任务数</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">认领数</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">已完成数</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="80">责令中</th>
					<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="80">未完成数</th>
					
				</tr>
				</thead>
			</table>
			<div id="planGridToolbar">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true" data-options="disabled:true">按检查机关+检查人员排序</a>
				<a href="#" id="btnUpdate" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true" data-options="disabled:true">按市场主体类型+检查机关排序</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">派发/取消派发</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">认领/取消认领</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">详细</a>
			</div>
		</div>

	</div>
</div>
	
	
</body>
</html>
   <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
<!--     
 --> 
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="./3102.js" ></script>