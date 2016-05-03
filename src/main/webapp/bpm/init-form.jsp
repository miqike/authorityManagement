<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <link href="${ctx}/css/content.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/metro-blue/easyui.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/icon.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="${ctx}/js/husky.common.js"></script>
    <script type="text/javascript" src="${ctx}/js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="${ctx}/js/formatter.js"></script>
</head>
<body style="padding:5px;">
<div style="padding:5px; height: 55px; border-bottom: 1px solid darkgray;">
    <div style=" float: left;">
        <img src="${ctx}/images/task-50.png">
    </div>
    <div>
        <span style="margin-left: 10px; color: blue; font-size: 18px; font-family: 'microsoft yahei', sans-serif">流程启动</span>
        - <a href='#' onclick='showProcessDefinition("${processDefinition.id}");'>${processDefinition.name}</a>
    </div>
    <div style="margin-top: 4px;">
        <span style="margin-left: 10px;height:16px;">
            <img style="margin-right: 5px;" src="${ctx}/images/user-16.png" />申请人: ${user.name}</span>
    </div>
</div>

<div style="padding:5px; height: 28px; border-bottom: 1px solid darkgray;">
    <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" plain="true" iconCls="icon-save">保存</a>
    <a href="javascript:void(0);" id="btnStartProcess" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19" disabled>提交审批</a>
</div>

<div id="dynamicForm" style="padding:5px; ">
    <jsp:include page="../form/${formKey}.jsp" ></jsp:include>
</div>
<div id="processDefinitionDiagramWindow" class="easyui-window" title="流程图"
     style="clear: both; width: 750px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <img id="processDefinitionDiagram" />
    </div>
</div>
</body>
</html>
<script>
    var user = ${user};
    var processDefinition = ${processDefinition};

    //显示流程状态
    function showProcessDefinition(processDefinitionId) {
        $("#processDefinitionDiagram").attr("src", "${ctx}/sys/processDefinition/trace/" + processDefinitionId);
        $("#processDefinitionDiagramWindow").window('open')
    }

    $(function () {
        $("#btnSave").click(function(){
            //保存业务对象
            if(!$(this).linkbutton('options').disabled) {
                var param = {"_serviceName_": _serviceName_};
                if($("#i_id").val() != "") {
                	param.businessKey = $("#i_id").val();
                }
                $.each($("#dynamicForm input.easyui-textbox, #dynamicForm input.easyui-datebox, #dynamicForm input.easyui-combobox, #dynamicForm input.easyui-numberbox"), function(idx, _elem){
                    var elem= $(_elem);
                    var id = elem.attr("id").split('_')[1];
                    if (elem.hasClass("easyui-textbox")) {
                        param[id] = elem.textbox("getValue");
                    } else if (elem.hasClass("easyui-datebox")) {
                        param[id] = elem.datebox("getValue");
                    } else if (elem.hasClass("easyui-combobox")) {
                        param[id] = elem.combobox("getValue");
                    } else if (elem.hasClass("easyui-numberbox")) {
                        param[id] = elem.numberbox("getValue");
                    }
                });

                $.ajax({
                    url: "${ctx}/bpm/form/",
                    dataType: 'json',
                    data: JSON.stringify(param),
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    success: function (response) {
                        if(response.status == 1) {
                            $("#i_id").val(response.businessKey);
                            $.messager.show({
                                title : '提示',
                                msg : response.message
                            });
                            $("#btnStartProcess").linkbutton("enable");
                            $("#btnSave").linkbutton("disable");
                            
                            if($("#mainGrid").length == 1) {
                            	$("#mainGrid").datagrid("reload");
                            }
                        } else {
                            $.messager.alert("错误", response.message);
                        }
                    }
                });
            }
        });

        $("#btnStartProcess").click(function(){
            //启动流程
            if(!$(this).linkbutton('options').disabled) {
                var param = {"_serviceName_": _serviceName_, "businessKey": $("#i_id").val()};
                $.ajax({
                    url: "${ctx}/bpm/form/" + processDefinition.key + "/start",
                    dataType: 'json',
                    data: JSON.stringify(param),
                    type: "PUT",
                    contentType: "application/json; charset=utf-8",
                    cache: false,
                    success: function (response) {
                        if(response.status == 1) {
                            $.messager.show({
                                title : '提示',
                                msg : response.message
                            });

                            $("#btnStartProcess").linkbutton("disable");

                            if(parent.document.location != self.document.location) {
                                parent.window._closeTab(title);
                            }
                            if($("#mainGrid").length == 1) {
                            	$("#mainGrid").datagrid("reload");
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