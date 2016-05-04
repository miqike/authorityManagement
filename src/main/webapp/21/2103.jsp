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
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
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
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="">

    <div style="margin-bottom:3px;margin-top:5px;">
        <span style="margin-left:8px;margin-right:0px;">代码/名称:</span>
        <input id="s_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>

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
           		width: 400,height:300,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
				toolbar: '#mainGridToolbar',
           		pageSize: 20, pagination: true"
           pagePosition="bottom">
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">事项编码</th>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="100">事项名称</th>
            <th data-options="field:'type',halign:'center',align:'left'" sortable="true" width="150">事项类型</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="260">事项描述</th>
            <th data-options="field:'material',halign:'center',align:'left'" sortable="true" width="260">检查材料</th>
            <th data-options="field:'method',halign:'center',align:'left'" sortable="true" width="260">检查方法</th>
            <th data-options="field:'handle',halign:'center',align:'left'" sortable="true" width="260">结果处理</th>
        </tr>
        </thead>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印</a>
        <a href="#" id="btnExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true">导出</a>
    </div>
</div>
<%-- </shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission> --%>
<!-- --------弹出窗口--------------- -->

<div id="detailWindow" class="easyui-window" title="抽检事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous" plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>
    <div>
        <table width="100%" id="detailTable">
            <tr>
                <td>
                    <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"
                       plain="true">保存</a>
                </td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td>事项编码</td>
                <td><input class="easyui-textbox" id="p_id" type="text" data-options="required:true"
                           style="width:200px;"/></td>
                <td>事项名称</td>
                <td><input class="easyui-textbox" type="text" id="p_name" data-options="required:true"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td>事项描述</td>
                <td><input class="easyui-textbox" id="p_desc" type="text" style="width:200px;" data-options=""/></td>
                <td>检查材料</td>
                <td><input class="easyui-textbox" id="p_material" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
            <tr>
                <td>检查方法</td>
                <td><input class="easyui-textbox" id="p_method" type="text" style="width:200px;"
                           data-options=""/></td>
                <td>结果处理</td>
                <td><input class="easyui-textbox" id="p_handle" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
            <tr>
                <td>事项类型</td>
                <td><input class="easyui-combobox" id="p_type" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
        </table>
    </div>

</div>

</body>
</html>