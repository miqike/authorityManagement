<%@ page contentType="text/html; charset=UTF-8"%>

<script>
function doMessageListDialogInit() {
	$("input:radio[name='messageStatusFilter']").change(function() {
		loadInboxGrid();
	});
}

function loadInboxGrid() {
	var messageStatusFilter = $("input:radio[name='messageStatusFilter']:checked").val();
	var param;
	if (messageStatusFilter == 'all') {
		param = null;
	} else if (messageStatusFilter == 'readed') {
		param = { state: 1};
	} else {
		param = { state: 0};
	}
    $.getJSON("./message/", param, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	$("#inboxGrid").datagrid("loadData", response);
        }
    });
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
function formatMessageContent(val, row) {
	if(val != undefined || val == true) {
		return "<span style='color:orange;cursor:pointer;text-decoration:underline' onclick='javascript:showMessageContent(\"" + row.sendId + "\");'>详细...</span>";
	} else {
		return "";
	}
}

function showMessageContent(sendId) {
	$.getJSON("./message/" + sendId, null, function (response) {
        if (response.status == $.husky.SUCCESS) {
        	if(response.status == $.husky.SUCCESS) {
	        	$.messager.alert("详细内容", response.data.content);
        	}
        }
    });
}


</script>
<div id="messageTab" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:messageTabSelectHandler">
    <div title="收件箱" style="padding:5px;" selected="true" iconCls="icon2 r10_c9">
    	<input type="radio" name="messageStatusFilter" value="all" checked style="margin-bottom: 8px;">全部</input>
    	<input type="radio" name="messageStatusFilter" value="readed" >已读</input>
    	<input type="radio" name="messageStatusFilter" value="unread" >未读</input>
    	
        <table id="inboxGrid"
               class="easyui-datagrid"
               data-options="
                   singleSelect:false,
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
                <th data-options="field:'title'" halign="center" align="center" width="360" formatter="formatMessageTitle">标题</th>
                <th data-options="field:'operateTime'" halign="center" align="center" width="120" formatter="formatDatetime2Min">发件时间</th>
                <th data-options="field:'state'" halign="center" align="center" width="40" formatter="formatMessageStatus">状态</th>
                <th data-options="field:'hasContent'" halign="center" align="center" width="60" formatter="formatMessageContent">内容</th>
            </tr>
            </thead>
        </table>
        <div id="inboxGridToolbar">
			<a href="#" id="btnWriteMessage" class="easyui-linkbutton" iconCls="icon2 r24_c2" plain="true">写信</a>
			<a href="#" id="btnReplyMessage" class="easyui-linkbutton" iconCls="icon2 r9_c1" plain="true">回复</a>
			<a href="#" id="btnMarkReaded" class="easyui-linkbutton" iconCls="icon2 r10_c9" plain="true">已读</a>
			<!-- <a href="#" id="btnMoveFavoriate" class="easyui-linkbutton" iconCls="icon2 r22_c3" plain="true">收藏</a> -->
			<a href="#" id="btnDeleteMessage" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
    </div>
<!--     
	<div title="发件箱" style="" iconCls="icon2 r10_c10">
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
    <div title="草稿箱" style="padding:5px;" iconCls="icon2 r9_c9">
    </div>
    <div title="收藏夹" style="padding:5px;" iconCls="icon2 r3_c14">
    </div>
    <div title="联系人" iconCls="icon2 r11_c19"></div>
 -->
</div>
