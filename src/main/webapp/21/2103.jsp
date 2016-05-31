<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>抽检事项清单管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <!-- 
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    -->
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script> 
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="./2103.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        div .datagrid-wrap {
            border-right: 0px;
            border-left: 0px;
            border-bottom: 0px
        }
        
        td.label {text-align:right;}
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="">

    <div style="padding: 5px 10px 0px 10px">
        <table id="queryTable">
            <tr>
                <td>核查类型</td>
                <td><input id="f_businessKey" class="easyui-combobox" codeName="hclx" data-options="panelHeight:60"/>
                </td>
                <td>核查信息分类</td>
                <td><input id="f_errorNo" class="easyui-combobox" codeName="hcxxfl" data-options="panelHeight:60"/></td>
                <td>公示项目</td>
                <td><input id="f_module" class="easyui-textbox"/></td>
                <td colspan="2" style="text-align:right">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                       iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                       iconCls="icon2 r3_c10">重置</a>
                </td>
            </tr>
        </table>
    </div>
    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,onClickRow:mainGridButtonHandler,
           		width: 400,height:300,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get',
				toolbar: '#mainGridToolbar',
				method: 'get',
           		pageSize: 20, pagination: true"
           pagePosition="bottom">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">名称</th>
            <th data-options="field:'hclx',halign:'center',align:'left'" sortable="true" width="90" codeName="hclx"
                formatter="formatCodeList">类型
            </th>
            <th data-options="field:'descript',halign:'center',align:'left'" sortable="true" width="150">描述</th>
            <th data-options="field:'hccl',halign:'center',align:'left'" sortable="true" width="70">核查材料</th>
            <th data-options="field:'hcff',halign:'center',align:'left'" sortable="true" width="70" codeName="hcfs"
                formatter="formatCodeList">核查方法
            </th>
            <th data-options="field:'hcxxfl',halign:'center',align:'left'" sortable="true" width="90" codeName="hcxxfl"
                formatter="formatCodeList">核查信息分类
            </th>
            <th data-options="field:'qyzzxs',halign:'center',align:'left'" sortable="true" width="100" codeName="qyzzxs"
                formatter="formatCodeList">企业组织形式
            </th>
            <th data-options="field:'gsxm',halign:'center',align:'left'" sortable="true" width="70">对应公示项目</th>
            <th data-options="field:'hcffsm',halign:'center',align:'left'" sortable="true" width="70">核查方法说明</th>
            <th data-options="field:'jgcl',halign:'center',align:'left'" sortable="true" width="70" codeName="gsjg"
                formatter="formatCodeList">结果处理
            </th>
            <th data-options="field:'xxdb',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">登记信息和公示信息比对
            </th>
            <th data-options="field:'dbxxly',halign:'center',align:'left'" sortable="true" width="70">比对信息来源</th>
            <th data-options="field:'sfxysdhc',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否需要实地核查
            </th>
            <th data-options="field:'sfxyrghd',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否需要人工核对
            </th>
            <th data-options="field:'gzqx',halign:'center',align:'left'" sortable="true" width="70">改正期限</th>
            <th data-options="field:'sfbjxm',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否必检项
            </th>
            <th data-options="field:'zxrq',halign:'center',align:'left'" sortable="true" width="70"
                formatter="formatDate">注销日期
            </th>
            <th data-options="field:'zxsm',halign:'center',align:'left'" sortable="true" width="70">注销说明</th>
        </tr>
        </thead>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled>编辑</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
        <a href="#" id="btnDrop" class="easyui-linkbutton" iconCls="icon-print" plain="true" disabled>注销/取消注销</a>
        <a href="#" id="btnShowDocWindow" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" disabled>核查材料清单</a>
    </div>
</div>
<!-- --------弹出窗口--------------- -->
<div id="baseWindow" class="easyui-window" title="抽检事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
     <div id="basePanel"
</div>

<div id="docWindow" class="easyui-window" title="抽检材料清单"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
	<div id="docPanel"></div>
</div>

</body>
</html>