 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" >
    $(function(){
    	$("tr").each(function(index){
    		if(index>2&&index<18){
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
    	    	 if (index>2) {
    	    		var xh=$(this).find('td').find('input#p_xh').val();
    	    		var gd=$(this).find('td').find("input#p_gd").val();
    	    		if(gd!=""){
    	    			 var beforeChangeGQ=$(this).find('td').find("input#p_beforeChangeGQ").val();
    	 	            var afterChangeGQ=$(this).find('td').find("input#p_AfterChangeGQ").val();
    	 	           /* var bgrq=$(this).find('td').find("input#p_bgrq").val();*/
    	 	            var jzrq=$(this).find('td').find("input#p_jzrq").val();
    	 	            var pzh=$(this).find('td').find("input#p_pzh").val();
    	 	            var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'gd':gd,'beforeChangeGQ':beforeChangeGQ,'afterChangeGQ':afterChangeGQ,'jzrq':jzrq,'pzh':pzh};
    	 	            data.push(tr);	
    	    		}
    	           
    			}
    		});
    	     
    	        $.ajax({
    	           
    	        	
    	            type: 'POST',
    	            url: '../zcb/saveGQBG',
    	            data: JSON.stringify(data) ,
    	            dataType:'json',
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
<table id="gqbg111" width="80%" border="1" cellspacing="0" align="center">
	<caption align="top" style="font-size: 30px;">股东股权转让等股权变更信息</caption>
	<tr>
			<td>信用代码</td>
			<td><input class="easyui-textbox" id="p_xydm"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" ></td>
			<td>年度</td>
			<td><input class="easyui-textbox" id="p_nd"
				style="border: none; width: 100%; height: 100%"
				data-options="required:true" ></td>
			<td>填报日期</td>
			<td colspan="2"><input class="easyui-textbox" id="p_tbrq"
				style="border: none; width: 100%; height: 100%" ></td>
		</tr>
	<tr >
	<td rowspan="2" align="center">序号</td>
	<td rowspan="2" align="center">股   东</td>
	<td rowspan="2" align="center">变更前股权比例（百分比）</td>
	<td rowspan="2" align="center">变更后股权比例（百分比）</td>
	<!-- <td rowspan="2" align="center">变更日期</td> -->
	<td colspan="2" align="center">相关财务凭证信息
	<tr>
	<td align="center">记账日期</td>
	<td align="center">凭证号</td>
	</tr>
	</td>
	</tr>
	
	<tr id="1">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="2">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="3">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="4">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="5">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="6">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="7">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		
		<tr id="8">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="9">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="10">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="11">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="12">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="13">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="14">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		<tr id="15">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_beforeChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_AfterChangeGQ"
				style="border: none; width: 100%;height: 100%" /></td>
			<!-- <td><input class="easyui-textbox" id="p_bgrq"
				style="border: none; width: 100%;height: 100%" /></td> -->
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" /></td>

		</tr>
		
</table>
<div style="position: relative; bottom: -9px; left: 130px;">
		<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save"
			plain="true">保存</a>
</div>