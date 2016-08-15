<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	window.navigateBar = {
		grid: $('#grid1')
	};

	function showChangeOrgDialog() {
	    var setting = {
	        data: {
	            key: {
	                title: "parentId",
	                name: "nameWithId"
	            }
	        },
	        async: {
	            enable: true,
	            type: "get",
	            url: "../sys/organization/getSub",
	            autoParam: ["id"]
	        },
	        callback: {
	            onClick: function () {
	                var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
	                var selected = treeObj.getSelectedNodes();
	                if (selected.length == 1) {
	                    $("#btnSelectOrg").linkbutton("enable");
	                } else {
	                    $("#btnSelectOrg").linkbutton("disable");
	                }
	            }
	        }
	    };

	    $.fn.zTree.init($("#orgTreeSelect"), setting);
	    $('#orgSelectDialog').dialog('open');
	}
	
	function selectOrg() {
		var treeObj = $.fn.zTree.getZTreeObj("orgTreeSelect");
	    var selected = treeObj.getSelectedNodes();
	    if(selected.length == 1) {
	    	$("#k_djjg").val(selected[0].id);
	    	$("#k_djjgmc").val(selected[0].name);
	    	$('#orgSelectDialog').window('close');
	    } else {
	    	$.messager.alert("操作提示", "请选择一个单位");
	    }
	    
	}
	
	function showAddTaskDialog() {
		
		$.easyui.showDialog({
			title : "选择单位",
			width : 850,
			height : 650,
			topMost : false,
			enableSaveButton : true,
			enableApplyButton : false,
			saveButtonText : "选择",
			closeButtonText : "返回",
			closeButtonIconCls : "icon-undo",
			href : "./candidateEnterpriseSelectDialog.jsp",
			onLoad : function() {
				doCandidateEnterpriseSelectDialogInit();
			},
			onSave : function() {
				addEnterprise();
				return false;
			}
		});
	}
	
	function removeTaskFromPlan() {
		var tasks = $('#grid3b').datagrid('getSelections');
	    var taskIds = new Array();
	    var flag = true;
	    for (var i = 0; i < tasks.length; i++) {
	    	if(tasks[i].rwzt < 5) {
	    		taskIds.push(tasks[i].id);
	    	} else {
	    		flag = false;
	    		break;
	    	}
	    }
	    if(flag) {
	    	$.ajax({
				url:"../31/hcjh/removeEnterprise/" +$("#k_id").val(),
				data:JSON.stringify(taskIds),
				type:"put",
				contentType: "application/json; charset=utf-8",
				cache:false,
				success: function(response) {
					if(response.status == $.husky.SUCCESS) {
						$.messager.show("操作提醒", "移除核查单位成功", "info", "bottomRight");
						$("#grid1").datagrid("reload");
						$("#grid3b").datagrid("reload");;
					} else {
						$.messager.alert("错误", "移除核查单位失败");
					}
				}
			});
	    } else {
	    	$.messager.alert("操作提示", "选中任务中有已完成任务,不能进行删除操作");
	    }
	}
	
	function grid3bClickHandler() {
		if ($('#grid3b').datagrid('getSelections').length > 0) {
			$("#btnRemoveTaskFromPlan").linkbutton("enable");
		} else {
			$("#btnRemoveTaskFromPlan").linkbutton("disable");
		}
	}
	
	$(function () {
		/* $("#btnShowChangeOrgDialog").click(showChangeOrgDialog);
		$("#btnShowAddTaskDialog").click(showAddTaskDialog);
		$("#btnSelectOrg").click(selectOrg); */
	});
</script>
<div id="planWindowb" style="padding: 5px;">
	<%-- <jsp:include page="../sys/iterationBar.jsp"/> --%> 
	<div id="tabPanelb" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandlerb">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="planTableb">
                <tr>
                    <td class="label">计划类型</td>
                    <td>
                        <input class="easyui-combobox" id="k_planType" style="width:200px;" 
                              codeName="planType" data-options="required:true,panelHeight:60" disabled/>
                    </td>
                    <td class="label">检查单位</td>
                    <td><input type="hidden" id="k_djjg"/>
                        <input class="easyui-validatebox" id="k_djjgmc" data-options="required:true"
                               style="width:160px;" />
                               <a href="#" id="btnShowChangeOrgDialog" class="easyui-linkbutton" iconCls="icon-edit" plain="true"></a>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划年度</td>
                    <td><input class="easyui-validatebox add" id="k_nd"
                               data-options="required:true,validType:'integer'" style="width:192px;"/>
                    </td>
                    <td class="label">计划编号</td>
                    <td><input type="hidden" id="k_id"/>
                        <input class="easyui-validatebox add" id="k_jhbh" data-options="required:true"
                               style="width:192px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">计划名称</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="k_jhmc" style="width:535px;"
                               data-options="required:true"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">抽查文号</td>
                    <td colspan="3">
                        <input class="easyui-validatebox add" id="k_cxwh" style="width:535px;"
                               data-options="required:true" disabled/>
                    </td>
                </tr>
                <tr>
                    <td class="label">公示系统计划编号</td>
                    <td>
                        <input class="easyui-validatebox " id="k_gsjhbh" style="width:192px;"
                               data-options="required:true" disabled/>
                    </td>
                    
                </tr>
                <tr>
                    <td class="label">计划开始时间</td>
                    <td><input class="easyui-datebox add modify" id="k_ksrq" style="width:200px;"
                               data-options="required:true"/></td>
                    <td class="label">计划结束时间</td>
                    <td><input class="easyui-datebox add modify" id="k_yqwcsj" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td class="label">成立起始日</td>
                    <td><input class="easyui-datebox" id="k_clqsr" style="width:200px;"
                               data-options=""/></td>
                    <td class="label">成立终止日</td>
                    <td><input class="easyui-datebox" id="k_clzzr" style="width:200px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">检查分类</td>
                    <td>
                        <input class="easyui-combobox add modify" id="k_fl" style="width:200px;"
                               data-options="panelHeight:60,required:true" codeName="hcfl"/>
                    </td>
                    <td class="label">检查内容</td>
                    <td colspan="3">
                        <input id="k_nr" class="easyui-combobox add modify" codeName="hcnr"
                               data-options="panelHeight:80,width:200,required:true" style=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">任务数量</td>
                    <td>
                        <input class="easyui-validatebox" id="k_hcrwsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">已派发</td>
                    <td><input class="easyui-validatebox" id="k_ypfsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td class="label">已认领</td>
                    <td>
                        <input class="easyui-validatebox" id="k_yrlsl" style="width:192px;" data-options=""/>
                    </td>
                    <td class="label">未认领</td>
                    <td><input class="easyui-validatebox" id="k_wrlsl" style="width:192px;"
                               data-options=""/></td>
                </tr>
                <tr>
	                <td class="label">下达日期</td>
	                <td><input class="easyui-datebox" id="k_xdrq" style="width:200px;"
	                               data-options=""/></td>
                    <td class="label">下达人</td>
                    <td><input type="hidden" id="k_xdr"/>
                        <input class="easyui-validatebox" id="k_xdrmc" style="width:192px;" data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td class="label">说明</td>
                    <td colspan="3"><input class="easyui-validatebox add modify" id="k_sm" style="width:535px;"
                                           data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3b"
                   class="easyui-datagrid"
                   data-options="
                   		method:'get',
                   		pageSize: 100, pagination: true,
                       singleSelect:false,
                       collapsible:true,
                       toolbar: '#grid3bToolbar',
                       onClickRow:grid3bClickHandler,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   style="height: 318px">
                <thead>
                <tr>
                    <!-- <th data-options="field:'id'" halign="center" align="center" width="100" formatter="formatZfry">执法人员</th> -->
                    <th data-options="field:'hcdwXydm',halign:'center',align:'center'" sortable="true" width="120">统一社会信用代码</th>
                    <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="300">单位名称</th>
                    <th data-options="field:'lrrq'" halign="center" align="center" sortable="true" width="150" formatter="formatDate">举报或列入经营异常起始日</th>
                    <th data-options="field:'ksrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">终止日</th>
                </tr>
                </thead>
            </table>
            <div id="grid3bToolbar">
		        <a href="#" id="btnShowAddTaskDialog" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
		        <a href="#" id="btnRemoveTaskFromPlan" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
		    </div>
        </div>
    </div>
</div>
	
<div id="orgSelectDialog" class="easyui-dialog" title="选择单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <div>
            <a href="#" id="btnSelectOrg" class="easyui-linkbutton" iconCls="icon-ok" plain="true"
               disabled="true">确定</a>
        </div>
        <ul id="orgTreeSelect" class="ztree"></ul>
    </div>
</div>	