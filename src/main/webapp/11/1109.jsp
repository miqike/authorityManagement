<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String privilegeName = "sysOrganization";//定义权限名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>公示时限设置</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/metro/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>

    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/myJs/common.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.function.ztree.js"></script>
    <script type="text/javascript" src="../js/myJs/formatter.js"></script>

    <script type="text/javascript" src="1109.js"></script>

</head>
<body>
<%--<shiro:hasPermission name="<%=privilegeName%>">--%>
<div class="easyui-layout" style="height:600px;">
    <table id="mainGrid"
           class="easyui-datagrid"
           toolbar="#mainGridToolbar"
           style="height: 500px"
           data-options="method: 'get'"
           pagination="false"
           pagePosition="bottom">
        <thead>
        <tr>
            <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
            <th data-options="field:'code',halign:'center',align:'left'" sortable="true" width="70">项目编码</th>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="260">项目名称</th>
            <th data-options="field:'type',halign:'center',align:'center'" sortable="true" width="70">类型</th>
            <th data-options="field:'wcsx',halign:'center',align:'right'" sortable="true" width="100">完成时限</th>
            <th data-options="field:'descript',halign:'center',align:'center'" sortable="true" width="70">说明</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
           disabled="true">编辑/查看</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true"
           disabled="true">删除</a>
    </div>
</div>
</div>
<%--
</shiro:hasPermission>
<shiro:lacksPermission name="<%=privilegeName%>">
    <div>没有权限或者权限配置异常</div>
</shiro:lacksPermission>
--%>

<!-- --------弹出窗口--------------- -->

<div id="baseWindow" class="easyui-window" title="公示时限信息"
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
    <div id="baseInfo" title="基本信息" style="padding:5px;" selected="true">

        <div style="display: none">
            <input class="easyui-textbox" id="p_id" type="text" style="width:200px;"/>
            <input class="easyui-textbox" id="p_name" type="text" data-options="required:true" style="width:200px;"/>
        </div>
        <table width="100%" id="baseTable">

            <tr>
                <td>
                    <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" iconCls="icon-save"
                       plain="true">保存</a>
                </td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td>项目名称</td>
                <td><input class="easyui-combobox" type="text" id="p_code" data-options="required:true"
                           style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td>类型</td>
                <td>
                    <input class="easyui-textbox" id="p_type" type="text" style="width:200px;" data-options=""/>
                </td>
                <td>完成时限</td>
                <td><input class="easyui-textbox" id="p_wcsx" type="text" style="width:200px;"
                           data-options=""/></td>
            </tr>
            <tr>
                <td>说明</td>
                <td colspan="3"><input class="easyui-textbox" type="text" id="p_descript" data-options=""
                                       style="width:500px;"/></td>
            </tr>
        </table>
    </div>
</div>

</body>
</html>
