<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};
</script>
<div id="planWindowb" style="padding: 5px;">
	<%-- <jsp:include page="../sys/iterationBar.jsp"/> --%> 
	<div id="tabPanelb" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandlerb">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="planTableb">
                <tr>
                    <td class="label">计划类型</td>
                    <td>
                        <input class="easyui-combobox" id="k_planType" style="width:200px;" 
                              codeName="planType" data-options="required:true,panelHeight:60" disabled/>
                    </td>
                    <td class="label">检查单位</td>
                    <td><input type="hidden" id="k_djjg"/>
                        <input class="easyui-validatebox add modify" id="k_djjgmc" data-options="required:true"
                               style="width:192px;" />
                    </td>
                </tr>
                <tr>
                    <td class="label">计划年度</td>
                    <td><input class="easyui-validatebox add" id="k_nd"
                               data-options="required:true,validType:'integer'" style="width:192px;"/>
                    </td>
                    <td class="label">计划编号</td>
                    <td><input type="hidden" id="k_id"/>
                        <input class="easyui-validatebox add" id="k_jhbh" data-options="required:true"
                               style="width:192px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划名称</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="k_jhmc" style="width:535px;"
                               data-options="required:true"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">抽查文号</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="k_cxwh" style="width:535px;"
                               data-options="required:true" disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="label">公示系统计划编号</td>
                    <td>
                        <input class="easyui-validatebox " id="k_gsjhbh" style="width:192px;"
                               data-options="required:true" disabled/>
                    </td>
                    
                </tr>
                <tr>
                    <td class="label">计划开始时间</td>
                    <td><input class="easyui-datebox add modify" id="k_ksrq" style="width:200px;"
                               data-options="required:true"/></td>
                    <td class="label">计划结束时间</td>
                    <td><input class="easyui-datebox add modify" id="k_yqwcsj" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td class="label">成立起始日</td>
                    <td><input class="easyui-datebox" id="k_clqsr" style="width:200px;"
                               data-options=""/></td>
                    <td class="label">成立终止日</td>
                    <td><input class="easyui-datebox" id="k_clzzr" style="width:200px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">检查分类</td>
                    <td>
                        <input class="easyui-combobox add modify" id="k_fl" style="width:200px;"
                               data-options="panelHeight:60,required:true" codeName="hcfl"/>
                    </td>
                    <td class="label">检查内容</td>
                    <td colspan="3">
                        <input id="k_nr" class="easyui-combobox add modify" codeName="hcnr"
                               data-options="panelHeight:80,width:200,required:true" style=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">任务数量</td>
                    <td>
                        <input class="easyui-validatebox" id="k_hcrwsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">已派发</td>
                    <td><input class="easyui-validatebox" id="k_ypfsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">已认领</td>
                    <td>
                        <input class="easyui-validatebox" id="k_yrlsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">未认领</td>
                    <td><input class="easyui-validatebox" id="k_wrlsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
	                <td class="label">下达日期</td>
	                <td><input class="easyui-datebox" id="k_xdrq" style="width:200px;"
	                               data-options=""/></td>
                    <td class="label">下达人</td>
                    <td><input type="hidden" id="k_xdr"/>
                        <input class="easyui-validatebox" id="k_xdrmc" style="width:192px;" data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">说明</td>
                    <td colspan="3"><input class="easyui-validatebox add modify" id="k_sm" style="width:535px;"
                                           data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3b"
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
	