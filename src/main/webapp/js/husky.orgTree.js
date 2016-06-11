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
        onClick: _onTreeClick,
        onAsyncSuccess: zTreeOnAsyncSuccess
    }
};

var log, className = "dark";

//树加载成功后事件
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {

}
//zTree点击前事件
function beforeTreeClick(treeId, treeNode, clickFlag) {
    className = (className === "dark" ? "":"dark");
    return (treeNode.click != false);
}
//zTree点击事件
function _onTreeClick(event, treeId, treeNode, clickFlag) {
	onTreeClick(event, treeId, treeNode, clickFlag);
}

function processorOrgId(orgId) {
	var result = orgId;
	while(result.endsWith("00")) {
		result = result.substr(0,result.length - 2);
	}
	return result;
}
