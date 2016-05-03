//----------------------------------------------------------------------------------------------
var setting = {
    data: {
        key: {
            title:"parentId",
            name:"name"
        }},
    async: {
        enable: true,
        type: "get",
        url:"../sys/organization/getSubWithUser",
        autoParam:["id"]
    },
    callback: {
        beforeClick: beforeTreeClick,
        onClick: onTreeClick,
        onAsyncSuccess: zTreeOnAsyncSuccess
    }
};

var log, className = "dark";
//树加载成功后事件
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {

}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var cycle = parseInt($("#currentCycle").text());
    var currentYear = parseInt($("#currentYear").text());
    $("#grid1").treegrid("unselectAll");

    $("#deptName").text(treeNode.name);
    if(treeNode.dataType=="1"){
        window.isDeptPlan = 1;
        //$("#popPageRow").show();
        $("#grid1").treegrid({
            url:'./planItems',
            queryParams: {
                cycleType: cycleType,
                cycle: cycle,
                year: currentYear,
                isSelfDeptPlan:window.isSelfDeptPlan,
                isDeptPlan:window.isDeptPlan,
                orgId:treeNode.id,
                sort:$("#sort").combobox("getValue"),
                order:$("#order").combobox("getValue")
            }
        });
        $("#grid1Toolbar").show();
        $("#btnRaisePlan").hide();
        $("#btnAdd").show();
    }else{
        window.isDeptPlan = 0;
        //$("#popPageRow").hide();
        $("#grid1").treegrid({
            url:'./planItems',
            queryParams: {
                cycleType: cycleType,
                cycle: cycle,
                year: currentYear,
                isSelfDeptPlan:window.isSelfDeptPlan,
                isDeptPlan:window.isDeptPlan,
                userId:treeNode.id,
                sort:$("#sort").combobox("getValue"),
                order:$("#order").combobox("getValue")
            }
        });
        $("#grid1Toolbar").show();
        $("#btnRaisePlan").show();
        $("#btnAdd").show();
    }
}
function orgPlanInit(){
    "use strict";
    //系统计划初始化
    //初始化树
    $.fn.zTree.init($("#tree"), setting);

    $("#grid1").treegrid({border:false});
    //$("#grid1").treegrid("loadData",[]);
    $("#grid1Toolbar").show();
    $("#popPageRaise").hide();
    //提升计划
    $("#btnRaisePlan").click(function(){
        var personalPlan=$("#grid1").datagrid("getSelected");
        if(null==personalPlan){
            $.messager.show({
                title: '提示',
                msg: "请先选择一条个人计划"
            });
        }else {
            if (personalPlan.isAssigned == 0) {
                var date = new Date();
                if (null != personalPlan.createTime) {
                    date.setTime(personalPlan.createTime);
                    personalPlan.createTime = $.fn.datebox.defaults.formatter(date);
                }
                if (null != personalPlan.end) {
                    date.setTime(personalPlan.end);
                    personalPlan.end = $.fn.datebox.defaults.formatter(date);
                }
                if (null != personalPlan.endAct) {
                    date.setTime(personalPlan.endAct);
                    personalPlan.endAct = $.fn.datebox.defaults.formatter(date);
                }
                if (null != personalPlan.start) {
                    date.setTime(personalPlan.start);
                    personalPlan.start = $.fn.datebox.defaults.formatter(date);
                }
                if (null != personalPlan.startAct) {
                    date.setTime(personalPlan.startAct);
                    personalPlan.startAct = $.fn.datebox.defaults.formatter(date);
                }

                $.post("../plan/raisePlan", personalPlan, function (response) {
                    if (response.status == SUCCESS) {
                        $('#grid1').treegrid("reload");
                        $.messager.show({
                            title: '提示',
                            msg: response.message
                        });
                    } else {
                        $.messager.alert("错误", response.message);
                    }
                });
            } else {
                $.messager.show({
                    title: '提示',
                    msg: "上级指派的计划，不能提升"
                });
            }
        }
    });
    $("#btnRaisePlan").hide();
}

function reloadMainGrid(){
    var treeNode=getZTreeSelectedNode("tree");
    onTreeClick(null,null,treeNode,null);
}

function personTreeGridDblClickHandler() {
    "use strict";
    var options = $("#grid3").treegrid("options");
    if(options.singleSelect) {
        btnPersonSelectHandler();
    }
}
function btnPersonFilterHandler() {
    filter($("#grid3"), $("#psd_filter"))
}
function btnDeptFilterHandler() {
    filter($("#grid4"), $("#dsd_filter"))
}

function filter(grid, filterField) {
    //处理已加载数据
    var filter = filterField.textbox("getValue");
    var data = grid.treegrid("getData");
    for(var i=0; i<data.length; i++) {
        _filter(grid, data[i], filter);
    }
}

function _filter(grid, data, filter) {
    if(!data.isParent) {
        if(data.id.contains(filter) || data.name.contains(filter) || makePy(data.name).join(",").contains(filter.toUpperCase())) {
            grid.parent().find("tr[node-id='" + data.id + "']").show();
        } else {
            grid.parent().find("tr[node-id='" + data.id + "']").hide();
        }
    } else if (data.children != undefined) {
        for(var j=0; j<data.children.length;j++) {
            _filter(grid, data.children[j], filter);
        }
    }
}

function resetGrid4() {
    $("#grid4").treegrid("options").url = undefined;
}

function resetGrid3() {
    $("#grid3").treegrid("options").url = undefined;
}

function deptTreeGridDblClickHandler(index,row){
    "use strict";
    var options = $("#grid4").treegrid("options");
    if(options.singleSelect) {
        btnDeptSelectHandler();
    }
}

function selectPerson(title, options) {
    $('#psd_filter').textbox("setValue", "");
    $('#personSelectDialog').dialog({ title:title,isItem:0}).dialog('open');
    options.url = '../sys/organization/getSubWithUser';
    $("#grid3").treegrid(options);
}

//负责人选择
function selectSuperintendent(e) {
    selectPerson("选择负责人", {
        singleSelect: true,
        queryParams: {
            pop: true
        }
    });
}

//执行选择
function selectOwner(e) {
    $.messager.confirm('确认选择执行人', '选择执行人之后将不能继续分解,请确认:', function (r) {
        if (r) {
            selectPerson("选择执行人", {
                singleSelect: true,
                queryParams: {
                    pop: false
                }
            });
        }
    });
}

//协助人选择
function selectCoupler(e) {
    selectPerson("选择协作人", {
        singleSelect: false,
        queryParams: {
            pop: true
        }
    });
}
//核实人选择
function selectVerifier(e) {
    selectPerson("选择核实人", {
        singleSelect: true,
        queryParams: {
            pop: true
        }
    });
}

//审批人选择
function selectApprover(e) {
    selectPerson("选择审批人", {
        singleSelect: true,
        queryParams: {
            pop: true
        }
    });
}
//------------------------------------------------------------------------------------------------------
var operateType="";//操作类型 新增addNew、分解split、编辑edit
window.pageId = 'deptPlan';
window.cycleType = 1;
window.isDeptPlan = 1;
window.isSelfDeptPlan=0;//是否只查询本单位数据，如果是，则查询所有状态的计划，否则查询状态不是草稿的计划

//功能按钮状态矩阵
var buttonStatus = [
    [-1,0,0,1,1,0,0,0,0,0,0,0,0], // 0 新增时使用
    [-1,1,1,1,1,1,0,0,0,0,0,0,1], // 1 草稿
    [-1,0,0,1,1,0,1,0,0,0,0,0,0], // 2 已提交审批
    [-1,0,1,1,1,1,0,1,0,0,0,0,0], // 3 已审批
    [-1,1,1,1,1,0,1,1,1,1,0,0,0], // 4 已开始执行中
    [-1,1,1,1,1,1,0,1,0,1,0,0,0], // 5 暂停
    [-1,1,1,1,1,0,0,0,0,1,1,1,1], // 6 终止
    [-1,1,1,1,1,0,0,0,0,0,1,1,1], // 7 待核实
    [-1,1,1,1,1,0,0,0,0,0,0,1,1], // 8 完成/已核实
    [-1,0,1,1,1,0,0,0,0,0,0,0,0]  // 9 已删除
];

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

function formatIsDeptPlan(val, row) {
    return val!=1 ? "<span><img src='../images/user-16.png' /></span>": "";
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
    $('#deptSelectDialog').dialog({ title:title,isItem:0}).dialog('open');
    var planDeptId = $('#p_ownDeptId').val();
    $('#dsd_filter').textbox("setValue", "");
    $("#grid4").treegrid({
        url:'../sys/organization/',
        queryParams: {
            currentDeptId: planDeptId
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
            var row = $("#grid1").treegrid("getSelected");
            if (row != null) {
                showModalDialog("popPlanWindow", "分解计划任务-详细信息");
                operateType = "split";
                $("#planForm").form("clear");
                $("#p_parentId").val(row.id);
                $("#p_parentName").val(row.title);

                setPlanDefaultValue();
                var treeNode=getZTreeSelectedNode("tree");
                $("#p_ownDeptId").val(null==treeNode?userInfo.orgId:treeNode.id);
                $("#p_ownDeptName").val(null==treeNode?userInfo.orgName:treeNode.name);

                $.getJSON("../plan/getNextSn", {
                    parentPlanId: $("#p_parentId").val(),
                    isDeptPlan: 1
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
                $.messager.show({
                    title: '提示',
                    msg: "请先选择数据"
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
            loadForm($("#planForm"),row);
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
        var treeNode=getZTreeSelectedNode("tree");
        showModalDialog("popPlanWindow", "新增计划任务-详细信息");

        $("#grid1").treegrid("unselectAll");
        operateType = "addNew";
        $("#planForm").form("clear");

        setPlanDefaultValue();
        $("#p_ownDeptId").val(null==treeNode?userInfo.orgId:treeNode.id);
        $("#p_ownDeptName").val(null==treeNode?userInfo.orgName:treeNode.name);

        $.getJSON("../plan/getNextSn", {
            parentPlanId: $("#p_parentId").val(),
            isDeptPlan: 1,
            orgId: null==treeNode?userInfo.orgId:treeNode.id
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
    });
    //取消保存
    $("#btnCancel").click(function(){
        "use strict";
        $("#popPlanWindow").window("close");
        var row=$("#grid1").treegrid("getSelected");
        if(null!=row){
            buttonStatusHandler(row);
        }
    });
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
            //单位计划，可以提交审批、审批，否则隐藏
            if(row.isDeptPlan==1){
                $("#btnPropose").show();
                $("#btnPropose1").show();
                $("#btnApprove").show();
                $("#btnApprove1").show();
                $("#btnRaisePlan").hide();
            }else{
                $("#btnPropose").hide();
                $("#btnPropose1").hide();
                $("#btnApprove").hide();
                $("#btnApprove1").hide();
                $("#btnRaisePlan").show();
            }
            setFiedlStatus(row);
        },
        onLoadSuccess:function(data){
            "use strict";
            var selectedRow=$("#grid1").treegrid("getSelected");
            if(selectedRow!=null) {
                buttonStatusHandler(selectedRow);
                //如当前登录用户和审批人匹配,则enable审批按钮,否则disable
                if (selectedRow.approverId != null && userInfo.userId != "" && selectedRow.approverId == userInfo.userId && selectedRow.status == 2) {
                    $("#btnApprove").linkbutton("enable");
                    $("#btnApprove1").linkbutton("enable");
                } else {
                    $("#btnApprove").linkbutton("disable");
                    $("#btnApprove1").linkbutton("disable");
                }
                //如果当前计划是顶层计划，则可以进行提交审批、审批操作
                if (selectedRow.parentId != null && selectedRow.parentId != "") {
                    $("#btnApprove").linkbutton("disable");
                    $("#btnPropose").linkbutton("disable");
                    $("#btnApprove1").linkbutton("disable");
                    $("#btnPropose1").linkbutton("disable");
                } else {
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
        onDblClickRow:function(index,row){
            "use strict";
            showModalDialog("popPlanWindow","修改计划任务-详细信息");
            var row=$("#grid1").treegrid("getSelected");
            operateType="addNew";
            //$("#planForm").form("clear");
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
    $("#grid1").treegrid({
        url:'./planItems',
        queryParams: {
            cycleType: 1,
            cycle: new Date().getMonth()+1,
            isSelfDeptPlan:window.isSelfDeptPlan,
            isDeptPlan:window.isDeptPlan
        }
    });

    //人员选择窗口确认按钮事件
    $("#btnPersonSelect").click(function(){
        "use strict";
        var options = $("#grid3").treegrid("options");
        if(options.singleSelect) {
            var row = $('#grid3').treegrid('getSelected');
            if (row != undefined){
                if(row.isParent) {
                    $.messager.alert("操作错误", "本操作只能选择人员!");
                    return false;
                } else {
                    if ($('#personSelectDialog').dialog("options").title == "选择负责人") {
                        $("#p_superintendentId").val(row.id);
                        $("#p_superintendentName").textbox("setValue", row.name);
                        //$("#p_superintendDeptId").val(row.orgId);
                        //$("#p_superintendDeptName").textbox("setValue", row.orgName);
                    } else if ($('#personSelectDialog').dialog("options").title == "选择执行人") {
                        $("#p_ownerId").val(row.id);
                        $("#p_ownerName").textbox("setValue", row.name);
                    } else if ($('#personSelectDialog').dialog("options").title == "选择核实人") {
                        $("#p_verifierId").val(row.id);
                        $("#p_verifierName").textbox("setValue", row.name);
                    } else if ($('#personSelectDialog').dialog("options").title == "选择审批人") {
                        $("#p_approverId").val(row.id);
                        $("#p_approverName").textbox("setValue", row.name);
                    }
                }
            }
        } else {
            //协助人
            var rows = $('#grid3').treegrid('getSelections');
            var coupler = "";
            var coupler_text = "";
            if(rows.length > 0) {
                for (var i=0; i<rows.length; i++) {
                    if(!rows[i].isParent) {
                        coupler += rows[i].id;
                        coupler += "/";
                        coupler += rows[i].name;
                        coupler_text += rows[i].name;
                        if (i < rows.length - 1) {
                            coupler += ";";
                            coupler_text += ";";
                        }
                    }
                }
            }
            $('#p_coupler').textbox("setValue", coupler);
            $('#p_coupler').textbox("setText", coupler_text);
        }

        $('#personSelectDialog').dialog('close');
    });

    //单位选择窗口确认按钮事件
    $("#btnDeptSelect").click(function(){
        "use strict";
        if($('#deptSelectDialog').dialog("options").title == "选择责任部门") {
            var row = $('#grid4').treegrid('getSelected');
            if (row != undefined){
                $("#p_superintendDeptId").val(row.id);
                $("#p_superintendDeptName").textbox("setValue", row.name);
            }
        } else {
            var rows = $('#grid4').treegrid('getSelections');
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
        var planId=$("#p_id").val()==""?$("#grid1").datagrid("getSelected").id:$("#p_id").val();
        estimatePlan(planId);
    });
    $("#btnCancelEstimate").click(function(){
        "use strict";
        $("#diaEstimate").dialog("close");
    });

    $("#btnSaveAttachment").click(saveAttachment);
    $("#btnSaveComment").click(saveComment);
    $("#btnPersonFilter").click(btnPersonFilterHandler);
    $("#btnDeptFilter").click(btnDeptFilterHandler);

    orgPlanInit();
});
