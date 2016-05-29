<%@ page contentType="text/html; charset=UTF-8"%>
<script>

</script>
<table style="margin-left:10px;margin-top:10px;">
    <tr align="center">
        <td>用户名</td>
        <td> <input type="text" id="t_uname" value="" class="easyui-validatebox" readonly="readonly" /></td>
    </tr>
    <tr align="center">
        <td>新密码</td>
        <td> <input type="password" id="t_password" class="easyui-validatebox" data-options="required:true" maxlength="60"/></td>
    </tr>
    <tr align="center">
        <td>确认密码 </td>
        <td> <input type="password" id="t_password2" class="easyui-validatebox" data-options="required:true" maxlength="60" validType="equals['t_password', 'id']"/></td>
    </tr>
</table>
