<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function doInit(operation) {
	$.codeListLoader.parse($("#baseInfo"));
	if(operation == "edit") {
    	$.easyuiExtendObj.loadForm("baseInfo", $("#mainGrid").datagrid("getSelected"));
	} else {
		var hcsx =  $("#mainGrid").datagrid("getSelected");
	}
}

function docGridClickRowHandler() {
	if($('#docGrid').datagrid('getSelected') != null) {
		$('#btnRemoveDoc').linkbutton('enable');
	} else {
		$('#btnRemoveDoc').linkbutton('disable');
	}
}

</script>
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
                <td class="label">用户代码</td>
                <td><input class="easyui-validatebox" id="p_userId" type="text"
                           data-options="required:true" style="width:200px;"/>
                </td>
                <td class="label">用户姓名</td>
                <td><input class="easyui-validatebox" type="text" id="p_name" data-options="required:true" style="width:200px;"/>
                </td>
            </tr>
            <tr>
                <td class="label">电话</td>
                <td>
                    <input class="easyui-validatebox" id="p_mobile" type="text" style="width:200px;" data-options=""/>
                </td>
                <td class="label">邮箱</td>
                <td><input class="easyui-validatebox" validType="email" id="p_email" type="text" style="width:200px;" data-options=""/></td>
            </tr>
            <tr>
                <td class="label">单位编码</td>
                <td><input class="easyui-validatebox" type="text" id="p_orgId" data-options="required:true,iconWidth: 20,
						icons: [{
							iconCls:'icon2 r22_c16',
							handler: selectOrganization
						}]" style="width:200px;"/></td>
            </tr>
            <tr>
                <td class="label">单位名称</td>
                <td colspan="3">
                    <input id="p_orgName" class="easyui-validatebox" style="width:557px;" data-options="required:true" />
                </td>
            </tr>
            <tr>
                <td class="label">上级</td>
                <td>
                    <input id="p_managerId" class="easyui-validatebox" style="width:70px;" data-options="disabled:true" />
                    <input class="easyui-validatebox" type="text" id="p_managerName" data-options="disabled:true,iconWidth: 20,
						icons: [{
							iconCls:'icon2 r25_c9',
							handler: selectManager
						}]" style="width:125px;"/></td>
                <td class="label">状态</td>
                <td>
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