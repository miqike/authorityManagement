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
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/themes/metro/easyui.css" rel="stylesheet"/>
	<link href="../css/themes/icon.css" rel="stylesheet"/>
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

	<script type="text/javascript" src="../js/hotkeys.min.js"></script>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
	<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js" ></script>

	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/myJs/common.js"></script>
	<script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
	<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.combobox.codeList.js"></script>
	<script type="text/javascript" src="../js/jqueryExtend/jquery.function.ztree.js"></script>
	<script type="text/javascript" src="../js/myJs/formatter.js"></script>

	<script type="text/javascript" src="sysOrganization.js"></script>

</head>
<body>
<%--<shiro:hasPermission name="<%=privilegeName%>">--%>
<div class="easyui-layout" style="height:600px;">
	<div data-options="region:'west',split:true" title="组织机构" style="width:400px;">
		<ul id="tree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',title:''" style="padding-left:30px;padding-top:10px;">
		<!-- <div id="tabPanel" class="easyui-tabs" style="width:700px;clear:both;" data-options="onSelect:tabSelectHandler">
			<div title="基本信息" style="padding:5px;" selected="true">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加本级</a>
				<a href="#" id="btnAddChild" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加下级</a>
				<a href="#" id="btnEdit" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>
				<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true" disabled="true">保存</a>
				<a href="#" id="btnCancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" disabled="true">取消</a>
				<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  disabled="true">删除</a>
				<form action="" id="treeNodeForm" method="post">
					<div style="display: none">
						上级单位编码<input class="easyui-textbox" id="f_parentId" name="parentId" style="width: 100px"/>
					</div>
					<table style="padding-top:10px">
						<tr>
							<td style="text-align:right">单位编码</td>
							<td><input class="easyui-textbox" id="f_id" name="p_id" style="width: 100px;text-align: right"/></td>
							<td style="text-align:right">单位名称</td>
							<td><input class="easyui-textbox" id="f_name" name="name" data-options="required:true" style="width: 200px"/></td>
                        </tr>
					</table>
				</form>
			</div>
		</div> --><!-- 
		data-options="onClickRow:mainGridButtonHandler,onLoadSuccess:mainGridLoadSuccessHandler,
                   offset: { width: -310, height: -40},
                   ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,method:'get'" -->
		 <table id="mainGrid"
                   class="easyui-datagrid"
                   
                   toolbar="#mainGridToolbar"
                   style="height: 600px"
                   pagination="false"
                   pagePosition ="bottom" >
                <thead>
                <tr>
                    <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
                    <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>
                    <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称</th>
                    <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">联系人</th>
                    <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">联系电话</th>
                    <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">地址</th>
                    <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">公示信息分类</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                        formatter="formatCodeList">编码别名</th>
                    <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">名称别名</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="mainGridToolbar">
                <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑/查看</a>
                <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
            </div>
	</div>
</div>
<%--
</shiro:hasPermission>
<shiro:lacksPermission name="<%=privilegeName%>">
    <div>没有权限或者权限配置异常</div>
</shiro:lacksPermission>
--%>
</body>
</html>
