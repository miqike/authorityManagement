var setting = {
    data: {
        key: {
            title:"parentId",
            name:"name"
        }},
    async: {
        enable: true,
        type: "get",
        url:"../sys/organization/getSub",
        autoParam:["id"]
    },
    callback: {
        beforeClick: beforeTreeClick,
        onClick: onTreeClick,
        onAsyncSuccess: zTreeOnAsyncSuccess
    }
};

//树加载成功后事件
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {

}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}
//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    $.easyuiExtendObj.loadForm("treeNodeForm",treeNode);
    setReadOnlyStatus();

    var tab = $('#tabPanel').tabs('getSelected');
    var index = $('#tabPanel').tabs('getTabIndex',tab);
    tabSelectHandler("",index);
}
