<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <title>计划核查</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<!-- 	
	<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
 --> 
 
 	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=2a0e3002d891662913ceb7d47fb9c188"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./5101.js"></script>
    <style>
        body {
            margin:0;
            padding:0;
            font:13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background:#ffffff;
        }
        div .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}
        div#tabPanel .datagrid-wrap{ border-top: 0px;}
        td.label {text-align:right;}
    </style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="" style="overflow: hidden;height:600px;">

	<div style="padding: 5px 10px 0px 10px">
		<table id="queryTable">
			<tr>
				<td class="label">计划年度</td>
				<td><input id="f_nd" class="easyui-numberspinner" data-options="min:2016"/></td>
				<td class="label">计划编号</td>
				<td><input id="f_hcjhId" class="easyui-textbox"/></td>
				<td class="label">计划名称</td>
				<td><input id="f_jhmc" class="easyui-textbox"/></td>
				<td colspan="2" style="text-align-right;">
					<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
					<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="layout" class="easyui-layout" data-options="fit:true">
		
		<div data-options="region:'west',split:true" title="我的核查任务" style="width:300px;">
			<table id="grid1"
		           class="easyui-datagrid"
		           data-options="collapsible:true,onClickRow:grid1ClickHandler,
		           		offset: { width: 0, height: 0},
		           		singleSelect:true,
						ctrlSelect:false,method:'get',
		           		pageSize: 20, pagination: true"
		           pagePosition ="bottom" >
		        <thead>
		        <tr>
		            <th data-options="field:'hcdwXydm',halign:'center',align:'left'" sortable="true" width="110">统一社会信用代码</th>
		            <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="170">单位名称</th>
		        </tr>
		        </thead>
		        <tbody>
		        </tbody>
		    </table>
		</div>
		<div data-options="region:'center'">
			<div style="margin: 5px">
				<table >
					<tr>
						<td class="label">计划编号</td><td><input id="p_id" class="easyui-textbox" readonly="readonly" data-options="width:100"/></td>
						<td class="label" style="padding-left:10px;">计划名称</td><td><input id="p_jhmc" class="easyui-textbox" readonly="readonly"/></td>
						<td class="label" style="padding-left:10px;">下达时间</td><td><input id="p_jhxdrq" class="easyui-datebox" readonly="readonly" data-options="width:100"/></td>
						<td class="label" style="padding-left:10px;">要求完成时间</td><td><input id="p_jhyqwcsj" class="easyui-datebox" readonly="readonly" data-options="width:100"/></td>
						<td class="label" style="padding-left:10px;">核查结果确认</td><td><input id="p_hcjieguo" class="easyui-combobox" readonly="readonly" data-options="width:100"/></td>
					</tr>
					<tr>
						<td colspan="8" style="text-align-right;">
							<a href="javascript:void(0);" id="btnSendHcgzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r10_c20" disabled>实地核查告知书</a>
							<a href="javascript:void(0);" id="btnSendZllxtzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r16_c20" disabled>责令履行通知书</a>
							<a href="javascript:void(0);" id="btnSendQyzshch" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c11" disabled>企业住所核查函</a>
							<a href="javascript:void(0);" id="btnPullData" class="easyui-linkbutton" plain="true" iconCls="icon2 r14_c3" disabled>加载在线数据</a>
							<!-- <a href="javascript:void(0);" id="btnReport" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10" disabled>核查结果上报/取消上报</a> -->
						</td>
					</tr>
				</table>
			</div>
		    <table id="mainGrid"
		           class="easyui-datagrid"
		           data-options="collapsible:true,onClickRow:mainGridButtonHandler,
		           		offset: { width: 0, height: 0},
						ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
						toolbar: '#mainGridToolbar'"
		           pagePosition ="bottom" >
		        <thead>
		        <tr>
		            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">核查事项</th>
		            <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs"
		                formatter="formatCodeList">核查方式</th>
		            <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
		            <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
		            <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt"
		                formatter="formatCodeList"  styler="stylerHczt">核查状态</th>
		            <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">核查结果</th>
		            <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
		        </tr>
		        </thead>
		        <tbody>
		        </tbody>
		    </table>
		    <div id="mainGridToolbar">
		        <a href="#" id="btnViewDocument" class="easyui-linkbutton" iconCls="icon2 r17_c1" plain="true" disabled>核查材料</a>
		        <a href="#" id="btnAudit" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" disabled>核查/查看</a>
		    </div>
		</div>
	</div>
	
</div>

<!-- --------弹出窗口--------------- -->
<div id="auditWindow"  title="核查"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 420px; padding: 10px;">
	<div id="auditContent" style="padding:10px;"></div>
	<div id="auditLog" style="margin-top:5px;"></div>
</div>

<div id="documentWindow" title="核查材料"
     data-options="modal:true,closed:true,iconCls:'icon2 r16_c14'"
     style="width: 750px; height: 400px; padding: 10px;">
	<div id="docPanel" style="padding:10px;"></div>
</div>


</body>
</html>