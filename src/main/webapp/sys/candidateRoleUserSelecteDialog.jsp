<%@ page contentType="text/html; charset=UTF-8"%>


<div id="candidateRoleUserWindow" >
	<div style="margin-bottom: 3px; margin-top: 5px;">
		<span style="margin-left: 8px; margin-right: 0px;">用户名/姓名</span> <input
			id="f_name"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="margin-left: 8px; margin-right: 0px;">单位</span> <input
			id="f_organization"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="width: 200px;"> <a href="javascript:void(0);"
			id="btnQueryUserByRoleIdNegative" class="easyui-linkbutton" plain="true"
			iconCls="icon-search">查找</a> <a href="javascript:void(0);"
			id="btnReset2" class="easyui-linkbutton" plain="true"
			iconCls="icon2 r3_c10">重置</a>
		</span>
	</div>

	<table id="candidateUserGrid" class="easyui-datagrid"
		data-options="
			ctrlSelect:true,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
		pageSize="100" pagination="true" style="height: 333px">
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

function reset2() {
	$("#f_name").val('');
    $("#f_organization").val('');
	queryUserByRoleIdNegative();
}
</script>