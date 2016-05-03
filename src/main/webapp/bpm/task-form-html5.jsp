<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>审核</title>
    <link href="${ctx}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${ctx}/js/jquery.min.js"></script>
    <script src="${ctx}/js/husky.common.js"></script>
    <script src="${ctx}/js/husky.easyui.codeList.js"></script>
    <script src="${ctx}/js/formatter.js"></script>
    <script src="${ctx}/js/bootstrap.min.js"></script>
    <script src="${ctx}/bpm/audit.js"></script>
</head>
<body>

    <div class="container">
        <div class="row clearfix">
            <div id="dynamicForm" style="padding:5px; ">
                <div class="col-md-12 column">
                    <form id="form" class="form-horizontal" role="form">


                        <div class="form-group">
                            <label for="proposer" class="col-sm-2 control-label">申请人</label>
                            <div class="col-sm-10">
                                <input id="proposer" class="form-control" type="text" value=${data.proposerName} />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="proposer1" class="col-sm-2 control-label">申请时间</label>
                            <div class="col-sm-10">
                                <input id="proposer1" class="form-control" type="text" value="<fmt:formatDate value='${data.processStartTime}' pattern="yyyy-MM-dd HH:mm" />"/>
                            </div>
                        </div>





                        <jsp:include page="../form/${task.formKey}-weixin.jsp" ></jsp:include>

                    </form>
                </div>
            </div>

        </div>
    </div>

</body>
</html>

<script>

    function initCombobox(){
        $.each($("#dynamicForm input.easyui-combobox"), function (idx, _elem) {
            var elem= $(_elem);
            var id = elem.attr("id").split('_')[1];
            elem.combobox("setValue", data[id]);
//            if(task.assignee == null)
            if(typeof _edit_ === "undefined" || $.inArray(id, _edit_.enableField) == -1)
                elem.combobox("disable");
            else
                elem.combobox("enable");

        });
        $.unsubscribe("CODELIST_INITIALIZED", initCombobox);
    }

    //显示流程状态
    function showProcessInstance(processInstanceId) {
        $("#processInstanceDiagram").attr("src", "${ctx}/sys/processInstance/trace/" + processInstanceId);
        $("#processInstanceDiagramWindow").window('open')
    }

    $(function () {
        window.data = ${data};
        window.task = ${task};

        $("#proposerName").val(data.proposerName);


        $.each($("#dynamicForm input.form-control"), function(idx, _elem){
            var elem= $(_elem);
            var id = elem.attr("id").split('_')[1];
            if(id != undefined) {
                if (elem.attr("type") === "text") {
                    console.log(elem.attr("type") + ": " + data[id])
                    elem.val(data[id]);

                } else {
                    console.log(elem.attr("type") + ": " + dateFormatter(new Date(data[id])))
                    elem.val(dateFormatter(new Date(data[id])));
                }
            }
        });

       /* if($.codeListLoader.CODELIST_INITIALIZED) {
            initCombobox();
        } else {
            $.subscribe("CODELIST_INITIALIZED", initCombobox);
        }

        if(task.assignee != null) {
            $("#btnClaim").hide();
            if(typeof _edit_ != "undefined" && _edit_.enableField.length > 0) {
                $("#btnSave").show();
                $("#btnShowApproveDialog").linkbutton("disable");
            } else {
                $("#btnSave").hide();
                $("#btnShowApproveDialog").linkbutton("enable");
            }
        } else {
            $("#btnClaim").show();
            $("#btnSave").hide();
            $("#btnShowApproveDialog").linkbutton("disable");
        }

        if(typeof _customApprove_ != "undefined") {
            if (_customApprove_.variable != undefined) {
                $("#approvalDialog tr:first td:first").text(_customApprove_.label);
                $("#_approval").attr("variable", _customApprove_.variable);
                $("#_approval").combobox(_customApprove_.combobox);
            } else {
                $("#approvalDialog tr:first td:first").text("");
                $("#_approval").combobox("destroy");
            }
            if (_customApprove_.button != undefined) {
                $("#btnShowApproveDialog").linkbutton(_customApprove_.button);
                $("#approvalDialog").window(_customApprove_.button);
                $("#btnApprove").linkbutton(_customApprove_.button);
            }
        }

        $("#btnClaim").click(function(){
            if(!$(this).linkbutton('options').disabled) {
                //签收受候选任务
                $.post("${ctx}/bpm/task/claim/" + task.id, null, function(response) {
                    if(response.status == 1) {
                        $.messager.show({
                            title : '提示',
                            msg : "任务已签收"
                        });
                        $('#btnClaim').hide();
                        //                    $("#btnUnClaim").show();
                        $("#btnShowApproveDialog").show();
                        $("#btnShowApproveDialog").linkbutton("enable");
                    } else {
                        $.messager.alert("错误", response.message);
                    }
                }, "json");
            }
        });

        $("#btnSave").click(function(){
            //更新业务数据
            if(!$(this).linkbutton('options').disabled) {
                var param = {};
                $.each($("#dynamicForm input.easyui-textbox, #dynamicForm input.easyui-datebox, #dynamicForm input.easyui-combobox, #dynamicForm input.easyui-numberbox"), function(idx, _elem){
                    var elem= $(_elem);
                    var id = elem.attr("id").split('_')[1];
                    if(elem.attr("disabled") == undefined) {
                        if (elem.hasClass("easyui-textbox")) {
                            param[id] = elem.textbox("getValue");
                        } else if (elem.hasClass("easyui-datebox")) {
                            param[id] = elem.datebox("getValue");
                        } else if (elem.hasClass("easyui-combobox")) {
                            param[id] = elem.combobox("getValue");
                        } else if (elem.hasClass("easyui-numberbox")) {
                            param[id] = elem.numberbox("getValue");
                        }
                    }
                });

                $.ajax({
                    url: "${ctx}/bpm/form/" + task.id,
                    dataType: 'json',
                    data: JSON.stringify(param),
                    type: "PUT",
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    success: function (response) {
                        if(response.status == 1) {
                            $.messager.show({
                                title : '提示',
                                msg : "业务数据保存成功"
                            });
                            $("#btnShowApproveDialog").linkbutton("enable");
                            $("#btnSave").linkbutton("disable");
                        } else {
                            $.messager.alert("错误", response.message);
                        }
                    }
                });
            }
        });


        $("#btnShowApproveDialog").click(function(){
            if(!$(this).linkbutton('options').disabled) {
                showModalDialog("approvalDialog");
            }
        });

        $("#btnApprove").click(function(){
            //完成任务
            if(!$(this).linkbutton('options').disabled) {
                var param = {};

                param[$("#_approval").attr("variable")] = $("#_approval").combobox("getValue");
                param._comment = $("#_comment").textbox("getValue");

                $.ajax({
                    url: "${ctx}/bpm/task/complete/" + task.id,
                    dataType: 'json',
                    data: JSON.stringify(param),
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    success: function (response) {
                        if(response.status == 1) {
                            $.messager.show({
                                title : '提示',
                                msg : "任务已完成"
                            });
                            $("#approvalDialog").window("close");
                            if(parent.document.location != self.document.location) {
                                parent.window._closeTab(title);
                            }

                        } else {
                            $.messager.alert("错误", response.message);
                        }
                    }
                });
            }
        });*/
    });

</script>