/*function quickSearch (value, name) {
	var externalParam = {};
	externalParam[name] = value;
	search(externalParam);
}

function collapseHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "1px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "1px")
}

function expandHandler() {
    $("div.datagrid-view:not(:last)").parent().css("border-right-width", "0px")
    $("div.datagrid-view:nth-child(1)").parent().css("border-bottom-width", "0px")
}

//zTree点击事件
function onTreeClick(event, treeId, treeNode, clickFlag) {
    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=scztMapper&queryName=query' + (userInfo.ext1 == 1 ? "Ext": "");
    if(treeNode.id.length==8) {
    	options.queryParams = {
    		qybm: treeNode.id
    	};
    } else {
	    options.queryParams = {
	        dwId: processorOrgId(treeNode.id)
	    };
    }
    $("#mainGrid").datagrid(options);
}
*/
function mainGridButtonHandler() {
    if ($('#mainGrid').datagrid('getSelected') != null) {
    	$('#btnView').linkbutton('enable');
    	$("#btnDelete").linkbutton('enable');
    } else {
        $('#btnView').linkbutton('disable');
    }
}

function updateMaterial(){
	var data=$("#mainGrid").datagrid("getSelected");
	console.info(data.name);
	if(data!=null){
		$("#editWindow").window("open");
		$("#editWindow #f_name").val(data.name);
		if(data.type==1){
			$("#editWindow #f_type").val("一般检查信息");
		}else{
			$("#editWindow #f_type").val("重点检查信息");
		}
		
		
		
	}
	
}

function editWindowSave(){
	var data=$("#mainGrid").datagrid("getSelected");
	if($("#editWindow #f_type").val()=="重点检查信息"){
		$("#f_type").val('2');
	}else{
		$("#f_type").val('1');
	}
	var newData={
			id:data.id,
			name:$("#editWindow  #f_name").val(),
			type:$("#f_type").val()
	};
	console.info(newData);
	 $.ajax({
	        url:"../21/updateMaterial",
	        type: "put",
	        data: newData,
	        success: function (response) {
	        	if(response.status==1){
	        		$.messager.show({
		        		title:'提示',
		        		msg:'修改成功',
		        		timeout:5000,
		        		showType:'slide'
		        	});
	        	}else{
	        		$.messager.show({
		        		title:'提示',
		        		msg:'修改失败',
		        		timeout:5000,
		        		showType:'slide'
		        	});
	        	}
	        	
}
	 });
	 $("#editWindow").window("close");
	 $("#mainGrid").datagrid("reload");
}
function editWindowClose(){
	 $("#editWindow").window("close");
	 $("#editWindow #f_name").val("");
	 $("#editWindow #f_type").val("");
}

function deleteMaterial(){
	 var data=$("#mainGrid").datagrid("getSelected");
	 
	 if(null != data) {
			$.messager.confirm("请确人是否删除该检查材料?", function (c) { if(c){
				$.ajax({
			        url: "../21/deleteMaterialById?id=" + data.id,
			        type: "DELETE",
			        success: function (response) {
			            if (response.status == 1) {
			               
			                $("#btnDelete").linkbutton("disable");
			                $("#mainGrid").datagrid("reload");
			               
			            } else {
			                $.messager.alert('失败', response.message, 'info');
			            }
			        }
			    });
				
			}});
			
			
		}
	
}
/*
function grid2ButtonHandler() {
	if ($('#grid2').datagrid('getSelected') != null) {
		$('#btnViewHcsxjg').linkbutton('enable');
		$('#btnViewDocList').linkbutton('enable');
	} else {
		$('#btnViewHcsxjg').linkbutton('disable');
		$('#btnViewDocList').linkbutton('disable');
	}
}*/
/*
function mainGridDblClickHandler(index, row) {
    window.selected = index;
    $('#mainGrid').datagrid('unselectAll').datagrid('selectRow', window.selected);
}
/*
function formatCompareCol(val, row) {
	var rc = row.qygsnr;
	if(val != null ) {
		if(val == "...") {
			return val;
		} else {
			if(rc == val) {
				return "<span style='color:green;'>" + val + "</span>";
			} else {
				return "<span style='color:red;'>" + val + "</span>";
			} 
		}
	}
}

function stylerRegist(val, row, index) {
	var compareSource = row.dbxxly;
	if(compareSource == 1 || compareSource == 3) {
		return "";
	} else if(compareSource == 2) {
		return "background-color:#ebeced";
	}
}

function stylerActual(val, row, index) {
	var compareSource = row.dbxxly;
	if(compareSource == 2 || compareSource == 3) {
		return "";
	} else {
		return "background-color:#ebeced;";
	} 
}

function formatZfry(val, row) {
	if(row.zfryName1 != null && row.zfryName2 != null ) {
		return row.zfryName1 + "/" + row.zfryName2;
	} else if(row.zfryName1 == null ) {
		return row.zfryName2;
	} else if(row.zfryName2 == null ) {
		return row.zfryName1;
	}
}

function stylerHczt(val, row, index) {
    if (val == 1) {
        return "";
    } else if (val == 2) {
        return "background-color:yellow";
    } else if (val == 3) {
        return "background-color:lightgreen";
    }
}

function stylerHcjg(val, row, index) {
    if (val == 1) {
        return "background-color:lightgreen";
    } else if (val == 2) {
        return "background-color:pink";
    } else {
        return "";
    }
}*/

function search(externalParam) {
    /*var treeObj = $.fn.zTree.getZTreeObj("orgTree");
    var selected = treeObj.getSelectedNodes();

    var options = $('#mainGrid').datagrid('options');
    options.url = '../common/query?mapper=scztMapper&queryName=query' + (userInfo.ext1 == 1 ? "Ext": "");
    options.queryParams = {
        dwId: selected.length == 1 ? processorOrgId(selected[0].id) : "",
        jhnd: $("#f_jhnd").val(),
        jhbh: $("#f_jhbh").val(),
        hcry: $("#f_hcry").val(),
        qymc: $("#f_qymc").val(),
        xydm: $("#f_xydm").val(),
        cxwh: $("#f_cxwh").val(),
        hyfl: $("#f_hyfl").combobox("getValue"),
        qy: $("#f_qy").val(),
        zzxs: $("#f_zzxs").combobox("getValue"),
        jyzt: $("#f_jyzt").combobox("getValue"),
        hcjg: $("#f_hcjg").combobox("getValue"),
        planType: $("#f_planType").combobox("getValue"),
        jhmc:$("#f_jhmc").val(),
        gsjhbh:$("#f_gsjhbh").val()
    };
    if(externalParam != undefined) {
    	_.extend(options.queryParams, externalParam);
    }
    $("#mainGrid").datagrid(options);*/
}
function saveMaterial(){
	if($("#f_type").val()=="重点检查信息"){
		$("#f_type").val("2");
	}else{
		$("#f_type").val("1");
	}
	var data={
			id:$("#f_id").val(),
			name:$("#f_name").val(),
			type:$("#f_type").val()
	};
	console.info(data);
	 $.ajax({
	        url:"../21/addMaterial",
	        type: "post",
	        data: data,
	        success: function (response) {
	        	if(response.status==1){
	        		$.messager.show({
		        		title:'提示',
		        		msg:'添加成功',
		        		timeout:5000,
		        		showType:'slide'
		        	});
	        	}else{
	        		$.messager.show({
		        		title:'提示',
		        		msg:'添加失败',
		        		timeout:5000,
		        		showType:'slide'
		        	});
	        	}
	        	
	        }
	           /* if (response.status == ) {
	                setReadOnlyStatus();
	             
	            }
			    	if(null==row) { 
			    		$("#mainGrid").datagrid("reload");
			    	} else {
			    		$.husky.refreshParent("mainGrid", data);
			    	}
			    	$.messager.show("操作提醒", response.message, "info", "bottomRight");
	            } else {
	                $.messager.alert('失败', response.message, 'info');
	            }
	        }*/
	    });
	 closeAddWindow();
	 $("#mainGrid").datagrid("reload");
}
function add(){
	
	$("#addWindow").window("open");
}
function addWindowSave(){
	saveMaterial();
	$("#addWindow").window("close");
	$("#f_id").val("");
	$("#f_name").val("");
	$("#f_type").val("");
}



function closeAddWindow(){
	
	$("#addWindow").window("close");
	$("#f_id").val("");
	$("#f_name").val("");
	$("#f_type").val("");
}
function reset() {
    $("#queryTable").form("clear");
    $('#mainGrid').datagrid('loadData', []);
}

function view(){
	var qy=$("#mainGrid").datagrid("getSelected");
	if(null != qy) {
		$("#examHistory").window("open");
		/* showModalDialog("examHistory");*/
	    $("#p_code").text(qy.xydm);
	    $("#p_name").text(qy.name);
	    var options = $("#grid2").datagrid("options");
	    options.url = '../common/query?mapper=hcrwMapper&queryName=queryForXydm';
	    $('#grid2').datagrid('load', {
	        hcdwXydm: qy.xydm
	    });
	    $('#btnViewHcsxjg').linkbutton('disable');
		$('#btnViewDocList').linkbutton('disable');
	}
}
/*
function closeHistory(){
    $("#examHistory").window("close");
}

function viewHcsxjg(){
	var rw=$("#grid2").datagrid("getSelected");
	if(null != rw) {
    	$("#examHistoryHcsxjg").window("open");
    	
    	$("#m_code").text(rw.hcdwXydm);
        $("#m_name").text(rw.hcdwName);
        
        $("#m_jhnd").text(rw.jhnd);
        $("#m_planType").text(rw.planType == 1 ? "双随机": "日常监管");
        $("#m_jhbh").text(rw.jhbh);
        $("#m_hcjgmc").text(rw.hcjgmc);
        
        var options = $("#grid3").datagrid("options");
        options.url = '../common/query?mapper=hcsxjgMapper&queryName=queryForTask';
        $('#grid3').datagrid('load', {
            hcrwId: rw.id
        });
	}
}

function viewDocList() {
	$.easyui.showDialog({
		title : "检查材料",
		width : 790,
		height : 420,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./docListc.jsp",
		onLoad : function() {
			//doDocListInit();
		}
	});
}

function closeHcsxjg(){
    $("#examHistoryHcsxjg").window("close");
}*/

$(function () {
	//$.husky.getUserInfo();
    //$.fn.zTree.init($("#orgTree"), setting);
    //$("#f_jhnd").val(new Date().getFullYear());
	
	
});