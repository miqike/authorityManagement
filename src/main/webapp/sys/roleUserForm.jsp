<%@ page contentType="text/html; charset=UTF-8"%>
<div style="margin-bottom: 3px; margin-top: 5px;">
	<span style="margin-left: 8px; margin-right: 0px;">用户名/姓名</span> <input
		id="f_name1"
		style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
	<span style="margin-left: 8px; margin-right: 0px;">单位</span> <input
		id="f_organization1"
		style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
	<span style="width: 200px;"> <a href="javascript:void(0);"
		id="btnSearch1" class="easyui-linkbutton" plain="true"
		iconCls="icon-search">查找</a> <a href="javascript:void(0);"
		id="btnReset1" class="easyui-linkbutton" plain="true"
		iconCls="icon2 r3_c10">重置</a> <a href="#" id="btnAddUserRole"
		class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a> <a
		href="#" id="btnDeleteUserRole" class="easyui-linkbutton"
		iconCls="icon-remove" plain="true">删除</a>
	</span>
</div>
<table id="grid2" class="easyui-datagrid"
	data-options="
		ctrlSelect:true,
                   collapsible:true,method:'get',
                   selectOnCheck:false,
                   checkOnSelect:false,
                   onClickRow:grid2ButtonHandler"
	pageSize="20" pagination="true" style="height: 250px">
	<thead>
		<tr>
			<th data-options="field:'orgId',halign:'center',align:'left'"
				sortable="true" width="100">单位编码</th>
			<th data-options="field:'orgName',halign:'center',align:'left'"
				sortable="true" width="250">单位名称</th>
			<th data-options="field:'userId',halign:'center',align:'center'"
				sortable="true" width="70">用户代码</th>
			<th data-options="field:'name',halign:'center',align:'center'"
				sortable="true" width="70">用户姓名</th>
			<th data-options="field:'status',halign:'center',align:'center'"
				sortable="true" width="70" codeName="userStatus"
				formatter="formatCodeList">状态</th>
		</tr>
	</thead>
</table>


<div id="userRoleWindow" class="easyui-window" title="用户信息"
	data-options="modal:true,closed:true,iconCls:'icon-search'"
	style="width: 640px; height: 440px; padding: 5px;">
	<div style="margin-bottom: 3px; margin-top: 5px;">
		<span style="margin-left: 8px; margin-right: 0px;">用户名/姓名</span> <input
			id="f_name"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="margin-left: 8px; margin-right: 0px;">单位</span> <input
			id="f_organization"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="width: 200px;"> <a href="javascript:void(0);"
			id="btnSearch2" class="easyui-linkbutton" plain="true"
			iconCls="icon-search">查找</a> <a href="javascript:void(0);"
			id="btnReset2" class="easyui-linkbutton" plain="true"
			iconCls="icon2 r3_c10">重置</a> <a href="#" id="btnSaveUserRole"
			class="easyui-linkbutton" iconCls="icon-ok" plain="true">选择</a> <a
			href="#" id="btnReturn" class="easyui-linkbutton" iconCls="icon-back"
			plain="true">关闭</a>
		</span>
	</div>

	<table id="grid3" class="easyui-datagrid"
		data-options="
			ctrlSelect:true,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false,
               onClickRow:grid3ButtonHandler"
		pageSize="20" pagination="true" style="height: 350px">
		<thead>
			<tr>
				<th data-options="field:'orgId',halign:'center',align:'left'"
					sortable="true" width="100">单位编码</th>
				<th data-options="field:'orgName',halign:'center',align:'left'"
					sortable="true" width="250">单位名称</th>
				<th data-options="field:'userId',halign:'center',align:'center'"
					sortable="true" width="70">用户代码</th>
				<th data-options="field:'name',halign:'center',align:'center'"
					sortable="true" width="70">用户姓名</th>
				<th data-options="field:'status',halign:'center',align:'center'"
					sortable="true" width="70" codeName="userStatus"
					formatter="formatCodeList">状态</th>
			</tr>
		</thead>
	</table>
</div>
<script>
$(function(){
	
	console.log(window.navigateBar.maingrid )
	$("#btnReset1").click(function(){
        $("#f_name1").val('');
        $("#f_organization1").val('');
		queryUserByRoleId();
    });
    $("#btnSearch1").click(queryUserByRoleId);
    $("#btnAddUserRole").click(addUserRole);
	$("#btnDeleteUserRole").click(deleteUserRole);
	$("#btnSaveUserRole").click(saveUserRole);
	$("#btnReturn").click(_return);

    $("#btnSearch2").click(queryUserByRoleIdNegative);
    $("#btnReset2").click(function(){
        $("#f_name").val('');
        $("#f_organization").val('');
		queryUserByRoleIdNegative();
    });

});
</script>