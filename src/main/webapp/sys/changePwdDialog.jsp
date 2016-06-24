<%@ page contentType="text/html; charset=UTF-8"%>
<table style="margin-left:20px;margin-top:20px;">
    <tr align="center">
        <td style="text-align:right">用户ID</td>
        <td> <input type="text" id="t_uid" value="" class="easyui-validatebox" readonly="readonly" disabled/></td>
    </tr>
    <tr align="center">
        <td style="text-align:right">用户名称</td>
        <td> <input type="text" id="t_uname" value="" class="easyui-validatebox" readonly="readonly" disabled/></td>
    </tr>
    <tr align="center">
        <td style="text-align:right">新密码</td>
        <td> <input type="password" id="t_password" class="easyui-validatebox" data-options="required:true" maxlength="60"/></td>
    </tr>
    <tr align="center">
        <td style="text-align:right">确认密码 </td>
        <td> <input type="password" id="t_password2" class="easyui-validatebox" data-options="required:true" maxlength="60" validType="equals['t_password', 'id']"/></td>
    </tr>
</table>
