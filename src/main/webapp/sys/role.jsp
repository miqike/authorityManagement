<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>角色列表</title>
	<link href="../css/content.css" rel="stylesheet" />
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

	<script type="text/javascript" src="../js/jquery.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/husky.easyui.extend.js" ></script>


	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/husky.common.js"></script>

	<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
	<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
	<script type="text/javascript" src="./role1.js" ></script>

	<style>
		div #panel .datagrid-wrap{ border: 0px;}
		div #roleWindow .datagrid-wrap{ border-right: 0px;
			border-left: 0px;
			border-bottom: 0px;}
	</style>

</head>
<body style="padding: 5px;" >

<%--<shiro:hasPermission name="role">--%>
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
			<%--<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>--%>
			<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
			<a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">锁定/解锁</a>
		</div>
	</div>
<%--</shiro:hasPermission>
<shiro:lacksPermission name="role">
	<script>
		alert("没有权限，跳转");
	</script>
</shiro:lacksPermission>--%>

	<!-- --------弹出窗口--------------- -->
	<div id="roleWindow" class="easyui-window" title="角色信息"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 750px; height: 440px; padding: 5px;">

		<div>
			<a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
			<a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
			<a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
			<a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
			<a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
			<a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
			<a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
		</div>
		<div id="tabPanel" class="easyui-tabs" style="width:720px;clear:both;" data-options="onSelect:tabSelectHandler">
			<div title="基本信息" style="padding:5px;" selected="true">
				<table width="100%" id="roleTable">
					<tr>
						<td></td>
						<td style="text-align: left; ">
							<a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">角色代码</td>
						<td >
							<input type="hidden" id="p_id"/>
							<input class="easyui-textbox" id="p_role" type="text"
									data-options="required:true" style="width:200px;"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">角色名称</td>
						<td><input class="easyui-textbox" type="text" id="p_name" data-options="required:true" style="width:200px;"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">描述</td>
						<td colspan='5'>
							<input id="p_description" class="easyui-textbox" style="width:200px;" data-options="required:false" />
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">状态</td>
						<td><input id="p_status" class="easyui-combobox" style="width:200px;" data-options="required:true" codeName="userStatus"/></td>
					</tr>

				</table>
			</div>
			<div title="角色功能授权" style="width:700px;padding:5px;">
				<div>
					<a href="#" id="btnEditOrSaveRoleResource" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
					<a href="#" id="btnExpandAll" class="easyui-linkbutton" iconCls="icon-plus" plain="true">展开</a>
					<a href="#" id="btnCollapseAll" class="easyui-linkbutton" iconCls="icon-minus" plain="true">缩回</a>
					<%--<a href="#" id="btnAddRoleResource" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>--%>
					<%--<a href="#" id="btnDeleteRoleResource" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>--%>
				</div>
				<ul id="tree" class="ztree"></ul>
			</div>
			<div title="对应操作人员" style="width:600px">
                <div style="margin-bottom:3px;margin-top:5px;">
                    <span style="margin-left:8px;margin-right:0px;">用户名/姓名</span>
                    <input id="f_name1" style="margin-left:5px;margin-right:10px; padding-right: 3px;width:70px"/>
					<span style="margin-left:8px;margin-right:0px;">单位</span>
					<input id="f_organization1" style="margin-left:5px;margin-right:10px; padding-right: 3px;width:70px"/>
					<span style="width:200px;">
                        <a href="javascript:void(0);" id="btnSearch1" class="easyui-linkbutton" plain="true"
                           iconCls="icon-search">查找</a>
                        <a href="javascript:void(0);" id="btnReset1" class="easyui-linkbutton" plain="true"
                           iconCls="icon2 r3_c10">重置</a>
						<a href="#" id="btnAddUserRole" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
						<a href="#" id="btnDeleteUserRole" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
                    </span>
                </div>
				<table id="grid2"
					   class="easyui-datagrid"
					   data-options="
						ctrlSelect:true,
                       collapsible:true,method:'get',
                       selectOnCheck:false,
                       checkOnSelect:false,
                       onClickRow:grid2ButtonHandler"
					   pageSize="20"
					   pagination="true"
					   style="height: 300px">
					<thead>
					<tr>
						<th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="100">单位编码</th>
						<th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="250">单位名称</th>
						<th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
						<th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
						<th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
							formatter="formatCodeList">状态</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="userRoleWindow" class="easyui-window" title="用户信息"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width:640px; height: 440px; padding: 5px;">
        <div style="margin-bottom:3px;margin-top:5px;">
            <span style="margin-left:8px;margin-right:0px;">用户名/姓名</span>
            <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;width:70px"/>
			<span style="margin-left:8px;margin-right:0px;">单位</span>
			<input id="f_organization" style="margin-left:5px;margin-right:10px; padding-right: 3px;width:70px"/>
			<span style="width:200px;">
                <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                   iconCls="icon-search">查找</a>
                <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                   iconCls="icon2 r3_c10">重置</a>
				<a href="#" id="btnSaveUserRole" class="easyui-linkbutton" iconCls="icon-ok" plain="true" >选择</a>
				<a href="#" id="btnReturn" class="easyui-linkbutton" iconCls="icon-back" plain="true" >关闭</a>
			</span>
        </div>

        <table id="grid3"
            class="easyui-datagrid"
            data-options="
				ctrlSelect:true,
                collapsible:true,
                selectOnCheck:false,
                method:'get',
                checkOnSelect:false,
                onClickRow:grid3ButtonHandler"
            pageSize="20"
            pagination="true"
            style="height: 350px">
			<thead>
			<tr>
				<th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="100">单位编码</th>
				<th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="250">单位名称</th>
				<th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
				<th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
				<th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
					formatter="formatCodeList">状态</th>
			</tr>
			</thead>
		</table>
	</div>

</body>
</html>