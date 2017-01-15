<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>编码信息维护</title>
	<link rel="stylesheet" href="../css/jquery-easyui-theme/${theme}/easyui.css" />
	<link rel="stylesheet" href="../css/jquery-easyui-theme/icon.css" />
	<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" >
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" >
	<link rel="stylesheet" href="../css/content.css"/>

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

	<script type="text/javascript" src="../js/husky/husky.common.js"></script>

	<script type="text/javascript" src="./codeEdit.js"></script>

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

		.validatebox-text {
	        border-width: 1px;
	        border-style: solid;
	        line-height: 17px;
	        padding-top: 1px;
	        padding-left: 3px;
	        padding-bottom: 2px;
	        padding-right: 3px;
	        background-attachment: scroll;
	        background-size: auto;
	        background-origin: padding-box;
	        background-clip: border-box;
	    }
	
	    .validatebox-invalid {
	        border-color: #ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: #fff3f3;
	        background-image: none;
	    }
	</style>

</head>
<body>
<div class="noprint" style="margin:5px;">
	<div class="easyui-layout" style="height:600px;" data-options="fit:true">
		<div id="typePanel" data-options="region:'west',split:false" title="编码类型列表" style="width:260px;">
			<table id="typeGrid" class="easyui-datagrid" title="" style="width:258px;"
				   data-options="ctrlSelect:true,url:'../common/query?mapper=codeMapper&queryName=queryType&editFlag=1',fitColumns: true,method:'get',onClickRow:typeGridButtonHandler">
				<thead>
				<tr>
					<th data-options="field:'descn',halign:'center',align:'center', width:250"></th>
				</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'center',title:''" style="padding-top:0px;margin-left: 0px">
			<div id="mainGridToolbar">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建</a>
				<a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
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
						<td><input class="easyui-validatebox" id="name"data-options="required:true,disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">样式</td>
						<td><input class="easyui-validatebox" id="style" style="width:200px;" data-options="disabled:true"/></td>
						<td style="text-align: right">描述</td>
						<td><input class="easyui-validatebox"  id="descn" data-options="disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">编辑标志</td>
						<td><input class="easyui-validatebox"  id="editFlag" data-options="disabled:true" style="width:200px;"/></td>
					</tr>
					<tr>
						<td style="text-align: right">编码值</td>
						<td><input class="easyui-validatebox"  id="value" data-options="required:true,disabled:true" style="width:200px;"/></td>
						<td style="text-align: right">编码名称</td>
						<td><input class="easyui-validatebox" id="literal" style="width:200px;" data-options="required:true,disabled:true"/></td>
						<td><a id="btnSave" class="easyui-linkbutton" data-options="iconCls:'icon-save',width:70,plain:'true',disabled:true">保存</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>


</body>
</html>
