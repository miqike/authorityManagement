<%@ page contentType="text/html; charset=UTF-8"%>

<script>
</script>

<div style="padding:10px;">
    <table id="messageTable">
        <tr>
            <td style="text-align: right">接收人</td>
            <td>
            	<input type="hidden" id="m_receiver" />
                <input class="easyui-validatebox"
						id="m_receiverName" style="width: 200px"
						data-options="required:true,editable:true" />
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
