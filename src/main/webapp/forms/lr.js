 $(function() {
	 	 $("#p_item15Bqfse").textbox({
	 		 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 	         click : function(e){
	 	        	 var p_item1Bqfse = $("#p_item1Bqfse").val();
	 					var p_item4Bqfse = $("#p_item4Bqfse").val();
	 					var p_item7Bqfse = $("#p_item7Bqfse").val();
	 					var p_item8Bqfse = $("#p_item8Bqfse").val();
	 					var p_item9Bqfse = $("#p_item9Bqfse").val();
	 					var p_item10Bqfse = $("#p_item10Bqfse").val();
	 					var p_item11Bqfse = $("#p_item11Bqfse").val();
	 					var p_item12Bqfse = $("#p_item12Bqfse").val();
	 					var p_item13Bqfse = $("#p_item13Bqfse").val();
	 					if (p_item1Bqfse != null && p_item1Bqfse != "" || p_item4Bqfse != null
	 							&& p_item4Bqfse != "" || p_item7Bqfse != null
	 							&& p_item7Bqfse != "" || p_item8Bqfse != null
	 							&& p_item8Bqfse != "" || p_item9Bqfse != null
	 							&& p_item9Bqfse != "" || p_item10Bqfse != null
	 							&& p_item10Bqfse != "" || p_item11Bqfse != null
	 							&& p_item11Bqfse != "" || p_item12Bqfse != null
	 							&& p_item12Bqfse != "" || p_item13Bqfse != null
	 							&& p_item13Bqfse != "" ) {
	 						var a = new Array(p_item1Bqfse,p_item12Bqfse,p_item13Bqfse);
	 						var d=new Array(p_item4Bqfse,p_item7Bqfse,p_item8Bqfse,p_item9Bqfse,p_item10Bqfse,p_item11Bqfse);
	 						var p_item15Bqfse = 0;
	 						for (var i = 0; i < a.length; i++) {
	 								if (a[i] != null && a[i] != ""){
	 								var b=parseFloat(a[i]);

	 								p_item15Bqfse +=b ;
	 								}
	 						}
	 						for (var i = 0; i < d.length; i++) {
	 							if (d[i] != null && d[i] != ""){
	 							var b=parseFloat(d[i]);

	 							p_item15Bqfse -=b ;
	 							}
	 					}
	 						$("#p_item15Bqfse").textbox('setValue',p_item15Bqfse);
	 					}

	 	        	       $("#p_item15Bqfse").textbox({readonly:true});
	 	        }
	 	    })
	 					
	 				});
	 		
	 		$("#p_item15Sqfse").textbox({
	 			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 		         click : function(e){
	 		        	 var p_item1Sqfse = $("#p_item1Sqfse").val();
	 						var p_item4Sqfse = $("#p_item4Sqfse").val();
	 						var p_item7Sqfse = $("#p_item7Sqfse").val();
	 						var p_item8Sqfse = $("#p_item8Sqfse").val();
	 						var p_item9Sqfse = $("#p_item9Sqfse").val();
	 						var p_item10Sqfse = $("#p_item10Sqfse").val();
	 						var p_item11Sqfse = $("#p_item11Sqfse").val();
	 						var p_item12Sqfse = $("#p_item12Sqfse").val();
	 						var p_item13Sqfse = $("#p_item13Sqfse").val();
	 						if (p_item1Sqfse != null && p_item1Sqfse != "" || p_item4Sqfse != null
	 								&& p_item4Sqfse != "" || p_item7Sqfse != null
	 								&& p_item7Sqfse != "" || p_item8Sqfse != null
	 								&& p_item8Sqfse != "" || p_item9Sqfse != null
	 								&& p_item9Sqfse != "" || p_item10Sqfse != null
	 								&& p_item10Sqfse != "" || p_item11Sqfse != null
	 								&& p_item11Sqfse != "" || p_item12Sqfse != null
	 								&& p_item12Sqfse != "" || p_item13Sqfse != null
	 								&& p_item13Sqfse != "" ) {
	 							var a = new Array(p_item1Sqfse,p_item12Sqfse,p_item13Sqfse);
	 							var d=new Array(p_item4Sqfse,p_item7Sqfse,p_item8Sqfse,p_item9Sqfse,p_item10Sqfse,p_item11Sqfse);
	 							var p_item15Sqfse = 0;
	 							for (var i = 0; i < a.length; i++) {
	 									if (a[i] != null && a[i] != ""){
	 									var b=parseFloat(a[i]);

	 									p_item15Sqfse +=b ;
	 									}
	 							}
	 							for (var i = 0; i < d.length; i++) {
	 								if (d[i] != null && d[i] != ""){
	 								var b=parseFloat(d[i]);

	 								p_item15Sqfse -=b ;
	 								}
	 						}
	 							$("#p_item15Sqfse").textbox('setValue',p_item15Sqfse);
	 						}
	 		        	         $("#p_item15Sqfse").textbox({readonly:true});
	 		        }
	 		    })
	 					

	 				});
	 		
	 		
	 			$("#p_item20Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item15Bqfse = $("#p_item15Bqfse").val();
	 							var p_item16Bqfse = $("#p_item16Bqfse").val();
	 							var p_item18Bqfse = $("#p_item18Bqfse").val();
	 							if (p_item15Bqfse != null && p_item15Bqfse != "" || p_item16Bqfse != null
	 									&& p_item16Bqfse != "" || p_item18Bqfse != null
	 									&& p_item18Bqfse != "" ) {
	 								var a = new Array(p_item15Bqfse,p_item16Bqfse);
	 								var p_item20Bqfse = 0;
	 								for (var i = 0; i < a.length; i++) {
	 										if (a[i] != null && a[i] != ""){
	 										var b=parseFloat(a[i]);

	 										p_item20Bqfse +=b ;
	 										}
	 								}
	 								if(p_item18Bqfse != null&& p_item18Bqfse != ""){
	 									var c=parseFloat(p_item18Bqfse);
	 									p_item20Bqfse-=c;
	 								}
	 								$("#p_item20Bqfse").textbox('setValue',p_item20Bqfse);
	 							}
	 			        	 $("#p_item20Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			$("#p_item20Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item15Sqfse = $("#p_item15Sqfse").val();
	 							var p_item16Sqfse = $("#p_item16Sqfse").val();
	 							var p_item18Sqfse = $("#p_item18Sqfse").val();
	 							if (p_item15Sqfse != null && p_item15Sqfse != "" || p_item16Sqfse != null
	 									&& p_item16Sqfse != "" || p_item18Sqfse != null
	 									&& p_item18Sqfse != "" ) {
	 								var a = new Array(p_item15Sqfse,p_item16Sqfse);
	 								var p_item20Sqfse = 0;
	 								for (var i = 0; i < a.length; i++) {
	 										if (a[i] != null && a[i] != ""){
	 										var b=parseFloat(a[i]);

	 										p_item20Sqfse +=b ;
	 										}
	 								}
	 								if(p_item18Sqfse != null&& p_item18Sqfse != ""){
	 									var c=parseFloat(p_item18Sqfse);
	 									p_item20Sqfse-=c;
	 								}
	 								$("#p_item20Sqfse").textbox('setValue',p_item20Sqfse);
	 							}

	 			        	 $("#p_item20Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			
	 			$("#p_item22Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item20Bqfse = $("#p_item20Bqfse").val();
	 							var p_item21Bqfse = $("#p_item21Bqfse").val();
	 							if (p_item20Bqfse != null && p_item20Bqfse != "" || p_item21Bqfse != null
	 									&& p_item21Bqfse != ""  ) {
	 								var p_item22Bqfse = 0;
	 								
	 								if (p_item20Bqfse != null && p_item20Bqfse!= ""){
	 										var b=parseFloat(p_item20Bqfse);

	 										p_item22Bqfse +=b ;
	 										}
	 								
	 								if (p_item21Bqfse != null && p_item21Bqfse!= ""){
	 									var b=parseFloat(p_item21Bqfse);

	 									p_item22Bqfse -=b ;
	 									}
	 								$("#p_item22Bqfse").textbox('setValue',p_item22Bqfse);
	 							}
	 			        	 $("#p_item22Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			$("#p_item22Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item20Sqfse = $("#p_item20Sqfse").val();
	 							var p_item21Sqfse = $("#p_item21Sqfse").val();
	 							if (p_item20Sqfse != null && p_item20Sqfse != "" || p_item21Sqfse != null
	 									&& p_item21Sqfse != ""  ) {
	 								var p_item22Sqfse = 0;
	 								
	 								if (p_item20Sqfse != null && p_item20Sqfse!= ""){
	 										var b=parseFloat(p_item20Sqfse);

	 										p_item22Sqfse +=b ;
	 										}
	 								
	 								if (p_item21Sqfse != null && p_item21Sqfse!= ""){
	 									var b=parseFloat(p_item21Sqfse);

	 									p_item22Sqfse -=b ;
	 									}
	 								$("#p_item22Sqfse").textbox('setValue',p_item22Sqfse);
	 							}
	 			        	 $("#p_item22Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			$("#p_item35Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item22Bqfse = $("#p_item22Bqfse").val();
	 							var p_item23Bqfse = $("#p_item23Bqfse").val();
	 							var p_item24Bqfse = $("#p_item24Bqfse").val();
	 							var p_item25Bqfse = $("#p_item25Bqfse").val();
	 							var p_item26Bqfse = $("#p_item26Bqfse").val();
	 							var p_item27Bqfse = $("#p_item27Bqfse").val();
	 							var p_item28Bqfse = $("#p_item28Bqfse").val();
	 							var p_item29Bqfse = $("#p_item29Bqfse").val();
	 							var p_item30Bqfse = $("#p_item30Bqfse").val();
	 							var p_item31Bqfse = $("#p_item31Bqfse").val();
	 							var p_item32Bqfse = $("#p_item32Bqfse").val();
	 							var p_item33Bqfse = $("#p_item33Bqfse").val();
	 							var p_item34Bqfse = $("#p_item34Bqfse").val();
	 							if (p_item22Bqfse != null && p_item22Bqfse != "" || p_item23Bqfse != null
	 									&& p_item23Bqfse != "" || p_item24Bqfse != null
	 									&& p_item24Bqfse != "" || p_item25Bqfse != null
	 									&& p_item25Bqfse != "" || p_item26Bqfse != null
	 									&& p_item26Bqfse != "" || p_item27Bqfse != null
	 									&& p_item27Bqfse != "" || p_item28Bqfse != null
	 									&& p_item28Bqfse != "" || p_item29Bqfse != null
	 									&& p_item29Bqfse != "" || p_item30Bqfse != null
	 									&& p_item30Bqfse != "" || p_item31Bqfse != null
	 									&& p_item31Bqfse != ""|| p_item32Bqfse != null
	 									&& p_item32Bqfse != ""|| p_item33Bqfse != null
	 									&& p_item33Bqfse != ""|| p_item34Bqfse != null
	 									&& p_item34Bqfse != "") {
	 								var a = new Array(p_item22Bqfse,p_item23Bqfse,p_item24Bqfse);
	 								var d=new Array(p_item25Bqfse,p_item26Bqfse,p_item27Bqfse,p_item28Bqfse,p_item29Bqfse,p_item30Bqfse,p_item31Bqfse,p_item32Bqfse,p_item33Bqfse,p_item34Bqfse);
	 								var p_item35Bqfse = 0;
	 								for (var i = 0; i < a.length; i++) {
	 										if (a[i] != null && a[i] != ""){
	 										var b=parseFloat(a[i]);

	 										p_item35Bqfse +=b ;
	 										}
	 								}
	 								for (var i = 0; i < d.length; i++) {
	 									if (d[i] != null && d[i] != ""){
	 									var b=parseFloat(d[i]);

	 									p_item35Bqfse -=b ;
	 									}
	 							}
	 								$("#p_item35Bqfse").textbox('setValue',p_item35Bqfse);
	 							}

	 			        	 $("#p_item35Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			$("#p_item35Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item22Sqfse = $("#p_item22Sqfse").val();
	 							var p_item23Sqfse = $("#p_item23Sqfse").val();
	 							var p_item24Sqfse = $("#p_item24Sqfse").val();
	 							var p_item25Sqfse = $("#p_item25Sqfse").val();
	 							var p_item26Sqfse = $("#p_item26Sqfse").val();
	 							var p_item27Sqfse = $("#p_item27Sqfse").val();
	 							var p_item28Sqfse = $("#p_item28Sqfse").val();
	 							var p_item29Sqfse = $("#p_item29Sqfse").val();
	 							var p_item30Sqfse = $("#p_item30Sqfse").val();
	 							var p_item31Sqfse = $("#p_item31Sqfse").val();
	 							var p_item32Sqfse = $("#p_item32Sqfse").val();
	 							var p_item33Sqfse = $("#p_item33Sqfse").val();
	 							var p_item34Sqfse = $("#p_item34Sqfse").val();
	 							if (p_item22Sqfse != null && p_item22Sqfse != "" || p_item23Sqfse != null
	 									&& p_item23Sqfse != "" || p_item24Sqfse != null
	 									&& p_item24Sqfse != "" || p_item25Sqfse != null
	 									&& p_item25Sqfse != "" || p_item26Sqfse != null
	 									&& p_item26Sqfse != "" || p_item27Sqfse != null
	 									&& p_item27Sqfse != "" || p_item28Sqfse != null
	 									&& p_item28Sqfse != "" || p_item29Sqfse != null
	 									&& p_item29Sqfse != "" || p_item30Sqfse != null
	 									&& p_item30Sqfse != "" || p_item31Sqfse != null
	 									&& p_item31Sqfse != ""|| p_item32Sqfse != null
	 									&& p_item32Sqfse != ""|| p_item33Sqfse != null
	 									&& p_item33Sqfse != ""|| p_item34Sqfse != null
	 									&& p_item34Sqfse != "") {
	 								var a = new Array(p_item22Sqfse,p_item23Sqfse,p_item24Sqfse);
	 								var d=new Array(p_item25Sqfse,p_item26Sqfse,p_item27Sqfse,p_item28Sqfse,p_item29Sqfse,p_item30Sqfse,p_item31Sqfse,p_item32Sqfse,p_item33Sqfse,p_item34Sqfse);
	 								var p_item35Sqfse = 0;
	 								for (var i = 0; i < a.length; i++) {
	 										if (a[i] != null && a[i] != ""){
	 										var b=parseFloat(a[i]);

	 										p_item35Sqfse +=b ;
	 										}
	 								}
	 								for (var i = 0; i < d.length; i++) {
	 									if (d[i] != null && d[i] != ""){
	 									var b=parseFloat(d[i]);

	 									p_item35Sqfse -=b ;
	 									}
	 							}
	 								$("#p_item35Sqfse").textbox('setValue',p_item35Sqfse);
	 							}
	 			        	 $("#p_item35Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			
	 			$("#p_item36Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item37Bqfse = $("#p_item37Bqfse").val();
	 							var p_item40Bqfse = $("#p_item40Bqfse").val();
	 							if (p_item37Bqfse != null && p_item37Bqfse != "" || p_item40Bqfse != null
	 									&& p_item40Bqfse != ""  ) {
	 								var p_item36Bqfse = 0;
	 								
	 								var a=new Array(p_item37Bqfse,p_item40Bqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item36Bqfse +=b ;
	 										}	
	 								}
	 								$("#p_item36Bqfse").textbox('setValue',p_item36Bqfse);
	 							}
	 			        	 $("#p_item36Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			$("#p_item36Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item37Sqfse = $("#p_item37Sqfse").val();
	 							var p_item40Sqfse = $("#p_item40Sqfse").val();
	 							if (p_item37Sqfse != null && p_item37Sqfse != "" || p_item40Sqfse != null
	 									&& p_item40Sqfse != ""  ) {
	 								var p_item36Sqfse = 0;
	 								var a=new Array(p_item37Sqfse,p_item40Sqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item36Sqfse +=b ;
	 										}	
	 								}
	 								
	 								$("#p_item36Sqfse").textbox('setValue',p_item36Sqfse);
	 							}
	 			        	 $("#p_item36Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			

	 			$("#p_item37Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item38Bqfse = $("#p_item38Bqfse").val();
	 							var p_item39Bqfse = $("#p_item39Bqfse").val();
	 							if (p_item38Bqfse != null && p_item38Bqfse != "" || p_item39Bqfse != null
	 									&& p_item39Bqfse != ""  ) {
	 								var p_item37Bqfse = 0;
	 								
	 								var a=new Array(p_item38Bqfse,p_item39Bqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item37Bqfse +=b ;
	 										}	
	 								}
	 								$("#p_item37Bqfse").textbox('setValue',p_item37Bqfse);
	 							}
	 			        	 $("#p_item37Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			$("#p_item37Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item38Sqfse = $("#p_item38Sqfse").val();
	 							var p_item39Sqfse = $("#p_item39Sqfse").val();
	 							if (p_item38Sqfse != null && p_item38Sqfse != "" || p_item39Sqfse != null
	 									&& p_item39Sqfse != ""  ) {
	 								var p_item37Sqfse = 0;
	 								var a=new Array(p_item38Sqfse,p_item39Sqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item37Sqfse +=b ;
	 										}	
	 								}
	 								
	 								$("#p_item37Sqfse").textbox('setValue',p_item37Sqfse);
	 							}
	 			        	 $("#p_item37Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						

	 					});
	 			
	 			

	 			$("#p_item40Bqfse").textbox({ 
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item41Bqfse = $("#p_item41Bqfse").val();
	 							var p_item42Bqfse = $("#p_item42Bqfse").val();
	 							var p_item43Bqfse = $("#p_item43Bqfse").val();
	 							var p_item44Bqfse = $("#p_item44Bqfse").val();
	 							var p_item45Bqfse = $("#p_item45Bqfse").val();
	 							var p_item46Bqfse = $("#p_item46Bqfse").val();
	 							if (p_item41Bqfse != null && p_item41Bqfse != "" || p_item42Bqfse != null
	 									&& p_item42Bqfse != "" || p_item43Bqfse != null
	 									&& p_item43Bqfse != "" || p_item44Bqfse != null
	 									&& p_item44Bqfse != "" || p_item45Bqfse != null
	 									&& p_item45Bqfse != "" || p_item46Bqfse != null
	 									&& p_item46Bqfse != ""  ) {
	 								var p_item40Bqfse = 0;
	 								
	 								var a=new Array(p_item41Bqfse,p_item42Bqfse,p_item43Bqfse,p_item44Bqfse,p_item45Bqfse,p_item46Bqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item40Bqfse +=b ;
	 										}	
	 								}
	 								$("#p_item40Bqfse").textbox('setValue',p_item40Bqfse);
	 							}

	 			        	 $("#p_item40Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			$("#p_item40Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item41Sqfse = $("#p_item41Sqfse").val();
	 							var p_item42Sqfse = $("#p_item42Sqfse").val();
	 							var p_item43Sqfse = $("#p_item43Sqfse").val();
	 							var p_item44Sqfse = $("#p_item44Sqfse").val();
	 							var p_item45Sqfse = $("#p_item45Sqfse").val();
	 							var p_item46Sqfse = $("#p_item46Sqfse").val();
	 							if (p_item41Sqfse != null && p_item41Sqfse != "" || p_item42Sqfse != null
	 									&& p_item42Sqfse != "" || p_item43Sqfse != null
	 									&& p_item43Sqfse != "" || p_item44Sqfse != null
	 									&& p_item44Sqfse != "" || p_item45Sqfse != null
	 									&& p_item45Sqfse != "" || p_item46Sqfse != null
	 									&& p_item46Sqfse != ""  ) {
	 								var p_item40Sqfse = 0;
	 								
	 								var a=new Array(p_item41Sqfse,p_item42Sqfse,p_item43Sqfse,p_item44Sqfse,p_item45Sqfse,p_item46Sqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item40Sqfse +=b ;
	 										}	
	 								}
	 								$("#p_item40Sqfse").textbox('setValue',p_item40Sqfse);
	 							}
	 			        	 $("#p_item40Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			$("#p_item47Bqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item22Bqfse = $("#p_item22Bqfse").val();
	 							var p_item36Bqfse = $("#p_item36Bqfse").val();
	 							if (p_item22Bqfse != null && p_item22Bqfse != "" || p_item36Bqfse != null
	 									&& p_item36Bqfse != ""  ) {
	 								var p_item47Bqfse = 0;
	 								
	 								var a=new Array(p_item22Bqfse,p_item36Bqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item47Bqfse +=b ;
	 										}	
	 								}
	 								$("#p_item47Bqfse").textbox('setValue',p_item47Bqfse);
	 							}

	 			        	 $("#p_item47Bqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			$("#p_item47Sqfse").textbox({
	 				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
	 			         click : function(e){
	 			        	 var p_item22Sqfse = $("#p_item22Sqfse").val();
	 							var p_item36Sqfse = $("#p_item36Sqfse").val();
	 							if (p_item22Sqfse != null && p_item22Sqfse != "" || p_item36Sqfse != null
	 									&& p_item36Sqfse != ""  ) {
	 								var p_item47Sqfse = 0;
	 								var a=new Array(p_item22Sqfse,p_item36Sqfse);
	 								for(var i=0;i<a.length;i++){
	 									if (a[i] != null && a[i]!= ""){
	 										var b=parseFloat(a[i]);

	 										p_item47Sqfse +=b ;
	 										}	
	 								}
	 								
	 								$("#p_item47Sqfse").textbox('setValue',p_item47Sqfse);
	 							}

	 			        	 $("#p_item47Sqfse").textbox({readonly:true});
	 			        }
	 			    })
	 						
	 					});
	 			
	 			 $('#btnSave').click(function() {
	 			      
	 			        var data=$.easyuiExtendObj.drillDownForm('lr111');

	 			        $.ajax({
	 			           
	 			            type: 'POST',
	 			            url: '../zcb/saveLR',
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