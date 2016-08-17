<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="./auditItemLista.js" ></script>

<script>
function doAuditItemListInit() {
	//http://192.168.5.100:9080/cpsi/common/query?mapper=hcsxjgMapper&queryName=queryForTask&hcrwId=10357&hclx=1&_=1471405124851
			
	var hcrw = $('#grid4').datagrid('getSelected');
	var annualAuditItemGridOptions = $("#annualAuditItemGrid").datagrid("options");
	annualAuditItemGridOptions.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask&hcrwId=10357&hclx=1&_=1471405124851';
}

</script>
<!-- 
<div id="auditItemAccordion" class="easyui-accordion" data-options="fit:true,border:true,animate:true" > 
	<div title="检查事项列表" data-options="iconCls:'icon2 r4_c20', fit: true,selected:true" style="overflow: auto;">
 -->		
 		<div id="auditItemTabs" class="easyui-tabs" data-options="fit: true, border: false" style="overflow: hidden;">
			<div data-options="title: '年报信息', iconCls: 'icon2 r9_c2', refreshable: false, selected: true">
				<table id="annualAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true, ctrlSelect:true,method:'get',
				    	offset: { width: -25, height: -255}" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs" formatter="formatCodeList">检查方式</th>
				         <th data-options="field:'dbxxly',halign:'center',align:'center'" sortable="true" width="90" codeName="sjly"
				             formatter="formatCodeList">比对信息来源</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="180">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="180" formatter="formatCompareCol" styler="stylerRegist">登记/备案内容</th>
				         <th data-options="field:'sjnr',halign:'center',align:'left'" sortable="true" width="180" formatter="formatCompareCol" styler="stylerActual">实际内容</th>
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="60" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">比对结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >问题描述</th>
				     </tr>
				     </thead>
				 </table>
			</div>
			<div data-options="title: '即时信息', iconCls: 'icon2 r8_c1', refreshable: false">
				<table id="instanceAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,	ctrlSelect:true,method:'get',
						offset: { width: -25, height: -255}" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
				             formatter="formatCodeList">检查方式</th>
				         <th data-options="field:'dbxxly',halign:'center',align:'center'" sortable="true" width="90" codeName="sjly"
				             formatter="formatCodeList">比对信息来源</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="150">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="180" formatter="formatCompareCol" styler="stylerRegist">登记/备案内容</th>
				         <th data-options="field:'sjnr',halign:'center',align:'left'" sortable="true" width="180" formatter="formatCompareCol" styler="stylerActual">实际内容</th>
				         <!-- <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
				             formatter="formatCodeList"  styler="stylerHczt">检查状态</th> -->
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="60" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">比对结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >问题描述</th>
				     </tr>
				     </thead>
				 </table>
			</div>
		</div>
    <!-- </div>
</div> -->
     