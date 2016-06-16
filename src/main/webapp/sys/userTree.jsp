<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户列表</title>

	<link href="../css/content.css" rel="stylesheet" />
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <!-- <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css"> -->
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<!-- 
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	 -->
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<!-- <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script> -->

	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js" ></script>

	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>

	<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
	<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
	
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/datagrid-filter.js"></script>
    <script type="text/javascript" src="../js/lodop/listPrint.js"></script>

    <script type="text/javascript" src="./userTree.js"></script>
	<style type="text/css">
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
		div #panel .datagrid-wrap{ border: 0px;}
		div #roleWindow .datagrid-wrap{ border-right: 0px;
			border-left: 0px;
			border-bottom: 0px;}

        #treePanel {
            width:300px;
            height: 500px;
            margin-left:5px;
            border-left-width:1px;
            border-right-width:1px;
            border-bottom-width:1px;
        }

        #treePanel panel-header {
            border-top-width:0px;
        }

        #treePanel>div.panel>div {
            border-left-width:0px;
            border-right-width:0px;
        }
        div.datagrid-wrap {
           border-left-width: 0px;
           border-right-width: 0px;
        }

        #userWindow div.datagrid-wrap {
           border-top-width: 0px;
           border-bottom-width: 0px;
        }

        #cc div.datagrid-wrap {
           border-top-width: 0px;
           border-bottom-width: 0px;
        }

    </style>

</head>
<body style="padding:1px;">
    <div class="easyui-layout" data-options="fit:true">
        <div id="treePanel" data-options="region:'west',collapsed:false,title:'',split:true,border:false">
            <div class="easyui-panel" title="单位列表" style="width:295px;height:145px;padding:5px;"
                 data-options="iconCls:'icon-search',collapsible:true,collapsed:true">
                <div id="p">
                    <span style="margin-left:5px;margin-right:0px;">编码</span>
                    <input id="q_ba0101" style="margin:0px 5px 5px 0px; width:100px;"/>
                    <br/>
                    <span style="margin-left:5px;margin-right:0px;">名称</span>
                    <input id="q_ba0111" style="margin:0px 5px 5px 0px; padding-right: 3px;width:100px;"/>
                    <br/>
                </div>
                <span style="margin-left:7px" ><input class="easyui-numberspinner" id="f_expandLevel" value="3" data-options="min:1,width:40,onChange:levelExpandTree" /></span>
                <a href="javascript:void(0);" id="btnSearch1" class="easyui-linkbutton" plain="true" iconCls="icon-search" style="margin-left:5px;">查找</a>
                <a href="javascript:void(0);" id="btnReset1" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
            </div>
            <div style="float:left;margin:0px 5px;solid: lightgray">
                <ul id='orgTree' class="ztree" style="height: 450px"></ul>
            </div>
        </div>
        <div data-options="region:'center'">
            <div style="margin-bottom:3px;margin-top:5px;">
                <span style="margin-left:8px;margin-right:0px;">用户代码/姓名:</span>
                <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
                <%--<span style="margin-left:8px;margin-right:0px;">单位:</span>
                <input id="f_organization" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>--%>
                <span style="width:300px;">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
                </span>
            </div>

            <table id="mainGrid"
                   class="easyui-datagrid"
                   data-options="onClickRow:mainGridButtonHandler,onLoadSuccess:mainGridLoadSuccessHandler,
                   offset: { width: -310, height: -40},
                   ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,method:'get'"
                   toolbar="#mainGridToolbar"
                   style="height: 600px"
                   pagination="false"
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
                        formatter="formatCodeList">状态</th>
                    <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">上级</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="mainGridToolbar">
                <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑/查看</a>
                <%--<a href="#" id="btnResetPass" class="easyui-linkbutton" iconCls="icon2 r10_c20" plain="true" disabled="true">重置密码</a>--%>
                <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
                <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">锁定/解锁</a>
                <!-- <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true" >打印</a> -->
                <a href="#" id="btnExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" >导出</a></div>

        </div>

    </div>

<!-- --------弹出窗口--------------- -->
<div id="userWindow" class="easyui-window" title="用户信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 780px; height: 440px; padding: 5px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    <div id="tabPanel" class="easyui-tabs" style="width:755px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">

            <table width="100%" id="userTable">
                <tr>
                    <td>
                        <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-save"  plain="true">保存</a>
                    </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>单位编码</td>
                    <td><input class="easyui-textbox" type="text" id="p_orgId" data-options="required:true,iconWidth: 20,onChange:validateOrg,
                        icons: [{
                            iconCls:'icon2 r22_c16',
                            handler: selectOrganization
                        }]" style="width:200px;"/></td>
                    <!-- <td>单位类型</td>
                    <td><input class="easyui-combobox" codeName="orgType" id="p_orgType" data-options="required:true" style="width:200px;"/>
                    </td> -->
                </tr>
                <tr>
                    <td>单位名称</td>
                    <td colspan="3">
                        <input id="p_orgName" class="easyui-textbox" style="width:557px;" data-options="required:true,disabled:true" />
                    </td>
                </tr>
                <tr>
                    <td>用户代码</td>
                    <td><input class="easyui-textbox" id="p_userId" type="text"
                               data-options="required:true,disabled:true" style="width:200px;"/>
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
                    <td>状态</td>
                    <td>
                        <input id="p_status" class="easyui-combobox" style="width:200px;" data-options="required:true" codeName="userStatus"/>
                    </td>
                    <td>排名</td>
                    <td>
                        <input id="p_weight" class="easyui-numberspinner" style="width:200px;" data-options="required:false" />
                    </td>
                </tr>
            </table>
        </div>
        <div title="所属角色" style="width:700px;">
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="
                       ctrlSelect:true,
                       collapsible:true"
                   toolbar="#grid2Toolbar"
                   style="height: 318px">
                <thead>
                <tr>
                    <%--<th data-options="field:'ck',checkbox:true,disabled:true"></th>--%>
                    <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th>
                    <th data-options="field:'role'" halign="center" align="left" width="100">角色代码</th>
                    <th data-options="field:'name'" halign="center" align="center" width="100">角色名称</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="roleStatus"
                        formatter="formatCodeList">状态</th>
                    <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
                </tr>
                </thead>
            </table>
        </div>
        <div id="grid2Toolbar">
            <%--<a href="#" id="btnEditOrSaveUserRole" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>--%>
            <a href="#" id="btnAddUserRole" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
            <a href="#" id="btnDeleteUserRole" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        </div>
        <div title="功能权限列表" style="width:700px;padding:5px;">
            <a href="#" id="btnExpandAll" class="easyui-linkbutton" iconCls="icon-plus" plain="true">展开</a>
            <a href="#" id="btnCollapseAll" class="easyui-linkbutton" iconCls="icon-minus" plain="true">缩回</a>
            <ul id="tree" class="ztree"></ul>
        </div>
        <!-- 
        <div title="数据权限" style="width:700px;">
            <table id="grid4"
                   class="easyui-datagrid"
                   data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       onClickRow:grid4ButtonHandler,
                       checkOnSelect:false"
                   toolbar="#grid4Toolbar"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'ISDEFAULT'" align="left" width="30" formatter="formatDefaultFlag"></th>
                    <th data-options="field:'DATAPERMID'" align="left" width="100">数据权限标识</th>
                    <th data-options="field:'DATAPERMDESC'" align="left" width="100">描述</th>
                    <th data-options="field:'DATAPERMRULEEXP'" align="left" width="150">规则表达式</th>
                    <th data-options="field:'ACLTYPE',halign:'center'" align="left" width="70" codeName="aclType" formatter="formatCodeList">ACL</th>
                    <th data-options="field:'DATAPERMRULEDESC',halign:'center',align:'left'" sortable="true" width="250">规则描述</th>
                    <th data-options="field:'ACL'" align="left" width="320">ACL列表</th>
                </tr>
                </thead>
            </table>
        </div> -->
    </div>

<!-- 
    <div id="grid4Toolbar">
        <a href="#" id="btnEditDataPermission" class="easyui-linkbutton" iconCls="icon-save" plain="true" >保存</a>
        <a href="#" id="btnShowAcl" class="easyui-linkbutton" iconCls="icon2 r5_c16" plain="true" disabled="true">ACL</a>
    </div> -->
</div>

<div id="dataPermRuleSelectDialog" class="easyui-dialog" title="选择数据权限规则"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div>
        <a href="#" id="btnDataPermRuleSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled="true">确定</a>
    </div>

    <table id="grid5"
           class="easyui-datagrid"
           data-options="
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       onClickRow:grid5ButtonHandler,
                       checkOnSelect:false"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'isDefault'" align="center" width="40" formatter="formatDefaultFlag1">缺省</th>
            <th data-options="field:'exp'" align="left" width="200">表达式</th>
            <th data-options="field:'aclType',halign:'center'" align="left" width="70" codeName="aclType" formatter="formatCodeList">ACL</th>
            <th data-options="field:'description'" align="left" width="300">描述</th>
        </tr>
        </thead>
    </table>
</div>

<div id="aclSelectDialog" class="easyui-dialog" title="用户访问控制列表"
     style="clear: both; width: 690px; height: 490px;padding:5px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">

    <div id="cc" class="easyui-layout" style="width:668px;height:442px;">
        <div data-options="region:'north',split:false,border:false" style="height:35px;padding-left:10px;">
            <a href="#" id="btnAclSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确认</a>
        </div>

        <div data-options="region:'center',title:'',split:true">
            <div id="aclTreeDiv">
                <ul id="aclTree" class="ztree"></ul>
            </div>
            <div id="bi01Div">
                <table id="grid6"
                       class="easyui-datagrid"
                       data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
                    method:'get',
                    <%--url:'../common/query?mapper=bi01Mapper&queryName=query'--%>
                    "
                       style="height: 200px"
                       pageSize="20"
                       pagination="true">
                    <thead>
                    <tr>
                        <th data-options="field:'bi0101',halign:'center',align:'left'" sortable="true" width="70">编码</th>
                        <th data-options="field:'bi0111',halign:'center',align:'center'" sortable="true" width="200">票据名称</th>
                        <%--<th data-options="field:'bi0201f',halign:'center',align:'center'" sortable="true" width="170" codeName="bi02Service.getCodeList" formatter="formatCodeList">类别名称</th>--%>
                        <th data-options="field:'bi0112c',halign:'center',align:'center'" sortable="true" width="100" codeName="debz" formatter="formatCodeList">定额标志</th>
                        <th data-options="field:'bi0114c',halign:'center',align:'center'" sortable="true" width="100" codeName="jxlx" formatter="formatCodeList">缴销类型</th>
                        <th data-options="field:'bi0125c',halign:'center',align:'center'" sortable="true" width="100" codeName="fmbz" formatter="formatCodeList">罚没标志</th>
                        <th data-options="field:'bi0127d',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">批准日期</th>
                        <th data-options="field:'startTime',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">启用日期</th>
                        <th data-options="field:'ceaseTime',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">停用日期</th>
                        <th data-options="field:'bi0143c',halign:'center',align:'center'" sortable="true" width="70" codeName="qyzt" formatter="formatCodeList">状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div data-options="region:'east',title:'',split:false" style="width:245px;">
            <table id="grid7"
                   class="easyui-datagrid"
                   data-options="singleSelect:true,collapsible:true,height:398,onDblClickRow:grid7DblClickHandler"
                   pagination="false">
                <thead>
                <tr>
                    <th data-options="field:'acl',halign:'center',align:'left'" sortable="true" width="90">编码</th>
                    <th data-options="field:'literal',halign:'center',align:'left'" sortable="true" width="130">名称</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- 选择单位弹出层 -->
<div id="organizationSelectDialog" class="easyui-dialog" title="选择单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <div>
            <a href="#" id="btnOrganizationSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled="true">确定</a>
        </div>
        <ul id="orgTreeSelect" class="ztree"></ul>
    </div>
</div>


<div id="roleSelectDialog" class="easyui-dialog" title="选择角色"
     style="clear: both; width: 700px; height: 500px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <table id="grid8"
           class="easyui-datagrid"
           data-options="collapsible:true,ctrlSelect:true,
				method:'get'"
           toolbar="#grid8Toolbar"
           style="height: 500px"
           pagination="false">
        <thead>
        <tr>
            <th data-options="field:'role',halign:'center',align:'center'" sortable="true" width="100">角色代码</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="100">角色名称</th>
            <th data-options="field:'description',halign:'center',align:'left'" sortable="true" width="350">描述</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                formatter="formatCodeList">状态</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="grid8Toolbar">
        <a href="#" id="btnAddUserRole1" class="easyui-linkbutton" iconCls="icon-add" plain="true">确定</a>
    </div>
</div>
 --%>

</body>
</html>