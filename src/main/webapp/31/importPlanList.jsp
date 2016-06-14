<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};
</script>
<div id="importPlanListWindow"  style="padding: 5px;">

    <table id="importPlanGrid"
           class="easyui-datagrid"
           data-options="
               singleSelect:false,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
           style="height: 288px">
        <thead>
        <tr>
            <!-- <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th> -->
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="60">事项代码</th>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">名称</th>
            <th data-options="field:'hclx',halign:'center',align:'left'" sortable="true" width="90" codeName="hclx"
                formatter="formatCodeList">检查类型
            </th>
            <th data-options="field:'descript',halign:'center',align:'left'" sortable="true" width="150">描述</th>
            <th data-options="field:'hcff',halign:'center',align:'left'" sortable="true" width="70" codeName="hcfs"
                formatter="formatCodeList">检查方法
            </th>
            <th data-options="field:'hcxxfl',halign:'center',align:'left'" sortable="true" width="90" codeName="hcxxfl"
                formatter="formatCodeList">检查信息分类
            </th>
        </tr>
        </thead>
    </table>
</div>
	