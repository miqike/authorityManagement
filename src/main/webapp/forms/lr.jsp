	 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
	 <script type="text/javascript">


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
	 </script>
	<table id="lr111" width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">利润表</caption>
		<tr>
                <td>信用代码</td>
                <td ><input id="p_xydm" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td>年度</td>
                <td ><input id="p_nd" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td >填报日期</td>
                <td ><input id="p_tbrq" class="easyui-textbox"  style="width:100%;height:100%;"></td>
            </tr>
		<tr>
			<th>项 目</th>
			<th>行次</th> 
			<th colspan="2">本期发生额</th>
			<th colspan="2">上期发生额</th>
		</tr>
		<tr>
			<td>一、营业收入</td>
			<td>1</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item1Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item1Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：主营业务收入</td>
			<td>2</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item2Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item2Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他业务收入</td>
			<td>3</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item3Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item3Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：营业成本</td>
			<td>4</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item4Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item4Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：主营业务成本</td>
			<td>5</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item5Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item5Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他业务成本</td>
			<td>6</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item6Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item6Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>营业税金及附加</td>
			<td>7</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item7Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item7Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>销售费用</td>
			<td>8</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item8Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item8Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>管理费用</td>
			<td>9</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item9Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item9Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>财务费用</td>
			<td>10</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item10Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item10Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>资产减值损失</td>
			<td>11</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item11Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item11Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>加：公允价值变动收益（损失以“-”号填列）</td>
			<td>12</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item12Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item12Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>投资收益（损失以“-”号填列）</td>
			<td>13</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item13Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item13Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：对联营企业和合营企业的投资收益</td>
			<td>14</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item14Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item14Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>二、营业利润(亏损以“-”号填列)</td>
			<td>15</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item15Bqfse"
				style="border: none; width: 100%;"  /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item15Sqfse"
				style="border: none; width: 100%;"  /></td>
		</tr>
		<tr>
			<td>加：营业外收入</td>
			<td>16</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item16Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item16Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：非流动资产处置利得</td>
			<td>17</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item17Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item17Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：营业外支出</td>
			<td>18</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item18Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item18Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：非流动资产处置损失</td>
			<td>19</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item19Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item19Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>三、利润总额(亏损总额“-”号填列)</td>
			<td>20</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item20Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item20Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>减：所得税费用</td>
			<td>21</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item21Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item21Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>四、净利润(净亏损以“-”号填列)</td>
			<td>22</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item22Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item22Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>加：年初未分配利润</td>
			<td>23</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item23Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item23Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他转入</td>
			<td>24</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item24Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item24Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：提取法定盈余公积</td>
			<td>25</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item25Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item25Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取法定公益金</td>
			<td>26</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item26Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item26Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取职工奖励及福利基金</td>
			<td>27</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item27Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item27Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取储备基金</td>
			<td>28</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item28Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item28Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取企业发展基金</td>
			<td>29</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item29Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item29Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>利润归还投资</td>
			<td>30</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item30Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item30Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>应付优先股股利</td>
			<td>31</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item31Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item31Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取任意盈余公积</td>
			<td>32</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item32Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item32Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>应付普通股股利</td>
			<td>33</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item33Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item33Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>转做资本（或股本）的普通股股利</td>
			<td>34</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item34Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item34Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>未分配利润</td>
			<td>35</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item35Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item35Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		
		
		<tr>
			<td>1.重新计量设定受益计划净负债或净资产的变动</td>
			<td>36</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item38Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item38Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>2.权益法下在被投资单位不能重分类进损益的其他综合收益中享有的份额</td>
			<td>37</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item39Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item39Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>（一）以后不能重分类进损益的其他综合收益</td>
			<td>38</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item37Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item37Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>1.权益法下在被投资单位以后将重分类进损益的其他综合收益中享有的份额</td>
			<td>39</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item41Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item41Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>2.可供出售金融资产公允价值变动损益</td>
			<td>40</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item42Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item42Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>3.持有至到期投资重分类为可供出售金融资产损益</td>
			<td>41</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item43Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item43Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>4.现金流量套期损益的有效部分</td>
			<td >42</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item44Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item44Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>5.外币财务报表折算差额</td>
			<td>43</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item45Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item45Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>6.其他</td>
			<td>44</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item46Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item46Sqfse" style="border: none;" /></td>
		</tr>
		<tr>
			<td>（二）以后将重分类进损益的其他综合收益</td>
			<td>45</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item40Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item40Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>五、其他综合收益的税后净额</td>
			<td>46</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item36Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item36Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>六、综合收益总额</td>
			<td>47</td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item47Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color:cyan"><input class="easyui-textbox" id="p_item47Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td>七、每股收益：</td>
			<td>48</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item48Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item48Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>(一)基本每股收益</td>
			<td>49</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item49Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item49Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>(二)稀释每股收益</td>
			<td>50</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item50Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item50Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
	</table>
	<div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	</div>
</body>
</html>