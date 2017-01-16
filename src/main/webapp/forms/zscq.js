 $(function() {
    	 $('#btnSave').click(function() {
    	      
    		 var data=new Array();
    	     
    	     $("tr").each(function(index) {
    	   	 var xydm=$("tr:first").find('td').find('input#p_xydm').val();
    	   	 var nd=$("tr:first").find('td').find('input#p_nd').val();
    	   	 var tbrq=$("tr:first").find('td').find('input#p_tbrq').val();
    	   	 if (index>1) {
    	   		var xh=$(this).find('td').find('input#p_xh').val();
    	   		var mc=$(this).find('td').find("input#p_mc").val();
    	   		if(mc!=""){
    	   			var zl=$(this).find('td').find("input#p_zl").val();
    	   	        var czrmc=$(this).find('td').find("input#p_czrmc").val();
    	   	        var zqrmc=$(this).find('td').find("input#p_zqrmc").val();
    	   	        var zqdjqx=$(this).find('td').find("input#p_zqdjqx").val();
    	   	        var djzt=$(this).find('td').find("input#p_djzt").val();
    	   	        var bhqk=$(this).find('td').find("input#p_bhqk").val();
    	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'mc':mc,'zl':zl,'czrmc':czrmc,'zqrmc':zqrmc,'zqdjqx':zqdjqx,'djzt':djzt,'bhqk':bhqk};
    	   	        data.push(tr);
    	   		}
    	        
    			}
    		});

    	        $.ajax({
    	           
    	            type: 'POST',
    	            url: '../zcb/saveZSCQ',
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