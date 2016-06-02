window.excludeSaved = false;

function collapseHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
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

function xxxx(orgId) {
    var year = $("#f_year").numberspinner('getValue');
    window.planGridKey = {year: year, tOrgId: orgId, excludeSaved: excludeSaved};
    if (orgId != undefined && orgId != null)
        refreshFunGrid(orgId);
}
//================

function onTreeClick(event, treeId, treeNode, clickFlag) {
    var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes()
    var hcjh = $('#grid1').datagrid('getSelected');
    if (selected.length == 1 && hcjh != null) {

        var options = $("#grid2").datagrid("options");
        options.url = '../common/query?mapper=hcrwMapper&queryName=queryForOrg';
        $('#grid2').datagrid('load', {
            hcjhId: hcjh.id,
            organization: selected[0].id
        });

        $("#btnSort1").linkbutton("enable");
        $("#btnSort2").linkbutton("enable");
        $("#btnAccept").linkbutton("enable");
    } else {
        $("#btnSort1").linkbutton("disable");
        $("#btnSort2").linkbutton("disable");
        $("#btnAccept").linkbutton("disable");
    }
}

function grid1ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnModify').linkbutton('enable');
        $('#btnAudit').linkbutton('enable');
        $('#btnViewCheckList').linkbutton('enable');
        if ($('#grid1').datagrid('getSelected').shzt != 2) {
            $('#btnModify').linkbutton('enable');
            $('#btnAudit').linkbutton({
                text: '审核',
                iconCls: 'icon2 r14_c2'
            });
        } else {
            $('#btnModify').linkbutton('disable');
            $('#btnAudit').linkbutton({
                text: '取消审核',
                iconCls: 'icon2 r14_c1'
            });
        }
    } else {
        $('#btnModify').linkbutton('disable');
        $('#btnAudit').linkbutton('disable');
        $('#btnViewCheckList').linkbutton('disable');
    }
    $('#grid2').datagrid("loadData", {total: 0, rows: []})
}

function grid2ClickHandler() {
    if ($('#grid1').datagrid('getSelected') != null) {
        $('#btnShowDetail').linkbutton('enable');
    } else {
        $('#btnShowDetail').linkbutton('disable');
    }
}

function setFormFieldStatus(formId, operation) {
    $("#" + formId + " input.easyui-textbox." + operation).textbox("enable");
    $("#" + formId + " input.easyui-combobox." + operation).combobox("enable");
    $("#" + formId + " input.easyui-numberspinner." + operation).numberspinner("enable");
    $("#" + formId + " input.easyui-datebox." + operation).datebox("enable");
    $("#" + formId + " input.easyui-textbox:not(." + operation + ")").textbox("disable");
    $("#" + formId + " input.easyui-combobox:not(." + operation + ")").combobox("disable");
    $("#" + formId + " input.easyui-numberspinner:not(." + operation + ")").numberspinner("disable");
    $("#" + formId + " input.easyui-datebox:not(." + operation + ")").datebox("disable");
}
function add() {
    showModalDialog("planWindow");
    $("#planTable input").val('');
    setFormFieldStatus("planTable", "add");

    $("#btnEditOrSave").linkbutton({
        iconCls: 'icon-save',
        text: '保存'
    });
    $("#btnImportTask").linkbutton("disable");
    $('#tabPanel').tabs('select', 0);
}

function modify() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $('#grid1').datagrid('getSelected');
        if (row) {
            showModalDialog("planWindow");
            $("#btnSavePlan").linkbutton("enable");
            $.easyuiExtendObj.loadForm("planTable", row);
            /*$("#btnEditOrSave").parent().css("text-align", " left");
             $('#userWindow input.easyui-validatebox').validatebox();*/
        }
        setFormFieldStatus("planTable", "modify");
        if (row.hcrwsl == null) {
            $("#btnImportTask").linkbutton("enable");
        } else {
            $("#btnImportTask").linkbutton("disable");
        }
        $('#tabPanel').tabs('select', 0);
    }
}

function audit() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $('#grid1').datagrid('getSelected');
        if (row) {
            var action = row.shzt == 1 ? '审核' : '取消审核';
            $.messager.confirm(action + '确认', '请确认是否对本计划进行<' + action + '>操作?', function (r) {
                if (r) {
                    $.getJSON("./hcjh/audit/" + row.id + "/" + row.shzt, null, function (response) {
                        if (response.status == SUCCESS) {
                            $.messager.alert("提示", action + "成功", 'info');
                            $('#grid1').datagrid('reload');
                        } else {
                            $.messager.alert("错误", action + '失败: \n' + response.message, 'info');
                        }
                    });
                }
            });
        }
    }

}

function formatZfry(val, row) {
    return row.zfryName1 + "/" + row.zfryName2;
}

function tabSelectHandler(title, index) {
    var planId = $('#p_id').val();
    if (index == 1) { //选择角色TAB
        if (planId != "") {
            if ($('#p_hcrwsl').textbox('getValue') == "") {
                $.messager.alert("提示", "任务信息尚未导入");
                $('#tabPanel').tabs('select', 0);
            } else {
                /*$.getJSON("../common/query?mapper=hcrwMapper&queryName=queryForPlan", {planId:planId }, function(response) {
                 $("#grid3").datagrid("loadData", response.rows);
                 });
                 */
                var options = $("#grid3").datagrid("options");
                options.url = '../common/query?mapper=hcrwMapper&queryName=queryForPlan';
                $('#grid3').datagrid('load', {
                    planId: planId
                });
            }
        } else {
            $.messager.alert("操作错误", "请先保存计划基本信息");
            $('#tabPanel').tabs('select', 0);
        }
    }
}

function viewCheckList() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $("#grid1").datagrid('getSelected');

        showModalDialog("checklistWindow");
        var options = $("#grid4").datagrid("options");
        options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlan';
        $('#grid4').datagrid('load', {
            hcjhId: row.id
        });
    }
}

function funcAdd4() {
    if (!$(this).linkbutton('options').disabled) {
        var row = $("#grid1").datagrid('getSelected');

        showModalDialog("addChecklistWindow");
        var options = $("#grid5").datagrid("options");
        options.url = '../common/query?mapper=hcsxMapper&queryName=queryForPlanCandidate';
        $('#grid5').datagrid('load', {
            hcjhId: row.id,
            nr: row.nr
        });
    }
}

function funcClose4() {
    $("#checklistWindow").window("close");
}

function funcSave5() {

    var checkedRows = $('#grid5').datagrid('getSelections');
    var param = new Array();
    $.each(checkedRows, function (idx, elem) {
        param.push(elem.id);
    });

    $.ajax({
        url: "./hcjh/hcsx/" + $('#grid1').datagrid('getSelected').id,
        data: JSON.stringify(param),
        type: "put",
        contentType: "application/json; charset=utf-8",
        cache: false,
        success: function (response) {
            if (response.status == SUCCESS) {
                //$.messager.alert("提示", "用户角色保存成功");

                $('#grid4').datagrid('reload')
                $('#grid5').datagrid('reload')
                /*$.messager.show({
                 title : '提示',
                 msg : "用户角色保存成功"
                 });*/
            } else {
                $.messager.alert("错误", "核查事项保存失败");
            }
        }
    });

    $("#grid5").datagrid("reload");
    //$("#addChecklistWindow").window("close");
}


function funcClose5() {
    $("#addChecklistWindow").window("close");
}

function loadGrid1() {
    var options = $("#grid1").datagrid("options");
    options.url = '../common/query?mapper=hcjhMapper&queryName=query';
    $('#grid1').datagrid('load', {
        nd: $('#f_nd').numberspinner("getValue"),
        jhbh: $('#f_jhbh').textbox("getValue"),
        gsjhbh: $('#f_gsjhbh').textbox("getValue"),
        jhmc: $('#f_jhmc').textbox("getValue"),
        nr: $('#f_nr').combobox("getValue"),
        fl: $('#f_fl').combobox("getValue")
    });
}

function clearInput() {
    $("#f_id").val("");
    $("#f_jhbh").textbox("setValue", "");
    $("#f_gsjhbh").textbox("setValue", "");
    $("#f_jhmc").textbox("setValue", "");
    $("#f_nr").combobox("setValue", "");
    $("#f_fl").combobox("setValue", "");
}

function funcBtnRest() {
    $("#f_nd").textbox("setValue", new Date().getFullYear());
    clearInput();
}

function funcSavePlan() {
    //debugger;
    if ($("#planTable").form('validate') && !$(this).linkbutton('options').disabled) {
        savePlan();
    }
}

//设置页面为不可编辑状态
function setReadOnlyStatus() {
    /*$("#btnAdd").linkbutton('enable');
     $("#btnEdit").linkbutton('enable');
     $("#btnDelete").linkbutton('enable');
     $("#btnSave").linkbutton('disable');
     $("#btnCancel").linkbutton('disable');*/

    $("#planTable input.easyui-numberspinner").numberspinner("disable");
    $("#planTable input.easyui-textbox").textbox("disable");
    $("#planTable input.easyui-datebox").datebox("disable");
    $("#planTable input.easyui-combobox").combobox("disable");
    $("#planTable input.easyui-combotree").combotree("disable");
}

function savePlan() {
    var data = $.easyuiExtendObj.drillDownForm('planTable');
    data.id = $("#p_id").val();
    var type = "";
    var url = "../31/hcjh";
    $.ajax({
        url: url,
        type: "POST",
        data: data,
        success: function (response) {
            if (response.status == SUCCESS) {
                $('#p_id').val(response.id);
                setReadOnlyStatus();
                $("#btnSavePlan").linkbutton("disable");
                $("#btnImportTask").linkbutton("enable");
                $('#grid1').datagrid('reload');
                /*var options = $('#grid1').datagrid('options');
                 options.url = '../common/query?mapper=hcjhMapper&queryName=query';
                 $("#grid1").datagrid(options);
                 if ($("#grid1").datagrid("getSelected") != null) {
                 $("#btnView").linkbutton("enable");
                 $("#btnDelete").linkbutton("enable");
                 } else {
                 $("#btnView").linkbutton("disable");
                 $("#btnDelete").linkbutton("disable");
                 }*/

                //$("#baseWindow").window("close");
            } else {
                $.messager.alert('失败', response.message, 'info');
            }
        }
    });

}
function funcImportTask() {
    if (!$(this).linkbutton('options').disabled) {
        showModalDialog("importTaskWindow");
    }
}

function selectImportType() {
    var importType = $("#importTaskWindow input:radio:checked").val();
    $("#importTaskWindow #" + importType).show();
    $("#importTaskWindow div:not(#" + importType + ")").hide();

}

function testDblink() {
    $.getJSON("./hcjh/testDblink", null, function (response) {
        if (response.status == SUCCESS) {
            $("#importReport #_hcrws").text(response.hcrws);
            $("#importReport #_hcrys").text(response.hcrys);
            $("#importReport").show();
        }
    });
}

function importDblink() {
    if (!$(this).linkbutton('options').disabled) {
        var hcjhId = $("#p_id").val();
        $.getJSON("./hcjh/importDblink/" + hcjhId, null, function (response) {
            if (response.status == SUCCESS) {
                $.messager.alert("提示", "数据导入成功,导入任务: " + response.hcrws, 'info');
                loadGrid1();

            }
        });
    }
}
//初始化
$(function () {
    $.fn.zTree.init($("#orgTree"), setting);
    $("#btnAdd").click(add);
    $("#btnModify").click(modify);
    $("#btnAudit").click(audit);
    $("#btnViewCheckList").click(viewCheckList);
    $("#btnAdd4").click(funcAdd4);
    $("#btnClose4").click(funcClose4);
    $("#btnSave5").click(funcSave5);
    $("#btnClose5").click(funcClose5);
    /*
     $("#btnAddPlan").hide();*/
    $("#f_nd").textbox("setValue", new Date().getFullYear());
    clearInput();
    loadGrid1();
    $("#btnSearch").click(loadGrid1);
    $("#btnReset").click(funcBtnRest);
    $("#btnSavePlan").click(funcSavePlan);
    $("#btnImportTask").click(funcImportTask);
    $("#importTaskWindow input:radio").click(selectImportType);

    $("#btnTestDblink").click(testDblink);
    $("#btnImportDblink").click(importDblink);


    /*
     */
});

