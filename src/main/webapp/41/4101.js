window.xydm = "33AE62C37FEF178DE050A8C085052133";

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

function formatUploadButton(value, rowData, rowIndex) {

    return "<a class='easyui-linkbutton' onclick='uploadFile(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";

}
$(function () {

    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=scztMapper&queryName=queryHccl';
    options.queryParams = {
        xydm: window.xydm
    };
    $("#mainGrid").datagrid(options);
});