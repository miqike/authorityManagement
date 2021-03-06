<%@ page contentType="text/html; charset=UTF-8"%>
<div id="auditItemAccordion" class="easyui-accordion" data-options="fit:true,border:true,animate:true" > 
	<div title="检查事项列表" data-options="iconCls:'icon2 r4_c20', fit: true,selected:true" style="overflow: auto;">
		<table id="annualAuditItemGrid" class="easyui-datagrid"
			   data-options="collapsible:true, ctrlSelect:true,method:'get',height:200,width:200,
				    	onClickRow:annualAuditItemClickHandler,onDblClickRow:annualAuditItemDblClickHandler,
				    	offset: { width: -25, height: -255},
						toolbar: '#annualAuditItemGridToolbar'" >
			<thead>
			<tr>
				<th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
				<th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs" formatter="formatCodeList">检查方式</th>
				<th data-options="field:'dbxxly',halign:'center',align:'center'" sortable="true" width="90" codeName="sjly"
					formatter="formatCodeList">比对信息来源</th>
				<th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="100" formatter="formatCompareCol" styler="stylerRegist">即时内容</th>
				<th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="100">公示内容</th>
				<th data-options="field:'sjnr',halign:'center',align:'left'" sortable="true" width="100" formatter="formatCompareCol" styler="stylerActual">实际内容</th>
				<th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="60" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">比对结果</th>
				<th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >问题描述</th>
			</tr>
			</thead>
		</table>
		<div id="annualAuditItemGridToolbar">
			<a href="#" id="btnAnnualAuditJs" class="easyui-linkbutton" iconCls="icon2 r17_c20" plain="true" disabled>检查/查看</a>
			<a href="#" id="btnAddAnnualDocFur" class="easyui-linkbutton" iconCls="icon2 r8_c18" plain="true" >企业提交附加材料清单</a>
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
     