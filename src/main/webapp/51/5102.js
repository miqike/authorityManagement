function taskStatusStyler(val, row, index) {
    if (val == 1) {
        return "background-color:lightgray";
    } else if (val == 2) {
        return "background-color:orange";
    } else if (val == 3) {
        return "background-color:pink";
    } else if (val == 4) {
        return "background-color:red";
    } else if (val == 5) {
        return "background-color:lightgreen";
    }
}

function checkParam(param) {
    return param.planType != undefined;
}

function tabSelectHandler(title, index) {
    if (index == 0) {
        minimizeMyTaskWindow();
    }else{
        showTaskListWindow()
    }
}

function clearInput() {
    $("#f_nd").val("");
    $("#f_hcjhId").val("");
    $("#f_jhmc").val("");
    $("#f_hcdwXydm").val("");
    $("#f_hcdwName").val("");
    $("#p_id").val("");
    $("#p_jhbh").val("");
    $("#p_jhmc").val("");
    $('#p_hcdwXydm').val("");
    $('#p_hcdwName').val("");
    $("#p_jhnd").val("");
    $("#p_djjgmc").val("");
}

function loadMyTask() {
    $("#grid1").datagrid("load",  {
        planType: planType,
        nd: $('#f_nd').val(),
        hcjhId: $('#f_hcjhId').val(),
        jhmc: $('#f_jhmc').val(),
        hcdwXydm: $('#f_hcdwXydm').val(),
        hcdwName: $('#f_hcdwName').val()
    });
}

function minimizeMyTaskWindow() {
    $("#myTaskListWindow").window("minimize");
}

function showTaskListWindow() {
    var options = $("#grid1").datagrid("options");
    if (null != window.userInfo) {
        options.url = "../common/query?mapper=hcrwMapper&queryName=queryForAuditor" + (userInfo.ext1 == 1 ? 1: 2);
    } else {
        $.subscribe("USERINFO_INITIALIZED", loadMyTask);
    }

    $("#myTaskListWindow").window({
        title: "我的任务列表", top: 5, left: $.util.windowSize().width-755, width: 750, height: 450,
        modal:false,
        collapsible:true,
        closable:false,
        minimizable:true,
        border:false,
        autoVCenter: false,     //该属性如果设置为 true，则使窗口保持纵向居中，默认为 true。
        autoHCenter: false,      //该属性如果设置为 true，则使窗口保持横向居中，默认为 true。
        onOpen : function() {
            loadMyTask();
        }
    });
}

$(function () {
    $.husky.getUserInfo();
    // clearInput();
   /* if (null != window.userInfo) {
        minimizeMyTaskWindow();
    } else {
        $.subscribe("USERINFO_INITIALIZED", minimizeMyTaskWindow);
    }*/
});