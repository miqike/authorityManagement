<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function loadCandidateUserRoleGrid() {
    $.getJSON('../common/query?mapper=roleMapper&queryName=selectRoleByUserIdExclude', {
	    userId: $('#mainGrid').datagrid('getSelected').userId
    }, function(response) {
    	$('#candidateUserRoleGrid').datagrid("loadData", response);
    });
    
}

function addUserRole() {
	var rows = $('#candidateUserRoleGrid').datagrid('getSelections');
	if(rows.length > 0) {
		var param = new Array();
		$.each(rows, function(idx, elem) {
			param.push(elem.id);
		});
	
		$.ajax({
			url:"../sys/user/role1/" + $('#mainGrid').datagrid('getSelected').userId,
			data:JSON.stringify(param),
			type:"put",
			contentType: "application/json; charset=utf-8",
			cache:false,
			success: function(response) {
				if(response.status == $.husky.SUCCESS) {
					$.messager.show("操作提醒", "添加用户角色成功", "info", "bottomRight");
					loadUserRoleGrid();
					loadCandidateUserRoleGrid()
				} else {
					$.messager.alert("错误", "添加用户角色失败");
				}
			}
		});
	} else {
		$.messager.alert("操作提醒", "请首先选择需要在增加的用户角色");
	}
}

</script>

<div id="candidateUserRoleSelectDialog" >
    <table id="candidateUserRoleGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,ctrlSelect:true, method:'get',fit:false,pagination:false" >
        <thead>
        <tr>
            <th data-options="field:'role',halign:'center',align:'center'" sortable="true" width="106">角色代码</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="106">角色名称</th>
            <th data-options="field:'description',halign:'center',align:'left'" sortable="true" width="300">描述</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                formatter="formatCodeList">状态</th>
        </tr>
        </thead>
    </table>
</div>
