<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>资源管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link href="../css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.extend.js"></script>

    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="res.js"></script>

    <style type="text/css">
        #tabPanel .tabs-panels{border: 0px}
        #tabPanel .tabs-header{border: 0px}
        div .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px; border-top: 0px}
    </style>
</head>
<body style="margin: 5px;">
<%--<shiro:hasPermission name="roleRes">--%>
<div class="easyui-layout" style="height:560px;">
    <div data-options="region:'west',split:false" title="资源管理" style="width:300px;padding:10px 5px 5px 20px">
        <ul id="tree" class="ztree"></ul>
    </div>
    <div data-options="region:'center'" style="overflow: hidden;">
        <div id="tabPanel" class="easyui-tabs" style="clear:both;" data-options="onSelect:tabSelectHandler" >
            <div title="基本信息" style="padding:5px;" selected="true">
                <form action="" id="treeNodeForm" method="post">
                    <a href="#" id="btnAddSibling" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加本级</a>
                    <a href="#" id="btnAddChild" class="easyui-linkbutton" iconCls="icon-add" plain="true" disabled="true">添加下级</a>
                    <a href="#" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑</a>
                    <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  disabled="true">删除</a>
                    <table style="padding-top:5px">
                        <tr>
                            <td style="text-align:right">资源编码</td>
                            <td><input class="easyui-textbox" id="f_id" name="id" style="width:300px;" data-options="require:true,disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">资源名称</td>
                            <td><input class="easyui-textbox" id="f_name" name="name" style="width:300px;" data-options="require:true,disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">标识</td>
                            <td><input class="easyui-textbox" id="f_identity" name="identity" style="width:300px;" data-options="disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">URL</td>
                            <td><input class="easyui-textbox" id="f_url" name="url" style="width:300px;" data-options="disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">排序</td>
                            <td><input class="easyui-textbox" id="f_weight" name="weight" style="width:300px;" data-options="disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">图标</td>
                            <td><input class="easyui-textbox" id="f_icon" name="icon" style="width:300px;" data-options="disabled:true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align:right">父节点</td>
                            <td><input class="easyui-textbox" id="f_parentId" name="parentId" style="width:100px;" data-options="disabled:true"/>
                                <input class="easyui-textbox" id="f_parentName" style="width:195px;" data-options="disabled:true"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right">路径</td>
                            <td><input class="easyui-textbox" id="f_parentIds" name="parentIds" style="width:300px;" data-options="disabled:true"/></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div title="关联角色"  >
                <table id="roleGrid"
                       class="easyui-datagrid"
                       data-options="singleSelect:true,
					   selectOnCheck:false,
                       checkOnSelect:false,
					   collapsible:true,onClickRow:roleGridButtonHandler,method:'get'"
                       toolbar="#roleGridToolbar"
                       style="height: 500px"
                       pageSize="20"
                       pagination="true">
                    <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true,disabled:true"></th>
                        <th data-options="field:'role',halign:'center',align:'center'" sortable="true" width="100">角色</th>
                        <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="100">角色名</th>
                        <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="roleStatus"
                            formatter="formatCodeList">状态</th>
                        <th data-options="field:'description',halign:'center',align:'left'" sortable="true" width="350">描述</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <div id="roleGridToolbar">
                    <a href="#" id="btnEditOrSaveResourceRole" class="easyui-linkbutton" iconCls="icon-edit" plain="true" >编辑</a>
                </div>
            </div>
            <div title="关联用户">
                <table id="userGrid"
                       class="easyui-datagrid"
                       data-options="singleSelect:true,collapsible:true,method:'get'"
                       style="height: 500px"
                       pageSize="20"
                       pagination="true">
                    <thead>
                    <tr>
                        <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户名</th>
                        <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">姓名</th>
                        <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
                        <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
                        <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>
                        <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="150">单位名称</th>
                        <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">上级</th>
                        <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                            formatter="formatCodeList">状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%--</shiro:hasPermission>
<shiro:lacksPermission name="roleRes">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission>--%>
</body>
</html>
