<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};
</script>
<div id="planWindow" style="padding: 5px;">
	<%-- <jsp:include page="../sys/iterationBar.jsp"/> --%> 
	<div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="planTable">
                <tr>
                    <td colspan="3">
                        <!-- <a href="javascript:void(0);" id="btnSavePlan" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a> -->
                        <a href="javascript:void(0);" id="btnImportPlan" class="easyui-linkbutton add"
                           iconCls="icon2 r13_c16" plain="true">导入任务信息</a>
                        <a href="javascript:void(0);" id="btnImportTask" class="easyui-linkbutton"
                           iconCls="icon2 r10_c1" plain="true" disabled>导入任务</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="label">计划年度</td>
                    <td><input class="easyui-validatebox add" id="p_nd"
                               data-options="required:true,validType:'integer'" style="width:192px;"/>
                    </td>
                    <td class="label">计划编号</td>
                    <td><input type="hidden" id="p_id"/>
                        <input class="easyui-validatebox add" id="p_jhbh" data-options="required:true"
                               style="width:192px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划名称</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="p_jhmc" style="width:535px;"
                               data-options="required:true"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">抽查文号</td>
                    <td colspan="3">
                        <input class="easyui-validatebox" id="p_cxwh" style="width:535px;"
                               data-options="required:true" disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="label">公示系统计划编号</td>
                    <td>
                        <input class="easyui-validatebox " id="p_gsjhbh" style="width:192px;"
                               data-options="required:true" disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划开始时间</td>
                    <td><input class="easyui-datebox add modify" id="p_ksrq" style="width:200px;"
                               data-options="required:true"/></td>
                    <td class="label">计划结束时间</td>
                    <td><input class="easyui-datebox add modify" id="p_yqwcsj" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td class="label">成立起始日</td>
                    <td><input class="easyui-datebox add modify" id="p_clqsr" style="width:200px;"
                               data-options="required:true"/></td>
                    <td class="label">成立终止日</td>
                    <td><input class="easyui-datebox add modify" id="p_clzzr" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td class="label">检查分类</td>
                    <td>
                        <input class="easyui-combobox add modify" id="p_fl" style="width:200px;"
                               data-options="panelHeight:60,required:true" codeName="hcfl"/>
                    </td>
                    <td class="label">检查内容</td>
                    <td colspan="3">
                        <input id="p_nr" class="easyui-combobox add modify" codeName="hcnr"
                               data-options="panelHeight:80,width:200,required:true" style=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">任务数量</td>
                    <td>
                        <input class="easyui-validatebox" id="p_hcrwsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">已派发</td>
                    <td><input class="easyui-validatebox" id="p_ypfsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">已认领</td>
                    <td>
                        <input class="easyui-validatebox" id="p_yrlsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">未认领</td>
                    <td><input class="easyui-validatebox" id="p_wrlsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <!-- 
                <tr>
                    <td class="label">审核状态</td>
                    <td>
                        <input class="easyui-combobox" id="p_shzt" style="width:200px;" data-options=""
                               codeName="shzt"/>
                    </td>
                    <td class="label">审核人</td>
                    <td><input class="easyui-validatebox" validType="email" id="p_shr" style="width:192px;"
                               data-options=""/></td>
                </tr> -->
                <tr>
	                <td class="label">下达日期</td>
	                <td><input class="easyui-datebox" id="p_xdrq" style="width:200px;"
	                               data-options=""/></td>
                    <td class="label">下达人</td>
                    <td>
                        <input class="easyui-validatebox" id="p_xdrmc" style="width:192px;" data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">说明</td>
                    <td colspan="3"><input class="easyui-validatebox add modify" id="p_sm" style="width:535px;"
                                           data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3"
                   class="easyui-datagrid"
                   data-options="
                   		method:'get',
                   		pageSize: 100, pagination: true,
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'id'" halign="center" align="center" width="100" formatter="formatZfry">
                        执法人员
                    </th>
                    <th data-options="field:'hcdwXydm',halign:'center',align:'left'" sortable="true" width="200">
                        统一社会信用代码
                    </th>
                    <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="300">单位名称
                    </th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
	