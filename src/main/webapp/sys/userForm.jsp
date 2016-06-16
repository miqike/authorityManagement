<%@ page contentType="text/html; charset=UTF-8"%>
<script>
window.navigateBar = {
	grid: $('#mainGrid')
};
function grid4ButtonHandler() {
    var udpr = $('#grid4').datagrid('getSelected');
	if(udpr != null) {
		$('#btnEditDataPermission').linkbutton('enable');
        if(udpr.ACLTYPE != undefined && udpr.ACLTYPE != 0) {
            $('#btnShowAcl').linkbutton('enable');
        } else {
            $('#btnShowAcl').linkbutton('disable');
        }
	} else {
		$('#btnEditDataPermission').linkbutton('disable');
		$('#btnShowAcl').linkbutton('disable');
	}
}

function grid5ButtonHandler() {
    var rule = $('#grid5').datagrid('getSelected');
	if(rule != null && rule.isDefault != 1) {
		$('#btnDataPermRuleSelect').linkbutton('enable');
	} else {
		//$('#btnDataPermRuleSelect').linkbutton('disable');
	}
}

function formatDefaultFlag(val, row) {
    var _val = parseInt(val);
    if(_val == 1) {
        return "<img src='../images/star.png'/>";
    } else if(_val == 0) {
        return "<img src='../images/wrench_orange.png'/>";
    } else {
        return "";
    }
}

$(function() {
});
</script>
<!-- --------弹出窗口--------------- -->
<div id="userWindow">
    <div id="tabPanel" class="easyui-tabs" style="width:755px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="userTable">
                <tr>
                    <td class="label">单位编码</td>
                    <td><input class="easyui-validatebox" id="p_orgId" data-options="required:true,iconWidth: 20,
                        icons: [{
                            iconCls:'icon2 r22_c16',
                            handler: selectOrganization
                        }]" style="width:200px;"/></td>
                </tr>
                <tr>
                    <td class="label">单位名称</td>
                    <td colspan="3">
                        <input id="p_orgName" class="easyui-validatebox" style="width:577px;" data-options="required:true,disabled:true" />
                    </td>
                </tr>
                <tr>
                    <td class="label">用户代码</td>
                    <td><input class="easyui-validatebox add" id="p_userId" type="text"
                               data-options="required:true,disabled:true" style="width:200px;"/>
                    </td>
                    <td class="label">用户姓名</td>
                    <td><input class="easyui-validatebox add update" id="p_name" data-options="required:true" style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">电话</td>
                    <td>
                        <input class="easyui-validatebox add update" id="p_mobile" style="width:200px;" data-options=""/>
                    </td>
                    <td class="label">邮箱</td>
                    <td><input class="easyui-validatebox add update" validType="email" id="p_email" style="width:200px;" data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">状态</td>
                    <td>
                        <input id="p_status" class="easyui-combobox add update" style="width:206px;" data-options="required:true,panelHeight:80" codeName="userStatus"/>
                    </td>
                    <td class="label">排名</td>
                    <td>
                        <input id="p_weight" class="easyui-numberspinner add update" style="width:206px;" data-options="required:false" />
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
        </div> 
    </div>

    <div id="grid4Toolbar">
        <a href="#" id="btnEditDataPermission" class="easyui-linkbutton" iconCls="icon-save" plain="true" >保存</a>
        <a href="#" id="btnShowAcl" class="easyui-linkbutton" iconCls="icon2 r5_c16" plain="true" disabled="true">ACL</a>
    </div>
</div>
<%-- 
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
                    url:'../common/query?mapper=bi01Mapper&queryName=query'
                    "
                       style="height: 200px"
                       pageSize="20"
                       pagination="true">
                    <thead>
                    <tr>
                        <th data-options="field:'bi0101',halign:'center',align:'left'" sortable="true" width="70">编码</th>
                        <th data-options="field:'bi0111',halign:'center',align:'center'" sortable="true" width="200">票据名称</th>
                        <th data-options="field:'bi0201f',halign:'center',align:'center'" sortable="true" width="170" codeName="bi02Service.getCodeList" formatter="formatCodeList">类别名称</th>
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
