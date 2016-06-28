<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function showUserSelectDialog() {
	$.easyui.showDialog({
		title : "选择收件人",
		width : 500,
		height : 440,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : true,
		enableCloseButton : false,
		enableApplyButton : false,
		saveButtonText : "确定",
		saveButtonIconCls : "icon-ok",
		href : "./sys/userSelectDialog.jsp",
		onSave: function() {
			addReceiver();
		}
	});
}

function addReceiver() {
	var selections = $("#_userGrid").datagrid("getSelections");
	if(selections.length > 0) {
		var oriReceiver = $("#m_receiver").val();
		var oriReceiverName = $("#m_receiverName").val();
		var oriReceiverArray = $("#m_receiver").val() == "" ? new Array(): oriReceiver.split(",");
		var oriReceiverNameArray = $("#m_receiver").val() == "" ? new Array(): oriReceiverName.split(",");
		
		for(var i=0; i<selections.length; i++) {
			var candidate = selections[i];
			if(!oriReceiverArray.contains(candidate.userId)) {
				oriReceiverArray.push(candidate.userId);
				oriReceiverNameArray.push(candidate.name);
			}
		}
		
		$("#m_receiver").val(oriReceiverArray.join(","));
		$("#m_receiverName").val(oriReceiverNameArray.join(","));
	}
}
</script>

<div style="padding:10px;">
    <table id="messageTable">
        <tr>
            <td style="text-align: right">接收人</td>
            <td>
            	<input type="hidden" id="m_receiver" />
                <input class="easyui-validatebox" id="m_receiverName" style="width: 200px" data-options="required:true,editable:true" />
                <a href="#" id="btnShowUserSelectDialog" class="easyui-linkbutton" iconCls="icon2 r25_c10" plain="true" >选择接收人</a> 
            </td>
        </tr>
        <tr>
            <td style="text-align: right">标题</td>
            <td>
                <input type="text" id="m_title" value="" class="easyui-validatebox" style="width:500px" data-options="required:true"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">详细内容</td>
            <td>
                <textarea id="m_content" value="" rows="3" style="width:500px;"></textarea>
            </td>
        </tr>
    </table>
</div>
