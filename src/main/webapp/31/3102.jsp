<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>计划任务分配</title>
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />
	<style>
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
					<td>计划年度</td>
					<td><input id="f_businessKey" class="easyui-textbox"/></td>
					<td>计划编号</td>
					<td><input id="f_errorNo" class="easyui-textbox"/></td>
					<td>公示系统计划编号</td>
					<td><input id="f_operator" class="easyui-textbox"/></td>
				</tr>
				<tr>
					<td>计划名称</td>
					<td><input id="f_module" class="easyui-textbox"/></td>
					<td>抽查内容</td>
					<td><input id="f_deptName" class="easyui-combobox" codeName="hcnr"
						data-options="panelHeight:120,width:150,onChange:queryPlan" style="" /></td>
					<td>抽查分类</td>
					<td><input id="f_deptName" class="easyui-combobox" codeName="hcfl"
						data-options="panelHeight:120,width:100,onChange:queryPlan" style="" /></td>
					<td colspan="2" style="text-align-right;">
						<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
						<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
					</td>
				</tr>
			</table>
		</div>
	
		<table id="planGrid"
			class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,
				method:'get',
				onSelect:showPlanDetail,
				onUnselect:disableUpdateAndDeleteButton"
			   toolbar="#planGridToolbar"
			   style="height: 550px"
			   sortOrder="asc">
			<thead>
			<tr>
				<th data-options="field:'bi1521'" halign="center" align="left" sortable="true" width="30">序号</th>
				<th data-options="field:'ba01861'" halign="center" align="left" sortable="true" width="150">检查机关</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">登记机关</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">统一社会信用代码</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">企业名称</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="80">市场主体类型</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="80">组织形式</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="100">区域</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70">检查人员</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70">计划认领人</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70" formatter="formatDate">认领日期</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70" codeName="jhlb" formatter="formatCodeList">计划完成状态</th>
				<th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="70" formatter="formatDate">实际完成日期</th>
			</tr>
			</thead>
		</table>
		<div id="planGridToolbar">
			<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">认领/取消认领</a>
			<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">详细</a>
		</div>
		<table id="planDetailGrid"
			class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true"
			style="height: 200px;margin-left:5px"
			sortOrder="asc">
			<thead>
			<tr>
				<th data-options="field:'bi0101'" halign="center" align="left" width="260" formatter="formatBillType">票据名称</th>
				<th data-options="field:'bi0123c'" halign="center" align="center" width="70" codeName="pjxz" formatter="formatCodeList">票据性质</th>
				<th data-options="field:'bi0134c'" halign="center" align="center" width="70" codeName="jldw" formatter="formatCodeList">计量单位</th>
				<th data-options="field:'count'" halign="center" align="right" width="40" formatter="formatCount">合计</th>
				<th data-options="field:'jan'" halign="center" align="right" width="40" >1月</th>
				<th data-options="field:'feb'" halign="center" align="right" width="40" >2月</th>
				<th data-options="field:'mar'" halign="center" align="right" width="40" >3月</th>
				<th data-options="field:'apr'" halign="center" align="right" width="40" >4月</th>
				<th data-options="field:'may'" halign="center" align="right" width="40" >5月</th>
				<th data-options="field:'jun'" halign="center" align="right" width="40" >6月</th>
				<th data-options="field:'jun'" halign="center" align="right" width="40" >8月</th>
				<th data-options="field:'sep'" halign="center" align="right" width="40" >9月</th>
				<th data-options="field:'oct'" halign="center" align="right" width="40" >10月</th>
				<th data-options="field:'nov'" halign="center" align="right" width="40" >11月</th>
				<th data-options="field:'dec'" halign="center" align="right" width="40" >12月</th>
			</tr>
			</thead>
		</table>
</div>
	
	
</body>
</html>
<script type="text/javascript" src="../js/jquery.min.js" ></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
<script type="text/javascript" src="../js/husky.easyui.extend.js" ></script>
<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.combobox.codeList.js"></script>
<script type="text/javascript" src="../js/husky.common.js" ></script>
<script type="text/javascript" src="../js/pinyin.js"></script>
<script type="text/javascript" src="../js/husky.combobox.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<!-- <script type="text/javascript" src="../bill/billFormat.js" ></script> -->
<script type="text/javascript" src="./applyCommon.js" ></script>
<script type="text/javascript" src="./3101.js" ></script>