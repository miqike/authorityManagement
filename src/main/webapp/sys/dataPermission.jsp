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
    <title>数据级权限管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.extend.depreciated.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./dataPermission.js"></script>
    <style>
        div .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}

        div#tabPanel .datagrid-wrap{ border-top: 0px;}
    </style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="" >
    <div style="margin-bottom:3px;margin-top:5px;">
        <span style="margin-left:8px;margin-right:0px;">标识:</span>
        <input id="f_id" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
        <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
               iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
               iconCls="icon2 r3_c10">重置</a>
			</span>
    </div>

    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
				method:'get',
				url:'../common/query?mapper=dataPermissionMapper&queryName=query'"
           toolbar="#mainGridToolbar"
           style="height: 500px"
           pageSize="100"
           pagination="true"
           pagePosition ="bottom" >
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="120">标识</th>
            <th data-options="field:'description',halign:'center',align:'left'" sortable="true" width="200">描述</th>
            <th data-options="field:'tableName',halign:'center',align:'left'" sortable="true" width="150">表名</th>
            <th data-options="field:'mapper',halign:'center',align:'left'" sortable="true" width="170">Mapper</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑/查看</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
    </div>
</div>

<!-- --------弹出窗口--------------- -->
<div id="popWindow" class="easyui-window" title="数据权限信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 5px;">
    <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="mainTable">
                <tr>
                    <td>
                        <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-edit"  plain="true">编辑</a>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>标识</td>
                    <td><input class="easyui-textbox" id="p_id" type="text"
                               data-options="required:true,disabled:true" style="width:200px;"/>
                    </td>
                    <td>描述</td>
                    <td><input class="easyui-textbox" id="p_description" data-options="required:true,disabled:true" style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td>表名</td>
                    <td>
                        <input class="easyui-textbox" id="p_tableName" style="width:200px;" data-options="disabled:true"/>
                    </td>
                    <td>Mapper</td>
                    <td><input class="easyui-textbox" id="p_mapper" style="width:200px;" data-options="disabled:true"/></td>
                </tr>
            </table>
        </div>
        <div title="关联规则" style="width:700px;">
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       onClickRow:grid2ButtonHandler,
                       checkOnSelect:false"
                   toolbar="#grid2Toolbar"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'isDefault',halign:'center'" align="center" width="40" formatter="formatDefaultFlag"></th>
                    <%--<th data-options="field:'id'" align="center" width="40">标识</th>--%>
                    <th data-options="field:'exp',halign:'center'" align="left" width="200">表达式</th>
                    <th data-options="field:'aclType',halign:'center'" align="left" width="70" codeName="aclType" formatter="formatCodeList">ACL</th>
                    <th data-options="field:'description',halign:'center'" align="left" width="300">描述</th>
                </tr>
                </thead>
            </table>
        </div>
      <div id="grid2Toolbar">
            <a href="#" id="btnAddDataPermissionRule" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
            <a href="#" id="btnEditDataPermissionRule" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>
            <a href="#" id="btnDeleteDataPermissionRule" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
            <a href="#" id="btnSetDefaultDataPermissionRule" class="easyui-linkbutton" iconCls="icon2 r3_c14" plain="true" disabled="true">设为缺省</a>
        </div>
    </div>
</div>

<div id="popWindow2" class="easyui-window" title="数据权限规则"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 550px; height: 300px; padding: 10px;">
    <table width="100%" id="popTable2">
        <tr>
            <td colspan="2">
                <a href="javascript:void(0);" id="btnEditOrSave2" class="easyui-linkbutton" iconCls="icon-edit"  plain="true">编辑</a>
                <input type="hidden" id="k_id" />
                <input type="hidden" id="k_isDefault" />
            </td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td>权限标识</td>
            <td><input class="easyui-textbox" id="k_dataPermId" type="text"
                       data-options="required:true,disabled:true" style="width:180px;"/>
            </td>
            <td>ACL</td>
            <td><input class="easyui-combobox" id="k_aclType" style="width:183px;" data-options="disabled:true" codeName="aclType"/></td>

        </tr>
        <tr>
            <td>表达式</td>
            <td colspan="3">
                <input class="easyui-textbox" id="k_exp" data-options="disabled:true,width:427"/>
            </td>
        </tr>
        <tr>
            <td>描述</td>
            <td colspan="3"><input class="easyui-textbox" id="k_description" data-options="required:true,disabled:true,width:427"/>
            </td>
        </tr>
    </table>

</div>


</body>
</html>