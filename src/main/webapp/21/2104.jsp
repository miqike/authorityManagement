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
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.jss"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./2104.js"></script>
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
           		width: 400,height:400,
           		offset: { width: 0, height: 0},
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
<%-- </shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission> --%>
<!-- --------弹出窗口--------------- -->

<div id="userWindow" class="easyui-window" title="用户信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">

            <table width="100%" id="userTable">
                <tr>
                    <td>
                        <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"  plain="true">保存</a>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>用户代码</td>
                    <td><input class="easyui-textbox" id="p_userId" type="text"
                               data-options="required:true" style="width:200px;"/>
                    </td>
                    <td>用户姓名</td>
                    <td><input class="easyui-textbox" type="text" id="p_name" data-options="required:true" style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td>电话</td>
                    <td>
                        <input class="easyui-textbox" id="p_mobile" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>邮箱</td>
                    <td><input class="easyui-textbox" validType="email" id="p_email" type="text" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td>单位编码</td>
                    <td><input class="easyui-textbox" type="text" id="p_orgId" data-options="required:true,iconWidth: 20,
										icons: [{
											iconCls:'icon2 r22_c16',
											handler: selectOrganization
										}]" style="width:200px;"/></td>
                    <%--<td>单位类型</td>
                    <td>
                        <input id="p_orgType" class="easyui-combobox" codeName="orgType" style="width:200px;" data-options="required:true" />
                    </td>--%>
                </tr>
                <tr>
                    <td>单位名称</td>
                    <td colspan="3">
                        <input id="p_orgName" class="easyui-textbox" style="width:557px;" data-options="required:true" />
                    </td>
                </tr>
                <tr>
                    <%--<td>上级</td>
                    <td>
                        <input id="p_managerId" class="easyui-textbox" style="width:70px;" data-options="disabled:true" />
                        <input class="easyui-textbox" type="text" id="p_managerName" data-options="disabled:true,iconWidth: 20,
										icons: [{
											iconCls:'icon2 r25_c9',
											handler: selectManager
										}]" style="width:125px;"/></td>--%>
                    <td>状态</td>
                    <td>
                        <!-- <select class="codelist" id="p_gender" codeName="gender" ></select> -->
                        <input id="p_status" class="easyui-combobox" style="width:200px;" data-options="required:true" codeName="userStatus"/>
                    </td>
                </tr>


            </table>
        </div>
        <div title="所属角色" style="width:700px;">
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   toolbar="#grid2Toolbar"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true,disabled:true"></th>
                    <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th>
                    <th data-options="field:'name'" halign="center" align="center" width="100">角色名</th>
                    <th data-options="field:'role'" halign="center" align="left" width="100">标识</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="roleStatus"
                        formatter="formatCodeList">状态</th>
                    <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
                </tr>
                </thead>
            </table>
        </div>
        <div title="功能权限列表" style="width:700px;padding:5px;">
            <ul id="tree" class="ztree"></ul>
        </div>

        <div id="grid2Toolbar">
            <a href="#" id="btnEditOrSaveUserRole" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
        </div>
    </div>
</div>

<!-- 选择单位弹出层 -->
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
    <!--<div style=" display: inline-block; position: relative;padding:5px 10px">-->
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
    <!--</div>-->
</div>

</body>
</html>