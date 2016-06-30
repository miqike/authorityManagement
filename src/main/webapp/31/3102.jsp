<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>计划任务进度管理</title>
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <style>
        td.label {
            text-align: right
        }

        #layout > div.layout-panel-west > div.panel-header {
            border-width: 1px 1px 1px 0px;
        }

        #layout > div.layout-panel-west > div.panel-body {
            border-width: 0px 1px 0px 0px;
        }

        #layout > div.layout-panel-center > div.panel-body {
            border-width: 0px;
        }

        #layout > div.layout-panel-center div.datagrid-wrap {
            border-width: 1px 0px 0px 0px;
        }
	   .validatebox-text {
	        border-width: 1px;
	        border-style: solid;
	        line-height: 17px;
	        padding-top: 1px;
	        padding-left: 3px;
	        padding-bottom: 2px;
	        padding-right: 3px;
	        background-attachment: scroll;
	        background-size: auto;
	        background-origin: padding-box;
	        background-clip: border-box;
	    }
	
	    .validatebox-invalid {
	        border-color: ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: fff3f3;
	        background-image: url("");
	    }
    </style>
</head>
<body style="margin:5px;">
<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',split:false,height:270" title=""  >
	    <div style="padding: 5px 10px 0px 10px">
	        <table id="queryTable">
	            <tr>
	                <td class="label">计划年度</td>
	                <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/>
	                </td>
	                <td class="label">计划编号</td>
	                <td><input id="f_jhbh" class="easyui-validatebox"/></td>
	                <td class="label">公示系统计划编号</td>
	                <td><input id="f_gsjhbh" class="easyui-validatebox"/></td>
	            </tr>
	            <tr>
	                <td class="label">计划名称</td>
	                <td><input id="f_jhmc" class="easyui-validatebox"/></td>
	                <td class="label">检查内容</td>
	                <td><input id="f_nr" class="easyui-combobox" codeName="hcnr"
	                           data-options="panelHeight:80,width:143,onChange:loadGrid1" style=""/></td>
	                <td class="label">检查分类</td>
	                <td><input id="f_fl" class="easyui-combobox" codeName="hcfl"
	                           data-options="panelHeight:60,width:143,onChange:loadGrid1" style=""/></td>
	                <td colspan="2" style="text-align-right;">
	                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
	                       iconCls="icon-search">查找</a>
	                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
	                       iconCls="icon2 r3_c10">重置</a>
	                </td>
	            </tr>
	        </table>
	    </div>
	    <div>
		<!-- onUnselect:disableUpdateAndDeleteButton" -->
			<table id="grid1"
				class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,height:200,
					onClickRow:grid1ClickHandler,pagination: false,
					url:'../common/query?mapper=hcjhMapper&queryName=query',
					method:'get'"
				   toolbar="#gridToolbar1"
				   style="height: 250px"
				   sortOrder="asc">
				<thead>
				<tr>
					<th data-options="field:'nd'" halign="center" align="center" sortable="true" width="50">年度</th>
	                <th data-options="field:'jhbh'" halign="center" align="left" sortable="true" width="70">计划编号</th>
	                <th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示计划编号</th>
	                <th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="130">计划名称</th>
					<th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">下达日期</th>
					 <th data-options="field:'ksrq'" halign="center" align="center" sortable="true" width="80"
	                    formatter="formatDate">计划开始时间
	                </th>
					<th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">计划结束时间</th>
					<th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl" formatter="formatCodeList">检查分类</th>
					<th data-options="field:'nr'" halign="center" align="left" sortable="true" width="150" codeName="hcnr"
	                    formatter="formatCodeList">检查内容</th>
					<th data-options="field:'hcrwsl'" halign="center" align="left" sortable="true" width="60" >任务数量</th>
					<!-- <th data-options="field:'ypfsl'" halign="center" align="left" sortable="true" width="60" >已派发</th> -->
					<th data-options="field:'yrlsl'" halign="center" align="left" sortable="true" width="60" >已认领</th>
					<th data-options="field:'wrlsl'" halign="center" align="left" sortable="true" width="60" >未认领</th>
					<!-- <th data-options="field:'jhshr'" halign="center" align="left" sortable="true" width="90" >审核人</th> -->
					<th data-options="field:'xdrmc'" halign="center" align="left" sortable="true" width="90" >下达人</th>
					<th data-options="field:'sm'" halign="center" align="left" sortable="true" width="250" >说明</th>
				</tr>
				</thead>
			</table>
			<div id="gridToolbar1">
				<a href="#" id="btnViewCheckList" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" data-options="disabled:true">检查事项</a>
			</div>
		</div>
	</div>
	
	<!-- <div id="layout" class="easyui-layout" data-options="fit:true"> -->
	<div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
		<ul id="orgTree" class="ztree"></ul>
	</div>
	<div data-options="region:'center'">
				<!-- onUnselect:disableUpdateAndDeleteButton" -->
		<table id="grid2"
			class="easyui-datagrid"
			data-options="singleSelect:false,collapsible:true,pageSize: 10, pagination: true,fit:true,
				method:'get'"
			   toolbar="#planGridToolbar"
			   style="height: 285px"
			   sortOrder="asc">
			<thead>
			<tr>
				<!-- <th data-options="field:'id'" halign="center" align="left" sortable="true" width="30">序号</th> -->
				<th data-options="field:'hcjgmc'" halign="center" align="left" width="250">检查机关</th>
				<th data-options="field:'zfryName'" halign="center" align="left" width="70">检查人员</th>
				<th data-options="field:'hcrws'" halign="center" align="left" width="60">检查任务数</th>
				<th data-options="field:'rls'" halign="center" align="left" width="60">认领数</th>
				<th data-options="field:'wcs'" halign="center" align="left" width="60">已完成数</th>
				<th data-options="field:'zlz'" halign="center" align="left" width="80">责令中</th>
				<th data-options="field:'wwcs'" halign="center" align="left" width="80">未完成数</th>
				
			</tr>
			</thead>
		</table>
		<div id="planGridToolbar">
			<!-- <a href="#" id="btnViewDetail" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:true">详细</a> -->
		</div>
	</div>
</div>
</body>
</html>

<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.orgTree.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="./3102.js" ></script>