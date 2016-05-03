
function mainGridButtonHandler() {
	if($('#mainGrid').datagrid('getSelected') != null) {
		$('#btnView').linkbutton('enable');
		$('#btnDelete').linkbutton('enable');
		$('#btnResetPass').linkbutton('enable');
		$('#btnLock').linkbutton('enable');
	} else {
		$('#btnView').linkbutton('disable');
		$('#btnDelete').linkbutton('disable');
		$('#btnResetPass').linkbutton('disable');
		$('#btnLock').linkbutton('disable');
	}
}

function add(){
	$('#popedWindow input').val('');
	showModalDialog("popedWindow");
}
	
function view(){
	var row = $('#mainGrid').datagrid('getSelected');
	if (row){
		$("#funForm").form('load', row);
		showModalDialog("popedWindow");
		$("#btnEditOrSave").parent().css("text-align"," left");
		$('#popedWindow input.easyui-validatebox').validatebox();
	};
	$.each($("#userTable input.easyui-textbox"), function(idx, elem) {
		$(elem).next().find("input.textbox-text").css("width", "100%");
	});
	$("#tg").parent().find("input:checkbox").attr("disabled", true);
	$("#grid2").parent().find("input:checkbox").attr("disabled", true);
	$('#tabPanel').tabs('select',0 );
}

function remove(){
	var row = $('#mainGrid').datagrid('getSelected');
	if (row){ 
		$.messager.confirm('确认删除','确认删除账户',function(r){  
			if (r){  
				$.getJSON("../user/" + row.userId + "/delete", null, function(response){
				    if(response.status == SUCCESS){
				    	$('#mainGrid').datagrid('reload');
				    } else{
				    	$.messager.alert('删除失败',response,'info');
				    }
				});
		    }  
		});
	}
}

function resetPass(){
	var row = $('#mainGrid').datagrid('getSelected');
	if (row){ 
		$.messager.confirm('确认重置密码','确认重置该账户密码',function(r){  
			if (r){  
		    	$.getJSON("../user/" + row.userId + "/resetPass", null, function(response){
				    if(response.status == SUCCESS){
				    	$.messager.alert("重置成功", "新密码为："+ response.message, 'info');
				    } else {
				    	$.messager.alert('重置失败', response.message, 'info');
				    }
				});
		    }  
		});
	}
}

function lockUnlock() {
	var row = $('#mainGrid').datagrid('getSelected');
	var operate = row.status == 2? "解锁":"锁定";
	if (row) {
		$.messager.confirm('确认' + operate + '用户', '是否' + operate + '该用户？', function (r) {
			if (r) {
				$.getJSON("../user/" + row.userId + "/lock", null, function (response) {
					if (response.status == SUCCESS) {
						$.messager.alert("提示", operate + "操作成功", 'info');
						$('#mainGrid').datagrid('reload');
					} else {
						$.messager.alert('提示', operate + '操作失败: ' + response.message, 'info');
					}
				});
			}
		});
	}
}

function saveUser(){
	if($('#popedWindow').form('validate')) {
		var row = $('#mainGrid').datagrid('getSelected');
		$.post("../user/" + row.id, {
			id:row.id,
			userId: $("#p_userId").val(),
			name: $("#p_name").val(),
			dwId: $("#p_dwId").val(),
			dwname: $("#p_dwname").val(),
			gw: $("#p_gw").val(),
			status: $("#p_status").val(),
			mobilePhoneNumber: $("#p_phone").val(),
			email: $("#p_email").val()
		}, function(response) {
			if(response.status == FAIL){
				$.messager.alert('保存失败', response.message, 'info');
		    } else {
		    	$("#mainGrid").datagrid("reload");
				$.messager.alert('保存成功','保存成功','info');
				//$("#popedWindow").window("close");
		    }
		}, "json");
	}
	return false;
}

function tabSelectHandler(title, index) {
	var row = $('#mainGrid').datagrid('getSelected');
	if(index == 2) { //选择关联收费项目TAB

		$.getJSON("../common/query?mapper=roleMapper&queryName=queryRole", {}, function(response) {
			$("#grid2").datagrid("loadData", response.rows);

			$.getJSON("../user/" + row.userId + "/role", {}, function(responseA) {
				$.each(response.rows, function(idx, rowData) {
					if(_.contains(responseA.data, rowData.id)) {
						rowData.ck = "true";
						$('#grid2').datagrid('checkRow', idx);
					}
				});
				$("#grid2").parent().find("input:checkbox").attr("disabled", true);
			});
		});

	} else if (index == 1) { //选择关联用票单位TAB
		$.getJSON("../user/" + row.userId + "/resource", {}, function(responseA) {
			window.ownedResources = responseA.data;
			$("#tg").treegrid({
				url: '../sys/resource',
				/*onExpand: function (row) {
					var rows = $("#tg").treegrid("getChildren", row.id);
					$.each(rows, function(idx, rowData) {
						if(_.contains(ownedResources, rowData.id)) {
							$('#tg').datagrid('checkRow', rowData.id);
						}
					});
					$("#tg").parent().find("input:checkbox").attr("disabled", true);
				},*/
				onLoadSuccess: fillResourceCheckbox
			});
		});
	}
}

/*function fillUserRoleCheckbox() {
	var rows = $("#tg").treegrid("getData");
	$.each(rows, function(idx, rowData) {
		if(_.contains(userResources, rowData.id)) {
			$('#grid2').datagrid('checkRow', idx);
		}
	});
}*/

function fillResourceCheckbox() {
	var rows = $("#tg").treegrid("getData");
	fillResourceCheckboxRecursive(rows);
	$("#tg").parent().find("input:checkbox").attr("disabled", true);
}

function fillResourceCheckboxRecursive(rows) {
	$.each(rows, function(idx, rowData) {
		if(_.contains(ownedResources, rowData.id)) {
			$('#tg').datagrid('checkRow', rowData.id);
		}
		if(rowData.children.length > 0) {
			fillResourceCheckboxRecursive(rowData.children);
		}
	});
}

function editOrSaveUserRole() {
	var linkbutton = $("#btnEditOrSaveUserRole");
	var options = linkbutton.linkbutton("options");

	if(options.text == "编辑") {
		$("#btnEditOrSaveUserRole").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$("#grid2").parent().find("input:checkbox").attr("disabled", false);

	} else {
		$("#btnEditOrSaveUserRole").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});

		$("#grid2").parent().find("input:checkbox").attr("disabled", true);
		saveUserRole();
	}
}

function saveUserRole() {
	var checkedRows = $('#grid2').datagrid('getChecked');
	var param = new Array();
	$.each(checkedRows, function(idx, elem) {
		param.push(elem.id);
	});
	$.post("../user/" + $('#mainGrid').datagrid('getSelected').userId + "/role", {
		roleIds:param.join(',')
	}, function(response){
		if(response.status == SUCCESS) {
			$.messager.alert("提示", "用户角色保存成功");
		} else {
			$.messager.alert("错误", "用户角色保存失败");
		}
	}, "json");
}


function editOrSave () {
	var linkbutton = $("#btnEditOrSave");
	var options = linkbutton.linkbutton("options");

	if(options.text == "编辑") {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-save',
			text:'保存'
		});

		$.each($("#viewFundTable input.easyui-textbox"), function(idx, elem) {
			if(elem.id != 'p_userId' && elem.id != 'p_name' && elem.id != 'p_dwname') {
				$(elem).textbox("enable").textbox("readonly", false);
			}
			$(elem).next().find("input.textbox-text").css("width", "100%");
		});

	} else {
		$("#btnEditOrSave").linkbutton({
			iconCls:'icon-edit',
			text:'编辑'
		});
		$.each($("#viewFundTable input.easyui-textbox"), function(idx, elem) {
			$(elem).textbox("disable").textbox("readonly", true);
			$(elem).next().find("input.textbox-text").css("width", "100%");
		});

		saveUser();
	}
}

function selectOrganization() {
	$("#organizationTreegrid").treegrid({
		url:'../master/organization',
		onClickRow:function(row) {
			$("#btnOrganizationSelect").linkbutton('enable');
		}
	});
	$('#organizationSelectDialog').dialog('open');
}

function organizationSelect() {
	var selected = $("#organizationTreegrid").treegrid('getSelected');
	$("#p_dwId").textbox("setValue", selected.id);
	$("#p_dwname").textbox("setValue", selected.name);
	$('#organizationSelectDialog').dialog('close');
}

$(function() {
	
	$("#btnAdd").click(add);
	$("#btnView").click(view);
	$("#btnResetPass").click(resetPass);
	$("#btnDelete").click(remove);
	$("#btnLock").click(lockUnlock);

	$("#btnEditOrSave").click(editOrSave);

	$("#btnEditOrSaveUserRole").click(editOrSaveUserRole);
	$("#btnOrganizationSelect").click(organizationSelect);
	$("#btnReset").click(function(){
		$("#f_name").val('');
		$("#f_organization").val('');
	});
	$("#btnSearch").click(function(){
		$('#mainGrid').datagrid('load',{
			name: $('#f_name').val(),
			organization: $('#f_organization').val()
		});
	});
	
	$("#viewFundTable td:even").css("text-align", "right");

	$(".datagrid-body").niceScroll({
	    cursorcolor : "lightblue", // 滚动条颜色
	    cursoropacitymax : 3, // 滚动条是否透明
	    horizrailenabled : false, // 是否水平滚动
	    cursorborderradius : 0, // 滚动条是否圆角大小
	    autohidemode : false // 是否隐藏滚动条
	});

});