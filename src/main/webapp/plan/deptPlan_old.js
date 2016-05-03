
Array.prototype.indexOf = function(el){
	var result={};
	result.index=-1;
	for (var i=0; i<this.length; i++){
		var findValue;
		if(typeof el =="object"){
			findValue=this[i][el["idFieldName"]];
			if (findValue === el["idFieldValue"]){
				result.index=i;
				result.data=this[i];
				return result;
			}
		}else{
			findValue=el;
			if (findValue === el){
				result.index=i;
				result.data=this[i];
				return result;
			}
		}
	}
	return result;
};

function selectSuperintendent(e) {
	var planDepId = $('#p_deptId').val();
	var options = $('#grid3').datagrid('options');
	options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
	options.singleSelect = true;
	options.queryParams= {
		orgId: userInfo.orgId
	};

	$("#grid3").datagrid("reload");
	$('#personSelectDialog').dialog({ title:"选择负责人",isItem:0}).dialog('open');
}
function selectItemSuperintendent(e) {
	var planDepId = $('#p_deptId').val();
	var options = $('#grid3').datagrid('options');
	options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
	options.singleSelect = true;
	options.queryParams= {
		orgId: userInfo.orgId
	};

	$("#grid3").datagrid("reload");
	$('#personSelectDialog').dialog({ title:"选择负责人",isItem:1}).dialog('open');
}

function selectCoupler(e) {
	var planDepId = $('#p_deptId').val();
	var options = $('#grid3').datagrid('options');
	options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
	options.singleSelect = false;
	options.queryParams= {
		orgId: planDepId
	};

	$("#grid3").datagrid("reload");

	$('#personSelectDialog').dialog({ title:"选择协作人",isItem:0}).dialog('open');
}
function selectItemCoupler(e) {
    var planDepId = $('#p_deptId').val();
    var options = $('#grid3').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
    options.singleSelect = false;
    options.queryParams= {
        orgId: planDepId
    };

    $("#grid3").datagrid("reload");

    $('#personSelectDialog').dialog({ title:"选择协作人",isItem:1}).dialog('open');
}

function selectCoupleDep(e) {
	var planDepId = $('#p_deptId').val();
	var options = $('#grid4').datagrid('options');
	options.url = '../common/query?mapper=sysOrganizationMapper&queryName=query';
	options.queryParams= {
		parentId: planDepId
	};

	$("#grid4").datagrid("reload");
	$('#coupleDepSelectDialog').dialog('open');
}


function personSelect() {

	if($('#personSelectDialog').dialog("options").title == "选择负责人") {
		var row = $('#grid3').datagrid('getSelected');
		if (row != undefined){
            if($('#personSelectDialog').dialog("options").isItem==1){
                $("#k_superintendentId").val(row.userId);
                $("#k_superintendentName").textbox("setValue", row.name);
            }else {
                $("#p_superintendentId").val(row.userId);
                $("#p_superintendentName").textbox("setValue", row.name);
            }
		}
	} else {
		var rows = $('#grid3').datagrid('getSelections');
		var coupler = "";
		var coupler_text = "";
		if(rows.length > 0) {
			for (var i=0; i<rows.length; i++) {
				coupler += rows[i].id;
				coupler += "/";
				coupler += rows[i].name;
				coupler_text += rows[i].name;
				if(i<rows.length - 1) {
					coupler += ";";
					coupler_text += ";";
				}
			}
		}
        if($('#personSelectDialog').dialog("options").isItem==1) {
            $('#k_coupler').textbox("setValue", coupler);
            $('#k_coupler').textbox("setText", coupler_text);
        }else{
            $('#p_coupler').textbox("setValue", coupler);
            $('#p_coupler').textbox("setText", coupler_text);
        }
	}
	$('#personSelectDialog').dialog('close');
}


function planStatusStyler(value, rowData, rowIndex) {
	if(value == '1') {
		return 'background-color:yellow;color:blue';
	} else if (value == '2') {
		return 'background-color:orange;';
	} else if (value == '3') {
		return 'background-color:lightgreen;';
	} else if (value == '4') {
		return 'background-color:lightblue;';
	} else if (value == '5') {
		return 'background-color:amber;';
	} else if (value == '6') {
		return 'background-color:slategray;color:yellow';
	} else if (value == '7') {
		return 'background-color:gray;';
	}
}

function formatImportance(val, row) {
	var html = "<span>";
	for(var i=0; i<val; i++ ) {
		html += "<img src='../images/star.png' />";
	}
	html += "</span>";
	return html;
}

function formatInstancy(val, row) {
	var html = "<span>";
	for(var i=0; i<val; i++ ) {
		html += "<img src='../images/feather.png' />";
	}
	html += "</span>";
	return html;
}

function formatShowPlanDetail(val, row) {
	return "<a href='javascript:showPlanDetail(\"" + row.id + "\");'>" + val + "</a>";
}

function formatShowTooltip(val, row) {
	return '<span title="' + val + '" class="easyui-tooltip">...</span>';
}

function cmClickHandler(item) {
	functionName = item.id[2].toLowerCase() + item.id.substr(3);
	eval(functionName + "();");
}


//功能按钮矩阵
var buttons = [
	'btnAdd',
	'btnPropose',
	'btnApprove',
	'btnStart',
	'btnPause',
	'btnStop',
	'btnDelete'];

//上下文菜单按钮矩阵
var cmButtons = [
	'cmPropose',
	'cmApprove',
	'cmStart',
	'cmPause',
	'cmStop',
	'cmDelete'];


//功能按钮状态矩阵
var buttonStatus = [
		[1,1,0,0,0,0,1],
		[1,0,1,0,0,0,0],
		[1,0,0,1,0,0,0],
		[1,0,0,0,1,1,0],
		[1,0,0,1,0,1,0],
		[1,0,0,0,0,1,1],
		[1,0,0,0,0,0,1]
	];

function getButtonStatus(status) {
	return buttonStatus[status - 1];
}

function mainGridRowContextMenuHandler(e, index, row){
	var selectedRow = $('#mainGrid').datagrid('getSelected');
	if(selectedRow != null) {
		var buttonStatus = getButtonStatus(selectedRow.status);
		var _cmenu = $('#menu');
		for (var i = 0; i < cmButtons.length; i++) {
			_cmenu.menu(getContextMenuItemStatusStatement(buttonStatus[i + 1]), $("#" + cmButtons[i])[0]);
		}
		e.preventDefault();
		_cmenu.menu('show', {
			//显示右键菜单
			left: e.pageX,//在鼠标点击处显示菜单
			top: e.pageY
		});
		e.preventDefault();
	}
}

function mainGridRowClickHandler() {
	var buttonStatus= getButtonStatus($('#mainGrid').datagrid('getSelected').status);
	for(var i=0; i<buttons.length; i++ ) {
		$("#"+buttons[i]).linkbutton(getButtonStatusStatement(buttonStatus[i]));
		$("#"+buttons[i] + "1").linkbutton(getButtonStatusStatement(buttonStatus[i]));
	}
}

function showPlanDetail(planId) {
	showModalDialog("popWindow");
	//alert(planId);
	$("#grid2").treegrid({
		url:'./planItems',
		queryParams: {
			planId: planId,
            isDeptPlan:1
		}
	});
	$('#popPageRow').show();
	$("#grid2Div").show();
	var row=$("#mainGrid").datagrid("getSelected");
	loadForm($("#planForm"),row);
}

function remove(){
	if(!$(this).linkbutton('options').disabled) {

		var row = $('#mainGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认删除', '确认删除此计划？', function (r) {
				if (r) {
					$.ajax({
						url: "../plan?planId=" + row.id,
						type: 'DELETE',
						success: function (response) {
							if (response.status == SUCCESS) {
								$('#mainGrid').datagrid('reload');
								$.messager.show({
									title: '提示',
									msg: "删除操作成功"
								});
							} else {
								$.messager.alert('删除失败', response.message, 'info');
							}
						}
					});
				}
			});
		}else{
			$.messager.show({
				title : '提示',
				msg : "请先选择记录"
			});
		}
	}
}

function _updatePlanStatus(status) {
	var selectedRow = $('#mainGrid').datagrid('getSelected');
	if(null != selectedRow){
		updatePlanStatus(selectedRow.id, status);
	} else {
		$.messager.show({
			title : '提示',
			msg : "请先选择数据！"
		});
	}
}

function updatePlanStatus(planId, status){
	var plan={"id":planId, "status":status};
	$.post("../plan/update", plan,function(response){
		if(response.status == SUCCESS) {
			$('#mainGrid').datagrid("reload");
			$.messager.show({
				title : '提示',
				msg : response.message
			});
		} else {
			$.messager.alert("错误", response.message);
		}
	});
}



function propose() {
	_updatePlanStatus(2);
}

function approve() {
	_updatePlanStatus(3);
}

function start() {
	_updatePlanStatus(4);
}

function pause(){
	_updatePlanStatus(5);
}

function stop(){
	_updatePlanStatus(6);
}

function navigateMaingrid(){
	var row = datagridNavigate("mainGrid", $(this).linkbutton("options").iconCls);
	$("#grid2").treegrid({
		url:'./planItems',
		queryParams: {
			planId: row.id,
            isDeptPlan:1
		}
	});
	$('#popPageRow').show();
	loadForm($("#planForm"),row);
}

function navigateGrid2() {
	var row = treegridNavigate("grid2", $(this).linkbutton("options").iconCls);
	loadForm($("#planItemTable"),row);
	$('#planItemTable input.easyui-textbox').textbox("enable");
	$('#planItemTable input.easyui-combobox').combobox("enable");
}

function grid3ButtonHandler() {
	if($('#grid3').datagrid('getSelected') != null) {
		$('#btnSuperintendentSelect').linkbutton('enable');
	} else {
		$('#btnSuperintendentSelect').linkbutton('disable');
	}
}

function savePlan(){
	if($('#planForm').form('validate')) {
        var data=drillDownForm('planForm');
        data.isDeptPlan=1;
		$.post("../plan/", data, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
			} else {
				$("#grid2Div").show();
				$("#mainGrid").datagrid("reload");
				$("#grid2").treegrid({
					url:'./planItems',
					queryParams: {
						planId: response.data.id,
                        isDeptPlan:1
					}
				});
				//loadForm($("#planForm"),response.data);
                $("#p_id").val(response.data.id);
                setPopPageRowButton(false);
                var buttonStatus= getButtonStatus($("#p_status").combobox("getValue"));
                for(var i=0; i<buttons.length; i++ ) {
                    $("#"+buttons[i]).linkbutton(getButtonStatusStatement(buttonStatus[i]));
                    $("#"+buttons[i] + "1").linkbutton(getButtonStatusStatement(buttonStatus[i]));
                }
                $.messager.show({
					title : '提示',
					msg : "保存成功"
				});
			}
		}, "json");
	}else{
        $.messager.show({
            title : '提示',
            msg : "数据不完整"
        });
    }
}
function savePlanItem(){
    if($('#planItemForm').form('validate')) {
        var data=drillDownForm('planItemForm');
        data.isDeptPlan=1;
        $.post("../plan/", data, function(response) {
            if(response.status == FAIL){
                $.messager.alert('保存失败', response.message, 'info');
            } else {
                $("#mainGrid").datagrid("reload");
                $("#grid2").treegrid({
                    url:'./planItems',
                    queryParams: {
                        planId: response.data.parentId,
                        isDeptPlan:1
                    }
                });
                $("#k_id").val(response.data.id);
                setPopPageRow2Button(false);
                var buttonStatus= getButtonStatus($("#k_status").combobox("getValue"));
                for(var i=0; i<buttons.length; i++ ) {
                    $("#"+buttons[i] + "2").linkbutton(getButtonStatusStatement(buttonStatus[i]));
                }
                $.messager.show({
                    title : '提示',
                    msg : "保存成功"
                });
            }
        }, "json");
    }else{
        $.messager.show({
            title : '提示',
            msg : "数据不完整"
        });
    }
}
function setPlanFormReadOnly(readonly){
    "use strict";
    $("#p_status").combobox("readonly",readonly);
    $("#p_startAct").datebox("readonly",readonly);
    $("#p_endAct").datebox("readonly",readonly);
    $("#p_authorName").textbox("readonly",readonly);
    $("#p_approverName").textbox("readonly",readonly);
    $("#p_createTime").datebox("readonly",readonly);
    $("#p_approveTime").datebox("readonly",readonly);
}
function setPopPageRowButton(disable){
    "use strict";
    var disableFun=disable?"disable":"enable";
    var enableFun=disable?"enable":"disable";
    $("#btnFirst1").linkbutton(disableFun);
    $("#btnPre1").linkbutton(disableFun);
    $("#btnNext1").linkbutton(disableFun);
    $("#btnLast1").linkbutton(disableFun);
    //$("#btnSave1").linkbutton(enableFun);
    $("#btnPropose1").linkbutton(disableFun);
    $("#btnApprove1").linkbutton(disableFun);
    $("#btnStart1").linkbutton(disableFun);
    $("#btnPause1").linkbutton(disableFun);
    $("#btnStop1").linkbutton(disableFun);
    $("#btnDelete1").linkbutton(disableFun);
    //$("#btnClose1").linkbutton(enableFun);
}
function setPlanItemFormReadOnly(readonly){
    "use strict";
    $("#k_status").combobox("readonly",readonly);
    $("#k_startAct").datebox("readonly",readonly);
    $("#k_endAct").datebox("readonly",readonly);
    $("#k_authorName").textbox("readonly",readonly);
    $("#k_approverName").textbox("readonly",readonly);
    $("#k_createTime").datebox("readonly",readonly);
    $("#k_approveTime").datebox("readonly",readonly);
}
function setPopPageRow2Button(disable){
    "use strict";
    var disableFun=disable?"disable":"enable";
    var enableFun=disable?"enable":"disable";
    $("#btnFirst2").linkbutton(disableFun);
    $("#btnPre2").linkbutton(disableFun);
    $("#btnNext2").linkbutton(disableFun);
    $("#btnLast2").linkbutton(disableFun);
    //$("#btnSave2").linkbutton(enableFun);
    $("#btnPropose2").linkbutton(disableFun);
    $("#btnApprove2").linkbutton(disableFun);
    $("#btnStart2").linkbutton(disableFun);
    $("#btnPause2").linkbutton(disableFun);
    $("#btnStop2").linkbutton(disableFun);
    $("#btnDelete2").linkbutton(disableFun);
    //$("#btnClose2").linkbutton(enableFun);
}
$(function() {

	$("#btnAdd").click(function(){
		showModalDialog("popWindow");
		$("#planForm").form("clear");
		$('#popPageRow').show();
		$("#grid2Div").hide();
		$('#grid2').treegrid("loadData", []);
        //设置初始值
        setPlanFormReadOnly(true);
        setPopPageRowButton(true);
		$("#p_status").combobox("setValue",1);
        $("#p_authorIId").val(userInfo.userId);
        $("#p_authorName").textbox("setValue",userInfo.name);
        $("#p_superintendentName").textbox("setValue",userInfo.name);
        $("#p_instancy").combobox("setValue",1);
        $("#p_importance").combobox("setValue",1);
        $("#p_progress").progressbar().progressbar("setValue",0)
        $("#p_createTime").datebox("setValue",(new Date()).format("yyyy-MM-dd"));
        $("#p_createTime").datebox("setValue",(new Date()).format("yyyy-MM-dd"));
        $("#p_deptId").val(userInfo.orgId);
        $("#p_deptName").val(userInfo.orgName);
        $.getJSON("../plan/getNextSn",{parentPlanId:$("#p_parentId").val()},function(response){
            "use strict";
           if(response.status==1){
               $("#p_sn").textbox("setValue",response.data);
           } else{
               $("#p_sn").textbox("setValue","");
               $.messager.show({
                   title : '提示',
                   msg :response.message
               });
           }
        });
	});

	//提交审批
	$('#btnPropose').click(propose);
	$('#btnApprove').click(approve);
	$('#btnStart').click(start);
	$('#btnPause').click(pause);
	$('#btnStop').click(stop);
	$("#btnDelete").click(remove);
    $("#btnReset").click(function(){
        $("#f_title").val('');
        $("#f_isAnnualPlan").combobox('setValue', '');
    });
    $("#btnSearch").click(function(){
        $('#mainGrid').datagrid('load',{
            title: encodeURI($('#f_title').val()),
            isAnnualPlan: $('#f_isAnnualPlan').combobox('getValue')
        });
    });
    $("#btnPersonSelect").click(personSelect);

    $("#btnSave1").click(savePlan);
    $("#btnPause1").click(function(){
        var row=$("#mainGrid").datagrid("getSelected");
        if(null!=row){
            updatePlanStatus(row.id,3);
        }else{
            $.messager.show({
                title : '提示',
                msg : "请先选择数据！"
            });
        }
    });
    $("#btnStop1").click(function(){
        var row=$("#mainGrid").datagrid("getSelected");
        if(null!=row){
            updatePlanStatus(row.id,4);
        }else{
            $.messager.show({
                title : '提示',
                msg : "请先选择数据！"
            });
        }
    });
    $("#btnClose1").click(function(){
        $("#popWindow").window("close");
    });
    $("#btnDelete1").click(remove);
    $("#btnFirst1").click(navigateMaingrid);
    $("#btnPre1").click(navigateMaingrid);
    $("#btnNext1").click(navigateMaingrid);
    $("#btnLast1").click(navigateMaingrid);

    $("#btnFirst2").click(navigateGrid2);
    $("#btnPre2").click(navigateGrid2);
    $("#btnNext2").click(navigateGrid2);
    $("#btnLast2").click(navigateGrid2);
    $("#btnPause2").click(function(){
        var row=$("#grid2").datagrid("getSelected");
        if(null!=row){
            updatePlanStatus(row.id,3);
        }else{
            $.messager.show({
                title : '提示',
                msg : "请先选择数据！"
            });
        }
    });
    $("#btnStop2").click(function(){
        var row=$("#grid2").datagrid("getSelected");
        if(null!=row){
            updatePlanStatus(row.id,4);
        }else{
            $.messager.show({
                title : '提示',
                msg : "请先选择数据！"
            });
        }
    });
    $("#btnDelete2").click(function(){
        if(!$(this).linkbutton('options').disabled) {

            var row = $('#grid2').treegrid('getSelected');
            if (row) {
                $.messager.confirm('确认删除', '确认删除此计划？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "../plan?planId=" + row.id,
                            type: 'DELETE',
                            success: function (response) {
                                if (response.status == SUCCESS) {
                                    $.messager.show({
                                        title: '提示',
                                        msg: "删除操作成功"
                                    });
                                    $('#popWindow2').window("close");
                                    $("#grid2").treegrid({
                                        url:'./planItems',
                                        queryParams: {
                                            planId: row.parentId,
                                            isDeptPlan:1
                                        }
                                    });
                                } else {
                                    $.messager.alert('删除失败', response.message, 'info');
                                }
                            }
                        });
                    }
                });
            }else{
                $.messager.show({
                    title : '提示',
                    msg : "请先选择记录"
                });
            }
        }
    });
    $("#btnClose2").click(function(){
        $('#popWindow2').window("close");
    });

	$("#btnSave2").click(savePlanItem);
    $("#btnEditOrSave2").click(function(){
        if($('#planItemForm').form('validate')) {
            $("#k_isDeptPlan").textbox("setValue",1);
            var data=drillDownForm('planItemForm');
            data.parentId = $("#p_id").textbox("getValue");
            $.post("../plan/", data, function(response) {
                if(response.status == FAIL){
                    $.messager.alert('保存失败', response.message, 'info');
                } else {
                    $.messager.show({
                        title : '提示',
                        msg : "保存成功"
                    });
                    $("#popWindow2").window("close");
                    $("#grid2").treegrid({
                        url:'./planItems',
                        queryParams: {
                            planId: $("#p_id").textbox("getValue"),
                            isDeptPlan:1
                        }
                    });
                }
            }, "json");
        }
    });

	$("#btnAddPlanItem").click(function(){
		showModalDialog("popWindow2");
        setPlanItemFormReadOnly(true);
        setPopPageRow2Button(true);
		$('#popWindow2 input').val('');
		$('#popPageRow2').show();
		$("#planItemForm").form("clear");
		$('#planItemTable input.easyui-textbox').textbox("enable");
		$('#planItemTable input.easyui-combobox').combobox("enable");
        $.getJSON("../plan/getNextSn",{parentPlanId:$("#p_id").val()},function(response){
            "use strict";
            if(response.status==1){
                $("#k_sn").textbox("setValue",response.data);
            } else{
                $("#k_sn").textbox("setValue","");
                $.messager.show({
                    title : '提示',
                    msg :response.message
                });
            }
        });
        $("#k_status").combobox("setValue",1);
        $("#k_authorIId").val(userInfo.userId);
        $("#k_authorName").textbox("setValue",userInfo.name);
        $("#k_superintendentName").textbox("setValue",userInfo.name);
        $("#k_instancy").combobox("setValue",1);
        $("#k_importance").combobox("setValue",1);
        $("#k_progress").progressbar().progressbar("setValue",0)
        $("#k_createTime").datebox("setValue",(new Date()).format("yyyy-MM-dd"));
        $("#k_createTime").datebox("setValue",(new Date()).format("yyyy-MM-dd"));
        $("#k_deptId").val(userInfo.orgId);
        $("#k_deptName").val(userInfo.orgName);
        $("#k_parentId").val($("#p_id").val());
        $("#k_parentName").val($("#p_title").textbox("getValue"));
	});

	$("#btnDeletePlanItem").click(function(){
		var row=$("#grid2").datagrid("getSelected");
		if(null!=row){
			$.ajax({
				url:"../plan?planId="+row.id ,
				data:null/*JSON.stringify({"planId":row.id})*/,
				type:"delete",
				contentType: "application/json; charset=utf-8",
				cache:false,
				success: function(response) {
					if(response.status == SUCCESS) {
						$.messager.show({
							title : '提示',
							msg : response.message
						});
						$("#grid2").treegrid({
							url:'./planItems',
							queryParams: {
								planId: row.parentId,
                                isDeptPlan:1
							}
						});
					} else {
						$.messager.alert("错误", response.message);
					}
				}
			});
		}else{
			$.messager.show({
				title : '提示',
				msg : "请先选择数据！"
			});
		}
	});

	$("#btnPausePlanItem").click(function(){
		var row=$("#grid2").datagrid("getSelected");
		if(null!=row){
			updatePlanStatus(row.id,3);
		}else{
			$.messager.show({
				title : '提示',
				msg : "请先选择数据！"
			});
		}
	});
	$("#btnStopPlanItem").click(function(){
		var row=$("#grid2").datagrid("getSelected");
		if(null!=row){
			updatePlanStatus(row.id,4);
		}else{
			$.messager.show({
				title : '提示',
				msg : "请先选择数据！"
			});
		}
	});
	$("#btnViewPlanItem").click(function(){
		var row=$("#grid2").datagrid("getSelected");
		if(row){
			showModalDialog("popWindow2");
			$('#popWindow2 input').val('');
			$('#popPageRow2').show();
			loadForm($("#planItemForm"),row);
			$('#planItemTable input.easyui-textbox').textbox("enable");
			$('#planItemTable input.easyui-combobox').combobox("enable");
		}else{
			$.messager.show({
				title : '提示',
				msg : "请先选择数据！"
			});
		}
	});

    $("input",$("#p_sn").next("span")).blur(function(){
        if($("#p_sn").textbox("getValue")!="") {
            $.getJSON("../plan/getPlan?sn=" + $("#p_sn").textbox("getValue"), null, function (response) {
                "use strict";
                if (response.status == 1 && response.data.length>0) {
                    $.messager.show({
                        title: '提示',
                        msg: "序号已经存在！！！"
                    });
                }
            });
        }
    });
    $("input",$("#p_title").next("span")).blur(function(){
        if($("#p_title").textbox("getValue")!="") {
            $.getJSON("../plan/getPlan?title=" + $("#p_title").textbox("getValue"), null, function (response) {
                "use strict";
                if (response.status == 1 && response.data.length>0) {
                    $.messager.show({
                        title: '提示',
                        msg: "计划名称已经存在！！！"
                    });
                }
            });
        }
    });

    $(".datagrid-body").niceScroll({
        cursorcolor : "lightblue", // 滚动条颜色
        cursoropacitymax : 3, // 滚动条是否透明
        horizrailenabled : false, // 是否水平滚动
        cursorborderradius : 0, // 滚动条是否圆角大小
        autohidemode : false // 是否隐藏滚动条
    });

});