<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <link href="${ctx}/css/content.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/metro-blue/easyui.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/icon.css" rel="stylesheet"/>
</head>
<body style="padding:5px;">
<div style="padding:5px; height: 55px; border-bottom: 1px solid darkgray;">
    <div style=" float: left;">
        <img src="${ctx}/images/task-50.png">
    </div>
    <div>
        <span style="margin-left: 10px; color: blue; font-size: 18px; font-family: 'microsoft yahei', sans-serif">${task.name}</span>
        - <a href='#' onclick='showProcessInstance("${task.processInstanceId}");'>${processDefinition.name}</a>
    </div>
    <div style="margin-top: 4px;">
        <span style="margin-left: 10px;height:16px;">
            <img style="margin-right: 5px;" src="${ctx}/images/user-16.png" />申请人: ${data.proposerName}</span>

        <span style="margin-left: 10px;height:16px;">
            <c:choose>
                <c:when test="${task.priority < 30}">
                    <img style="margin-right: 5px;" src="${ctx}/images/priority-low-16.png" />优先级: 低
                </c:when>
                <c:when test="${task.priority > 70}">
                    <img style="margin-right: 5px;" src="${ctx}/images/priority-high-16.png" />优先级: 高
                </c:when>
                <c:otherwise>
                    <img style="margin-right: 5px;" src="${ctx}/images/priority-medium-16.png" />优先级: 中
                </c:otherwise>
            </c:choose>
        </span>
        <span style="margin-left: 10px;"><img style="margin-right: 5px;" src="${ctx}/images/duedate-16.png" />到期时间:
            <c:choose>
                <c:when test="${task.dueDate == null}">无</c:when>
                <c:otherwise>
                    <fmt:formatDate value='${task.dueDate}' pattern="yyyy-MM-dd HH:mm" />
                </c:otherwise>
            </c:choose>
        </span>
        <span style="margin-left: 10px;"><img style="margin-right: 5px;" src="${ctx}/images/create-time-16.png" />申请时间:
            <fmt:formatDate value='${data.processStartTime}' pattern="yyyy-MM-dd HH:mm" />
        </span>
        <span style="margin-left: 10px;"><img style="margin-right: 5px;" src="${ctx}/images/create-time-16.png" />任务创建时间:
            <fmt:formatDate value='${task.createTime}' pattern="yyyy-MM-dd HH:mm" />
        </span>
    </div>
</div>

<div style="padding:5px; height: 60px; border-bottom: 1px solid darkgray;">
    <a href="javascript:void(0);" id="btnClaim" class="easyui-linkbutton" plain="true" iconCls="icon2 r17_c20">签收</a>
    <%--<a href="javascript:void(0);" id="btnUnClaim" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c2">退回</a>--%>
    <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" plain="true" iconCls="icon-save">保存</a>
    <a href="javascript:void(0);" id="btnShowApproveDialog" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19">审批/完成</a>
    <!--<span style="color: purple;font-size:16px; ">${task.description}这里是任务描述</span>-->
</div>

<div id="dynamicForm" style="padding:5px; ">
    <jsp:include page="../form/${task.formKey}.jsp" ></jsp:include>
</div>

<div id="approvalDialog"
     class="easyui-window" title="办理/审批"
     data-options="modal:true,closed:true,iconCls:'icon2 r12_c19'"
     style="width: 450px; height: 250px; padding: 10px;">
    <table>
        <tr style="margin-bottom: 10px;">
            <td style="text-align:right">审批意见</td>
            <td><input class="easyui-combobox" id="_approval" variable="approved" data-options="
                panelHeight:60,	width:60, valueField: 'value', textField: 'label',
                data: [{label: '同意',value: 'true'},{label: '否决',value: 'false'}]" />
                <a href="javascript:void(0);" id="btnApprove" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19">审批/完成</a>
            </td>
        </tr>
        <tr>
            <td style="text-align:right; vertical-align: top;padding-top: 5px;">批注</td>
            <td style="padding-top: 5px;"><input class="easyui-textbox" id="_comment" data-options="multiline:true, width:350, height:140"/></td>
        </tr>
    </table>
</div>
<div id="processInstanceDiagramWindow" class="easyui-window" title="流程跟踪"
     style="clear: both; width: 750px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <img id="processInstanceDiagram" />
    </div>
</div>
</body>
</html>
<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="${ctx}/js/husky.common.js"></script>
<script type="text/javascript" src="${ctx}/js/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="${ctx}/js/formatter.js"></script>
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
        if($("#i_id").length == 1) {
        	$("#i_id").val(data.id);
        }
        $.each($("#dynamicForm input.easyui-textbox, #dynamicForm input.easyui-datebox, #dynamicForm input.easyui-numberbox"), function(idx, _elem){
            var elem= $(_elem);
            var id = elem.attr("id").split('_')[1];
            if(elem.hasClass("easyui-textbox")) {
                elem.textbox("setValue", data[id]);
                if(typeof _edit_ === "undefined" || $.inArray(id, _edit_.enableField) == -1)
                    elem.textbox("disable");
                else
                    elem.textbox("enable");
            } else if (elem.hasClass("easyui-datebox")) {
                elem.datebox("setValue", formatDate(data[id]));
                if(typeof _edit_ === "undefined" || $.inArray(id, _edit_.enableField) == -1)
                    elem.datebox("disable");
                else
                    elem.datebox("enable");
            } else if (elem.hasClass("easyui-numberbox")) {
                elem.numberbox("setValue", data[id]);
                if(typeof _edit_ === "undefined" ||  $.inArray(id, _edit_.enableField) == -1)
                    elem.numberbox("disable");
                else
                    elem.numberbox("enable");
            }
        });

        if($.codeListLoader.CODELIST_INITIALIZED) {
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
                var param = {"_serviceName_": _serviceName_,
                		"businessKey": $("#i_id").val()};
				if($("#_approval").length == 1) 
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
        });
    });

</script>