<%@ page contentType="text/html; charset=UTF-8"%>
<div id="auditItemAccordion" class="easyui-accordion" data-options="fit:true,border:true,animate:true" > 
	<div title="检查事项列表" data-options="iconCls:'icon2 r4_c20', fit: true,selected:true" style="overflow: auto;">
		<div id="auditItemTabs" class="easyui-tabs" data-options="fit: true, border: false" style="overflow: hidden;">
			<div data-options="title: '年报信息', iconCls: 'icon2 r9_c2', refreshable: false, selected: true">
				<table id="annualAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true, ctrlSelect:true,method:'get',
				    	onClickRow:annualAuditItemClickHandler,onDblClickRow:annualAuditItemDblClickHandler,
				    	offset: { width: -25, height: -255},
						toolbar: '#annualAuditItemGridToolbar'" >
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
				 <div id="annualAuditItemGridToolbar">
				     <a href="#" id="btnAnnualAudit" class="easyui-linkbutton" iconCls="icon2 r17_c20" plain="true" disabled>检查/查看</a>
				     <a href="#" id="btnAddAnnualDocFur" class="easyui-linkbutton" iconCls="icon2 r8_c18" plain="true" >企业提交附加材料清单</a>
				 </div>
			</div>
			<div data-options="title: '即时信息', iconCls: 'icon2 r8_c1', refreshable: false">
				<table id="instanceAuditItemGrid" class="easyui-datagrid"
					data-options="collapsible:true,	ctrlSelect:true,method:'get',
						onClickRow:instanceAuditItemGridClickHandler,onDblClickRow:instanceAuditItemGridDblClickHandler,
						offset: { width: -25, height: -255}, 
						toolbar: '#instanceAuditItemGridToolbar'" >
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
				 <div id="instanceAuditItemGridToolbar">
				     <a href="#" id="btnInstanceAudit" class="easyui-linkbutton" iconCls="icon2 r17_c20" plain="true" disabled>检查/查看</a>
				     <a href="#" id="btnAddInstanceDocFur" class="easyui-linkbutton" iconCls="icon2 r8_c18" plain="true" >企业提交附加材料清单</a>
				 </div>
			</div>
		</div>
    </div>
    <div title="事项内容" data-options="iconCls:'icon2 r11_c17'" style="padding:5px;">
        <div id="auditWindow"  title="检查"
		     data-options="modal:true,closed:true,iconCls:'icon-search'"
		     style="width: 750px; height: 420px; padding: 10px;">
			<div id="auditContent" style="padding:10px;"></div>
            <div id="failReason" style="padding:5px;">
				<span style="font-weight:bold; ">检查项目不通过理由和说明:</span>
	               <a href="#" id="btnShowPrompt" class="easyui-linkbutton" iconCls="icon2 r11_c18" plain="true">选择常见问题说明</a>
				<br/>
				<textarea id="k_failReason" cols="70" rows="2" style="width:553px;margin-top:5px;"></textarea>
	            <!-- <a href="#" id="btnConfirmFail" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
	               <a href="#" id="btnCancelFail" class="easyui-linkbutton" iconCls="icon-undo" plain="true">取消</a> -->
			</div>
			<div id="auditToolbar" style="padding:5px 0px;">
                <div class="dialog-button calendar-header" style="height: auto; border-top-color: rgb(195, 217, 224);text-align: left;">
				    <a href="#" id="btnPass" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>
				    <a href="#" id="btnFail" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">不通过</a>
				    <a href="#" id="btnCloseAuditWindow" class="easyui-linkbutton" iconCls="icon-back" plain="true">返回</a>
				</div>
			</div>
			<div id="auditLog" style="margin-top:5px;"></div>
			
		</div>
    </div>
</div>
     