<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
<title>new</title>
<link href="../css/content.css" rel="stylesheet" />
<link href="../css/jquery-easyui-theme/${theme}/easyui.css"
	rel="stylesheet" />
<link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet" />
<link href="../js/jeasyui-extensions-release/jeasyui.extensions.min.css"
	rel="stylesheet">

<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript"
	src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript"
	src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript"
	src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
<script type="text/javascript"
	src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<script type="text/javascript" src="./2106.js"></script>
<style type="text/css">
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
<body style="padding: 5px;">


	<table id="mainGrid" class="easyui-datagrid"
		data-options="collapsible:true,
           		singleSelect: true,
           		onClickRow:mainGridButtonHandler,
           		width: 1500,height:800,
           		offset: { width: -50, height: -50},
				ctrlSelect:true,method:'get',
				toolbar: '#mainGridToolbar',
				method: 'get',
				url:'../common/query?mapper=materialMapper&queryName=query',
           		pageSize: 100, pagination: true"
		pagePosition="bottom">
		<thead>
			<tr>

				<th data-options="field:'name',halign:'center',align:'left'"
					width="250">材料名称</th>
				<th data-options="field:'type',halign:'center',align:'center'"
					width="150" codeName="wjlx" formatter="formatCodeList">材料类型
				<th data-options="field:'dxnType',halign:'center',align:'center'"
					width="150" codeName="dxnType" formatter="formatCodeList">财务核查数据标志
				</th>
			</tr>
		</thead>
	</table>
	<div id="mainGridToolbar">
		<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add"
			plain="true" onClick="add()">新增</a>
	    <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateMaterial()" disabled>编辑</a>
		<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteMaterial()" disabled>删除</a>
	</div>
	<!--弹出窗口  -->

	<div id="addWindow" class="easyui-window" title="新增材料信息" closed="true"
		minimizable="false" maximizable="false" collapsible="false">
		<div id="materialInfo" title="基本信息" style="padding: 5px;"
			selected="true">
			<table width="100%" id="addTable">
				<tr>
					<td>材料编码</td>
					<td><input class="easyui-validatebox add" id="f_id"
						data-options="required:true" style="width: 200px;" disabled /></td>
				</tr>
				<tr>
					<td>材料名称</td>
					<td><input class="easyui-validatebox add" id="f_name"
						data-options="required:true" style="width: 200px;" /></td>
				</tr>
				<tr>
					<td>材料类型</td>
					<td><input class="easyui-combobox add" id="f_type"
						data-options="required:true" style="width: 200px;" codeName="wjlx"/></td>
				</tr>
			</table>
			<a href="#" id="add_save" class="easyui-linkbutton"
				iconCls="icon-save" plain="true" onClick="addWindowSave()">保存</a> 
			<a href="#" id="btnCancel" class="easyui-linkbutton" iconCls="icon-undo"
			plain="true" onClick="closeAddWindow()">取消</a>
		</div>

	</div>

<div id="editWindow" class="easyui-window" title="编辑材料信息" closed="true"
		minimizable="false" maximizable="false" collapsible="false">
		<div id="materialInfoUpdate" title="基本信息" style="padding: 5px;"
			selected="true">
			<table width="100%" id="editTable">
			<tr>
					<td style="text-align:right;">材料编码</td>
					<td><input class="easyui-validatebox add" id="u_id"
						data-options="required:true" style="width: 200px;" disabled /></td>
				</tr>
				<tr>
					<td style="text-align:right;">材料名称</td>
					<td><input class="easyui-validatebox add" id="u_name"
						data-options="required:true" style="width: 200px;" /></td>
				</tr>
				<tr>
					<td style="text-align:right;">材料类型</td>
					<td><input class="easyui-combobox add" id="u_type"
						data-options="required:true" style="width: 200px;" codeName="wjlx"/></td>
				</tr>
				<tr>
					<td style="text-align:right;">财务核查数据标志</td>
					<td><input class="easyui-combobox add" id="u_dxnType"
						data-options="panelHeight:70" style="width: 200px;" codeName="dxnType"/></td>
				</tr>

			</table>
			<a href="#" id="editWindowSave" class="easyui-linkbutton"
				iconCls="icon-save" plain="true" onClick="editWindowSave()">保存</a> 
			<a href="#" id="editWindowClose" class="easyui-linkbutton" iconCls="icon-undo"
			plain="true" onClick="editWindowClose()">取消</a>
		</div>

	</div>



</body>
</html>