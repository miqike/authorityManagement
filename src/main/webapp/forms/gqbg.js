$(function(){
	$("tr").each(function(index){
		if(index>2&&index<18){
			var value=$(this).attr("id");
		$(this).find('input:first').textbox('setValue',value);
	}
	});
	
	
	 $('#btnSave').click(function() {
	      
	        var data=$.easyuiExtendObj.drillDownForm('gqbg111');

	        $.ajax({
	           
	            type: 'POST',
	            url: '../zcb/saveGQBG',
	            data: data ,
	            dataType:"json",
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