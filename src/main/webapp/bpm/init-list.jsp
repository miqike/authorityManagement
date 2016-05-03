<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/common/global.jsp"%>
    <%@ include file="/common/meta.jsp" %>
    <link href="${ctx}/css/content.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/metro-blue/easyui.css" rel="stylesheet"/>
    <link href="${ctx}/css/themes/icon.css" rel="stylesheet"/>
    <style>
    	#mainGridDiv .datagrid-wrap{border-top: 0px;}
    </style>
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
        <span style="margin-left: 10px; color: blue; font-size: 18px; font-family: 'microsoft yahei', sans-serif">列表</span>
        - <a href='#' onclick='showProcessDefinition("${processDefinition.id}");'>${processDefinition.name}</a>
    </div>
    <div style="margin-top: 4px;">
        <span style="margin-left: 10px;height:16px;">
            <img style="margin-right: 5px;" src="${ctx}/images/user-16.png" />2016年度 已请事假: 3天</span>
    </div>
</div>

<div id="mainGridDiv" >
	<table id="mainGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,onClickRow:mainGridButtonHandler,
				ctrlSelect:true,method:'get',onDblClickRow:mainGridDblClickHandler,
				url:'../../../../common/query?mapper=leaveMapper&queryName=query&proposer=${user.userId}'"
           toolbar="#mainGridToolbar"
           style="height: 500px"
           pageSize="20"
           pagination="true"
           pagePosition ="bottom" >
        <thead>
        <tr>
            <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
            <th data-options="field:'leaveType',halign:'center',align:'center'" sortable="true" width="70" codeName="leaveType" formatter="formatCodeList" >请假类型</th>
            <th data-options="field:'reason',halign:'center',align:'left'" sortable="true" width="200">理由</th>
            <th data-options="field:'startDate',halign:'center',align:'center'" sortable="true" width="75" formatter="formatDate">开始日期</th>
            <th data-options="field:'endDate',halign:'center',align:'center'" sortable="true" width="75" formatter="formatDate">结束日期</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="120" formatter="formatDatetime2Min">销假时间</th>
            <th data-options="field:'processInstanceId',halign:'center',align:'center'" sortable="true" width="100">流程编号</th>
            <th data-options="field:'processStatus',halign:'center',align:'center'" sortable="true" width="50" codeName="processStatus" formatter="formatCodeList">状态</th>
            <th data-options="field:'processStartTime',halign:'center',align:'center'" sortable="true" width="120" formatter="formatDatetime2Min">启动时间</th>
            <th data-options="field:'processEndTime',halign:'center',align:'center'" sortable="true" width="120" formatter="formatDatetime2Min">完成时间</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true" >编辑</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true" >删除</a>
        <a href="#" id="btnStart" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" disabled="true" >提交审批</a>
    </div>
</div>
<div id="formWindow" class="easyui-window" title="表单" data-options="iconCls:'icon-edit',modal:true,closed:true">
	<div style="padding:5px; height: 28px; border-bottom: 1px solid darkgray;">
	    <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" plain="true" iconCls="icon-save">保存</a>
	    <a href="javascript:void(0);" id="btnStartProcess" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19" disabled>提交审批</a>
	</div>
	
	<div id="dynamicForm" style="padding:5px; ">
	    <jsp:include page="../form/${formKey}.jsp" ></jsp:include>
	</div>
</div>
<%-- 
<div id="processDefinitionDiagramWindow" class="easyui-window" title="流程图"
     style="clear: both; width: 750px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <img id="processDefinitionDiagram" />
    </div>
</div>
 --%>
 
</body>
</html>
<script>
//如果有保存删除操作,必须定义此变量
var _serviceName_ = "leaveService";

function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null && $('#mainGrid').datagrid('getSelected').processStatus == 0) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnStart').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnStart').linkbutton('disable');
	}
}
function mainGridDblClickHandler(index, row) {
	window.selected = index;
	$('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
	var selected = $('#mainGrid').datagrid('getSelected');
	if(selected.processStatus == 0) {
		showModalDialog("formWindow");
		loadForm($('#dynamicForm'), selected);
		$("#btnStartProcess").linkbutton($("#i_id").val()==""? "disable": "enable");
	}
}

function add(){
	$('#formWindow input').val('');
	showModalDialog("formWindow");
	$('#dynamicForm input.easyui-textbox').textbox("enable");
	$('#dynamicForm input.easyui-combobox').combobox("enable");
	$("#btnEditOrSave").linkbutton({
		iconCls:'icon-save',
		text:'保存'
	});
}
	
function view(){
	if(!$(this).linkbutton('options').disabled) {
		var selected = $('#mainGrid').datagrid('getSelected');
		if (selected) {
			if(selected.processStatus == 0) {
				showModalDialog("formWindow");
				loadForm($('#dynamicForm'), selected);
				$("#btnStartProcess").linkbutton($("#i_id").val()==""? "disable": "enable");
			}
		}
	}
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除数据?', function (r) {
				if (r) {
					$.ajax({
						url: "../../" + _serviceName_ + "/" + row.id,
						type: 'DELETE',
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
							} else {
								$.messager.alert('删除失败', response, 'info');
							}
						}
					});
				}
			});
		}
	}
}
    var user = ${user};
    var processDefinition = ${processDefinition};

    //显示流程状态
    function showProcessDefinition(processDefinitionId) {
        $("#processDefinitionDiagram").attr("src", "${ctx}/sys/processDefinition/trace/" + processDefinitionId);
        $("#processDefinitionDiagramWindow").window('open')
    }

    $(function () {
    	
    	$("#btnAdd").click(add);
    	$("#btnView").click(view);
    	$("#btnDelete").click(remove);
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
                var param = {"_serviceName_": _serviceName_,
                			"businessKey": $("#i_id").val()
                		};
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