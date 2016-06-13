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
                        <a href="javascript:void(0);" id="btnImportTask" class="easyui-linkbutton"
                           iconCls="icon2 r10_c1" plain="true" disabled>导入任务信息</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="label">计划年度</td>
                    <td><input class="easyui-numberspinner add" id="p_nd" type="text"
                               data-options="required:true,min:2016" style="width:200px;"/>
                    </td>
                    <td class="label">计划编号</td>
                    <td><input type="hidden" id="p_id"/>
                        <input class="easyui-validatebox add" type="text" id="p_jhbh" data-options="required:true"
                               style="width:192px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划名称</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="p_jhmc" type="text" style="width:535px;"
                               data-options="required:true"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">公示系统计划编号</td>
                    <td>
                        <input class="easyui-validatebox add" id="p_gsjhbh" type="text" style="width:192px;"
                               data-options="required:true"/>
                    </td>
                    <td class="label">要求完成时间</td>
                    <td><input class="easyui-datebox add modify" type="text" id="p_yqwcsj" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td class="label">检查分类</td>
                    <td>
                        <input class="easyui-combobox add modify" id="p_fl" type="text" style="width:200px;"
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
                        <input class="easyui-validatebox" id="p_hcrwsl" type="text" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">已派发</td>
                    <td><input class="easyui-validatebox" id="p_ypfsl" type="text" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">已认领</td>
                    <td>
                        <input class="easyui-validatebox" id="p_yrlsl" type="text" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">未认领</td>
                    <td><input class="easyui-validatebox" id="p_wrlsl" type="text" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <!-- 
                <tr>
                    <td class="label">审核状态</td>
                    <td>
                        <input class="easyui-combobox" id="p_shzt" type="text" style="width:200px;" data-options=""
                               codeName="shzt"/>
                    </td>
                    <td class="label">审核人</td>
                    <td><input class="easyui-validatebox" validType="email" id="p_shr" type="text" style="width:192px;"
                               data-options=""/></td>
                </tr> -->
                <tr>
	                <td class="label">下达日期</td>
	                <td><input class="easyui-datebox add moddify" id="p_xdrq" type="text" style="width:200px;"
	                               data-options="required:true"/></td>
                    <td class="label">下达人</td>
                    <td>
                        <input class="easyui-validatebox" id="p_xdrmc" type="text" style="width:192px;" data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">说明</td>
                    <td colspan="3"><input class="easyui-validatebox add modify" id="p_sm" type="text" style="width:535px;"
                                           data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3"
                   class="easyui-datagrid"
                   data-options="
                   		method:'get',
                   		pageSize: 10, pagination: true,
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
	