<%@ page contentType="text/html; charset=UTF-8"%>

<div>
  <table class="content" style="padding-top:5px;margin-bottom: 20px;width:600px;">

    <tr>
      <td style="text-align:right">请假类型：</td>
      <td>
      	<input id="i_id" type="hidden" />
      	<input class="easyui-combobox" id="i_leaveType" codeName="leaveType" data-options="panelHeight:60" style="width:100px;"/></td>
    </tr>
    <tr>
      <td style="text-align:right">事由：</td>
      <td><input class="easyui-textbox" id="i_reason" style="width:100px;"/> </td>
    </tr>
    <tr>
      <td style="text-align:right">请假时间起：</td>
      <td><input class="easyui-datebox" id="i_startDate" style="width:100px;" data-options="onChange: calcLeaveDays"/></td>
    </tr>
    <tr>
      <td style="text-align:right">止：</td>
      <td><input class="easyui-datebox" id="i_endDate" style="width:100px;" data-options="onChange: calcLeaveDays"/></td>
    </tr>
    <tr>
      <td style="text-align:right">请假天数</td>
      <td><input class="easyui-textbox" id="i_days" style="width:100px;" disabled /></td>
    </tr>
  </table>
</div>

<script>
  //如果有保存操作,必须定义此变量
  var _serviceName_ = "leaveService";

  function calcLeaveDays(newValue,oldValue) {
    var startDate = $("#i_startDate").datebox("getValue");
    var endDate = $("#i_endDate").datebox("getValue");

    var ms = new Date(endDate) - new Date(startDate);
    $("#i_days").textbox("setValue", ms/86400000 + 1);
  }

  $(function () {
    $("#i_proposerName").textbox("setValue", ${user}.name);
  });
</script>