 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" >
    $(function() {
    	var i=6;
    	$("#btn").click(function() {

            var tr = "<tr id="+i+"><td style='height:35px;'><input type='text' id='p_xh' style='border: none; width: 100%; height: 100%'></td><td><input type='text' id='p_gd' style='border: none; width: 100%; height: 100%;' ></td><td><input type='text' id='p_sjcze' style='border: none; width: 100%; height: 100%' ></td><td><input type='text' id='p_sjczsj' style='border: none; width: 100%;height: 100%' ></td><td><input type='text' id='p_czfs'  style='border: none; width: 100%; height: 100%' ></td><td><input type='text' id='p_jzrq' style='border: none; width: 100%; height: 100%' ></td><td><input type='text' id='p_pzh'  style='border: none; width: 100%; height: 100%' ></td></tr>";
           $("table").append(tr);
           $("#"+i+" input").each(function(index) {
    		if(index==0){
    			$(this).textbox({
    				required:'true'
    			});
    		}else{
    			$(this).textbox();
    		}
    	})
    	i++;
            });
    	
    	$("tr").each(function(index){
    		if(index>2&&index<8){
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
       			var sjcze=$(this).find('td').find("input#p_sjcze").val();
       	        var sjczsj=$(this).find('td').find("input#p_sjczsj").val();
       	        var czfs=$(this).find('td').find("input#p_czfs").val();
       	        var pzh=$(this).find('td').find("input#p_pzh").val();
       	        var jzrq=$(this).find('td').find("input#p_jzrq").val();
       	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'gd':gd,'sjcze':sjcze,'sjczsj':sjczsj,'czfs':czfs,'jzrq':jzrq,'pzh':pzh};
       	        data.push(tr);
       		}
            
    		}
    	});

    		        $.ajax({
    		           
    		            type: 'POST',
    		            url: '../zcb/saveGDCZ',
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

	<table id="gdcz111" width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">股东及出资信息</caption>
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
		<tr>
			<th rowspan="2">序号</th>
			<th rowspan="2">股 东</th>
			<th rowspan="2">实缴出资额（万元）</th>
			<th rowspan="2">实缴出资时间</th>
			<th rowspan="2">出资方式</th>
			<th colspan="2">相关财务凭证信息
		<tr>
			<td>记账日期</td>
			<td>凭证号</td>
		</tr>
		</th>
		</tr>
		<tr id="1">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%;"></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%; height: 100%;" ></td>
			<td><input class="easyui-textbox" id="p_sjcze"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjczsj"
				style="border: none; width: 100%;height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_czfs"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%; height: 100%" ></td>

		</tr>
		<tr id="2">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjcze"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjczsj"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_czfs"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" ></td>

		</tr>
		<tr id="3">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjcze"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjczsj"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_czfs"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%;height: 100%" ></td>

		</tr>
		<tr id="4">
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjcze"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjczsj"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_czfs"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%; height: 100%" ></td>

		</tr>
		<tr id="5" >
			<td height="35px"><input class="easyui-textbox" id="p_xh"
				style="border: none; width: 100%; height: 100%"></td>
			<td><input class="easyui-textbox" id="p_gd"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjcze"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_sjczsj"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_czfs"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_jzrq"
				style="border: none; width: 100%; height: 100%" ></td>
			<td><input class="easyui-textbox" id="p_pzh"
				style="border: none; width: 100%; height: 100%" ></td>

		</tr>

	</table>
    <div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btn" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加一行</a>
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	</div>

