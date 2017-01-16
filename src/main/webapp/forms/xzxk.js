 $(function() {
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