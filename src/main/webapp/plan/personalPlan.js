var operateType="";//操作类型 新增addNew、分解split、编辑edit
window.pageId = 'personalPlan';
window.cycleType = 1;
window.isSelfDeptPlan=0;//是否只查询本单位数据，如果是，则查询所有状态的计划，否则查询状态不是草稿的计划

//功能按钮状态矩阵
var buttonStatus = [
    [1,0,0,-1,-1,0,0,0,0,0,0,0,0], // 0 新增时使用
    [1,1,1,-1,-1,1,0,0,0,0,0,0,1], // 1 草稿
    [1,0,0,-1,-1,0,1,0,0,0,0,0,0], // 2 已提交审批
    [1,0,1,-1,-1,1,0,1,0,0,0,0,0], // 3 已审批
    [1,1,1,-1,-1,0,1,1,1,1,0,0,0], // 4 已开始执行中
    [1,1,1,-1,-1,1,0,1,0,1,0,0,0], // 5 暂停
    [1,1,1,-1,-1,0,0,0,0,1,1,1,1], // 6 终止
    [1,1,1,-1,-1,0,0,0,0,0,1,1,1], // 7 待核实
    [1,1,1,-1,-1,0,0,0,0,0,0,1,1], // 8 完成/已核实
    [1,0,1,-1,-1,0,0,0,0,0,0,0,0]  // 9 已删除
];

var buttonRoleStatus = [
    [1,1,1,-1,-1,0,0,0,0,0,0,0,1], // 1 创建人
    [1,0,1,-1,-1,1,1,1,1,1,0,0,1], // 2 负责人
    [1,1,1,-1,-1,1,1,1,1,1,0,1,1], // 3 执行人
    [0,0,1,-1,-1,0,0,0,0,0,0,0,0], // 4 协作人
    [1,0,1,-1,-1,0,0,0,0,0,1,0,0], // 5 核实人
    [0,0,0,-1,-1,0,0,0,0,0,0,0,0]  // 6 审批人
];


function setEditable(editable) {
    for(var i=0; i<editableFields.length; i++) {
        setInputFieldReadonly($("#p_" + editableFields[i]), !editable);
    }
}


//更新选定计划的状态
function _updatePlanStatus(status) {
    var selectedRow = $('#grid1').treegrid('getSelected');
    if(null != selectedRow){
        updatePlanStatus(selectedRow.id, status);
    } else {
        $.messager.show({
            title : '提示',
            msg : "请先选择数据！"
        });
    }
}
//在单元格后面增加按钮，点击按钮显示提示
//更新指定计划的状态
function updatePlanStatus(planId, status){
    var plan={"id":planId, "status":status};
    var cascadeFlag="0";
    $.messager.confirm('提示', '请确认是否级联操作？', function(r) {
        if (r) {
            cascadeFlag = "1";
        }
        plan.cascadeFlag= cascadeFlag;
        $.post("../plan/changeStatus", plan,function(response){
            if(response.status == SUCCESS) {
                $('#grid1').treegrid("reload");
                $.messager.show({
                    title : '提示',
                    msg : response.message
                });
            } else {
                $.messager.alert("错误", response.message);
            }
        });
    });
}

function formatIsDeptPlan(val, row) {
    return val!=1 ? "<span><img src='../images/user-16.png' /></span>": "";
}

function formatRoleInTask(val, row) {

    var html = "";
    if(row.ownerId == userInfo.id) {
        html += "执/"
    }
    if(row.superintendentId == userInfo.id) {
        html += "责/"
    }
    if(row.verifierId == userInfo.id) {
        html += "核/"
    }
    if(row.coupler.contains(userInfo.id)) {
        html += "协/"
    }

    return html.substr(0, html.length - 1);
}

/*
//负责人选择
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

//执行选择
function selectOwner(e) {
    $.messager.confirm('确认选择执行人', '选择执行人之后将不能继续分解,请确认:', function (r) {
        if (r) {
            var planDepId = $('#p_deptId').val();
            var options = $('#grid3').datagrid('options');
            options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
            options.singleSelect = true;
            options.queryParams= {
                orgId: userInfo.orgId
            };

            $("#grid3").datagrid("reload");
            $('#personSelectDialog').dialog({ title:"选择执行人",isItem:0}).dialog('open');
        }
    });
}

//协助人选择
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

//核实人选择
function selectVerifier(e) {
    var planDepId = $('#p_deptId').val();
    var options = $('#grid3').datagrid('options');
    options.url = '../common/query?mapper=userMapper&queryName=querySuperintendentCandidate';
    options.singleSelect = true;
    options.queryParams= {
        orgId: userInfo.orgId
    };

    $("#grid3").datagrid("reload");
    $('#personSelectDialog').dialog({ title:"选择核实人",isItem:0}).dialog('open');
}

//责任部门选择
function selectSuperintendDept(e) {
    $("#grid4").datagrid({"singleSelect": true});
    selectDept("选择责任部门");
}

//协助部门选择
function selectCoupleDept(e) {
    $("#grid4").datagrid({"singleSelect": false});
    selectDept("选择协作部门");
}

//部门选择
function selectDept(title) {
    var planDepId = $('#p_deptId').val();
    var options = $('#grid4').datagrid('options');
    options.url = '../common/query?mapper=sysOrganizationMapper&queryName=query';
    options.queryParams= {
        parentId: planDepId
    };

    $("#grid4").datagrid("reload");
    $('#deptSelectDialog').dialog({ title:title,isItem:0}).dialog('open');
}
*/
function adjustProgress() {
    if (!$(this).linkbutton('options').disabled) {
        var row=$("#grid1").datagrid("getSelected");
        if(null==row ){
            $.messager.show({
                title : '提示',
                msg : "请先选择计划"
            });
        }else{
            if(row.isParent){
                $.messager.show({
                    title : '提示',
                    msg : "有子计划，不能修改此计划的进度"
                });
            }else{
                showModalDialog("progressWindow");
            }
        }
    }
}

function saveProgress() {
    var data = {
        id:$("#grid1").treegrid("getSelected").id,
        progress:$("#k_progress").numberspinner("getValue")
    };

    $.post("../plan/changeProgress/", data, function(response){
        if(response.status == SUCCESS) {
            $.messager.show({
                title : '提示',
                msg : response.message
            });
            $("#grid1").treegrid("reload");
            $("#progressWindow").window("close");
        } else {
            $.messager.alert("错误", response.message);
        }
    });
}

function complete() {
    if(!$(this).linkbutton('options').disabled) {
        var row=$("#grid1").treegrid("getSelected");
        var cascadeFlag="0";
        $.messager.confirm('提示', '请确认是否级联开始完成操作？', function(r){
            if (r){
                cascadeFlag="1";
            }
            var data = {
                id: row.id,
                progress: 100,
                cascadeFlag:cascadeFlag
            };
            $.post("../plan/changeProgress/", data, function (response) {
                if (response.status == SUCCESS) {
                    $.messager.show({
                        title: '提示',
                        msg: response.message
                    });
                    $("#grid1").treegrid("reload");
                    //如果是弹出窗口,修改进度条
                    if (!$("#progressWindow").window("options").closed) {
                        $("#progressWindow").window("close");
                    }
                    if (!$("#popPlanWindow").window("options").closed) {
                        $("#p_progress").html(formatProgress(100));
                    }
                } else {
                    $.messager.alert("错误", response.message);
                }
            });
        });
    }
}

function verify() {
    if(!$(this).linkbutton('options').disabled) {
        $.messager.confirm('任务核实', '是否确认该项计划任务已经完成?', function (r) {
            if (r) {
                var data = {
                    id: $("#grid1").treegrid("getSelected").id,
                    status: 8
                }
                $.post("../plan/changeStatus/", data, function (response) {
                    if (response.status == SUCCESS) {
                        $.messager.show({
                            title: '提示',
                            msg: response.message
                        });
                        $("#grid1").treegrid("reload");
                    } else {
                        $.messager.alert("错误", response.message);
                    }
                });
            }
        });
    }
}

$(function() {
    $("#btnPre").click(showPreviousCycle);
    $("#btnNext").click(showNextCycle);
    $("#currentYear").text(new Date().getFullYear());
    $("#currentCycle").text(new Date().getMonth()+1);
    $("#cycleTypeMonth")[0].checked="checked";
    $("input:radio[name='cycleType']").click(changeCycleType);
    $("#grid1").treegrid({height:$("body").css("height").substr(0,3) - 25});

    $("#sort").combobox("setValue", "SN");
    $("#order").combobox("setValue", "ASC");


    //分解计划
    $("#btnSplit").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            var row = $("#grid1").treegrid("getSelected");
            if (row != null) {
                showModalDialog("popPlanWindow", "分解计划任务-详细信息");
                operateType = "split";
                $("#planForm").form("clear");
                $("#p_parentId").val(row.id);
                $("#p_parentName").val(row.title);

                setPlanDefaultValue();
                $("#p_superintendentId").val(userInfo.id);
                $("#p_ownerId").val(userInfo.id);
                $("#p_superintendDeptId").val(userInfo.orgId);
                $("#p_superintendentName").textbox("readonly",true).textbox("setValue",userInfo.name);
                $("#p_ownerName").textbox("readonly",true).textbox("setValue",userInfo.name);
                $("#p_superintendDeptName").textbox("readonly",true).textbox("setValue",userInfo.orgName);

                $.getJSON("../plan/getNextSn", {
                    parentPlanId: $("#p_parentId").val(),
                    isDeptPlan: 0
                }, function (response) {
                    "use strict";
                    if (response.status == 1) {
                        $("#p_sn").textbox("setValue", response.data);
                    } else {
                        $("#p_sn").textbox("setValue", "");
                        $.messager.show({
                            title: '提示',
                            msg: response.message
                        });
                    }
                });
            } else {
                /*$.messager.show({
                    title: '提示',
                    msg: "请先选择数据"
                });*/
                window.alertify.maxLogItems(20).delay(1000).logPosition("botom right").success("请先选择数据");
            }
        }
    });
    //编辑计划
    $("#btnView").click(function(){
        "use strict";
        var row=$("#grid1").treegrid("getSelected");
        if(row!=null){
            showModalDialog("popPlanWindow","修改计划任务-详细信息");
            operateType="edit";
            setEditable(userInfo.userId == row.ownerId && row.isDeptPlan == 0);
            loadForm($("#planForm"),row);
            setFiedlStatus(row)
            loadAttachmentPanel(row.id);
            loadCommentPanel(row.id);
        }else{
            $.messager.show({
                title : '提示',
                msg :"请先选择数据"
            });
        }
    });
    //新增计划
    $("#btnAdd").click(function(){
        "use strict";
        showModalDialog("popPlanWindow","新增计划任务-详细信息");
        operateType="addNew";
        $("#planForm").form("clear");
        var row=$("#grid1").treegrid("getSelected");
        if(row!=null){
            $("#p_parentId").val(row.parentId);
            $("#p_parentName").val(row.parentName);
        }

        setPlanDefaultValue();

        $("#p_superintendentId").val(userInfo.id);
        $("#p_ownerId").val(userInfo.id);
        $("#p_superintendDeptId").val(userInfo.orgId);
        $("#p_superintendentName").textbox("readonly",true).textbox("setValue",userInfo.name);
        $("#p_ownerName").textbox("readonly",true).textbox("setValue",userInfo.name);
        $("#p_superintendDeptName").textbox("readonly",true).textbox("setValue",userInfo.orgName);

        $.getJSON("../plan/getNextSn",{parentPlanId:$("#p_parentId").val(),isDeptPlan:0},function(response){
            "use strict";
            if(response.status==1){
                $("#p_sn").textbox("setValue",response.data);
            } else{
                $("#p_sn").textbox("setValue", "");
            }
        });
    });
    //取消保存
    $("#btnCancel").click(btnCancelHandler);
    //保存计划
    $("#btnSave").click(function(){
        "use strict";
        if($('#planForm').form('validate')) {
            var data=drillDownForm('planForm');
            data.isDeptPlan=0;
            $.post("../plan/", data, function(response) {
                if(response.status == FAIL){
                    $.messager.alert('保存失败', response.message, 'info');
                } else {
                    $("#grid1").treegrid("reload");
                    $("#p_id").val(response.data.id);
                    $.messager.show({
                        title : '提示',
                        msg : "保存成功"
                    });
                    $("#popPlanWindow").window("close");
                    $("#grid1").treegrid("reload");
                }
            }, "json");
        }else{
            $.messager.show({
                title : '提示',
                msg : "数据不完整"
            });
        }
    });

    //更新计划状态
    $("#btnPropose").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(2);
        }
    });

    $("#btnStart").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(4);
        }
    });
    $("#btnPause").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(5);
        }
    });
    $("#btnStop").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(6);
        }
    });

    $("#btnStart1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(4);
        }
    });
    $("#btnPause1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(5);
        }
    });
    $("#btnStop1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(6);
        }
    });
    //删除计划
    $("#btnDelete").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            var row = $('#grid1').treegrid('getSelected');
            if (row) {
                $.messager.confirm('确认删除', '确认删除此计划？', function (r) {
                    if (r) {
                        $.ajax({
                            url: "../plan?planId=" + row.id,
                            type: 'DELETE',
                            success: function (response) {
                                if (response.status == SUCCESS) {
                                    $('#grid1').treegrid('reload');
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
    });
    $("#btnDelete1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            $.messager.confirm('确认删除', '确认删除此计划？', function (r) {
                if (r) {
                    $.ajax({
                        url: "../plan?planId=" + $("#p_id").val(),
                        type: 'DELETE',
                        success: function (response) {
                            if (response.status == SUCCESS) {
                                $('#grid1').treegrid('reload');
                                $.messager.show({
                                    title: '提示',
                                    msg: "删除操作成功"
                                });
                                $("#popPlanWindow").window("close");
                            } else {
                                $.messager.alert('删除失败', response.message, 'info');
                            }
                        }
                    });
                }
            });
        }
    });
    //计划列表表格事件
    $("#grid1").treegrid({
        onClickRow:function(row){
            "use strict";
            buttonStatusHandler(row);
            $("#btnSplit").linkbutton("enable");

            /*if(row.ownerId != null && row.ownerId != "") {
                $("#btnSplit").linkbutton("disable");
            }*/
            setFiedlStatus(row)
        },
        onLoadSuccess:function(data){
            "use strict";
            var selectedRow=$("#grid1").treegrid("getSelected");
            if(selectedRow!=null) {
                buttonStatusHandler(selectedRow);
            }


            var div01 = $("div.datagrid-body td[field='description'] div.datagrid-cell");
            div01.css({
                "width":div01.width(),
                "white-space":"nowrap",
                "text-overflow":"ellipsis",
                "-o-text-overflow":"ellipsis",
                "overflow":"hidden"
            });

            $('.datagrid-header td,.datagrid-body td').mouseover(function(e){
                $('#displayDescription').dialog({
                    title: '目标要求',
                    left:e.pageX+10,
                    top:e.pageY+10,
                    width: 600,
                    height: 400,
                    closed: false,
                    cache: false,
                    modal: true
                }).dialog("close");
            }).mouseout(function(e){
            });
        },
        onDblClickRow:function(index,row){
            "use strict";
            showModalDialog("popPlanWindow","修改计划任务-详细信息");
            var row=$("#grid1").treegrid("getSelected");
            operateType="edit";
            setEditable(userInfo.userId == row.ownerId && row.isDeptPlan == 0);
            loadForm($("#planForm"),row);
            loadAttachmentPanel(row.id);
            loadCommentPanel(row.id);
        },
        onClickCell:function(field,row){
            "use strict";
            if(field=="description"){
                $('#displayDescription').dialog("open");
                $("#d_description").textbox("setValue",row[field]).textbox("readonly",true);
            }
        }
    });

    var cycle = parseInt($("#currentCycle").text());
    var currentYear = parseInt($("#currentYear").text());
    reloadMainGrid(cycleType, cycle, currentYear);

    //人员选择窗口确认按钮事件
    $("#btnPersonSelect").click(btnPersonSelectHandler);

    //单位选择窗口确认按钮事件
    $("#btnDeptSelect").click(function(){
        "use strict";
        if($('#deptSelectDialog').dialog("options").title == "选择责任部门") {
            var row = $('#grid4').datagrid('getSelected');
            if (row != undefined){
                $("#p_superintendDeptId").val(row.userId);
                $("#p_superintendDeptName").textbox("setValue", row.name);
            }
        } else {
            var rows = $('#grid4').datagrid('getSelections');
            var coupleDept = "";
            var coupleDept_text = "";
            if(rows.length > 0) {
                for (var i=0; i<rows.length; i++) {
                    coupleDept += rows[i].id;
                    coupleDept += "/";
                    coupleDept += rows[i].name;
                    coupleDept_text += rows[i].name;
                    if(i<rows.length - 1) {
                        coupleDept += ";";
                        coupleDept_text += ";";
                    }
                }
            }
            $('#p_coupleDept').textbox("setValue", coupleDept);
            $('#p_coupleDept').textbox("setText", coupleDept_text);
        }
        $('#deptSelectDialog').dialog('close');
    });

    $("#p_needVerify").combobox("setValue", 0).combobox({
        onChange: function (n,o) {
            $("#p_verifierId").val("");
            if(n == 0) {
                $("#p_verifierName").textbox({disabled: true}).textbox("readonly",true).textbox("setValue", "");
            } else {
                $("#p_verifierName").textbox({disabled: false}).textbox("readonly",false).textbox("setValue", "");
            }
        }
    });

    //评价
    $("#btnEstimate1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            showModalDialog("diaEstimate");
            if(userInfo.userId==$("#p_ownerId").val()){
                $("input[name='quality']")[4-$("#p_selfQualityEstimate").textbox("getValue")].checked="checked";
                $("input[name='effective']")[4-$("#p_selfEffectiveEstimate").textbox("getValue")].checked="checked";
            }else{
                $("input[name='quality']")[4-$("#p_qualityEstimate").textbox("getValue")].checked="checked";
                $("input[name='effective']")[4-$("#p_effectiveEstimate").textbox("getValue")].checked="checked";
            }
        }
    });
    $("#btnEstimate").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            var row = $("#grid1").datagrid("getSelected");
            if (null == row) {
                $.messager.show({
                    title: '提示',
                    msg: "请选择要评价的计划"
                });
            } else {
                showModalDialog("diaEstimate");
                if(userInfo.userId==$("#p_ownerId").val()){
                    $("input[name='quality']")[4-row.selfQualityEstimate].checked="checked";
                    $("input[name='effective']")[4-row.selfEffectiveEstimate].checked="checked";
                }else{
                    $("input[name='quality']")[4-row.qualityEstimate].checked="checked";
                    $("input[name='effective']")[4-row.effectiveEstimate].checked="checked";
                }
            }
        }
    });
    $("#btnSaveEstimate").click(function(){
        "use strict";
        var planId=$("#p_id").val()==""?$("#grid1").datagrid("getSelected").id:$("#p_id").val();
        estimatePlan(planId);
    });
    $("#btnCancelEstimate").click(function(){
        "use strict";
        $("#diaEstimate").dialog("close");
    });

    $("#btnSaveAttachment").click(saveAttachment);
    $("#btnSaveComment").click(saveComment);

    $('#btnProgress').click(adjustProgress);
    $('#btnProgress1').click(adjustProgress);
    $('#btnComplete').click(complete);
    $('#btnComplete1').click(complete);
    $('#btnSaveProgress').click(saveProgress);
    $('#btnVerify').click(verify);
    $('#btnVerify1').click(verify);

    $("#btnCancel").click(btnCancelHandler);
});
