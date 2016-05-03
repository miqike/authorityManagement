window.queryChild=false;

function levelExpandTree(newValue, oldValue) {
	levelExpand($.fn.zTree.getZTreeObj("orgTree"), newValue);
}

//查询用户
function queryUser(){
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	var selected = treeObj.getSelectedNodes()

	if(selected.length == 1) {
		var options = $("#mainGrid").datagrid("options");
		options.url = '../common/query?mapper=userMapper&queryName=queryUserForOrg';
		$('#mainGrid').datagrid('load',{
			organization: selected[0].id
		});

	} else {
	}

}
//更新单位树
function refreshOrgTree(){
	var setting = {
		data: {
			key: {
				title:"parentId",
				name:"name"
			}},
		async: {
			enable: true,
			type: "get",
			url: "../sys/organization/getSub",
			autoParam:["id"]
		},
		callback: {
			onClick: function(event, treeId, treeNode) {
				queryUser();
			}
		}
	};

	$.fn.zTree.init($("#orgTree"), setting);
}

function expandAll(e) {
	var zTree = $.fn.zTree.getZTreeObj("tree"),
		type = e.data.type,
		nodes = zTree.getSelectedNodes();
	if (type.indexOf("All")<0 && nodes.length == 0) {
		alert("请先选择一个父节点");
	}
	if (type == "expandAll") {
		expandNodes(zTree, zTree.getNodes());
		checkAuthorizedResourceNode();
	} else if (type == "collapseAll") {
		zTree.expandAll(false);
	}

}

function expandNodes(zTree, nodes) {
	if (!nodes) return;
	for (var i=0, l=nodes.length; i<l; i++) {
		zTree.expandNode(nodes[i], true, false, false, true);
		if (nodes[i].isParent && nodes[i].zAsync) {
			expandNodes(zTree,  nodes[i].children);
		}
	}
}

$(function() {
	//取得登录用户信息
	getUserInfo();
	if(null!=window.userInfo){
		refreshOrgTree();
	}else{
		$.subscribe("USERINFO_INITIALIZED", refreshOrgTree);
	}

	window._expandeLevel = $("#f_expandLevel").numberspinner("getValue");

	$("#btnReset").click(function(){
		if(!$(this).linkbutton('options').disabled){
			$("#f_name").val('');
			var dg = $('#mainGrid');
			dg.datagrid('disableFilter');
			$("#btnSearch").linkbutton('enable');
			var treeObj = $.fn.zTree.getZTreeObj("orgTree");
			var selected = treeObj.getSelectedNodes()[0];

			$('#mainGrid').datagrid('load',{
				organization: selected.ba01861
			});
		}
	});

	$("#btnSearch").click(function(){
		if(!$(this).linkbutton('options').disabled){
			var treeObj = $.fn.zTree.getZTreeObj("orgTree");
			var selected = treeObj.getSelectedNodes()[0];

			$('#mainGrid').datagrid('load',{
				name: encodeURI($('#f_name').val()),
				organization: selected.ba01861
			});
		}
	});

	$("#mainGrid").datagrid({
        onClickRow:function(index,row){
            "use strict";
            var options = $("#managedDeptGrid").datagrid("options");
            options.url = '../common/query?mapper=planUserOrgMapper&queryName=queryByUserId';
            $('#managedDeptGrid').datagrid('load',{
                userId:row.userId
            });
        }
	});
    $("#btnDeptAdd").click(function(){
        "use strict";
        showModalDialog("deptSelectDialog");
        var options = $("#gridDept").treegrid("options");
        options.url = '../sys/organization/getSub';
        $("#gridDept").treegrid(options).treegrid({loadFilter:function(data,parentId){
            //console.log(data);
            //console.log(parentId);
            return data;
        }});
    });
    $("#btnDeptCancel").click(function(){
        "use strict";
        $("#deptSelectDialog").dialog("close");
    });
    $("#btnDeptSelect").click(function(){
        "use strict";
        var managedDept=$("#managedDeptGrid").datagrid("getData").rows;
        var havedFlag=false;
        var rows = $('#gridDept').datagrid('getSelections');
        var param = new Array();
        $.each(rows, function(idx, elem) {
            for(var i=0;i<managedDept.length;i++){
                if(managedDept[i].orgId==elem.id){
                    havedFlag=true;
                    break;
                }
            }
            if(havedFlag==false) {
                param.push(elem.id);
            }
            havedFlag=false;
        });
		$.ajax({
			url:"../plan/saveUserOrg/" + $('#mainGrid').datagrid('getSelected').userId,
			data:JSON.stringify(param),
			type:"put",
			contentType: "application/json; charset=utf-8",
			cache:false,
			success: function(response) {
				if(response.status == SUCCESS) {
					$.messager.show({
						title : '提示',
						msg : "添加可编制计划单位成功"
					});
					$("#managedDeptGrid").datagrid("reload");
                    $("#deptSelectDialog").dialog("close");
				} else {
					$.messager.alert("错误", "添加可编制计划单位失败");
				}
			}
		});
    });
    $("#btnDeptDel").click(function(){
        "use strict";
        var managedDept=$("#managedDeptGrid").datagrid("getSelections");
        var param = new Array();
        $.each(managedDept, function(idx, elem) {
                param.push(elem.orgId);
        });
        $.ajax({
            url:"../plan/deleteUserOrg/" + $('#mainGrid').datagrid('getSelected').userId,
            data:JSON.stringify(param),
            type:"delete",
            contentType: "application/json; charset=utf-8",
            cache:false,
            success: function(response) {
                if(response.status == SUCCESS) {
                    $.messager.show({
                        title : '提示',
                        msg : "删除可编制计划单位成功"
                    });
                    $("#managedDeptGrid").datagrid("reload");
                } else {
                    $.messager.alert("错误", "删除可编制计划单位失败");
                }
            }
        });
    });
});