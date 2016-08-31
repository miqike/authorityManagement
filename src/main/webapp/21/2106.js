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
	if(data!=null){
		//debugger;
		$("#editWindow").window("open");
		$.husky.loadForm("editWindow", data);
		/*
		$("#editWindow #f_name").val(data.name);
		if(data.type==1){
			$("#editWindow #f_type").val("一般检查信息");
		}else{
			$("#editWindow #f_type").val("重点检查信息");
		}*/
	}
}

function editWindowSave(){
//	var data=$("#mainGrid").datagrid("getSelected");
	/*if($("#editWindow #f_type").val()=="重点检查信息"){
		$("#f_type").val('2');
	}else{
		$("#f_type").val('1');
	}*/
	/*var newData={
			id:data.id,
			name:$("#editWindow  #f_name").val(),
			type:$("#f_type").val()
	};*/
    var formData=$.husky.getFormData("editWindow");
    
	 $.ajax({
	        url:"../21/updateMaterial",
	        type: "put",
	        data: formData,
	        success: function (response) {
	        	if(response.status==1){
	        		$.messager.show('操作提示', '修改核查材料成功', "info", "bottomRight");
	        		$("#mainGrid").datagrid("reload");
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
			$.messager.confirm("请确认是否删除该检查材料?", function (c) { if(c){
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

function saveMaterial(){
	
	/*if($("#f_type").val()=="重点检查信息"){
		$("#f_type").val("2");
	}else{
		$("#f_type").val("1");
	}
	var data={
			id:$("#f_id").val(),
			name:$("#f_name").val(),
			type:$("#f_type").val()
	};
	console.info(data);*/
	 var formData=$.husky.getFormData("addWindow");
	 $.ajax({
	        url:"../21/addMaterial",
	        type: "post",
	        data: formData,
	        success: function (response) {
	        	if(response.status==1){
	        		$.messager.show({
		        		title:'提示',
		        		msg:'添加成功',
		        		timeout:1000,
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

$(function () {
	
});