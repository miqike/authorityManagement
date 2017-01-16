$(function(){
	 $('#btnSave').click(function() {
		 var data=$.easyuiExtendObj.drillDownForm('gsxxzcb111');

	        $.ajax({
	           
	            type: 'POST',
	            url: '../zcb/saveGSXXZCB',
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

