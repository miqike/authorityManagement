<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};
</script>
<div id="planAbstractListWindow"  style="padding: 5px;">

    <table id="planAbstractGrid"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               method:'get'"
           style="height: 288px">
        <thead>
        <tr>
            <th data-options="field:'nd',halign:'center',align:'center'" sortable="true" width="50">年度</th>
            <th data-options="field:'gsjhbh',halign:'center',align:'center'" sortable="true" width="90">公示计划编号</th>
            <th data-options="field:'jhmc',halign:'center',align:'left'" sortable="true" width="200">计划名称</th>
            <th data-options="field:'cxwh',halign:'center',align:'left'" sortable="true" width="200">抽查文号</th>
            <th data-options="field:'hcrwsl',halign:'center',align:'left'" sortable="true" width="60" >任务数量</th>
        </tr>
        </thead>
    </table>
</div>
	