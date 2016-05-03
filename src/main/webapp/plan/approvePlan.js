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
    return val!=1 ? "": "<span><img src='../images/user-16.png' /></span>";
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

function formatNeedVerify(val, row) {
    return val!=1 ? "": "<span><img src='../images/task-finished-16.png' /></span>";
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

function init(){
    "use strict";
    var options = $('#grid1').treegrid('options');
    options.url = '../common/query?mapper=planMapper&queryName=query';
    //options.queryParams.userId = window.userInfo.userId;
    options.queryParams.status = 2;//待审批的计划
    options.queryParams.approverId = window.userInfo.userId;//审批人是自己
    $("#grid1").treegrid(options);
}
$(function() {
    //取得登录用户信息
    getUserInfo();
    if(null!=window.userInfo){
        init();
    }else {
        $.subscribe("USERINFO_INITIALIZED", init);
    }
    $("#btnApprove").click(function(){
        "use strict";
        if(!$(this).linkbutton('options').disabled) {
            _updatePlanStatus(3);
        }
    });
});