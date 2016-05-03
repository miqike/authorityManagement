<%@ page contentType="text/html; charset=UTF-8"%>
<!-- --------弹出窗口--------------- -->
<div id="popPlanWindow" class="easyui-window" title="计划任务详细信息"
	data-options="modal:true,closed:true,iconCls:'icon2 r16_c6',maximizable:false,minimizable:false,collapsible:false,closable:false"
	style="width: 700px; height: 560px; padding: 5px;">
	<div
		style="border: 0px solid lightblue; border-bottom-width: 0px; padding: 3px;">
		<div>
			<a href="#" id="btnPropose1" class="easyui-linkbutton"
				iconCls="icon2 r19_c7" plain="true" disabled="true">提交审批</a> <a
				href="#" id="btnApprove1" class="easyui-linkbutton"
				iconCls="icon2 r12_c19" plain="true" disabled="true">审批</a> <a
				href="#" id="btnStart1" class="easyui-linkbutton"
				iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a> <a
				href="#" id="btnPause1" class="easyui-linkbutton"
				iconCls="icon2 r6_c16" plain="true" disabled="true">暂停</a> <a
				href="#" id="btnStop1" class="easyui-linkbutton"
				iconCls="icon2 r7_c8" plain="true" disabled="true">终止</a> <a
				href="#" id="btnEstimate1" class="easyui-linkbutton"
				iconCls="icon2 r24_c2" plain="true" disabled="true">评价</a> <a
				href="#" id="btnDelete1" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" disabled="true">删除</a> <a
				href="javascript:void(0);" id="btnSave" class="easyui-linkbutton"
				iconCls="icon-save" plain="true">保存</a> <a
				href="javascript:void(0);" id="btnCancel" class="easyui-linkbutton"
				iconCls="icon-undo" plain="true">取消</a>
		</div>

		<form id="planForm">
			<div style="display: none">
				计划主键<input type="hidden" id="p_id" /> 计划拥有者<input type="hidden"
					id="p_authorId" /> 计划负责人<input type="hidden"
					id="p_superintendentId" /> 计划拥有单位ID<input type="hidden"
					id="p_ownDeptId" /> 计划拥有单位名称<input type="hidden"
					id="p_ownDeptName" /> 计划创建者ID<input type="hidden" id="p_ownerId" />
				计划审批者ID<input type="hidden" id="p_approverId" /> 上级计划主键<input
					type="hidden" id="p_parentId" /> 上级计划名称<input type="hidden"
					id="p_parentName" /> 责任部门ID<input type="hidden"
					id="p_superintendDeptId" /> 核实人ID<input type="hidden"
					id="p_verifierId" /> <input type="hidden" id="p_isAssigned" />
			</div>
			<table style="padding-top: 5px" id="planTable">
				<tr>
					<td style="text-align: right">编号</td>
					<td><input class="easyui-textbox" id="p_sn"
						style="width: 100px" data-options="required:true" /></td>
					<td style="text-align: right">计划名称</td>
					<td colspan="5"><input class="easyui-textbox" id="p_title"
						name="title" style="width: 418px" data-options="required:true" /></td>
				</tr>
				<tr>
					<td style="text-align: right">目标/要求</td>
					<td colspan="7"><input class="easyui-textbox"
						id="p_description" style="width: 575px"
						data-options="required:true,editable:false,
                            icons:[{
                                iconCls:'icon2 r17_c20',
                                handler: editDescription
                            }]" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right">重要程度</td>
					<td><input class="easyui-combobox" id="p_importance"
						name="importance" codeName="jhzycd" style="width: 100px"
						data-options="required:true,panelHeight:100" /></td>
					<td style="text-align: right">紧急程度</td>
					<td><input class="easyui-combobox" id="p_instancy"
						name="instancy" codeName="jhjjcd" style="width: 100px"
						data-options="required:true,panelHeight:100" /></td>
					<td style="text-align: right">状态</td>
					<td><input class="easyui-combobox" id="p_status" name="status"
						codeName="planStatus" style="width: 100px"
						data-options="required:true,readonly:true" /></td>
					<td style="text-align: right">进度</td>
					<td><div class="husky-progressbar" id="p_progress"
							name="progress" style="width: 100px" editable="false" /></td>
				</tr>

				</tr>
				<tr>
					<td style="text-align: right">责任人</td>
					<td><input class="easyui-textbox" id="p_superintendentName"
						style="width: 100px"
						data-options="required:true,editable:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectSuperintendent
                                    }]" /></td>
					<td style="text-align: right">执行人</td>
					<td><input class="easyui-textbox" id="p_ownerName"
						style="width: 100px"
						data-options="required:false,editable:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectOwner
                                    }]" /></td>

					<td style="text-align: right">协助人</td>
					<td><input class="easyui-textbox" id="p_coupler"
						style="width: 100px"
						data-options="required:false,editable:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectCoupler
                                    }]" />
					</td>
					<td style="text-align: right">权重</td>
					<td><input class="easyui-numberbox" id="p_weight"
						style="width: 100px" data-options="" /></td>
				</tr>
				<tr>
					<td style="text-align: right">责任部门</td>
					<td colspan="3"><input class="easyui-textbox"
						id="p_superintendDeptName" style="width: 258px"
						data-options="required:false,editable:false,
                                icons:[{
                                    iconCls:'icon-group',
                                    handler: selectSuperintendDept
                                }]" /></td>
					<td style="text-align: right">协助部门</td>
					<td colspan="3"><input class="easyui-textbox"
						id="p_coupleDept" style="width: 258px"
						data-options="required:false,editable:false,
                                icons:[{
                                    iconCls:'icon-group',
                                    handler: selectCoupleDept
                                }]" /></td>
				</tr>
				<tr>
					<td style="text-align: right">任务来源</td>
					<td><input class="easyui-combobox" id="p_level"
						style="width: 100px" codeName="planLevel"
						data-options="panelHeight:80" /></td>
					<td style="text-align: right">需要核实</td>
					<td><input class="easyui-combobox" id="p_needVerify"
						name="end" style="width: 100px" codeName="needVerify"
						data-options="readonly:false,panelHeight:60" /></td>
					<td style="text-align: right">核实人</td>
					<td><input class="easyui-textbox" id="p_verifierName"
						name="startAct" style="width: 100px"
						data-options="editable:false,readonly:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectVerifier
                                    }]" /></td>
				</tr>
				<tr>
					<td style="text-align: right">开始时间</td>
					<td><input class="easyui-datebox" id="p_start" name="start"
						style="width: 100px" /></td>
					<td style="text-align: right">结束时间</td>
					<td><input class="easyui-datebox" id="p_end" name="end"
						style="width: 100px" validType="laterThan['p_start']"
						invalidMessage="结束时间必须晚于开始时间" /></td>
					<td style="text-align: right">实际开始</td>
					<td><input class="easyui-datebox" id="p_startAct"
						name="startAct" style="width: 100px" data-options="readonly:true" /></td>
					<td style="text-align: right">实际结束</td>
					<td><input class="easyui-datebox" id="p_endAct" name="endAct"
						style="width: 100px" data-options="readonly:true" /></td>
				</tr>
				<tr>
					<td style="text-align: right">创建人</td>
					<td><input class="easyui-textbox" id="p_authorName"
						style="width: 100px" data-options="required:true,readonly:true" /></td>
					<td style="text-align: right">创建时间</td>
					<td><input class="easyui-datebox" id="p_createTime"
						name="createTime" style="width: 100px"
						data-options="required:true,readonly:true" /></td>
					<td style="text-align: right">审批人</td>
					<td><input class="easyui-textbox" id="p_approverName"
						name="approverId" style="width: 100px"
						data-options="editable:false,required:false,readonly:true,icons:[{
                                        iconCls:'icon-man',
                                        handler: selectApprover
                                    }]" /></td>
					<td style="text-align: right">审批时间</td>
					<td><input class="easyui-datebox" id="p_approveTime"
						style="width: 100px" data-options="readonly:true" /></td>
				</tr>
				<tr>
					<td style="text-align: right">质量自评</td>
					<td><input class="easyui-combobox" id="p_selfQualityEstimate"
						style="width: 100px" data-options="required:false,readonly:true"
						codeName="qualityEstimate" /></td>
					<td style="text-align: right">时效自评</td>
					<td><input class="easyui-combobox"
						id="p_selfEffectiveEstimate" style="width: 100px"
						data-options="readonly:true" codeName="effectiveEstimate" /></td>
					<td style="text-align: right">质量</td>
					<td><input class="easyui-combobox" id="p_qualityEstimate"
						style="width: 100px" data-options="required:false,readonly:true"
						codeName="qualityEstimate" /></td>
					<td style="text-align: right">时效</td>
					<td><input class="easyui-combobox" id="p_effectiveEstimate"
						style="width: 100px" data-options="required:false,readonly:true"
						codeName="effectiveEstimate" /></td>
				</tr>
				<tr>
					<td colspan="8" align="center"></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="attachmentPanel" class="easyui-panel" title="附件"
		data-options="collapsible:true,collapsed:true,iconCls:'icon2 r3_c13',tools:'#attachmentPanelTools'"
		style="width: 640px; height: 140px; padding: 10px">
		<%--<a href="#" id="btnAddAttachment" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a><br/>--%>
		<div id="attachmentContent"></div>
	</div>
	<div style="height: 8px;"></div>
	<div id="commentPanel" class="easyui-panel" title="评注/讨论"
		data-options="collapsible:true,iconCls:'icon2 r15_c11',tools:'#commentPanelTools'"
		style="width: 640px; height: 200px; padding: 10px">
		<div id="commentContent"></div>
	</div>
</div>

<div id="attachmentPanelTools">
	<a href="javascript:void(0)" class="icon-add"
		onclick="javascript:addAttachment();"></a>
</div>

<div id="commentPanelTools">
	<a href="javascript:void(0)" class="icon-add"
		onclick="javascript:addComment();"></a>
</div>

<div id="personSelectDialog" class="easyui-dialog" title="选择协助人"
	style="clear: both; width: 600px; height: 400px; padding: 5px;"
	data-options="iconCls:'icon-man',modal:true,closed:true,onBeforeClose:resetGrid3">
	<table id="grid3" class="easyui-treegrid"
		data-options="
                idField: 'id',
                treeField: 'name',
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                onDblClickRow:personTreeGridDblClickHandler,
                onLoadSuccess:btnPersonFilterHandler,
                toolbar:'#grid3Toolbar',
                method:'get'"
		style="height: 318px">
		<thead>
			<tr>
				<th data-options="field:'id',halign:'center',align:'left'"
					sortable="true" width="70">代码</th>
				<th data-options="field:'name',halign:'center',align:'left'"
					sortable="true" width="250">名称</th>
				<th data-options="field:'mobile',halign:'center',align:'right'"
					sortable="true" width="100">电话</th>
				<th data-options="field:'email',halign:'center',align:'right'"
					sortable="true" width="150">邮箱</th>
			</tr>
		</thead>
	</table>
</div>
<div id="grid3Toolbar">
	<input id="psd_filter" class="easyui-textbox" /> <a href="#"
		id="btnPersonFilter" class="easyui-linkbutton" iconCls="icon-filter"
		plain="true">过滤</a> <a href="#" id="btnPersonSelect"
		class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
</div>

<div id="deptSelectDialog" class="easyui-dialog" title="选择协助部门"
	style="clear: both; width: 600px; height: 400px; padding: 5px;"
	data-options="iconCls:'icon-group',modal:true,closed:true,onBeforeClose:resetGrid4">
	<table id="grid4" class="easyui-treegrid"
		data-options="
                idField: 'id',
                treeField: 'name',
                singleSelect:true,
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                onDblClickRow:deptTreeGridDblClickHandler,
                onLoadSuccess:btnDeptFilterHandler,
                toolbar:'#grid4Toolbar',
                method:'get'"
		style="height: 318px">
		<thead>
			<tr>
				<th data-options="field:'id',halign:'center',align:'left'"
					sortable="true" width="100">单位代码</th>
				<th data-options="field:'name',halign:'center',align:'left'"
					sortable="true" width="300">单位名称</th>
			</tr>
		</thead>
	</table>
</div>
<div id="grid4Toolbar">
	<input id="dsd_filter" class="easyui-textbox" /> <a href="#"
		id="btnDeptFilter" class="easyui-linkbutton" iconCls="icon-filter"
		plain="true">过滤</a> <a href="#" id="btnDeptSelect"
		class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
</div>

<div id="addAttachmentDialog" class="easyui-dialog" title="添加附件"
	style="clear: both; width: 470px; height: 180px;"
	data-options="iconCls:'icon-man',modal:true,closed:true">
	<div style="padding-left: 10px; padding-top: 10px;">
		<input type="radio" name="a_dispatch" value="1" checked="true" />只限本级
		<input type="radio" name="a_dispatch" value="2" />下发一级 <input
			type="radio" name="a_dispatch" value="3" />下级可见 <br /> <a href="#"
			id="btnUpload" class="easyui-linkbutton" iconCls="icon2 r1_c13"
			plain="true">文件</a> <input type="hidden" id="a_mongoId" /> <input
			class="easyui-textbox" data-options="" id="a_name" /> <a href="#"
			id="btnSaveAttachment" class="easyui-linkbutton" iconCls="icon-save"
			plain="true">保存</a>
	</div>
</div>

<div id="addCommentDialog" class="easyui-dialog" title="添加评注/讨论"
	style="clear: both; width: 570px; height: 380px;"
	data-options="iconCls:'icon-man',modal:true,closed:true">
	<div style="padding-left: 10px; padding-top: 10px;">
		<input type="radio" name="d_dispatch" value="1" checked="true" />只限本级
		<input type="radio" name="d_dispatch" value="2" />下发一级 <input
			type="radio" name="d_dispatch" value="3" />下级可见 <a href="#"
			id="btnSaveComment" class="easyui-linkbutton" iconCls="icon-save"
			plain="true">保存</a>
	</div>
	<div style="margin-left: 5px;">
		<input class="easyui-textbox" id="d_content"
			data-options="multiline:true" style="width: 540px; height: 310px" />
	</div>
</div>

<div id="displayDescription" class="easyui-dialog" title="目标要求"
	style="clear: both; width: 600px; height: 400px;"
	data-options="iconCls:'icon-man',modal:true,closed:true,maximizable:false,minimizable:false,collapsible:false">
	<div style="padding: 5px">
		<input class="easyui-textbox" id="d_description"
			data-options="multiline:true" style="width: 575px; height: 350px" />
	</div>
</div>

<div id="diaEstimate" class="easyui-dialog" title="评价"
	style="clear: both; width: 280px; height: 130px;"
	data-options="iconCls:'icon-man',modal:true,closed:true,maximizable:false,minimizable:false,collapsible:false">
	<div align="center" style="padding-top: 10px">
		<span>品质</span> <input type="radio" name="quality" value="4">优秀</input>
		<input type="radio" name="quality" value="3">良好</input> <input
			type="radio" name="quality" value="2" checked="true">合格</input> <input
			type="radio" name="quality" value="1">不合格</input>
	</div>
	<div align="center">
		<span>时效</span> <input type="radio" name="effective" value="4">优秀</input>
		<input type="radio" name="effective" value="3">良好</input> <input
			type="radio" name="effective" value="2" checked="true">合格</input> <input
			type="radio" name="effective" value="1">不合格</input>
	</div>
	<div align="center">
		<a href="#" id="btnSaveEstimate" class="easyui-linkbutton"
			iconCls="icon-ok" plain="true">确认</a> <a href="#"
			id="btnCancelEstimate" class="easyui-linkbutton"
			iconCls="icon2 r3_c10" plain="true">取消</a>
	</div>
</div>
