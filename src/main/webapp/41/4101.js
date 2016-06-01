//window.xydm = "33AE62C37FEF178DE050A8C085052133";

function uploadFile(row) {
    console.log(row);
    showModalDialog("documentWindow");
    $("#docPanel").panel({
        href: './4101DocForm.jsp',
        onLoad: function () {
            doInit();
        }
    });
}

function displayAttachment(mongoId) {
    $("<iframe id='download' style='display:none' src='../display?mongoId=" + mongoId + "'/>").appendTo("body");
}

function formatUploadButton(value, rowData, rowIndex) {
    if (null == rowData.MONGO_ID) {
        return "<a class='easyui-linkbutton' onclick='uploadFile(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";
    } else {
        return "<a href=\"javascript: displayAttachment('" + rowData.MONGO_ID + "');\">查看</a>";
    }
}
$(function () {

    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=scztMapper&queryName=queryHccl';
    options.queryParams = {
        xydm: window.xydm,
        nd: 2016
    };
    $("#mainGrid").datagrid(options);
});