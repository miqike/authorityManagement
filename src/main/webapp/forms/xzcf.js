 $(function() {
    	 $('#btnSave').click(function() {
    	      
    		 var data=new Array();
    	     
    	     $("tr").each(function(index) {
    	   	 var xydm=$("tr:first").find('td').find('input#p_xydm').val();
    	   	 var nd=$("tr:first").find('td').find('input#p_nd').val();
    	   	 var tbrq=$("tr:first").find('td').find('input#p_tbrq').val();
    	   	 if (index>1) {
    	   		var xh=$(this).find('td').find('input#p_xh').val();
    	   		var cfjdswh=$(this).find('td').find("input#p_cfjdswh").val();
    	   		if(cfjdswh!=""){
    	   			var wfxwlx=$(this).find('td').find("input#p_wfxwlx").val();
    	   	        var xzcfnr=$(this).find('td').find("input#p_xzcfnr").val();
    	   	        var zccfjdjg=$(this).find('td').find("input#p_zccfjdjg").val();
    	   	        var cfrq=$(this).find('td').find("input#p_cfrq").val();
    	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'cfjdswh':cfjdswh,'wfxwlx':wfxwlx,'xzcfnr':xzcfnr,'zccfjdjg':zccfjdjg,'cfrq':cfrq};
    	   	        data.push(tr);
    	   		}
    	        
    			}
    		});

    	        $.ajax({
    	           
    	            type: 'POST',
    	            url: '../zcb/saveXZCF',
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