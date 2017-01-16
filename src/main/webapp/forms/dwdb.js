$(function(){
	$('#btnSave').click(function() {
		 var data=new Array();
	     
	     $("tr").each(function(index) {
	   	 var xydm=$("tr:first").find('td').find('input#p_xydm').val();
	   	 var nd=$("tr:first").find('td').find('input#p_nd').val();
	   	 var tbrq=$("tr:first").find('td').find('input#p_tbrq').val();
	   	 if (index>1) {
	   		var xh=$(this).find('td').find('input#p_xh').val();
	   		var zqr=$(this).find('td').find("input#p_zqr").val();
	   		if(zqr!=""){
	   			var zwr=$(this).find('td').find("input#p_zwr").val();
	   	        var zzqzl=$(this).find('td').find("input#p_zzqzl").val();
	   	        var zzqse=$(this).find('td').find("input#p_zzqse").val();
	   	        var lxzwqx=$(this).find('td').find("input#p_lxzwqx").val();
	   	        var bzqj=$(this).find('td').find("input#p_bzqj").val();
	   	        var bzfs=$(this).find('td').find("input#p_bzfs").val();
	   	        var bzdbfw=$(this).find('td').find("input#p_bzdbfw").val();
	   	        var tr={'xydm':xydm,'nd':nd,'tbrq':tbrq,'xh':xh,'zqr':zqr,'zwr':zwr,'zzqzl':zzqzl,'zzqse':zzqse,'lxzwqx':lxzwqx,'bzqj':bzqj,'bzfs':bzfs,'bzdbfw':bzdbfw};
	   	        data.push(tr);
	   		}
	        
			}
		});

	        $.ajax({
	           
	            type: 'POST',
	            url: '../zcb/saveDWDB',
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
	