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
    <title>用户管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" >
    <link href="../js/jeasyui-extensions-release/jeasyui.extensions.min.css" rel="stylesheet" >

	<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>

    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./user1.js"></script>
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
	        border-color: #ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: #fff3f3;
	        background-image: none;
	    }
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="" >

    <div style="margin-bottom:3px;margin-top:5px;">
        <span style="margin-left:8px;margin-right:0px;">用户代码/姓名:</span>
        <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>


        <span style="margin-left:8px;margin-right:0px;">单位:</span>
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
           		offset: { width: -26, height: -55},
				ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
				url:'../common/query?mapper=userMapper&queryName=queryUser',
				toolbar: '#mainGridToolbar',
           		pageSize: 20, pagination: true"
           pagePosition ="bottom" >
        <thead>
        <tr>
            <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
            <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>
            <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称</th>
            <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
            <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
            <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                formatter="formatCodeList">状态</th><%--
            <th data-options="field:'orgType',halign:'center',align:'center'" sortable="true" width="70" codeName="orgType"
                formatter="formatCodeList">单位类型</th>
            --%>
            <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">上级</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <shiro:hasPermission name="user:create">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
        </shiro:hasPermission>
        <%--<a href="#" id="btnResetPass" class="easyui-linkbutton" iconCls="icon2 r10_c20" plain="true">重置密码</a>--%>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true">锁定/解锁</a>
        <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true" >打印</a>
        <a href="#" id="btnExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" >导出</a>
    </div>
</div>

<!-- --------弹出窗口--------------- -->
<!-- 
<div id="userWindow" class="easyui-window" title="用户信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    
</div>

<div id="organizationSelectDialog" class="easyui-dialog" title="选择单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <div>
            <a href="#" id="btnOrganizationSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
        </div>
        <ul id="orgTree" class="ztree"></ul>
    </div>
</div>

<div id="orgTypeSelectDialog" class="easyui-dialog" style="width:250px;height:130px"
     data-options="title:'请选择是否财政单位',toolbar:'#tb',modal:true">
    <div style=";padding:20px">
        <input type="radio" name="isFinancial" value="1"/>是
        <input type="radio" name="isFinancial" value="0" selected/>否
        <a href="#" id="btnOrgTypeSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确认</a>
    </div>
</div>

<div id="managerSelectDialog" class="easyui-dialog" title="选择上级"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
        <div>
            <a href="#" id="btnManagerSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
        </div>
        <table id="grid3"
            class="easyui-datagrid"
            data-options="
                singleSelect:true,
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                onClickRow:grid3ButtonHandler,
                method:'get'"
            style="height: 318px">
            <thead>
            <tr>
                <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
                <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
                <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
                <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
                <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">上级</th>
                <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                    formatter="formatCodeList">状态</th>
            </tr>
            </thead>
        </table>
</div>
 -->
</body>
</html>