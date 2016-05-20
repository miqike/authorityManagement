
function planStatusStyler(value, rowData, rowIndex) {
	if(value == undefined || value == "00") {
		return "";
	} else if(value == '01') {
		return 'background-color:orange';
	} else if(value == '02') {
		return 'background-color:lightgreen';
	}

}

//根据索引值删除数组中指定的数据
function delArray(index, dataArray){
    var len=dataArray.length;
    for(var i=0;i<len;i=i+1){
        if(i==(index-1)){
            for(var j=i+1;j<len;j=j+1){
                //当前索引值后的数据都向前移
                dataArray[j-1]=dataArray[j];
            }
            //移完之后,自身长度减1
            dataArray.length--;
        }
    }
}
//删除明细项目
function funDeleteItem(){
	var rowNum=$("#popedPlanDetailGrid").datagrid("getRowIndex",$("#popedPlanDetailGrid").datagrid("getSelected"))+1;
	delArray(rowNum,window.itemList);
	$("#popedPlanDetailGrid").datagrid("loadData",window.itemList);
}

function validateBillType() {
	var billType = $("#billType").combobox("getValue");
	var valid = true;
	$.each(window.itemList, function(idx, item){
		if(billType == item.billType) {
			valid = false;
			return false;
		}
	});
	if(!valid) {
		$.messager.alert("警告", "票据名称不能重复");
		$("#billType").combobox("setValue", "");
	}
}

//增加明细
function funAddDetailItem(){
	if(!$(this).linkbutton('options').disabled) {
		if($('#planDetailWindow').form('validate')) {
			var data={
				bi0101:$("#billType").combobox("getValue"),//票据类型
				bi0111:$("#billType").combobox("getText"),//票据名称
				bi0123C:$("#billKind").combobox("getValue"),
				bi0134C:$("#unit").combobox("getValue"),//
				count:$("#count").text(),
				jan:$("#jan").textbox("getValue"),
				feb:$("#feb").textbox("getValue"),
				mar:$("#mar").textbox("getValue"),
				apr:$("#apr").textbox("getValue"),
				may:$("#may").textbox("getValue"),
				jun:$("#jun").textbox("getValue"),
				jul:$("#jul").textbox("getValue"),
				aug:$("#aug").textbox("getValue"),
				sep:$("#sep").textbox("getValue"),
				oct:$("#oct").textbox("getValue"),
				nov:$("#nov").textbox("getValue"),
				dec:$("#dec").textbox("getValue")
			};
			window.itemList.push(data);
			$("#popedPlanDetailGrid").datagrid("loadData",window.itemList);
		}
	}
}
//
function funCancelDetailItem(){
	cancelBack("planDetailWindow");
}
//增加项目
function funAddItem(){
	var orgId = $("#deptName").combobox('getValue');
	getBillType(orgId);
	openDetailWindow();
/*
	if(window.billTypeMap[orgId] == undefined) {
		$.getJSON('../common/query?mapper=bi01Mapper&queryName=queryForBa01', {ba01861: orgId}, function (response) {
			window.billTypeMap[orgId] = response.rows;
			window.billType = billTypeMap[orgId];
			openDetailWindow();
		});
	} else {
		window.billType = billTypeMap[orgId];
		openDetailWindow();
	}*/
}

function openDetailWindow() {
	if(window.billType.length > 0 ) {
		$("#billType").combobox({
			data:window.billType,
			valueField:"bi0101",
			textField:"bi0111",
			filter: pinyinFilter
		});
		showModalDialog("planDetailWindow");
		$.each($("#planDetailWindow tr:nth-child(3)>td>input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox('setValue', '').textbox({onChange:calcCount});
		});
		$.each($("#planDetailWindow tr:nth-child(4)>td>input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox('setValue', '').textbox({onChange:calcCount});
		});
	} else {
		$.messager.alert("警告", "该单位没有可操作票据类型，请首先进行该配置！");
	}
}

function calcCount(newValue, oldValue) {
	var count = 0;
	$.each($("#planDetailWindow tr:nth-child(3)>td>input.easyui-textbox"), function(idx, elem) {
		var val = $(elem).textbox("getValue");
		if(val != "") {
			count += parseInt(val);
		}
	});
	$.each($("#planDetailWindow tr:nth-child(4)>td>input.easyui-textbox"), function(idx, elem) {
		var val = $(elem).textbox("getValue");
		if(val != "") {
			count += parseInt(val);
		}
	});
	$("#count").text(count);
}
//计算结束号码
function calNumbers(newValue,oldValue){
	$("#endBillCode").textbox("setValue",parseInt($("#numbers").textbox("getValue"))+parseInt($("#startBillCode").textbox("getValue")));
}
//增加
function funAdd(){
	window.operateType="add";//数据操作类型
	window.itemList=[];
	$("#btnAddPlan").linkbutton("disable");
	$("#btnPrint").linkbutton("disable");
	showModalDialog("planWindow");

	$("#popedPlanDetailGrid").datagrid('loadData', []);

	$("#year").numberspinner('setValue', new Date().getFullYear());

	$("#remark").textbox("setValue", "");
	$("#applyTime").textbox("setValue", formatDate(new Date()));
	$("#proposerName").textbox("setValue", userInfo.name);

}
//修改
function update(){
	if(!$(this).linkbutton('options').disabled) {
		window.operateType="update";//数据操作类型
		window.itemList=$("#planDetailGrid").datagrid('getData').rows;
		$("#btnAddPlan").linkbutton("disable");
		$("#btnPrint").linkbutton("disable");
		showModalDialog("planWindow");

		var model = $('#planGrid').datagrid('getSelected');
		$("#deptName").combobox("setValue", model.ba01861);//.combobox("setText", model.orgName);
		$("#btnAddItem").linkbutton("enable");
		$("#year").numberspinner("setValue", model.bi1502).numberspinner("readonly",true);
		$("#applyTime").textbox("setValue", datetimeFormatter(new Date(model.bi1512d), false)).textbox("readonly",true);
		$("#planType").combobox("setValue", model.bi1516c);
		$("#status").combobox("setValue", model.bi1522);

		$("#auditorName").textbox("setValue", model.bi1520).textbox("readonly",true);
		$("#proposerName").textbox("setValue", model.bi1519).textbox("readonly",true);
		$("#remark").textbox("setValue", model.remark);

		$("#popedPlanDetailGrid").datagrid('loadData', window.itemList);
		$("#btnDeleteItem").linkbutton("disable");

		if(excludeSaved) {
			$("#sn").textbox("setValue", model.bi1521);
		}
	}

}
//删除
function remove(){
	if(!$(this).linkbutton('options').disabled) {
		var row = $("#planGrid").datagrid('getSelected');
		if (row){
			$.messager.confirm('确认删除','确认删除票据计划?', function(r){
				if (r){
					$.ajax({
						url: "../bi/bi15/" + row.bi1501,
						type: 'DELETE',
						success: function(response) {
							if(response.status == SUCCESS){
								refreshFunGrid();
								$.messager.show({
									title : '提示',
									msg : "票据计划删除成功"
								});
							} else{
								$.messager.alert('票据计划删除失败',response,'info');
							}
						}
					});
				}
			});
		}
	}
}

//取消保存
function funCancleSave(){
	if(!$(this).linkbutton('options').disabled) {
		cancelBack("planWindow");
	}
}
//保存入库单
function funSave(){
	if(!$(this).linkbutton('options').disabled) {
		if($('#planWindow').form('validate')) {
			var plan = {
				planGridStr: JSON.stringify(window.itemList),
				ba01861:$("#deptName").combobox("getValue"),
				ba01862:$("#deptName").combobox("getText"),
				bi1502:$("#year").numberspinner("getValue"),
				bi1516c:$("#planType").combobox("getValue"),
				remark:$("#remark").textbox("getValue")
			};

			if(operateType == "update") {
				var row = $("#planGrid").datagrid('getSelected');
				plan.bi1501 = row.bi1501;
				plan.bi1521 = row.bi1521;
				plan.bi1522 = row.bi1522;
			}

			if(window.itemList.length > 0) {
				$.post("../bi/bi15", plan, function(response) {
					if(response.status == SUCCESS){
						$.messager.show({
							title : '提示',
							msg :  response.message});
						//$("#planWindow").window("close");
						$("#btnAddPlan").linkbutton("enable");
						$("#btnPrint").linkbutton("enable");

						refreshFunGrid(plan.orgId);
				    } else {
						$.messager.alert('错误', response.message);
				    }
				}, "json");
			} else {
				$('#btnAddItem').tooltip({
					position: 'top',
					showDelay: 5,
				    hideDelay: 300,
					content: '<span>请首先填写票据计划信息项目</span>',
					onShow: function(){
				        $(this).tooltip('tip').css({
				            backgroundColor: 'orange',
				            borderColor: '#666'
				        });
				    }
				}).tooltip('show');
			}
		}
	}
}

//--------------------------------------
function disableUpdateAndDeleteButton() {
	$("#btnUpdate").linkbutton("disable");
	$("#btnDelete").linkbutton("disable");
	$("#btnSubmit").linkbutton("disable");
}

function queryPlanFromTree() {
	var nodes = orgTreeObj.getCheckedNodes(true);
	var orgId= new Array();
	for(var i=0; i<nodes.length; i++){
		orgId.push(nodes[i].ba01861);
	}
	$("#f_deptName").combobox("setText", "");
	xxxx(orgId);
}

function queryPlan(node){
	var _orgId = $("#f_deptName").combobox("getValue");
	if(_orgId != "" ) {
		var orgId = new Array();
		orgId.push(_orgId);
		xxxx(orgId);
	} else if(window.orgTreeObj) {
		queryPlanFromTree();
	}
}

function xxxx(orgId) {
	var year = $("#f_year").numberspinner('getValue');
	window.planGridKey = {year:year, tOrgId:orgId, excludeSaved: excludeSaved};
	if(orgId != undefined && orgId != null )
		refreshFunGrid(orgId);
}

function refreshFunGrid(orgId) {
	//debugger;
	$("#planDetailGrid").datagrid('loadData', []);
	if(orgId != "" && window.planGridKey != undefined) {
		for(idx in orgId) {
			getBillType(orgId[idx]);
		}
		$.getJSON('../common/query?mapper=bi15Mapper&queryName=selectByYearAndOrgId',
			planGridKey,
			function(response){
				$('#planGrid').datagrid('loadData',response.rows);
				disableUpdateAndDeleteButton();
			});
	} else {
		window.billType = null;
		$('#planGrid').datagrid('loadData', []);
		disableUpdateAndDeleteButton();
	}
}

function getBillType(orgId) {
	if(window.billTypeMap == undefined) {
		window.billTypeMap = {};
	}
	if(!isNaN(orgId) && window.billTypeMap[orgId] == undefined) {

		$.ajax({
			url: '../common/query?mapper=bi01Mapper&queryName=queryForBa01',
			data: {ba01861: orgId},
			dataType: "json",
			async: "false",
			success:function(response){
				window.billTypeMap[orgId] = response.rows;
				window.billType = billTypeMap[orgId];
			}
		});

		/*$.getJSON('../common/query?mapper=bi01Mapper&queryName=queryForBa01', {ba01861: orgId}, function (response) {
			window.billTypeMap[orgId] = response.rows;
			window.billType = billTypeMap[orgId];
		});*/
	} else {
		window.billType = billTypeMap[orgId];
	}
}

var setting = {
	check: {
		enable: true
	},

	data: {
		key: {
			name:"ba01862"
		},
		simpleData: {
			enable: true,
			idKey:"treeId",
			pIdKey: "parentId",
			rootPId: null
		}
	},
	callback: {
		onCheck: queryPlanFromTree
	}
};



$(function() {
	//取得登录用户信息
    getUserInfo();
	$.subscribe("CODELIST_INITIALIZED", function(){
		/*$.getJSON("../ba/ba01/cascade", function (response) {
            if(response.length > 0) {
                window.orgTreeObj = $.fn.zTree.init($("#orgTree"), setting, response);
                var x = new Array();
                $.each($.codeListLoader.data['ba05Service.getCodeList2'], function(idx, elem) {
                    x.push(elem.value);
                });
                //x.push(parseInt(window.userInfo.orgId));
                var nodes = orgTreeObj.getNodesByFilter(function (node) {
                    return !_.contains(x, node.ba01861);
                });

                orgTreeObj.hideNodes(nodes);

            } else {
                $('#layout').layout('remove','west');
                $("#f_deptName").combobox({
                    data:[{
                        literal: userInfo.orgName,
                        value: userInfo.orgId
                    }]
                }).combobox("setValue", userInfo.orgId).combobox("disable");
            }

		});*/
	});



	$("#f_year").numberspinner('setValue', new Date().getFullYear());

	$("#btnSave").click(funSave);
	$("#btnPrint");
	$("#btnReturn").click(funCancleSave);

	$("#btnAddItem").click(funAddItem);
	$("#btnDeleteItem").click(funDeleteItem);

	$("#btnAddDetailItem").click(funAddDetailItem);
	$("#btnCancelDetailItem").click(funCancelDetailItem);

	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

});
