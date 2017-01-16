 $(function(){
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