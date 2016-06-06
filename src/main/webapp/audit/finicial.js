function executeFile(file, paramArray) {
    try {
        var _file = file;
        var fso = new ActiveXObject("Scripting.FileSystemObject");
        if (fso.FileExists(_file)) {
            var shellActiveXObject = new ActiveXObject("WScript.Shell");
            if (!shellActiveXObject) {
                alert('无法创建WScript.Shell');
                return;
            }
            var exePath = file;
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

function doInit() {
	executeFile("C:/ky1.0/sjp6.exe", null);
}

