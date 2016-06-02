<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="../audit/email.js"></script>
<div >
	<p>电子邮件核查过程:发送测试邮件到客户邮箱,客户收到邮件后点击相应的链接即可完成,若5日内未完成则该项验证失败</p>
	
	<table>
		<tr>
			<td>公示电子邮件: 
			</td>
			<td>
				<span style="color:blue; " id="_mail_"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
        		<a href="#" id="btnSentVerifyMail" class="easyui-linkbutton" iconCls="icon2 r10_c10" plain="true">发送验证邮件</a>
        		<a href="#" id="btnCloseAuditWindow" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
			</td>
		</tr>
	</table>
	
</div>
