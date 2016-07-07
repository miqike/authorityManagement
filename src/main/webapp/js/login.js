window.SUCCESS = 1;
window.FAIL = -1;

JoelPurra.PlusAsTab.setOptions({
	key: 13
});

function login() {
	
	if(!$("#btnLogin").linkbutton('options').disabled && $('#loginForm').form('validate')){
		$.post("login",{
			userId:$("#userId").val(),
			password:new Base64().encode($('#password').val()),
			rememberMe:$('#rememberMe')[0].checked,
			captcha:$("#captcha").val()
		},function(response){
			if(response.status == SUCCESS){
				window.top.location="index.jsp";
			} else if(response.status == 302) {
				if(response.redirect == "/login?kickout=1") {
					$.messager.alert("警告", "因超出允许的单一账户同时登录数而被踢出!");
				} else if(response.redirect == "/login?forcelogout=1") {
					$.messager.alert("警告", "被管理员强行踢出!");
				}
				refreshCaptchaImg();
			} else {
				$("#loginMessage").html(response.message).show();
				refreshCaptchaImg();
		    }
		}, "json");
	}
	return false;
}

function refreshCaptchaImg(){
	$("#panel").panel('resize',{"height": parseInt($("#loginForm").css("height").replace("px", "")) + 55})
	var timestamp = (new Date()).valueOf();
    $("#captchaImg").attr("src", 'captcha?time=' + timestamp);
	$("#captcha").val("").focus();
	return false;
}

function checkUserExist(){
	/*if($("#userId").val() != "") {
		$.getJSON("user/" + $("#userId").val()+"/exist", function(response){
			if(response.status == FAIL){
				$("#loginMessage").text(response.message).show();
				$("#btnLogin").linkbutton("disable");
			} else if (response.status == SUCCESS) {
				$("#loginPanel").panel('close');
				
				$("#loginMessage").hide();
				$("#btnLogin").linkbutton("enable");
			}
		});
	}*/
}

function retrievePass(){
	if($("#userId").val() != "") {
		$.messager.confirm('确认', '是否确找回密码?本操作需要重置该账户密码,新密码通过注册邮箱和手机短信发送', function (r) {
			if (r) {
				$.getJSON("./user/" + $("#userId").val() + "/retrievePass", null, function (response) {
					if (response.status == $.husky.SUCCESS) {
						$.messager.alert("操作提醒", response.message, 'info');
					} else {
						$.messager.alert("错误", '找回密码失败', 'info');
					}
				});
			}
		});
	} else {
		$.messager.alert("操作提示", "用户名不能为空");
	}
}

function checkIE() {
    if(window.navigator.userAgent.toLowerCase().indexOf("msie") != -1) {
    	location.href ='./chromeframe/default.html'
    }
}

$(function(){
	checkIE();
	if($.util.request.forceLogout != undefined) {
		$("#loginMessage").html("被管理员强行踢出!").show();
		refreshCaptchaImg();
	} else if($.util.request.kickout != undefined) {
		$("#loginMessage").html("因超出允许的单一账户同时登录数而被踢出!").show();
		refreshCaptchaImg();
	}
	
	$("#loginForm input.easyui-validatebox").val("")
	
	$.each($("#loginForm input.easyui-validatebox"), function(i, f) {
		$(f).validatebox().bind('keydown', function(e){
			if (e.keyCode == 13){
				var _eltId = $(this).attr("id");
				if(_eltId == "captcha" && $("#userId").val() != "" && $("#password").val() != "" &&  $("#captcha").val() != "" ) {
					$("#btnLogin").click();
				}
			}
		});
	});
	
	$("#lnkRefreshCaptchaImg").click(refreshCaptchaImg);
	/*$("#btnScztLogin").click(function(){
		window.location='http://localhost:9090/cpsi_pub/index.jsp';
	});*/
	//校验用户登录名
	$("#userId").blur(checkUserExist);
	$("#loginForm").plusAsTab();
});
