

$(function(){
	$('#tt').tree({
		onClick:function(node){
			if(node.id!='zcb'){
				  $("#main").panel({
			        	fit:true,
			            href: './'+node.id+'.jsp',
			            onLoad: function () {
			            	if(node.id=='dwdb'||node.id=='dwtz'||node.id=='xzxk'||node.id=='zscq'||node.id=='xzcf'){
			            		doRequiredXH();
			            	}else {
								doGDGQ();
							}
			            }
			        });
			}
		}
	});
	 function doRequiredXH(){
		 
		 $("tr").each(function(index){
			 if(index>1){
				 var value=$(this).attr("id");
				 $(this).find('input:first').textbox('setValue',value);
			 }
		 });
	 }
	 function doGDGQ(){
		 $("tr").each(function(index){
	    		if(index>2){
	    			var value=$(this).attr("id");
	    		$(this).find('input:first').textbox('setValue',value);
	    	}
	    	});
	 }
	 
})


 