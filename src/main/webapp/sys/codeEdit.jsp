<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编码信息维护</title>
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
	<link href="../css/themes/icon.css" rel="stylesheet"/>

	<script type="text/javascript" src="../js/hotkeys.min.js"></script>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>

	<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
	<script type="text/javascript" src="../js/husky.common.js"></script>

	<script type="text/javascript" src="../js/lodop/listPrint.js"></script>
	<script type="text/javascript" src="./codeEdit.js"></script>

	<!-- 打印控件引入定义开始 -->
	<script type="text/javascript" src="../js/LodopFuncs.js"></script>

	<style>
		#typePanel>div.datagrid>div.datagrid-wrap {
			border-top: 0px;
			border-right: 0px;
			border-left: 0px;
			border-bottom: 0px;
		}

		div.easyui-layout>div.layout-panel div.datagrid>div.panel-header {
			border-top: 0px;
			border-left: 0px;
		}

		div.easyui-layout>div.layout-panel div.datagrid>div.panel-body {
			border-left: 0px;
		}

		#typePanel {
			border-left-width:1px;
			border-right-width:1px;
			border-bottom-width:1px;
		}

		#typePanel>div.panel>div {
			border-left-width:0px;
			border-right-width:0px;
		}

	</style>

	<object id="LODOP_OB"
			classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
		<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
	</object>
	<!-- 打印控件引入定义结束 -->

</head>
<body>
<div class="noprint" style="margin:5px;height:540px;">
	<div class="easyui-layout" style="height:600px;">
		<div id="typePanel" data-options="region:'west',split:false" title="编码类型列表" style="width:310px;">
			<table id="typeGrid" class="easyui-datagrid" title="" style="width:308px;"
				   data-options="ctrlSelect:true,url:'../common/query?mapper=codeMapper&queryName=queryType&editFlag=1',fitColumns: true,method:'get',onClickRow:typeGridButtonHandler">
				<thead>
				<tr>
					<th data-options="field:'name',halign:'center',align:'center'" hidden="true" width="70" >编码类型</th>
					<th data-options="field:'descn',halign:'center',align:'center'" width="70"></th>
					<th data-options="field:'style',halign:'center',align:'center'" hidden="true" width="70">样式</th>
					<th data-options="field:'editFlag',halign:'center',align:'center'" hidden="true" width="70">编辑标志</th>
					<th data-options="field:'value',halign:'center',align:'center'" hidden="true" width="70">编码</th>
					<th data-options="field:'literal',halign:'center',align:'left'" hidden="true" width="150">编码名称</th>
				</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'center',title:''" style="padding-top:0px;margin-left: 0px">
			<div id="mainGridToolbar">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建</a>
				<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
				<a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true" >打印</a>
				<a href="#" id="btnExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" >导出</a>
			</div>

			<table id="mainGrid" class="easyui-datagrid" title="编码维护" style="width:900px;height:300px"
				   data-options="fitColumns: true,method:'get',singleSelect:true,toolbar:'#mainGridToolbar',onClickRow:mainGridButtonHandler,onLoadSuccess:mainGridLoadSuccessHandler">
				<thead>
				<tr>
					<th data-options="field:'name',halign:'center',align:'center'" hidden="true" width="70" >编码类型</th>
					<th data-options="field:'style',halign:'center',align:'center'" hidden="true" width="70">样式</th>
					<th data-options="field:'descn',halign:'center',align:'center'" width="70">编码类型</th>
					<th data-options="field:'editFlag',halign:'center',align:'center'" hidden="true" width="70">编辑标志</th>
					<th data-options="field:'value',halign:'center',align:'center'" width="70">编码</th>
					<th data-options="field:'literal',halign:'center',align:'left'" width="150">编码名称</th>
				</tr>
				</thead>
			</table>
			<div title="基本信息" style="padding:5px;" selected="true">
				<table width="800px" id="codeTable">
					<tr style="display:none">
						<td style="text-align: right">编码名</td>
						<td><input class="easyui-textbox" id="name"data-options="required:true,disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">样式</td>
						<td><input class="easyui-textbox" id="style" style="width:200px;" data-options="disabled:true"/></td>
						<td style="text-align: right">描述</td>
						<td><input class="easyui-textbox"  id="descn" data-options="disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">编辑标志</td>
						<td><input class="easyui-textbox"  id="editFlag" data-options="disabled:true" style="width:200px;"/></td>
					</tr>
					<tr>
						<td style="text-align: right">编码值</td>
						<td><input class="easyui-textbox"  id="value" data-options="required:true,disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">编码名称</td>
						<td><input class="easyui-textbox" id="literal" style="width:200px;" data-options="required:true,disabled:true"/></td>
						<td><a id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-save',width:70,plain:'true',disabled:true">保存</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>


</body>
</html>
