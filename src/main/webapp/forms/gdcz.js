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