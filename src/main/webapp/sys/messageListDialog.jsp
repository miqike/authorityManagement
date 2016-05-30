<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function doInit() {
	$("#inboxGrid").datagrid({"url": "./message/"});
}
	
function formatSender(val, row) {
	if(row.senderName != null) {
		return val + "/" + row.senderName;
	} else {
		return val;
	}
}

function formatMessageTitle(val, row) {
	var array = val.split(":")
	if(array[0]=="TODO") {
		return "待办任务:<a href=\"javascript: showForm(this, " + array[1] + ", '" + row._id + "');\">" + array[2] + "</a>";
	} else {
		return val;
	}
}

function formatMessageStatus(val, row) {
	if(val==0) {
		return "<span style='color:red'>未读</span>";
	} else {
		return "<span style='color:green'>已读</span>";
	}
}
</script>
<div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" >
    <div title="收件箱" style="padding:5px;" selected="true">
    	<input type="radio" name="messageStatus" value="all" checked style="margin-bottom: 8px;">全部</input>
    	<input type="radio" name="messageStatus" value="readed" >已读</input>
    	<input type="radio" name="messageStatus" value="unread" >未读</input>
    	
        <table id="inboxGrid"
               class="easyui-datagrid"
               data-options="
                   singleSelect:true,
                   collapsible:true,
                   selectOnCheck:false,
                   checkOnSelect:false,
                   method:'get',
                   pageSize:20,
       			   pagination:true,
               	   toolbar: '#inboxGridToolbar'"
               style="height: 318px">
            <thead>
            <tr>
                <th data-options="field:'sender'" halign="center" align="center" width="100" formatter="formatSender">发件人</th>
                <th data-options="field:'title'" halign="center" align="center" width="200" formatter="formatMessageTitle">标题</th>
                <th data-options="field:'operateTime'" halign="center" align="center" width="120" formatter="formatDatetime2Min">发件时间</th>
                <th data-options="field:'state'" halign="center" align="center" width="40" formatter="formatMessageStatus">状态</th>
            </tr>
            </thead>
        </table>
        <div id="inboxGridToolbar">
			<a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true">回复</a>
			<a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">已读</a>
			<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">收藏</a>
			<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">删除</a>
		</div>
    </div>
    <div title="发件箱" style="width:700px;">
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
                <th data-options="field:'description'" halign="center" align="left" width="400">描述</th>
            </tr>
            </thead>
        </table>
    </div>
    <div title="草稿箱" style="width:700px;padding:5px;">
    </div>
    <div title="收藏夹" style="width:700px;padding:5px;">
    </div>

    <div title="联系人">
        <a href="#" id="btnEditOrSaveUserRole" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
    </div>
</div>
