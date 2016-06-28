<%@ page contentType="text/html; charset=UTF-8"%>
<div id="userSelectDialog" >
	<div style="margin-bottom: 3px; margin-top: 5px;">
		<span style="margin-left: 8px; margin-right: 0px;">用户名/姓名</span> <input
			id="f_name"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="margin-left: 8px; margin-right: 0px;">单位</span> <input
			id="f_organization"
			style="margin-left: 5px; margin-right: 10px; padding-right: 3px; width: 70px" />
		<span style="width: 200px;"> <a href="javascript:void(0);"
			id="btn_queryUser_" class="easyui-linkbutton" plain="true"
			iconCls="icon-search">查找</a> <a href="javascript:void(0);"
			id="btn_reset_" class="easyui-linkbutton" plain="true"
			iconCls="icon2 r3_c10">重置</a>
		</span>
	</div>

	<table id="_userGrid" class="easyui-datagrid"
		data-options="
			ctrlSelect:true,collapsible:true,checkOnSelect:false,
            selectOnCheck:false,pagination:true,method:'get',pageSize:20,
			url:'./common/query?mapper=userMapper&queryName=queryUser'"
		 	style="height: 333px">
		<thead>
			<tr>
				<th data-options="field:'userId',halign:'center',align:'center'"
					sortable="true" width="70">用户名</th>
				<th data-options="field:'name',halign:'center',align:'center'"
					sortable="true" width="70">姓名</th>
				<th data-options="field:'orgId',halign:'center',align:'center'"
					sortable="true" width="80">单位编码</th>
				<th data-options="field:'orgName',halign:'center',align:'left'"
					sortable="true" width="240">单位</th>
			</tr>
		</thead>
	</table>
</div>
<script>

function _queryUser_() {
	$("#_userGrid").datagrid("load",{
    	name: $('#f_name').val(),
    	organization: $('#f_organization').val()
    });
}

function _reset_() {
	$("#f_name").val('');
    $("#f_organization").val('');
    _queryUser_(); 
}
</script>