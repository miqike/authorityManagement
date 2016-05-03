
function mainGridButtonHandler() {
    if($('#mainGrid').datagrid('getSelected') != null) {
        $('#btnView').linkbutton('enable');
        $('#btnDelete').linkbutton('enable');
        $('#btnResetPass').linkbutton('enable');
        $('#btnLock').linkbutton('enable');
    } else {
        $('#btnView').linkbutton('disable');
        $('#btnDelete').linkbutton('disable');
        $('#btnResetPass').linkbutton('disable');
        $('#btnLock').linkbutton('disable');
    }
}

function add(){
    $('#popedWindow input').val('');
    showModalDialog("popedWindow");
}

function view(){
    var row = $('#mainGrid').datagrid('getSelected');
    if (row){
        $("#chargerGroup").combobox("setValue", row.chargerGroup);
        $("#tollGroup").combobox("setValue", row.tollGroup);
        $("#feeGroup").combobox("setValue", row.feeGroup);
        $("#description").textbox("setValue", row.description);
        showModalDialog("popedWindow");
    }
}

function remove(){
    var row = $('#mainGrid').datagrid('getSelected');
    if (row){
        $.messager.confirm('确认删除','确认删除账户',function(r){
            if (r){
                $.getJSON("../master/chargerTollFee/" + row.id + "/delete", null, function(response){
                    if(response.status == SUCCESS){
                        $('#mainGrid').datagrid('reload');
                    } else{
                        $.messager.alert('删除失败',response,'info');
                    }
                });
            }
        });
    }
}


function saveUser(){
    if($('#popedWindow').form('validate')) {
        var row = $('#mainGrid').datagrid('getSelected');
        $.post("../user/" + row.id, {
            id:row.id,
            userId: $("#p_userId").val(),
            name: $("#p_name").val(),
            dwId: $("#p_dwId").val(),
            dwname: $("#p_dwname").val(),
            gw: $("#p_gw").val(),
            status: $("#p_status").val(),
            mobilePhoneNumber: $("#p_phone").val(),
            email: $("#p_email").val()
        }, function(response) {
            if(response.status == FAIL){
                $.messager.alert('保存失败', response.message, 'info');
            } else {
                $("#mainGrid").datagrid("reload");
                $.messager.alert('保存成功','保存成功','info');
                //$("#popedWindow").window("close");
            }
        }, "json");
    }
    return false;
}

function init() {
    $.getJSON("../master/chargerTollFee", {}, function(response) {
        $("#chargerGroup").combobox({
            data:response.chargerGroup,
            valueField:"value",
            textField:"literal"
        });
        $("#tollGroup").combobox({
            data:response.tollGroup,
            valueField:"value",
            textField:"literal"
        });
        $("#feeGroup").combobox({
            data:response.feeGroup,
            valueField:"value",
            textField:"literal"
        });

        initMainTab();
    });
}

function initTab(url, param, detailGridUrl, grid, detailGridColumns) {
    $.post(url, param, function(response) {
        grid.datagrid({
            view: detailview,
            detailFormatter:function(index, row) {
                return '<div class="ddv" style="padding:5px 0"><table></table></div>';
            },
            onExpandRow: function(index, _row){
                var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
                ddv.panel({
                    border:false,
                    cache:false
                });
                $.getJSON(detailGridUrl + _row.value, null, function(response) {
                    var gridTable = ddv.find("table");
                    gridTable.datagrid({
                        toolbar:"#detailGridToolbar",
                        columns:detailGridColumns
                    }).datagrid('loadData', response);

                    grid.datagrid('fixDetailRowHeight',index);
                });
                grid.datagrid('fixDetailRowHeight',index);
            }
        }).datagrid("loadData", response.rows);
    }, "json");
}

function initMainTab(){
    $.getJSON('../common/query?mapper=chargerTollFeeMapper&queryName=queryChargerTollFee', null, function(response) {
        $("#mainGrid").datagrid("loadData", response.rows);
    });
}

function tabSelectHandler(title, index) {
    var row = $('#mainGrid').datagrid('getSelected');
    if(index == 0) { //
        initMainTab();
    } else if (index == 1) { //
        initTab("../common/query?mapper=orgGroupMapper&queryName=queryCodeByType",
            {type: 1},
            '../master/orgGroup/',
            $("#chargerGrid"),
            [[
                {field:'orgId',title:'单位编码',width:100},
                {field:'orgName',title:'单位名称',width:300}
            ]]
        );

    } else if (index == 2) { //
        initTab("../common/query?mapper=orgGroupMapper&queryName=queryCodeByType",
            {type: 2},
            '../master/orgGroup/',
            $("#tollGrid"),
            [[
                {field:'orgId',title:'单位编码',width:100},
                {field:'orgName',title:'单位名称',width:300}
            ]]
        );

    } else if (index == 3) { //

        initTab("../common/query?mapper=feeGroupMapper&queryName=queryCode",
            null,
            '../master/feeGroup/',
            $("#feeGrid"),
            [[
                {field:'feeId',title:'项目编码',width:100},
                {field:'feeName',title:'名称',width:300}
            ]]
        );
    }
}

function fillResourceCheckbox() {
    var rows = $("#tg").treegrid("getData");
    fillResourceCheckboxRecursive(rows);
    $("#tg").parent().find("input:checkbox").attr("disabled", true);
}

function fillResourceCheckboxRecursive(rows) {
    $.each(rows, function(idx, rowData) {
        if(_.contains(ownedResources, rowData.id)) {
            $('#tg').datagrid('checkRow', rowData.id);
        }
        if(rowData.children.length > 0) {
            fillResourceCheckboxRecursive(rowData.children);
        }
    });
}
/*

function editOrSaveUserRole() {
    var linkbutton = $("#btnEditOrSaveUserRole");
    var options = linkbutton.linkbutton("options");

    if(options.text == "编辑") {
        $("#btnEditOrSaveUserRole").linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });

        $("#grid2").parent().find("input:checkbox").attr("disabled", false);

    } else {
        $("#btnEditOrSaveUserRole").linkbutton({
            iconCls:'icon-edit',
            text:'编辑'
        });

        $("#grid2").parent().find("input:checkbox").attr("disabled", true);
        saveUserRole();
    }
}

function saveUserRole() {
    var checkedRows = $('#grid2').datagrid('getChecked');
    var param = new Array();
    $.each(checkedRows, function(idx, elem) {
        param.push(elem.id);
    });
    $.post("../user/" + $('#mainGrid').datagrid('getSelected').userId + "/role", {
        roleIds:param.join(',')
    }, function(response){
        if(response.status == SUCCESS) {
            $.messager.alert("提示", "用户角色保存成功");
        } else {
            $.messager.alert("错误", "用户角色保存失败");
        }
    }, "json");
}
*/


function editOrSave () {
    var linkbutton = $("#btnEditOrSave");
    var options = linkbutton.linkbutton("options");

    if(options.text == "编辑") {
        $("#btnEditOrSave").linkbutton({
            iconCls:'icon-save',
            text:'保存'
        });

        $("#chargerGroup").combobox("enable").combobox("readonly", false);
        $("#tollGroup").combobox("enable").combobox("readonly", false);
        $("#feeGroup").combobox("enable").combobox("readonly", false);
        $("#description").textbox("enable").textbox("readonly", false);

    } else {
        $("#btnEditOrSave").linkbutton({
            iconCls:'icon-edit',
            text:'编辑'
        });
        $("#chargerGroup").combobox("disable");
        $("#tollGroup").combobox("disable");
        $("#feeGroup").combobox("disable");
        $("#description").textbox("disable");

        saveUser();
    }
}

function selectChargerGroup() {
    $("#chargerGroupDatagrid").datagrid({
        url:'../master/chargerGroup',
        onClickRow:function(row) {
            $("#btnChargerGroupSelect").linkbutton('enable');
        }
    });
    $('#chargerGroupSelectDialog').dialog('open');
}

function organizationSelect() {
    var selected = $("#organizationTreegrid").treegrid('getSelected');
    $("#p_dwId").textbox("setValue", selected.id);
    $("#p_dwname").textbox("setValue", selected.name);
    $('#organizationSelectDialog').dialog('close');
}

function addChargerGroup() {

    var setting = {
        key: {
            title:"parentIds"
        },
        async: {
            enable: true,
            type: "get",
            url:"../master/organization",
            autoParam:["id"]/*,
            dataFilter: filter*/
        },
        callback: {
            //beforeClick: beforeClick,
            //onClick: onClick
        }
    };

    $.fn.zTree.init($("#leftTree"), setting);

    showModalDialog('orgGroupWindow');
}

function deleteChargerGroup() {

}

function editChargerGroup() {

}

function addItem2Group() {
    var currentChargerGroup = model.currentChargerGroup;
    var leftTree = $.fn.zTree.getZTreeObj("leftTree");
    var selectedNodes = leftTree.getSelectedNodes();

    var setting = {

        simpleData: {
            enable: true,
            pIdKey: "parentId"
        },
        callback: {
            //beforeClick: beforeClick,
            //onClick: onClick
        }
    };

    $.fn.zTree.init($("#rightTree"), setting, selectedNodes);

    var rightTree = $.fn.zTree.getZTreeObj("rightTree");




}

function removeItem2Group() {


}

function saveChargerGroup() {
    var currentChargerGroup = model.currentChargerGroup;
    var leftTree = $.fn.zTree.getZTreeObj("leftTree");
    var selectedNodes = leftTree.getSelectedNodes();

    var groupId = $("#groupId").textbox("getValue");
    var groupType = $("#groupType").textbox("getValue");
    var groupName = $("#groupName").textbox("getValue");

    var orgGroupArray = new Array();

    for(idx in selectedNodes) {
        var node = selectedNodes[idx];
        orgGroupArray.push({
                orgName:node.name,
                orgId:node.id,
                orgCode:node.orgCode,
                groupId: groupId,
                groupType: groupType,
                groupName: groupName
            });
    }

    $.ajax({
        url:"../master/orgGroup",
        data:JSON.stringify(orgGroupArray),

        type:"post",
        contentType: "application/json; charset=utf-8",
        cache:false,
        success: function(response) {
        }
    });
}

$(function() {
    window.model = {
        chargerTollFeeList:[],
        chargerGroupList:[],
        tollGroupList:[],
        feeGroupList:[],
        currentChargerGroup:[],
        currentTollGroupList:[],
        currentFeeGroupList:[]
    }
    $("#btnAdd").click(add);
    $("#btnView").click(view);
    $("#btnDelete").click(remove);

    $("#btnEditOrSave").click(editOrSave);

    $("#btnAddChargerGroup").click(addChargerGroup);
    $("#btnEditChargerGroup").click(editChargerGroup);
    $("#btnDeleteChargerGroup").click(deleteChargerGroup);

    $("#btnSaveChargerGroup").click(saveChargerGroup);

    $("#btnAddItem2Group").click(addItem2Group);
    $("#btnRemoveItem2Group").click(removeItem2Group);

    init();

});