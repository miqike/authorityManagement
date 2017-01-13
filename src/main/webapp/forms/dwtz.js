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
	   		var slqymc=$(this).find('td').find("input#p_slqymc").val();
	   		if(slqymc!=""){
	   			var slqyxydm=$(this).find('td').find("input#p_slqyxydm").val();
	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'slqymc':slqymc,'slqyxydm':slqyxydm};
	   	        data.push(tr);
	   		}
	        
			}
		});

	        $.ajax({
	           
	            type: 'POST',
	            url: '../zcb/saveDWTZ',
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