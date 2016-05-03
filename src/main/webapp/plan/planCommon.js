window.sortFields = [
    {literal: '编号', value: 'SN'},
    {literal: '名称', value: 'TITLE'},
    {literal: '来源', value: 'LEVEL'},
    {literal: '状态', value: 'STATUS'},
    {literal: '开始时间', value: 'START'},
    {literal: '责任人', value: 'SUPERINTENDENT_NAME'},
    {literal: '执行人', value: 'OWNER_NAME'},
    {literal: '编制人', value: 'AUTHOR_NAME'},
    {literal: '核实人', value: 'VERIFIER_NAME'},
    {literal: '审批人', value: 'APPROVER_NAME'},
    {literal: '重要程度', value: 'IMPORTANCE'}
];

function formatWeight(value,row) {
    if(value == 0 && row.parentId == "") {
        return "";
    } else{
        return value;
    }
}

function formatCoupler(value,row){
    if(value != null && value != "") {
        var coupler = value.split(";");
        var text = "";
        for (var i = 0; i < coupler.length; i++) {
            text += coupler[i].split("/")[1];
            if (i < coupler.length - 1) {
                text += ";";
            }
        }
    }
    return text;
}

function formatDescription(value,row) {
    var html = '<span><input class="easyui-textbox" data-options="width:70,iconWidth:22,icons: [{ iconCls:\'icon-man\', handler: selectSuperintendent }]"></input></span>';
    $.parser.parse(html)
    return html;
}

function formatIsAssigned(val, row) {
	return val!=1 ? "": "<span>上级</span>";
}

function formatNeedVerify(val, row) {
    return val!=1 ? "": "<span><img src='../images/task-finished-16.png' /></span>";
}

function showPreviousCycle() {
    var cycle = parseInt($("#currentCycle").text());
    var currentYear = parseInt($("#currentYear").text());
    if(window.cycleType == 1 && cycle == 1) {
        cycle = 12;
        currentYear = currentYear - 1;
    } else if(window.cycleType == 2 && cycle == 1) {
        cycle = 4;
        currentYear = currentYear - 1;
    } else if(window.cycleType == 4 && cycle == 1) {
        currentYear = currentYear - 1;
        var lastDayOfLastYear = new Date(currentYear, 11, 31, 12, 59, 59, 999);
        cycle = theWeek(lastDayOfLastYear);
    } else {
        cycle -= 1;
    }

    if(window.cycleType == 3) {
        currentYear = cycle;
    }

    $("#currentYear").text(currentYear);
    $("#currentCycle").text(cycle);
    reloadMainGrid(cycleType, cycle, currentYear);
}

function reloadMainGrid(cycleType, cycle, year) {
    $("#grid1").treegrid({
        url:'./planItems',
        queryParams: {
            cycleType: cycleType,
            cycle: cycle,
            year: year,
            isDeptPlan: window.pageId == 'deptPlan' ? 1: 0,
            isSelfDeptPlan:window.isSelfDeptPlan,
            orgId:window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue"): null,
            sort:$("#sort").combobox("getValue"),
            order:$("#order").combobox("getValue")
        }
    });
}


function showNextCycle() {
	var cycle = parseInt($("#currentCycle").text());
    var currentYear = parseInt($("#currentYear").text());

    var lastDayOfThisYear = new Date(currentYear, 11, 31, 12, 59, 59, 999);
    if((window.cycleType == 1 && cycle == 12) || (window.cycleType == 2 && cycle == 4) || (window.cycleType == 4 && cycle == theWeek(lastDayOfThisYear))) {
        cycle = 1;
        currentYear = currentYear + 1;
    } else {
        cycle += 1;
    }

    if(window.cycleType == 3) {
        currentYear = cycle;
    }

    $("#currentYear").text(currentYear);
    $("#currentCycle").text(cycle);
    reloadMainGrid(cycleType, cycle, currentYear);
}

//负责人选择
function selectSuperintendent(e) {
    selectPerson("选择负责人", {
        singleSelect: true,
        queryParams: {
            pop: true,
            currentDeptId:window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue"): userInfo.orgId
        }});
}

//执行选择
function selectOwner(e) {
    if(window.pageId == 'deptPlan') {
        $.messager.confirm('确认选择执行人', '选择执行人之后将不能继续分解,请确认:', function (r) {
            if (r) {
                selectPerson("选择执行人", {
                    singleSelect: true,
                    queryParams: {
                        pop: false,
                        currentDeptId: window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue") : userInfo.orgId
                    }
                });
            }
        });
    }else{
        selectPerson("选择执行人", {
            singleSelect: true,
            queryParams: {
                pop: false,
                currentDeptId: window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue") : userInfo.orgId
            }
        });
    }
}

//协助人选择
function selectCoupler(e) {
    selectPerson("选择协作人", {
        singleSelect: false,
        queryParams: {
            pop: true,
            currentDeptId:window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue"): userInfo.orgId
        }
    });
}
//核实人选择
function selectVerifier(e) {
    selectPerson("选择核实人", {
        singleSelect: true,
        queryParams: {
            pop: true,
            currentDeptId:window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue"): userInfo.orgId
        }});
}

//审批人选择
function selectApprover(e) {
    selectPerson("选择审批人", {
        singleSelect: true,
        queryParams: {
            pop: true,
            currentDeptId:window.pageId == 'deptPlan' ? $("#deptName").combobox("getValue"): userInfo.orgId
        }});
}
function changeCycleType() {
	var newCycleType = $("input:radio[name='cycleType']:checked").val();
	if(window.cycleType != newCycleType) {
		window.cycleType = newCycleType;
        var now = new Date();
		var currentYear = now.getFullYear();
		var currentMonth = now.getMonth() + 1;
		var currentWeek = theWeek(now);
		var currentCycle;

		if(cycleType == 1) {
			currentCycle = currentMonth;
            $("#currentCycle").show();
            $("#cycleTypeLiteral").show().text("月份");
		} else if(cycleType == 2) {
			currentCycle = Math.floor(currentMonth / 3);
            $("#currentCycle").show();
            $("#cycleTypeLiteral").show().text("季度");
		} else if(cycleType == 3)  {
			currentCycle = currentYear;
            $("#currentCycle").hide();
            $("#cycleTypeLiteral").hide();
		} else if(cycleType == 4)  {
			currentCycle = currentWeek;
            $("#currentCycle").show();
            $("#cycleTypeLiteral").show().text("周");
		}
		$("#currentYear").text(currentYear);
		$("#currentCycle").text(currentCycle);

        reloadMainGrid(cycleType, currentCycle, currentYear);

	}
}

function displayAttachment(src) {
    $("<iframe id='download' style='display:none' src='../display?mongoId=" + $(src).parent().attr("mongoId") + "'/>") .appendTo("body");
}

function downloadAttachment(src) {
    $("<iframe id='download' style='display:none' src='../download?mongoId=" + $(src).parent().attr("mongoId") + "'/>") .appendTo("body");
}

function deleteAttachment(src) {
    $.ajax({
        url: "attachment/" + $(src).parent().attr("mongoId") ,
        type: 'DELETE',
        success: function (response) {
            if (response.status == SUCCESS) {
                loadAttachmentPanel($("#p_id").val());
                $.messager.show({
                    title: '提示',
                    msg: "文件已删除"
                });
            } else {
                $.messager.alert('错误', '文件删除失败：' + response.message, 'error');
            }
        }
    });

    //$("<iframe id='download' style='display:none' src='../download?mongoId=" + row.bi0511 + "'/>") .appendTo("body");

}

function loadAttachmentPanel(planId) {
    $.get('./attachment/' + planId, null, function (response) {
        var attachmentContent = $("#attachmentContent");
        attachmentContent.empty();
        for(var index in response) {
            var attachment = response[index];
            var content = '<div mongoId="';
            content += attachment.mongoId;
            content += '"><span style="display:inline-block;width:170px;"><a href="#" onclick="javascript:displayAttachment(this);">';
            content += attachment.name;
            content += '</a></span><span style="margin-left:10px;margin-right:10px;">';
            if(attachment.dispatch == 0) {
                content += '仅限本级';
            } else if (attachment.dispatch == 1) {
                content += '下发一级';
            } else {
                content += '下发所有';
            }

            content += '</span><a href="#" class="easyui-linkbutton" iconCls="icon2 r2_c1" plain="true" onclick="javascript:downloadAttachment(this);">下载</a>';
            content += '<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  onclick="javascript:deleteAttachment(this);">删除</a></div>';
            attachmentContent.append(content);
        }

        $.parser.parse(attachmentContent)
    }, "json");
}

function addAttachment() {
    $('input:radio[name="a_dispatch"]')[1].checked="checked";
    $('#a_name').textbox("setValue", "");
    $("#btnUpload").linkbutton("enable");
    $("#btnSaveAttachment").linkbutton("disable");

    var uploader = new qq.FileUploaderBasic({
        button: document.getElementById('btnUpload'),
        allowedExtensions: [],
        action: '../ajaxUpload',
        multiple: false,
        debug: false,

        onSubmit: function(id, fileName){
            uploader.setParams({
                owner:"PLAN",
                col:"",
                ownerKey: $("#p_id").val()
            });
            $("#progressbar").show().width('260px');
        },

        onProgress: function(id, fileName, loaded, total){
            var percentLoaded = (loaded / total) * 100;
            $( "#progressbar" ).progressBar(percentLoaded);
        },
        // display a fancy message
        onComplete: function (id, fileName, response) {
            $("#progressbar").hide();
            $("#a_name").textbox("setValue", fileName);
            $("#a_mongoId").val(response.mongoId);
            $("#btnUpload").linkbutton("disable");
            $("#btnSaveAttachment").linkbutton("enable");
        }

    });

    $('#addAttachmentDialog').dialog('open');
}

function saveAttachment() {
    var data=drillDownForm('addAttachmentDialog');
    data.planId = $("#p_id").val();
    data.dispatch = $("input:radio[name='d_dispatch']:checked").val();

    $.post("./attachment/", data, function(response) {
        if(response.status == FAIL){
            $.messager.alert('保存失败', response.message, 'info');
        } else {
            loadAttachmentPanel($("#p_id").val());
            $.messager.show({
                title : '提示',
                msg : "保存成功"
            });
            $('#addAttachmentDialog').dialog('close');
        }
    }, "json");
}

function loadCommentPanel(planId) {
    $.get('./comment/' + planId, null, function (response) {
        var commentContent = $("#commentContent");
        commentContent.empty();
        for(var index in response) {
            var comment = response[index];
            var content = formatDatetime2Min(comment.createTime);
            content += " ";
            content += comment.authorName;
            content += ":<br/><div style='margin-left:40px;'>";
            content += comment.content;
            content += "</div>";
            commentContent.append(content);
        }
    }, "json");
}

function addComment() {
    $('input:radio[name="d_dispatch"]')[1].checked="checked";
    $('#d_content').textbox("setValue", "");
    $('#addCommentDialog').dialog('open');
}

function saveComment() {
    var data=drillDownForm('addCommentDialog');
    data.planId = $("#p_id").val();
    data.dispatch = $("input:radio[name='d_dispatch']:checked").val();

    $.post("./comment/", data, function(response) {
        if(response.status == FAIL){
            $.messager.alert('保存失败', response.message, 'info');
        } else {
            loadCommentPanel($("#p_id").val());
            $.messager.show({
                title : '提示',
                msg : "保存成功"
            });
            $('#addCommentDialog').dialog('close');
        }
    }, "json");
}

//设置新计划默认值
function setPlanDefaultValue(){
    "use strict";
    var now = new Date().format("yyyy-MM-dd");
    $("#p_status").combobox("setValue",1);
    $("#p_authorId").val(userInfo.userId);
    $("#p_authorName").textbox("setValue",userInfo.name);
    $("#p_instancy").combobox("setValue",1);
    $("#p_importance").combobox("setValue",1);
    $("#p_progress").progressbar().progressbar("setValue",0);
    $("#p_createTime").datebox("setValue",now);
    $("#p_start").datebox("setValue",now);
    $("#p_end").datebox("setValue",now);
    $("#p_deptId").val(userInfo.orgId);
    $("#p_deptName").val(userInfo.orgName);
    $("#p_isAssigned").val("0");
    $("#p_description").textbox("setValue","");
    $("#p_needVerify").combobox("setValue", 0);

    $("#p_ownDeptId").val("");
    $("#p_ownDeptName").val("");
    $("#p_ownerId").val("");
    $("#p_ownerName").textbox("setValue","");
    $("#p_superintendentId").val("");
    $("#p_superintendentName").textbox("setValue","");
    $("#p_verifierId").val("");
    $("#p_verifierName").textbox({disabled: true}).textbox("setValue", "");
    //$("#p_approverId").val("");
    //$("#p_approverName").textbox({disabled: false,readonly:false}).textbox("setValue", "");
    //$("#p_qualityEstimate").combobox("setValue",2);
    //$("#p_effectiveEstimate").combobox("setValue",2);
    //$("#p_selfQualityEstimate").combobox("setValue",2);
    //$("#p_selfEffectiveEstimate").combobox("setValue",2);

    //设置页面内容状态
    var row=drillDownForm('planForm');
    row.status=0;
    var priButtonStatus= getButtonStatus(row);
    for(var i=0; i<buttons.length; i++ ) {
        $("#"+buttons[i]).linkbutton(getButtonStatusStatement(priButtonStatus[i]));
        $("#"+buttons[i]+"1").linkbutton(getButtonStatusStatement(priButtonStatus[i]));
    }
    row.status=1;
    setFiedlStatus(row);
}

function editDescription(){
    "use strict";
    $('#displayDescription').dialog({
        title: '目标要求',
        width: 600,
        height: 400,
        closed: false,
        cache: false,
        modal: true,
        onOpen:function(){
            $("#d_description").textbox("setValue",$("#p_description").textbox("getValue"));
            $("#d_description").textbox("readonly",false);
        },
        onClose:function(){
            $("#p_description").textbox("setValue",$("#d_description").textbox("getValue"));
        }
    }).dialog("center");

};

function estimatePlan(planId, ownerId){
    "use strict";
    var plan={"id":planId};
    if(userInfo.userId==ownerId){
        plan.selfQualityEstimate=$("input:radio[name='quality']:checked").val();
        plan.selfEffectiveEstimate=$("input:radio[name='effective']:checked").val();
    }else{
        plan.qualityEstimate=$("input:radio[name='quality']:checked").val();
        plan.effectiveEstimate=$("input:radio[name='effective']:checked").val();
    }

    $.post("../plan/update", plan,function(response){
        if(response.status == SUCCESS) {
            $('#grid1').treegrid("reload");
            if(userInfo.userId==$("#p_ownerId").val()){
                $("#p_selfQualityEstimate").combobox("setValue",$("input:radio[name='quality']:checked").val()) ;
                $("#p_selfEffectiveEstimate").combobox("setValue",$("input:radio[name='effective']:checked").val()) ;
            }else{
                $("#p_qualityEstimate").combobox("setValue",$("input:radio[name='quality']:checked").val()) ;
                $("#p_effectiveEstimate").combobox("setValue",$("input:radio[name='effective']:checked").val()) ;
            }

            $.messager.show({
                title : '提示',
                msg : response.message
            });
            $("#diaEstimate").dialog("close");
        } else {
            $.messager.alert("错误", response.message);
        }
    });
}

function setFiedlStatus(row) {
    var fieldStatus = getFieldStatus(row);
    for (var i = 0; i < fields.length; i++) {
        setInputFieldReadonly($("#p_" + fields[i]), !fieldStatus[i]);
    }
}

function sortChangeHandler(newValue, oldValue) {
    if(oldValue != "" && newValue != oldValue) {
        var cycle = parseInt($("#currentCycle").text());
        var currentYear = parseInt($("#currentYear").text());
        reloadMainGrid(cycleType, cycle, currentYear);
    }
}


function resetGrid3() {
    $("#grid3").treegrid("options").url = undefined;
}

function personTreeGridDblClickHandler() {
    "use strict";
    var options = $("#grid3").treegrid("options");
    if(options.singleSelect) {
        btnPersonSelectHandler();
    }
}

function btnPersonSelectHandler() {
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

//部门选择
function selectPerson(title, options) {
    $('#psd_filter').textbox("setValue", "");
    $('#personSelectDialog').dialog({ title:title,isItem:0}).dialog('open');
    options.url = '../sys/organization/getSubWithUser';
    $("#grid3").treegrid(options);
}

//责任部门选择
function selectSuperintendDept(e) {
    $("#grid4").treegrid({"singleSelect": true});
    selectDept("选择责任部门");
}

//协助部门选择
function selectCoupleDept(e) {
    $("#grid4").treegrid({"singleSelect": false});
    selectDept("选择协助部门");
}

function deptTreeGridDblClickHandler(index,row){
    "use strict";
    var options = $("#grid4").treegrid("options");
    if(options.singleSelect) {
        btnDeptSelectHandler();
    }
}

//部门选择
function selectDept(title) {
    var planDeptId = $('#p_ownDeptId').val();
    $('#dsd_filter').textbox("setValue", "");
    $("#grid4").treegrid({
        url:'../sys/organization/',
        queryParams: {
            currentDeptId: planDeptId
        }
    });

    $('#deptSelectDialog').dialog({ title:title,isItem:0}).dialog('open');
}

function btnDeptSelectHandler() {
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
}

function resetGrid4() {
    $("#grid4").treegrid("options").url = undefined;
}

function btnCancelHandler(){
    "use strict";
    $("#popPlanWindow").window("close");
    var row=$("#grid1").treegrid("getSelected");
    if(null!=row){
        buttonStatusHandler(row);
    }
}