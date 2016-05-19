<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>市场主体管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
<!--     
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
 --> 
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./2101.js"></script>
    <style>
        body {
            margin:0;
            padding:0;
            font:13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background:#ffffff;
        }

        div .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}

        div#tabPanel .datagrid-wrap{ border-top: 0px;}
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="" style="overflow: hidden;height:600px;">
	<div id="layout" class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',title:'单位列表',onCollapse:collapseHandler,onExpand:expandHandler" style="width:200px">
			<div style="float:left;margin:0px 5px;border: 1px solid lightgray;">
                <ul id='orgTree' class="ztree" ></ul>
			</div>
		</div>
		<div data-options="region:'center'">
		    <div style="margin-bottom:3px;margin-top:5px;">
		        <span style="margin-left:8px;margin-right:0px;">注册号:</span>
		        <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
		        <span style="margin-left:8px;margin-right:0px;">名称:</span>
		        <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
		        <span style="margin-left:8px;margin-right:0px;">法人:</span>
		        <input id="f_organization" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
		
		        <span style="width:300px;">
					<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
		               iconCls="icon-search">查找</a>
					<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
		               iconCls="icon2 r3_c10">重置</a>
					</span>
		    </div>
		
		    <table id="mainGrid"
		           class="easyui-datagrid"
		           data-options="collapsible:true,onClickRow:mainGridButtonHandler,
		           		offset: { width: 0, height: 0},
						ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
						toolbar: '#mainGridToolbar',
		           		pageSize: 20, pagination: true"
		           pagePosition ="bottom" >
		        <thead>
		        <tr>
		            <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
		            <th data-options="field:'zch',halign:'center',align:'left'" sortable="true" width="70">注册号</th>
		            <th data-options="field:'mc',halign:'center',align:'left'" sortable="true" width="260">名称</th>
		            <th data-options="field:'lx',halign:'center',align:'center'" sortable="true" width="70">类型</th>
		            <th data-options="field:'fr',halign:'center',align:'center'" sortable="true" width="70">法人</th>
		            <th data-options="field:'clrq',halign:'center',align:'right'" sortable="true" width="100">成立日期</th>
		            <th data-options="field:'zczb',halign:'center',align:'right'" sortable="true" width="150">注册资本</th>
		            <th data-options="field:'djjgmc',halign:'center',align:'right'" sortable="true" width="150">登记机关</th>
		            <th data-options="field:'djzt',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
		                formatter="formatCodeList">登记状态</th>
		        </tr>
		        </thead>
		        <tbody>
		        </tbody>
		    </table>
		    <div id="mainGridToolbar">
		        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
		        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
		        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		        <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true" >打印</a>
		        <a href="#" id="btnExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" >导出</a>
		    </div>
		</div>
	</div>
	
</div>
<!-- --------弹出窗口--------------- -->

</body>
</html>