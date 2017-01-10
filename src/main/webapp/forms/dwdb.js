$(function(){
	 $('#btnSave').click(function() {
	      
	        var data=$.easyuiExtendObj.drillDownForm('dwdb111');

	        $.ajax({
	           
	            type: 'POST',
	            url: '../zcb/saveDWDB',
	            data: data ,
	            dataType:"json",
	            success: function (response) {
	                console.log(response);
	            }
	        });
	    });
})