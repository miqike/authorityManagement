 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" >
    $(function(){
    	$("tr").each(function(index){
    		if(index>1){
    			var value=$(this).attr("id");
    		$(this).find('input:first').textbox('setValue',value);
    	}
    	});
    	 $('#btnSave').click(function() {
    	      
             var data=new Array();
    	     
    	     $("tr").each(function(index) {
    	   	 var xydm=$("tr:first").find('td').find('input#p_xydm').val();
    	   	 var nd=$("tr:first").find('td').find('input#p_nd').val();
    	   	 var tbrq=$("tr:first").find('td').find('input#p_tbrq').val();
    	   	 if (index>1) {
    	   		var xh=$(this).find('td').find('input#p_xh').val();
    	   		var zqr=$(this).find('td').find("input#p_zqr").val();
    	   		if(zqr!=""){
    	   			var zwr=$(this).find('td').find("input#p_zwr").val();
    	   	        var zzqzl=$(this).find('td').find("input#p_zzqzl").val();
    	   	        var zzqse=$(this).find('td').find("input#p_zzqse").val();
    	   	        var lxzwqx=$(this).find('td').find("input#p_lxzwqx").val();
    	   	        var bzqj=$(this).find('td').find("input#p_bzqj").val();
    	   	        var bzfs=$(this).find('td').find("input#p_bzfs").val();
    	   	        var bzdbfw=$(this).find('td').find("input#p_bzdbfw").val();
    	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'zqr':zqr,'zwr':zwr,'zzqzl':zzqzl,'zzqse':zzqse,'lxzwqx':lxzwqx,'bzqj':bzqj,'bzfs':bzfs,'bzdbfw':bzdbfw};
    	   	        data.push(tr);
    	   		}
    	        
    			}
    		});

    	        $.ajax({
    	           
    	            type: 'POST',
    	            url: '../zcb/saveDWDB',
    	            data: JSON.stringify(data) ,
    	            dataType:"json",
    	            contentType: 'application/json;charset=utf-8',
    	            success: function (response) {
    	            	if(response.status == SUCCESS){
    		            	   $.messager.alert('成功', response.message, 'info');
    		            	   $("input").val("");
    		            	   
    		            	   
    		               }else {
    		            	   $.messager.alert('失败', response.message, 'info');
    					}
    	            }
    	        });
    	    });
    })
    </script>
<table id="dwdb111" width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">对外提供保证担保信息</caption>
		<tr>
			<td>信用代码</td>
			<td colspan="2"><input class="easyui-textbox" id="p_xydm"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td>年度</td>
			<td colspan="2"><input class="easyui-textbox" id="p_nd"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td>填报日期</td>
			<td colspan="2"><input class="easyui-textbox" id="p_tbrq"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr>
			<td height="35px" align="center">序号</td>
			<td align="center">债权人</td>
			<td align="center">债务人</td>
			<td align="center">主债权种类</td>
			<td align="center">主债权数额</td>
			<td align="center">履行债务的期限</td>
			<td align="center">保证的期间</td>
			<td align="center">保证的方式</td>
			<td align="center">保证担保的范围</td>
		</tr>

		<tr id="1">
			<td height="35px"><input class="easyui-textbox" id="p_xh" style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="2">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="3">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="4">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="5">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="6">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="7">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="8">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="9">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="10">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="11">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="12">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="13">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="14">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
		<tr id="15">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" /></td>
			<td><input class="easyui-textbox" id="p_zqr"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_zwr"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqzl"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_zzqse"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_lxzwqx"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzqj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_bzdbfw"
				style="border: none; width: 100%; height: 100%" /></td>
		</tr>
	</table>
	<div style="position: relative; bottom: -9px; left: 0px;">
		<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save"
			plain="true">保存</a>
	</div>
