var operateType="";//操作类型 新增addNew、分解split、编辑edit
window.pageId = 'deptPlan';
window.cycleType = 1;
window.isSelfDeptPlan=1;//是否只查询本单位数据，如果是，则查询所有状态的计划，否则查询状态不是草稿的计划

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
    $.post("../plan/update", plan,function(response){
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
}

$(function() {
	$("#btnPre").click(showPreviousCycle);
	$("#btnNext").click(showNextCycle);
	$("#currentYear").text(new Date().getFullYear());
	$("#currentCycle").text(new Date().getMonth()+1);
	$("#cycleTypeMonth")[0].checked="checked";
	$("input:radio[name='cycleType']").click(changeCycleType);
	$("#grid1").treegrid({height:$("body").css("height").substr(0,3) - 25});

    $("#sort").combobox("setValue", "SN")/*.combobox({onChange:sortChangeHandler})*/;
    $("#order").combobox("setValue", "ASC")/*.combobox({onChange:orderChangeHandler})*/;

    //分解计划
    $("#btnSplit").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            var row=$("#grid1").treegrid("getSelected");
            if(row!=null){
                showModalDialog("popPlanWindow","分解计划任务-详细信息");
                operateType="split";
                $("#planForm").form("clear");
                $("#p_parentId").val(row.id);
                $("#p_parentName").val(row.title);

                setPlanDefaultValue();

                $.getJSON("../plan/getNextSn",{parentPlanId:$("#p_parentId").val(),isDeptPlan:1,orgId:$("#deptName").combobox("getValue")},function(response){
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
            }else{
                $.messager.show({
                    title : '提示',
                    msg :"请先选择数据"
                });
            }
        }
    });
    //编辑计划
    $("#btnView").click(function(){
        "use strict";
        var row=$("#grid1").treegrid("getSelected");
        if(row!=null){
            showModalDialog("popPlanWindow","修改计划任务-详细信息");
            operateType="addNew";
            //$("#planForm").form("clear");
            loadForm($("#planForm"), row);
            setFiedlStatus(row);
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
        if(null ==$("#deptName").combobox("getValue") || $("#deptName").combobox("getValue")==""){
            $.messager.show({
                title: '提示',
                msg: "请选择具体单位"
            });
        }else {
            showModalDialog("popPlanWindow", "新增计划任务-详细信息");
            $("#grid1").treegrid("unselectAll");
            operateType = "addNew";
            $("#planForm").form("clear");
            setPlanDefaultValue();
            $("#p_ownDeptId").val($("#deptName").combobox("getValue"));
            $("#p_ownDeptName").val($("#deptName").combobox("getText"));

            $.getJSON("../plan/getNextSn", {
                parentPlanId: $("#p_parentId").val(),
                isDeptPlan: 1,
                orgId: $("#deptName").combobox("getValue")
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
        }
	});
    //取消保存
    $("#btnCancel").click(btnCancelHandler);

    //保存计划
    $("#btnSave").click(function(){
        "use strict";
        if($('#planForm').form('validate')) {
            var data=drillDownForm('planForm');
            data.isDeptPlan=1;
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
    $("#btnApprove").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(3);
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
    $("#btnPropose1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(2);
        }
    });
    $("#btnApprove1").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(3);
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

            if(row.ownerId != null && row.ownerId != "") {
                $("#btnSplit").linkbutton("disable");
            }
            //如当前登录用户和审批人匹配,则enable审批按钮,否则disable
            if(row.approverId != null && userInfo.id != "" && row.approverId==userInfo.id && row.status==2 ) {
                $("#btnApprove").linkbutton("enable");
                $("#btnApprove1").linkbutton("enable");
            }else{
                $("#btnApprove").linkbutton("disable");
                $("#btnApprove1").linkbutton("disable");
            }
            //如果当前计划是顶层计划，则可以进行提交审批、审批操作
            if(row.parentId != null && row.parentId != "") {
                $("#btnApprove").linkbutton("disable");
                $("#btnPropose").linkbutton("disable");
                $("#btnApprove1").linkbutton("disable");
                $("#btnPropose1").linkbutton("disable");
            }else{
            }
            setFiedlStatus(row)
        },
        onLoadSuccess:function(data){
            "use strict";
            var selectedRow=$("#grid1").treegrid("getSelected");
            if(selectedRow!=null) {
                buttonStatusHandler(selectedRow);
                if(selectedRow.ownerId != null && selectedRow.ownerId != "") {
                    $("#btnSplit").linkbutton("disable");
                }
                //如当前登录用户和审批人匹配,则enable审批按钮,否则disable
                if(selectedRow.approverId != null && userInfo.userId != "" && selectedRow.approverId==userInfo.userId && selectedRow.status==2 ) {
                    $("#btnApprove").linkbutton("enable");
                    $("#btnApprove1").linkbutton("enable");
                }else{
                    $("#btnApprove").linkbutton("disable");
                    $("#btnApprove1").linkbutton("disable");
                }
                //如果当前计划是顶层计划，则可以进行提交审批、审批操作
                if(selectedRow.parentId != null  && selectedRow.parentId != "") {
                    $("#btnApprove").linkbutton("disable");
                    $("#btnPropose").linkbutton("disable");
                    $("#btnApprove1").linkbutton("disable");
                    $("#btnPropose1").linkbutton("disable");
                }else{
                }
            }


            /**/
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
        onDblClickRow:function(row){
            "use strict";
            showModalDialog("popPlanWindow","修改计划任务-详细信息");
            operateType="addNew";
            loadForm($("#planForm"),row);
            if($("#p_needVerify").combobox("getValue")==0){
                $("#p_verifierid").val("");
                $("#p_verifierName").textbox({disabled: true});
            } else {
                $("#p_verifierName").textbox({disabled: false});
            }
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

    //人员选择窗口确认按钮事件
    $("#btnPersonSelect").click(btnPersonSelectHandler);

    //单位选择窗口确认按钮事件
    $("#btnDeptSelect").click(btnDeptSelectHandler);

    $("#p_needVerify").combobox("setValue", 0).combobox({
        onChange: function (n,o) {
            $("#p_verifierId").val("");
            if(n == "0") {
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
        var planId = $("#p_id").val() == "" ? $("#grid1").datagrid("getSelected").id: $("#p_id").val();
        var ownerId = $("#p_ownerId").val() == "" ? $("#grid1").datagrid("getSelected").ownerId: $("#p_ownerId").val();
        estimatePlan(planId, ownerId);
    });
    $("#btnCancelEstimate").click(function(){
        "use strict";
        $("#diaEstimate").dialog("close");
    });

    $("#btnSaveAttachment").click(saveAttachment);
    $("#btnSaveComment").click(saveComment);
    $("#btnPersonFilter").click(btnPersonFilterHandler);
    $("#btnDeptFilter").click(btnDeptFilterHandler);

    $.getJSON("../plan/managedDept",null,function(response){
        "use strict";
        var data=response.data;
        if(data.length>1){
           data.unshift({"id":"","name":"--全部单位--"});
        }
        $("#deptName").combobox({data:response.data,valueField:"id",textField:"name",
            onLoadSuccess:function(){
                var data=$("#deptName").combobox("getData");
                if(data.length>0){
                    if(data.length>1){
                        $.messager.alert("提示", "您可以编制多个单位计划，编制计划前请先选择单位");
                    }
                    $("#deptName").combobox("setValue",data[0].id);
                    $("#grid1").treegrid({
                        url:'./planItems',
                        queryParams: {
                            cycleType: 1,
                            cycle: new Date().getMonth()+1,
                            isSelfDeptPlan:window.isSelfDeptPlan,
                            orgId:data[0].id,
                            sort:$("#sort").combobox("getValue"),
                            order:$("#order").combobox("getValue")
                        }
                    });
                }
            },
            onSelect:function(record){
                var cycle = parseInt($("#currentCycle").text());
                var currentYear = parseInt($("#currentYear").text());

                $("#grid1").treegrid({
                    url:'./planItems',
                    queryParams: {
                        cycleType: 1,
                        cycle: cycle,
                        year: currentYear,
                        isSelfDeptPlan:window.isSelfDeptPlan,
                        orgId:record.id,
                        sort:$("#sort").combobox("getValue"),
                        order:$("#order").combobox("getValue")
                    }
                });
            }
        })
    });
});