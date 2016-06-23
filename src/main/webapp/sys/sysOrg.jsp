<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
	String privilegeName="sysOrganization";//定义权限名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>组织机构维护</title>
	<link rel="stylesheet" href="../css/jquery-easyui-theme/${theme}/easyui.css" />
	<link rel="stylesheet" href="../css/jquery-easyui-theme/icon.css" />
	<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" >
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" >

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jqueryExtend/jquery.function.ztree.js"></script>
	<script type="text/javascript" src="../js/husky/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.extend.js"></script>
	<script type="text/javascript" src="./sysOrg.js"></script>
	<link rel="stylesheet" href="../css/content.css"/>
</head>
<body>
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'west',split:true" title="组织机构" style="width:400px;">
		<ul id="tree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',title:''" style="padding-left:10px;padding-top:10px;">
		<div id="tabPanel" class="easyui-tabs" style="width:500px;clear:both;" data-options="onSelect:tabSelectHandler">
			<div title="基本信息" style="padding:5px;" selected="true">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加本级</a>
				<a href="#" id="btnAddChild" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加下级</a>
				<a href="#" id="btnEdit" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>
				<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true" disabled="true">保存</a>
				<a href="#" id="btnCancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" disabled="true">取消</a>
				<a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  disabled="true">删除</a>
				<form action="" id="treeNodeForm" method="post">
					<div style="display: none">
						上级单位编码<input class="easyui-validatebox" id="f_parentId" style="width: 100px"/>
					</div>
					<table style="padding-top:10px">
						<tr>
							<td style="text-align:right">单位编码</td>
							<td><input class="easyui-validatebox" id="f_id" data-options="required:true"  style="width: 100px;text-align: right"/></td>
							<td style="width: 70px; text-align:right">单位简称</td>
							<td><input class="easyui-validatebox" id="f_briefName" style="width: 200px;text-align: left"/></td>
						</tr>
						<tr>
							<td style="text-align:right">单位名称</td>
							<td colspan="3"><input class="easyui-validatebox" id="f_name" data-options="required:true" style="width: 386px"/></td>
						</tr>
						<tr>
							<td style="text-align:right">联系人</td>
							<td><input class="easyui-validatebox" id="f_contacts" style="width: 100px;text-align: right"/></td>
							<td style="text-align:right">联系电话</td>
							<td><input class="easyui-validatebox" id="f_phone" style="width: 200px"/></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
