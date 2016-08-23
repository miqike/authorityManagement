<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>代码管理</title>
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
	<script type="text/javascript" src="./code.js"></script>
	<style type="text/css">
		#panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
	</style>
</head>
<body style="padding:5px;">
	<div id="panel" class="easyui-panel" title="">
		<div style="padding: 5px 10px 0px 10px">
			<span style="margin-left:8px;margin-right:0px;">代码名:</span>
			<input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
	
			<span style="width:300px;">
				<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
				   iconCls="icon-search">查找</a>
				<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
				   iconCls="icon2 r3_c10">重置</a>
				</span>
		</div>
		<table id="mainGrid" class="easyui-datagrid" title="" style="height:550px"
			   data-options="
			   		url:'../common/query?mapper=codeMapper&queryName=queryCode',
					fitColumns: true,method:'get',
					offset: {height: -50, width:-26},height:450,
					singleSelect:true,
					toolbar:'#mainGridToolbar',
					onClickRow:mainGridButtonHandler,
					pageSize:100,pagination:true">
			<thead>
			<tr>
				<th data-options="field:'name',halign:'center',align:'left',editor:'textbox'" width="70">代码名</th>
				<th data-options="field:'value',halign:'center',align:'center',editor:'textbox'" width="70">代码值</th>
				<th data-options="field:'literal',halign:'center',align:'left',editor:'textbox'" width="150">字面量</th>
				<th data-options="field:'style',halign:'center',align:'left',editor:'textbox'" width="150">样式</th>
				<th data-options="field:'descn',halign:'center',align:'left',editor:'textbox'" width="150">描述</th>
			</tr>
			</thead>
		</table>
	</div>

	<div id="mainGridToolbar">
		<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
		<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑/查看</a>
		<a href="#" id="btnDuplicate" class="easyui-linkbutton" iconCls="icon2 r17_c1" plain="true"  disabled="true">复制</a>
		<a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
	</div>
	
	<div id="popWindow" class="easyui-window" title="代码信息"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 400px; height: 260px; padding: 5px;">
	
		<div title="基本信息" style="padding:5px;" selected="true">
			<table width="100%" id="codeTable">
				<tr>
					<td style="text-align: right">
						<a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-edit"  plain="true">编辑</a>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">代码名</td>
					<td><input class="easyui-textbox" id="name"
							   data-options="required:true,disabled:true" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">代码值</td>
					<td><input class="easyui-textbox"  id="value" data-options="required:true,disabled:true" style="width:200px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">字面量</td>
					<td>
						<input class="easyui-textbox" id="literal" style="width:200px;" data-options="required:true,disabled:true"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">样式</td>
					<td>
						<input class="easyui-textbox" id="style" style="width:200px;" data-options="disabled:true"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right">描述</td>
					<td><input class="easyui-textbox"  id="descn" data-options="disabled:true" style="width:200px;"/></td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>
