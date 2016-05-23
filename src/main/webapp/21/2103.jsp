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

    <div style="padding: 5px 10px 0px 10px">
        <table id="queryTable">
            <tr>
                <td>检查类型</td>
                <td><input id="f_businessKey" class="easyui-textbox"/></td>
                <td>检查信息分类</td>
                <td><input id="f_errorNo" class="easyui-textbox"/></td>
                <td>公示项目</td>
                <td><input id="f_module" class="easyui-textbox"/></td>
                <td colspan="2" style="text-align-right;">
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
				ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
				toolbar: '#mainGridToolbar',
           		pageSize: 20, pagination: true"
           pagePosition="bottom">
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">企业组织形式</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">检查类型</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">检查信息分类</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">项目编码</th>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="100">抽检事项</th>
            <th data-options="field:'material',halign:'center',align:'left'" sortable="true" width="260">对应公示项目</th>
            <th data-options="field:'method',halign:'center',align:'left'" sortable="true" width="260">检查方法说明</th>
            <th data-options="field:'handle',halign:'center',align:'left'" sortable="true" width="260">结果处理</th>
            <th data-options="field:'type',halign:'center',align:'left'" sortable="true" width="150">登记信息和公示信息比对</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">比对信息来源</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">是否需要实地核查</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">是否人工核对</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">改正期限</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">是否必检项</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">注销日期</th>
            <th data-options="field:'desc',halign:'center',align:'left'" sortable="true" width="100">注销说明</th>
        </tr>
        </thead>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="#" id="btnDrop" class="easyui-linkbutton" iconCls="icon-print" plain="true">注销/取消注销</a>
        <a href="#" id="btnList" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true">检查材料清单</a>
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
        <a href="javascript:void(0);" id="btnPre1" class="easyui-linkbutton" iconCls="icon-previous"
           plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext1" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst1" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast1" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose1" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>
    <div>
        <table width="100%" id="baseTable">
            <tr>
                <td>
                    <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"
                       plain="true">保存</a>
                </td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td>企业组织形式</td>
                <td><input class="easyui-textbox" id="p_id" type="text" data-options="required:true"
                           style="width:200px;"/></td>
                <td>检查类型</td>
                <td><input class="easyui-textbox" type="text" id="p_name" data-options="required:true"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td>检查信息分类</td>
                <td><input class="easyui-textbox" id="p_desc" type="text" style="width:200px;" data-options=""/></td>
                <td>项目编码</td>
                <td><input class="easyui-textbox" id="p_material" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
            <tr>
                <td>抽检事项</td>
                <td><input class="easyui-textbox" id="p_method" type="text" style="width:200px;"
                           data-options=""/></td>
                <td>对应公示项目</td>
                <td><input class="easyui-textbox" id="p_handle" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
        </table>
    </div>

</div>
<div id="detailWindow1" class="easyui-window" title="抽检材料清单"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd2" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre2" class="easyui-linkbutton" iconCls="icon-previous"
           plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext2" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst2" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast2" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete2" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose2" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>
    <div>
        <table id="detailTable1"
               class="easyui-datagrid"
               data-options="collapsible:true,onClickRow:mainGridButtonHandler,
           		width: 400,height:300,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
				toolbar: '',
           		pageSize: 20, pagination: true"
               pagePosition="bottom">
            <thead>
            <tr>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">序号</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">材料名称</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">是否必要项</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">文件类型</th>
            </tr>
            </thead>
        </table>
    </div>

</div>

</body>
</html>