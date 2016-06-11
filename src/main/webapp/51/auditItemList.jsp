<%@ page contentType="text/html; charset=UTF-8"%>
<!-- <script type="text/javascript" src="./userDoc.js"></script> -->
<script>

$(function () {
	debugger;
	$("#btnAnnualAudit").click(funcAnnualAudit);
	$("#btnInstanceAudit").click(funcInstanceAudit);
});

</script>
<div id="auditItemAccordion" class="easyui-accordion" data-options="fit:true,border:false,animate:true" style="width:500px;height:467px;"> 
	<div title="检查事项列表" data-options="iconCls:'icon2 r4_c20', selected:true" style="overflow:auto;">
		<div id="auditItemTabs" class="easyui-tabs" data-options="fit: true, border: false, onSelect:auditItemsTabSelectHandler">
			<div data-options="title: '年报信息', iconCls: 'icon2 r9_c2', refreshable: false, selected: true">
				<table id="annualAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,height: 380,	
				    	onClickRow:annualAuditItemClickHandler,width:805,
						ctrlSelect:true,method:'get',onDblClickRow:annualAuditItemDblClickHandler,
						toolbar: '#annualAuditItemGridToolbar'" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
				             formatter="formatCodeList">检查方式</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
				         <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
				             formatter="formatCodeList"  styler="stylerHczt">检查状态</th>
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">检查结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
				     </tr>
				     </thead>
				 </table>
				 <div id="annualAuditItemGridToolbar">
				     <a href="#" id="btnAnnualAudit" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" disabled>检查/查看</a>
				 </div>
			</div>
			<div data-options="title: '即时信息', iconCls: 'icon2 r8_c1', refreshable: false">
				<table id="instanceAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,	height: 380,
						onClickRow:instanceAuditItemGridClickHandler,width:805,
						ctrlSelect:true,method:'get',onDblClickRow:instanceAuditItemGridDblClickHandler,
						toolbar: '#instanceAuditItemGridToolbar'" >
				     <thead>
				     <tr>
				         <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
				         <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
				             formatter="formatCodeList">检查方式</th>
				         <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
				         <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
				         <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
				             formatter="formatCodeList"  styler="stylerHczt">检查状态</th>
				         <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">检查结果</th>
				         <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
				     </tr>
				     </thead>
				 </table>
				 <div id="instanceAuditItemGridToolbar">
				     <a href="#" id="btnInstanceAudit" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" disabled>检查/查看</a>
				 </div>
			</div>
		</div>
    </div>
    <div title="事项内容" data-options="iconCls:'icon2 r11_c17'" style="padding:5px;">
        <div id="auditWindow"  title="检查"
		     data-options="modal:true,closed:true,iconCls:'icon-search'"
		     style="width: 750px; height: 420px; padding: 10px;">
			<div id="auditContent" style="padding:10px;"></div>
			<div id="auditToolbar" style="padding:5px 0px;">
                <div class="dialog-button calendar-header" style="height: auto; border-top-color: rgb(195, 217, 224);">
				    <a href="#" id="btnSuccess" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>
				    <a href="#" id="btnFail" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">不通过</a>
				    <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
				</div>
			</div>
            <div id="failReason" style="display:none;padding:5px;">
				<span style="font-weight:bold; ">检查项目不通过理由和说明:</span><br/>
				<textarea id="k_failReason" cols="70" rows="2" style="width:553px;margin-top:5px;"></textarea>
	               <a href="#" id="btnConfirmFail" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
	               <a href="#" id="btnCancelFail" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">取消</a>
			
			</div>
			<div id="auditLog" style="margin-top:5px;"></div>
			
		</div>
    </div>
</div>
</div>
     
