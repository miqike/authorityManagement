<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>角色列表</title>
	
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

	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js" ></script>

	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/husky/husky.common.js"></script>

	<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
	<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
	<script type="text/javascript" src="./role.js" ></script>
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
	        border-color: ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: fff3f3;
	        background-image: url("");
	    }
		div #panel .datagrid-wrap{ border: 0px;}
		div #roleWindow .datagrid-wrap{ border-right: 0px;
			border-left: 0px;
			border-bottom: 0px;}
	</style>

</head>
<body style="padding: 5px;" >
	<div id="panel" class="easyui-panel" title="" >
		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="collapsible:true,onClickRow:mainGridButtonHandler,ctrlSelect:true,
				onDblClickRow:mainGridDblClickHandler,onLoadSuccess:mainGridLoadSuccessHandler,
				method:'get',
				url:'../common/query?mapper=roleMapper&queryName=queryRole'"
			toolbar="#mainGridToolbar"
			style="height: 500px" 
			pageSize="20" 
			queryParams="filter: $('#filter').val()" 
			pagination="true">
			<thead>
				<tr>
					<th data-options="field:'role',halign:'center',align:'center'" sortable="true" width="100">角色代码</th>
					<th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="100">角色名称</th>
					<th data-options="field:'description',halign:'center',align:'left'" sortable="true" width="350">描述</th>
					<th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
						formatter="formatCodeList">状态</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="mainGridToolbar">
			<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
			<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>
			<a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
			<a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">锁定/解锁</a>
		</div>
	</div>
</body>
</html>