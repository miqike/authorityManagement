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

function init(){
    "use strict";
    var options = $('#grid1').treegrid('options');
    options.url = '../common/query?mapper=planMapper&queryName=query';
    //options.queryParams.userId = window.userInfo.userId;
    options.queryParams.status = 7;//已经完成的计划
    options.queryParams.verifierId = window.userInfo.userId;//核实人是自己
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
});