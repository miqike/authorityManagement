
function userGridButtonHandler() {
	if($('#userGrid').datagrid('getSelected') != null) {
		$('#btnUpdate').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnResetPass').linkbutton('enable');
	} else {
		$('#btnUpdate').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnResetPass').linkbutton('disable');
	}
}

function addUser(){
	$('#userWindow input').val('');
	showModalDialog("userWindow");
}
	
function updateUser(){
	var row = $('#userGrid').datagrid('getSelected');  
	if (row){  
		$("#p_userId").val(row.userId).attr("readonly", "readonly").css("background-color", "lightgray");
		$("#p_userName").val(row.userName);
		$("#p_title").val(row.title);
		$("#p_gender").combobox('setValue', row.gender);
		$("#p_age").val(row.age);
		$("#p_phone").val(row.phone);
		$("#p_status").val(row.status);
		$("#p_email").val(row.email);
		showModalDialog("userWindow");
		$('#userWindow input.easyui-validatebox').validatebox();
	};
}

function deleteUser(){
	var row = $('#userGrid').datagrid('getSelected');  
	if (row){ 
		$.messager.confirm('确认删除','确认删除账户',function(r){  
			if (r){  
				$.post("../user/delete/"+row.userId, null, function(response){
				    if(response.status == SUCCESS){
				    	$('#userGrid').datagrid('reload');
				    } else{
				    	$.messager.alert('删除失败',response,'info');
				    }
				}, 'json');
		    }  
		});
	}
}

function resetPass(){
	var row = $('#userGrid').datagrid('getSelected');  
	if (row){ 
		$.messager.confirm('确认重置密码','确认重置该账户密码',function(r){  
			if (r){  
		    	$.post("../user/resetPass/"+row.userId, null, function(response){
				    if(response.status == SUCCESS){
				    	$.messager.alert("重置成功","新密码为："+response.newPass,'info');
				    } else {
				    	$.messager.alert('重置失败',response,'info');
				    }
				}, 'json');
		    }  
		});
	}
}

function saveUser(){
	if($('#userWindow').form('validate')) {
		$.post("../user/saveUser.json", {
			userId: $("#p_userId").val(),
			userName: $("#p_userName").val(),
			title: $("#p_title").val(),
			gender: $("#p_gender").combobox('getValue'),
			phone: $("#p_phone").val(),
			status: $("#p_status").val(),
			email: $("#p_email").val()
		}, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
		    } else {
		    	//debugger;
		    	$("#userGrid").datagrid("reload");
				$.messager.alert('保存成功','保存成功','info');
				$("#userWindow").window("close");
		    }
		}, "json");
	}
	return false;
}

$(function() {
	
	$("#btnAdd").click(addUser);
	$("#btnUpdate").click(updateUser);
	$("#btnDelete").click(deleteUser);
	$("#btnResetPass").click(resetPass);
	
	$("#btnSearch").click(function(){
		$('#userGrid').datagrid('load',{
			filter: $("#filter").val()
		});
	});
	
	$("#btnSave").click(saveUser);
	
	
	$("#userTable td:even").css("text-align", "right");
	$("#userTable td:odd input").css("width", "90%");
	
	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

});