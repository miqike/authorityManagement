 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" >
    $(function() {
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
    	   		var xkwjbh=$(this).find('td').find("input#p_xkwjbh").val();
    	   		if(xkwjbh!=""){
    	   			var xkwjmc=$(this).find('td').find("input#p_xkwjmc").val();
    	   	        var yxqFrom=$(this).find('td').find("input#p_yxqFrom").val();
    	   	        var yxqTo=$(this).find('td').find("input#p_yxqTo").val();
    	   	        var xkjg=$(this).find('td').find("input#p_xkjg").val();
    	   	        var djzt=$(this).find('td').find("input#p_djzt").val();
    	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'xkwjbh':xkwjbh,'xkwjmc':xkwjmc,'yxqFrom':yxqFrom,'yxqTo':yxqTo,'xkjg':xkjg,'djzt':djzt};
    	   	        data.push(tr);
    	   		}
    	        
    			}
    		});

    	        $.ajax({
    	           
    	            type: 'POST',
    	            url: '../zcb/saveXZXK',
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
<table id="xzxk111" width="80%" border="1" cellspacing="0" align="center">
	<caption align="top" style="font-size: 30px;">行政许可信息</caption>
	<tr>
                <td>信用代码</td>
                <td colspan="2"><input id="p_xydm" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td>年度</td>
                <td ><input id="p_nd" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td >填报日期</td>
                <td ><input id="p_tbrq" class="easyui-textbox"  style="width:100%;height:100%;"></td>
	</tr>
	<tr>
	<td height="35px" align="center">序号</td>
	<td align="center">许可文件编号</td>
	<td align="center">许可文件名称</td>
	<td align="center">有效期自</td>
	<td align="center">有效期至</td>
	<td align="center">许可机关</td>
	<td align="center">登记状态</td>
	</tr>
	
	<tr id="1">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="2">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="3">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="4">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="5">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="6">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="7">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="8">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="9">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="10">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="11">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="12">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="13">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="14">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	<tr id="15">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkwjbh"
				style="border: none; width: 100%;height: 100%;" /></td>
			<td><input class="easyui-textbox" id="p_xkwjmc"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqFrom"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_yxqTo"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_xkjg"
				style="border: none; width: 100%;height: 100%" /></td>
			<td><input class="easyui-textbox" id="p_djzt"
				style="border: none; width: 100%;height: 100%" /></td>
		</tr>
	</table>
	<div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
</div>
