function executeFile(file, paramArray) {
    try {
        debugger;
        var _file = file;
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (fso.FileExists(_file)) {
            var shellActiveXObject = new ActiveXObject("WScript.Shell");
            if (!shellActiveXObject) {
                alert('无法创建WScript.Shell');
                return;
            }
            var exePath = "";
            $.getJSON("../user/" + userInfo.userId + "/all", null, function (response) {
                var qy = $("#grid1").datagrid("getSelected");
                //用户名&salt&加密后的密码&计划单编号&企业注册号&企业名称
                exePath = file + " " + response.userId + "&" + response.salt + "&" + response.password + "&" + $("#p_id").textbox("getValue") + "&" + qy.hcdwXydm + "&" + qy.hcdwName;
            });

            if (null != paramArray) {
                for (var i = 0; i < paramArray.length; i++) {
                    exePath = exePath + " " + paramArray[i];
                }
                alert(exePath);
            }

            shellActiveXObject.Run(exePath, 1, false);
            shellActiveXObject = null;
        }
        else {
            alert("系统检测到未安装" + file);
        }
    }
    catch (errorObject) {
        alert("请将站点设置为可信任站点，并将其安全级别设置为低!");
    }
}
//更新单位树
function execute() {
    executeFile("C:/ky1.0/sjp6.exe");
}

function doInit() {
    getUserInfo();
    if (null != window.userInfo) {
        execute();
    } else {
        $.subscribe("USERINFO_INITIALIZED", execute);
    }
}

