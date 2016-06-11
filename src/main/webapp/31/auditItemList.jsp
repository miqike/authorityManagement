<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};
</script>
<div id="auditItemListWindow"  style="padding: 5px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd4" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnDelete4" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <!-- <a href="javascript:void(0);" id="btnClose4" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a> -->
    </div>

    <table id="grid4"
           class="easyui-datagrid"
           data-options="
               singleSelect:false,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
           toolbar="#grid4Toolbar"
           style="height: 288px">
        <thead>
        <tr>
            <!-- <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th> -->
            <!-- <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="60">事项代码</th> -->
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

<div id="addAuditItemWindow" class="easyui-window" title="备选检查事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 560px; height: 500px; padding: 5px;">
    <div id="grid5Toolbar">
        <a href="javascript:void(0);" id="btnSave5" class="easyui-linkbutton" iconCls="icon-ok" plain="true">增加</a>
        <a href="javascript:void(0);" id="btnClose5" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>

    <table id="grid5"
           class="easyui-datagrid"
           data-options="
               singleSelect:false,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
           style="height: 418px">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="250">名称</th>
            <th data-options="field:'hclx',halign:'center',align:'left'" sortable="true" width="100" codeName="hclx"
                formatter="formatCodeList">检查类型
            </th>
        </tr>
        </thead>
    </table>
</div>
	