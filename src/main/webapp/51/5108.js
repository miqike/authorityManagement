function quickSearch (value, name) {
	/*var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()
	var options = $("#grid2").datagrid("options");
	var hcjh = $('#grid1').datagrid('getSelected');
    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg&' + name + "=" + value,
    $('#grid2').datagrid('load', {
        hcjhId: hcjh.id,
        organization: processorOrgId(selected[0].id),
        order:1
    });*/
	
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {

        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg&' + name + "=" + value;
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id),
            order: 1,
            rwzt:5
        });
    } else {
        $.messager.alert("提示","请首先选择计划和单位")
    }
    
}

function queryPlan(node) {
    var _orgId = $("#f_deptName").combobox("getValue");
    if (_orgId != "") {
        var orgId = new Array();
        orgId.push(_orgId);
        xxxx(orgId);
    } else if (window.orgTreeObj) {
        queryPlanFromTree();
    }
}

function grid2ClickHandler() {
	var tasks = $('#grid2').datagrid('getSelections');
	var filterByAuditResult = $("input[name='filterByAuditResult']:checked").val();
    if (tasks.length > 0) {
    	if(filterByAuditResult == 1) {
    		$('#btnShowAuditDialog').linkbutton('enable');
    		$('#btnCancelAuditStatus').linkbutton('enable');
    	} else if(filterByAuditResult == 2)  {
    		$('#btnShowAuditDialog').linkbutton('disable');
    		$('#btnCancelAuditStatus').linkbutton('enable');
    	} else {
    		$('#btnShowAuditDialog').linkbutton('enable');
    		$('#btnCancelAuditStatus').linkbutton('disable');
    	}
    	/*if(task.auditResult == null) {
    		$('#btnShowAuditDialog').linkbutton('enable');
    		$('#btnCancelAuditStatus').linkbutton('disable');
    	} else {
    		$('#btnShowAuditDialog').linkbutton('disable');
    		$('#btnCancelAuditStatus').linkbutton('enable');
    	}*/
    } else {
    	$('#btnCancelAuditStatus').linkbutton('disable');
        $('#btnShowAuditDialog').linkbutton('disable');
    }
}

function cancelAuditStatus() {
        //var hcrw = $("#grid2").datagrid("getSelected");
        
        var tasks = $("#grid2").datagrid("getSelections");
        var hcrwId = new Array();
        for(var i=0; i<tasks.length; i++) {
        	hcrwId.push(tasks[i].id);
        }
        
        //if(null != hcrw) {
       	if(tasks.length > 0) {
        	//if(hcrw.auditor != userInfo.userId) {
        	//	$.messager.alert("操作提示", "该信息审核人不是本人操作,不允许操作");
        	//} else {
        		$.messager.confirm('确认', "是否确认取消审核?", function (r) {
        			if (r) {
        				$.ajax({
        					//url: "../51/" + hcrw.id + "/cancelAudit",
        		            url: "../51/batchCancelAudit",
        		            data: JSON.stringify(hcrwId),
        		            dataType: "json",
        					type: "POST",
        					contentType: 'application/json;charset=utf-8',
        					success: function (response) {
        						if (response.status == $.husky.SUCCESS) {
        							$('#grid2').datagrid('reload');
        							$.messager.show('提示',"取消审核成功", "info", "bottomRight");
        						} else {
        							$.messager.alert('取消审核失败', response.message, 'error');
        						}
        					}
        				});
        			}
        		});
        	//}
        }
}

function search() {
	loadMyPlan();
}

function firstLoadMyPlan() {
	var options = $("#grid1").datagrid("options");
	options.url = "../common/query?mapper=hcjhMapper&queryName=query" + (userInfo.ext1 == 1 ? "Ext": "");
	loadMyPlan();
}

function loadMyPlan() {
	$("#grid1").datagrid("load", {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        cxwh: $('#f_cxwh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")//,
    });
}

function loadGrid1() {
    $('#grid1').datagrid('load', {
        nd: $('#f_nd').val(),
        jhbh: $('#f_jhbh').val(),
        gsjhbh: $('#f_gsjhbh').val(),
        jhmc: $('#f_jhmc').val(),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}

function clearInput() {
    $("#f_nd").val("");
    $("#f_id").val("");
    $("#f_jhbh").val( "");
    $("#f_gsjhbh").val( "");
    $("#f_jhmc").val( "");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function reset() {
    clearInput();
    loadGrid1();
}
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes()
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {

        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id),
            filterByAuditResult:$("input[name='filterByAuditResult']:checked").val(),
            order: 1,
            rwzt:5
        });
    } else {
        $.messager.alert("提示","请首先选择计划和单位")
    }
}

function showAuditDialog() {
	
	$.easyui.showDialog({
		title : "核查结果审核",
		width : 520,
		height : 310,
		topMost : false,
		iconCls:'icon2 r12_c19',
		enableSaveButton : true,
		enableApplyButton : false,
		saveButtonText : "审核",
		closeButtonText : "取消",
		closeButtonIconCls : "icon-undo",
		href : "./auditForm.jsp",
		onLoad : function() {
			doAuditFormInit();
		},
		onSave: function() {
			if($("#auditTable").form("validate")) {
				auditHcwr();
				return true;
			} else {
	    		return false;
			}
		}
	});
}
function printAuditReport() {
    printQiYeNianBaoGongShiXinXiHeChaJieGuoBaoGao("grid2");
}
function exportAuditReport() {
    var qy=$("#grid2").datagrid("getSelected");
    if(null!=qy) {
        $.messager.progress({
            title: '请等待',
            msg: '',
            text: '处理中.......'
        });
        var url = "./" + qy.id + "/exportExcelHcsxJg";
        $("<iframe id='poiExport' style='display:none' src=" + url + ">").appendTo("body");
        $.messager.progress("close");
    }else{
        $.messager.show("操作提醒", '请先选择企业', "info", "bottomRight");
    }
}

//查询数据
function queryData(){
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {
        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: processorOrgId(selected[0].id),
            filterByAuditResult:$("input[name='filterByAuditResult']:checked").val(),
            order: 1,
            rwzt:5,
            hcjieguo:$("#s_hcjieguo").combobox("getValue")
        });
    }
}
//初始化
$(function () {
	$.husky.getUserInfo();
    $.fn.zTree.init($("#orgTree"), setting);
    clearInput();
    if (null != window.userInfo) {
    	firstLoadMyPlan();
    } else {
        $.subscribe("USERINFO_INITIALIZED", firstLoadMyPlan);
    }
    $("input[name='filterByAuditResult']").change(queryData);

    $("#s_hcjieguo").combobox({
        onSelect:function(record){
            queryData();
        }
    });
});

