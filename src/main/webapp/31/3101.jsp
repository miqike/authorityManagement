<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>计划任务分配</title>
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link href="../css/content.css" rel="stylesheet"/>
	<style>
		
		td.label{text-align: right}
		
		#layout>div.layout-panel-west>div.panel-header {
			border-width: 1px 1px 1px 0px;
		}

		#layout>div.layout-panel-west>div.panel-body {
			border-width: 0px 1px 0px 0px;
		}

		#layout>div.layout-panel-center>div.panel-body {
			border-width: 0px;
		}

		#layout>div.layout-panel-center div.datagrid-wrap {
			border-width: 1px 0px 0px 0px;
		}
	</style>
</head>
<body style="margin:5px;">
<div id="panel" class="easyui-panel" title="" style="overflow: hidden;height:600px;">
	<div style="padding: 5px 10px 0px 10px">
		<table id="queryTable">
			<tr>
				<td class="label">计划年度</td>
				<td><input id="p_recallLimits" class="easyui-numberspinner" data-options="min:2000,max:2017"/>
				</td>
				<td class="label">计划编号</td>
				<td><input id="f_errorNo" class="easyui-textbox"/></td>
				<td class="label">公示系统计划编号</td>
				<td><input id="f_operator" class="easyui-textbox"/></td>
			</tr>
			<tr>
				<td class="label">计划名称</td>
				<td><input id="f_module" class="easyui-textbox"/></td>
				<td class="label">核查内容</td>
				<td><input id="f_deptName" class="easyui-combobox" codeName="hcnr"
					data-options="panelHeight:80,width:143,onChange:queryPlan" style="" /></td>
				<td class="label">核查分类</td>
				<td><input id="f_deptName" class="easyui-combobox" codeName="hcfl" 
					data-options="panelHeight:60,width:143,onChange:queryPlan" style="" /></td>
				<td colspan="2" style="text-align-right;">
					<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
					<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
				</td>
			</tr>
		</table>
	</div>
	<div>
<!-- 				onUnselect:disableUpdateAndDeleteButton" -->
		<table id="grid1"
			class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,
				onClickRow:grid1clickHandler,
				method:'get',url:'../common/query?mapper=hcjhMapper&queryName=query',
				onSelect:showPlanDetail"
			   toolbar="#gridToolbar1"
			   style="height: 250px"
			   sortOrder="asc">
			<thead>
			<tr>
				<th data-options="field:'nd'" halign="center" align="left" sortable="true" width="50">计划年度</th>
				<th data-options="field:'id'" halign="center" align="left" sortable="true" width="70">计划编号</th>
				<th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示系统计划编号</th>
				<th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="130" >计划名称</th>
				<th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">下达日期</th>
				<th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">要求完成时间</th>
				<th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl" formatter="formatCodeList">核查分类</th>
				<th data-options="field:'nr'" halign="center" align="left" sortable="true" width="150" >核查内容</th>
				<th data-options="field:'hcrwsl'" halign="center" align="left" sortable="true" width="60" >任务数量</th>
				<th data-options="field:'ypfsl'" halign="center" align="left" sortable="true" width="60" >已派发</th>
				<th data-options="field:'yrlsl'" halign="center" align="left" sortable="true" width="60" >已认领</th>
				<th data-options="field:'wrlsl'" halign="center" align="left" sortable="true" width="60" >未认领</th>
				<th data-options="field:'shzt'" halign="center" align="left" sortable="true" width="90" codeName="shzt" formatter="formatCodeList">审核状态</th>
				<th data-options="field:'shrmc'" halign="center" align="left" sortable="true" width="90" >审核人</th>
				<th data-options="field:'xdrmc'" halign="center" align="left" sortable="true" width="90" >下达人</th>
				<th data-options="field:'sm'" halign="center" align="left" sortable="true" width="250" >说明</th>
			</tr>
			</thead>
		</table>
		<div id="gridToolbar1">
			<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
			<a href="#" id="btnModify" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-options="disabled:true">修改</a>
			<a href="#" id="btnAudit" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" data-options="disabled:true">审核/取消审核</a>
			<a href="#" id="btnViewCheckList" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" data-options="disabled:true">核查事项</a>
		</div>
	</div>
	
	<div id="layout" class="easyui-layout" data-options="fit:true">
		<!-- <div data-options="region:'west',title:'单位列表',onCollapse:collapseHandler,onExpand:expandHandler" style="width:200px">
			<div style="float:left;margin:0px 5px;border: 1px solid lightgray;">
                <ul id='orgTree' class="ztree" ></ul>
			</div>
		</div> -->
		<div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
			<ul id="orgTree" class="ztree"></ul>
		</div>
		<div data-options="region:'center'">
					<!-- onUnselect:disableUpdateAndDeleteButton" -->
			<table id="grid2"
				class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,
					method:'get',
					onSelect:showPlanDetail"
				   toolbar="#planGridToolbar"
				   style="height: 250px"
				   sortOrder="asc">
				<thead>
				<tr>
					<th data-options="field:'id'" halign="center" align="left" sortable="true" width="30">序号</th>
					<th data-options="field:'hcjgmc'" halign="center" align="left" sortable="true" width="150">检查机关</th>
					<th data-options="field:'djjgmc'" halign="center" align="left" sortable="true" width="150">登记机关</th>
					<th data-options="field:'hcdwXydm'" halign="center" align="left" sortable="true" width="150">统一社会信用代码</th>
					<th data-options="field:'hcdwName'" halign="center" align="left" sortable="true" width="150">企业名称</th>
					<th data-options="field:'ztlx'" halign="center" align="left" sortable="true" width="80" codeName="jhlb" formatter="formatCodeList">市场主体类型</th>
					<th data-options="field:'zzxs'" halign="center" align="left" sortable="true" width="80" codeName="jhlb" formatter="formatCodeList">组织形式</th>
					<th data-options="field:'qymc'" halign="center" align="left" sortable="true" width="100">区域</th>
					<th data-options="field:'zfryCode1'" halign="center" align="left" sortable="true" width="70">检查人员</th>
					<th data-options="field:'rlrmc'" halign="center" align="left" sortable="true" width="70">计划认领人</th>
					<th data-options="field:'rlrq'" halign="center" align="left" sortable="true" width="70" formatter="formatDate">认领日期</th>
					<th data-options="field:'rwzt'" halign="center" align="left" sortable="true" width="70" codeName="jhlb" formatter="formatCodeList">计划完成状态</th>
					<th data-options="field:'sjwcrq'" halign="center" align="left" sortable="true" width="70" formatter="formatDate">实际完成日期</th>
					
					
				</tr>
				</thead>
			</table>
			<div id="planGridToolbar">
				<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true" data-options="disabled:true">按检查机关+检查人员排序</a>
				<a href="#" id="btnUpdate" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true" data-options="disabled:true">按市场主体类型+检查机关排序</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">派发/取消派发</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">认领/取消认领</a>
				<a href="#" id="btnDelete1" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">详细</a>
			</div>
		</div>

	</div>
</div>


<!-- --------弹出窗口--------------- -->
<div id="planWindow" class="easyui-window" title="核查计划信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    <!-- <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler"> -->
    <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="planTable">
                <tr>
                    <td colspan="3">
                        <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"  plain="true">保存</a>
                        <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"  plain="true" disabled>导入任务信息</a>
                    </td>
                    <td ></td>
                </tr>
                <tr>
                    <td>计划年度</td>
                    <td><input class="easyui-textbox" id="p_nd" type="text"
                               data-options="required:true" style="width:200px;"/>
                    </td>
                    <td>计划编号</td>
                    <td><input class="easyui-textbox" type="text" id="p_id" data-options="required:true" style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td>公示系统计划编号</td>
                    <td>
                        <input class="easyui-textbox" id="p_gsjhbh" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>下达日期</td>
                    <td><input class="easyui-datebox" id="p_xdrq" type="text" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td>要求完成时间</td>
                    <td><input class="easyui-datebox" type="text" id="p_yqwcsj" data-options="" style="width:200px;"/></td>
                    <td>核查分类</td>
                    <td>
                        <input class="easyui-combobox" id="p_fl" type="text" style="width:200px;" data-options="" codeName="hcfl"/>
                    </td>
                </tr>
                <tr>
                    <td>核查内容</td>
                    <td colspan="3">
                        <input id="p_nr" class="easyui-textbox" style="width:557px;" data-options="required:true" />
                    </td>
                </tr>
                <tr>
                    <td>任务数量</td>
                    <td>
                        <input class="easyui-textbox" id="p_hcrwsl" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>已派发</td>
                    <td><input class="easyui-textbox" validType="email" id="p_ypfsl" type="text" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td>已认领</td>
                    <td>
                        <input class="easyui-textbox" id="p_yrlsl" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>未认领</td>
                    <td><input class="easyui-textbox" validType="email" id="p_wrlsl" type="text" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td>审核状态</td>
                    <td>
                        <input class="easyui-combobox" id="p_shzt" type="text" style="width:200px;" data-options="" codeName="shzt"/>
                    </td>
                    <td>审核人</td>
                    <td><input class="easyui-textbox" validType="email" id="p_shr" type="text" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td>下达人</td>
                    <td>
                        <input class="easyui-textbox" id="p_xdrmc" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>说明</td>
                    <td><input class="easyui-textbox" id="p_sm" type="text" style="width:200px;" data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'id'" halign="center" align="center" width="100" formatter="formatZfry">执法人员</th>
                    <th data-options="field:'hcdwXydm',halign:'center',align:'left'" sortable="true" width="100">统一社会信用代码</th>
		            <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="100">单位名称</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
	
	
<div id="checklistWindow" class="easyui-window" title="核查事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    
    <table id="grid2"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               selectOnCheck:false,
               checkOnSelect:false"
           toolbar="#grid2Toolbar"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'ck',checkbox:true,disabled:true"></th>
            <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th>
            <th data-options="field:'name'" halign="center" align="center" width="100">角色名</th>
            <th data-options="field:'role'" halign="center" align="left" width="100">标识</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="roleStatus"
                formatter="formatCodeList">状态</th>
            <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
        </tr>
        </thead>
    </table>
</div>	
	
</body>
</html>
   <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    
	<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
<!--     
 --> 
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="./3101.js" ></script>