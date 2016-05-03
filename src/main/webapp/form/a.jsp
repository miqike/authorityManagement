<%@ page contentType="text/html; charset=UTF-8"%>

<div>
  <table class="content" style="padding-top:5px;margin-bottom: 20px;width:600px;">

    <tr>
      <td style="text-align:right">请假类型：</td>
      <td><input class="easyui-combobox" id="i_leaveType" codeName="leaveType" data-options="panelHeight:60" style="width:100px;"/></td>
      <td style="text-align:right">事由：</td>
      <td><input class="easyui-textbox" id="i_reason" style="width:100px;"/> </td>
    </tr>
    <tr>
      <td style="text-align:right">请假时间起：</td>
      <td><input class="easyui-datebox" id="i_startDate" style="width:100px;" /></td>
      <td style="text-align:right">止：</td>
      <td><input class="easyui-datebox" id="i_endDate" style="width:100px;"/></td>
    </tr>
  </table>
</div>

<script>
var _serviceName_ = "leaveService";
  var _customApprove_ = {
    "variable": "deptLeaderApproved"
  }
</script>