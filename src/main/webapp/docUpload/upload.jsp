<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>企业抽查资料上报</title>
	<link rel="stylesheet" type="text/css" href="../css/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../css/themes/metro-blue/easyui.css">
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../css/login.css" />

    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        div .datagrid-wrap {
            border-right: 0px;
            border-left: 0px;
            border-bottom: 0px
        }

        div#tabPanel .datagrid-wrap {
            border-top: 0px;
        }
	    .validatebox-text {
	        border-width: 1px;
	        border-style: solid;
	        height: 20px;
	        line-height: 17px;
	        padding-top: 1px;
	        padding-left: 3px;
	        padding-bottom: 2px;
	        padding-right: 3px;
	        background-attachment: scroll;
	        background-size: auto;
	        background-origin: padding-box;
	        background-clip: border-box;
	    }
	
	    .validatebox-invalid {
	        border-color: ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: fff3f3;
	        background-image: url("");
	    }
    </style>
</head>
<body style="padding:5px;">
<div id="box">
		<div id="main">
			<div id="header">33AE62C37FFE178DE050A8C085052133</div>
			<div class="loginbox" style="margin-right:320px;">
				<div id="panel" class="easyui-panel rounded" title="检查单位登录" style="height:316px;width:440px;padding-left:20px">

					<form id="loginForm" method="post" class="loginForm">
						<table>
							<tr>
								<td class='br' style="width:150px;">统一社会信用代码</td>
								<td><input class="easyui-validatebox" id="f_xydm" 
									data-options="required:true,onChange:loadSczt,prompt:'统一社会信用代码'" tabindex="1" /></td>
							</tr>
							<tr>
								<td class='br'>单位名称</td>
								<td><input class="easyui-validatebox" id="f_name" 
									data-options="readonly:true,prompt:'单位名称'" tabindex="1" /></td>
							</tr>
							<tr>
								<td class='br'>联系人电话</td>
								<td><input class="easyui-validatebox" id="f_lxdh" 
									data-options="readonly:true,prompt:'联系人电话'" tabindex="1" />
									<a href="javascript:void(0);" id="btnChangeLxdh" class="easyui-linkbutton" tabindex="4">申请修改</a>
									</td>
							</tr>
							<tr>
								<td class='br'>动态口令</td>
								<td>
									<input type="hidden" id="f_tokenId" />
									<input class="easyui-validatebox" type="password" id="f_password" value="" data-options="required:true,iconCls:'icon-lock'" tabindex="2" />
									<a href="javascript:void(0);" id="btnSendToken" class="easyui-linkbutton" tabindex="4">发送口令</a>
									
								</td>
							</tr>
							<!-- 
							<tr>
								<td class='br'>验证码</td>
								<td>
									<input class="easyui-validatebox" id="captcha" data-options="required:true,prompt:'验证码',iconCls:'icon-more'" tabindex="3"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									 <img id="captchaImg" src="captcha"/><a id="lnkRefreshCaptchaImg" href="javascirpt:void(0);" style="padding-left:5px;">刷新</a>
								</td>
							</tr> -->
						</table> 
						<div id="loginMessage" style="color:red;margin-left:10px;"></div>
						<div id="toolbar" style="margin-top:10px;">
							<a href="javascript:void(0);" id="btnLogin" class="easyui-linkbutton" iconCls="icon-ok" tabindex="4">登录</a>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footer">版权所有 CopyRight 2013. 科艺电子. Inc. All Rights Reserved. <br/>技术支持：1332555885</div>
	</div>
</body>
<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="../js/plugins/plusAsTab/emulatetab.joelpurra.js"></script>
<script type="text/javascript" src="../js/plugins/plusAsTab/plusastab.joelpurra.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
<script type="text/javascript" src="../js/husky/jeasyui.extend.js"></script>
<script type="text/javascript" src="../js/husky.common.js"></script>
<script>
JoelPurra.PlusAsTab.setOptions({
	key: 13
});

function login() {
	if(!$("#btnLogin").linkbutton('options').disabled && $('#loginForm').form('validate')){
		$.post("./" + $("#f_xydm").val() + "/login",  $.easyuiExtendObj.drillDownForm('loginForm'), function(response){
			if(response.status == SUCCESS){
				window.location="./4101.jsp";
			} else {
				$("#loginMessage").html(response.message).show();
				refreshCaptchaImg();
		    }
		}, "json");
	}
	return false;
}

function sendToken(){
	if($("#f_xydm").val() != "") {
		$.getJSON("./" + $("#f_xydm").val() + "/sendToken/" + $("#f_lxdh").val() , function(response){
			if(response.status == FAIL){
				$("#loginMessage").text(response.message).show();
				$("#btnLogin").linkbutton("disable");
			} else if (response.status == SUCCESS) {
				$("#f_tokenId").val(response.tokenId);
				$.alert("动态口令已经发送到指定手机上,请注意查收");
			}
		});
	}
}

function loadSczt(){
	if($("#f_xydm").val() != "") {
		$.getJSON("./" + $("#f_xydm").val(), function(response){
			if(response.status == FAIL){
				$("#loginMessage").text(response.message).show();
				$("#btnLogin").linkbutton("disable");
			} else if (response.status == SUCCESS) {
				$("#loginPanel").panel('close');
				
				$("#loginMessage").hide();
				//$("#btnLogin").linkbutton("enable");
				$("#f_name").val(response.data.name);
				$("#f_lxdh").val(response.data.lxdh);
				
			}
		});
	}
}



$(function(){
	$("#f_xydm").blur(loadSczt);
	$("#btnSendToken").click(sendToken);
	$("#btnLogin").click(login);
	
	$("#loginForm input.easyui-validatebox").val("")
	
	$.each($("#loginForm input.easyui-validatebox"), function(i, f) {
		$(f).validatebox().bind('keydown', function(e){
			if (e.keyCode == 13){
				var _eltId = $(this).attr("id");
				if(_eltId == "password" && $("#f_xydm").val() != "" && $("#f_name").val() != "" &&  $("#f_password").val() != "" ) {
					$("#btnLogin").click();
				}
			}
		});
	});
	
	//校验用户登录名
	$("#loginForm").plusAsTab();
});

</script>
</html>