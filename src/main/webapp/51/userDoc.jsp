<%@ page contentType="text/html; charset=UTF-8"%>
<!-- <script type="text/javascript" src="./userDoc.js"></script> -->

<script>
	function formatDocOperation(val, row) {
		return "<a href=\" \">查看</a>";
	}
	
	function wjlyStyler(val,row,index) {
		console.log(val)
		if(val == 1) {
			return "background-color:lightgreen";
		} else {
			return "background-color:orange";
		}
	}
</script>

<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    <table id="docGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,
           		singleSelect:true,height:300,width:680,
				ctrlSelect:false,method:'get',
				toolbar: '#docGridToolbar',
				url:'../common/query?mapper=hcclmxMapper&queryName=queryForTask',
           		pageSize: 20, pagination: true">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="110">名称</th>
            <th data-options="field:'ly',halign:'center',align:'center'" sortable="true" width="80" codeName="wjly" formatter="formatCodeList" styler="wjlyStyler">分类</th>
            <th data-options="field:'hcsxmc',halign:'center',align:'left'" sortable="true" width="100">核查事项</th>
            <th data-options="field:'uploadTime',halign:'center',align:'left'" sortable="true" width="70" formatter="formatDatetime2Min">上传时间</th>
            <th data-options="field:'wjlx',halign:'center',align:'center'" sortable="true" width="70" codeName="wjlx" formatter="formatCodeList">文件类型</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70" formatter="formatDocOperation">显示</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

</div>
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon-add" plain="true" >上传</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>

