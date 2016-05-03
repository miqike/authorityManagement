<%@ page contentType="text/html; charset=UTF-8"%>

    <div class="form-group">
      <label for="i_leaveType" class="col-sm-2 control-label">请假类型</label>
      <div class="col-sm-10">
        <input id="i_leaveType" class="form-control easyui-combobox" type="text" codeName="leaveType" />
      </div>
    </div>
    <div class="form-group">
      <label for="i_startDate" class="col-sm-2 control-label">请假时间起</label>
      <div class="col-sm-10">
        <input id="i_startDate" class="form-control" type="date" />
      </div>
    </div>
    <div class="form-group">
      <label for="i_endDate" class="col-sm-2 control-label">请假时间止</label>
      <div class="col-sm-10">
        <input id="i_endDate" class="form-control" type="date" />
      </div>
    </div>
    <div class="form-group">
      <label for="i_reason" class="col-sm-2 control-label">事由</label>
      <div class="col-sm-10">
        <input id="i_reason" class="form-control" type="text" />
      </div>
    </div>

    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button id="btnSuccess" type="button" class="btn btn-default">通过</button>
        <button id="btnFail" type="button" class="btn btn-default">拒绝</button>
      </div>
    </div>

<script>
  var _customApprove_ = {
    "variable": "reApply",
    "label": "操作",
    "combobox": {
      "width":100,
      "data": [
        {label: '重新提交', value: 'true'},
        {label: '放弃', value: 'false'}
      ],
    },
    "button": {
      "text": "提交",
      "iconCls":"icon-ok"
    }
  };

  var _edit_ = {
    "enableField": ["startDate", "endDate", "reason"]
  };

</script>
