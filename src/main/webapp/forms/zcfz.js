	$(function() {
			 $('#btnSave').click(function() {
		        var data=$.easyuiExtendObj.drillDownForm('zcfz111');

		        $.ajax({
		           
		            type: 'POST',
		            url: '../zcb/saveZCFZ',
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
		 
		 
		
		 $("#p_item15Qcs").textbox({
			 
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item2Qcs = $("#p_item2Qcs").val();
						var p_item3Qcs = $("#p_item3Qcs").val();
						var p_item4Qcs = $("#p_item4Qcs").val();
						var p_item5Qcs = $("#p_item5Qcs").val();
						var p_item6Qcs = $("#p_item6Qcs").val();
						var p_item7Qcs = $("#p_item7Qcs").val();
						var p_item8Qcs = $("#p_item8Qcs").val();
						var p_item9Qcs = $("#p_item9Qcs").val();
						var p_item10Qcs = $("#p_item10Qcs").val();
						var p_item11Qcs = $("#p_item11Qcs").val();
						var p_item12Qcs = $("#p_item12Qcs").val();
						var p_item13Qcs = $("#p_item13Qcs").val();
						var p_item14Qcs = $("#p_item14Qcs").val();
						if (p_item2Qcs != null && p_item2Qcs != "" || p_item3Qcs != null
								&& p_item3Qcs != "" || p_item4Qcs != null
								&& p_item4Qcs != "" || p_item5Qcs != null
								&& p_item5Qcs != "" || p_item6Qcs != null
								&& p_item6Qcs != "" || p_item7Qcs != null
								&& p_item7Qcs != "" || p_item8Qcs != null
								&& p_item8Qcs != "" || p_item9Qcs != null
								&& p_item9Qcs != "" || p_item10Qcs != null
								&& p_item10Qcs != "" || p_item11Qcs != null
								&& p_item11Qcs != "" || p_item12Qcs != null
								&& p_item12Qcs != "" || p_item13Qcs != null
								&& p_item13Qcs != "" || p_item14Qcs != null
								&& p_item14Qcs != "") {
							var a = new Array(p_item2Qcs, p_item3Qcs, p_item4Qcs,
									p_item5Qcs, p_item6Qcs, p_item7Qcs, p_item8Qcs,
									p_item9Qcs, p_item10Qcs, p_item11Qcs, p_item12Qcs,
									p_item13Qcs, p_item14Qcs);
							var p_item15Qcs = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									p_item15Qcs +=b ;
									}
							}
							$("#p_item15Qcs").textbox('setValue',p_item15Qcs);
						}
						$("#p_item15Qcs").textbox({readonly:true});
				    }
		        })
		    
			 	
	});
			
			
			$("#p_item15Qms").textbox({
				
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item2Qms = $("#p_item2Qms").val();
							var p_item3Qms = $("#p_item3Qms").val();
							var p_item4Qms = $("#p_item4Qms").val();
							var p_item5Qms = $("#p_item5Qms").val();
							var p_item6Qms = $("#p_item6Qms").val();
							var p_item7Qms = $("#p_item7Qms").val();
							var p_item8Qms = $("#p_item8Qms").val();
							var p_item9Qms = $("#p_item9Qms").val();
							var p_item10Qms = $("#p_item10Qms").val();
							var p_item11Qms = $("#p_item11Qms").val();
							var p_item12Qms = $("#p_item12Qms").val();
							var p_item13Qms = $("#p_item13Qms").val();
							var p_item14Qms = $("#p_item14Qms").val();
							if (p_item2Qms != null && p_item2Qms != "" || p_item3Qms != null
									&& p_item3Qms != "" || p_item4Qms != null
									&& p_item4Qms != "" || p_item5Qms != null
									&& p_item5Qms != "" || p_item6Qms != null
									&& p_item6Qms != "" || p_item7Qms != null
									&& p_item7Qms != "" || p_item8Qms != null
									&& p_item8Qms != "" || p_item9Qms != null
									&& p_item9Qms != "" || p_item10Qms != null
									&& p_item10Qms != "" || p_item11Qms != null
									&& p_item11Qms != "" || p_item12Qms != null
									&& p_item12Qms != "" || p_item13Qms != null
									&& p_item13Qms != "" || p_item14Qms != null
									&& p_item14Qms != "") {
								var a = new Array(p_item2Qms, p_item3Qms, p_item4Qms,
										p_item5Qms, p_item6Qms, p_item7Qms, p_item8Qms,
										p_item9Qms, p_item10Qms, p_item11Qms, p_item12Qms,
										p_item13Qms, p_item14Qms);
								var p_item15Qms = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item15Qms +=b ;
										}
								}
								$("#p_item15Qms").textbox('setValue',p_item15Qms);
							}
							$("#p_item15Qms").textbox({readonly:true});
			        }
			    })
				
			});
			
			
			
			$("#p_item34Qcs").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item17Qcs = $("#p_item17Qcs").val();
							var p_item18Qcs = $("#p_item18Qcs").val();
							var p_item19Qcs = $("#p_item19Qcs").val();
							var p_item20Qcs = $("#p_item20Qcs").val();
							var p_item21Qcs = $("#p_item21Qcs").val();
							var p_item22Qcs = $("#p_item22Qcs").val();
							var p_item23Qcs = $("#p_item23Qcs").val();
							var p_item24Qcs = $("#p_item24Qcs").val();
							var p_item25Qcs = $("#p_item25Qcs").val();
							var p_item26Qcs = $("#p_item26Qcs").val();
							var p_item27Qcs = $("#p_item27Qcs").val();
							var p_item28Qcs = $("#p_item28Qcs").val();
							var p_item29Qcs = $("#p_item29Qcs").val();
							var p_item30Qcs = $("#p_item30Qcs").val();
							var p_item31Qcs = $("#p_item31Qcs").val();
							var p_item32Qcs = $("#p_item32Qcs").val();
							var p_item33Qcs = $("#p_item33Qcs").val();
							if (p_item17Qcs != null && p_item17Qcs != "" || p_item18Qcs != null
									&& p_item18Qcs != "" || p_item19Qcs != null
									&& p_item19Qcs != "" || p_item20Qcs != null
									&& p_item20Qcs != "" || p_item21Qcs != null
									&& p_item21Qcs != "" || p_item22Qcs != null
									&& p_item22Qcs != "" || p_item23Qcs != null
									&& p_item23Qcs != "" || p_item24Qcs != null
									&& p_item24Qcs != "" || p_item25Qcs != null
									&& p_item25Qcs != "" || p_item26Qcs != null
									&& p_item26Qcs != "" || p_item27Qcs != null
									&& p_item27Qcs != "" || p_item28Qcs != null
									&& p_item28Qcs != "" || p_item29Qcs != null
									&& p_item29Qcs != ""|| p_item30Qcs != null
									&& p_item30Qcs != ""|| p_item31Qcs != null
									&& p_item31Qcs != ""|| p_item32Qcs != null
									&& p_item32Qcs != ""|| p_item33Qcs != null
									&& p_item33Qcs != "") {
								var a = new Array(p_item17Qcs, p_item18Qcs, p_item19Qcs,
										p_item20Qcs, p_item21Qcs, p_item22Qcs, p_item23Qcs,
										p_item24Qcs, p_item25Qcs, p_item26Qcs, p_item27Qcs,
										p_item28Qcs, p_item29Qcs,p_item30Qcs,p_item31Qcs,p_item32Qcs,p_item33Qcs);
								var p_item34Qcs = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item34Qcs +=b ;
										}
								}
								$("#p_item34Qcs").textbox('setValue',p_item34Qcs);
							}
							$("#p_item34Qcs").textbox({readonly:true});
			        }
			    })
			});

			
			$("#p_item34Qms").textbox({
				inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item17Qms = $("#p_item17Qms").val();
							var p_item18Qms = $("#p_item18Qms").val();
							var p_item19Qms = $("#p_item19Qms").val();
							var p_item20Qms = $("#p_item20Qms").val();
							var p_item21Qms = $("#p_item21Qms").val();
							var p_item22Qms = $("#p_item22Qms").val();
							var p_item23Qms = $("#p_item23Qms").val();
							var p_item24Qms = $("#p_item24Qms").val();
							var p_item25Qms = $("#p_item25Qms").val();
							var p_item26Qms = $("#p_item26Qms").val();
							var p_item27Qms = $("#p_item27Qms").val();
							var p_item28Qms = $("#p_item28Qms").val();
							var p_item29Qms = $("#p_item29Qms").val();
							var p_item30Qms = $("#p_item30Qms").val();
							var p_item31Qms = $("#p_item31Qms").val();
							var p_item32Qms = $("#p_item32Qms").val();
							var p_item33Qms = $("#p_item33Qms").val();
							if (p_item17Qms != null && p_item17Qms != "" || p_item18Qms != null
									&& p_item18Qms != "" || p_item19Qms != null
									&& p_item19Qms != "" || p_item20Qms != null
									&& p_item20Qms != "" || p_item21Qms != null
									&& p_item21Qms != "" || p_item22Qms != null
									&& p_item22Qms != "" || p_item23Qms != null
									&& p_item23Qms != "" || p_item24Qms != null
									&& p_item24Qms != "" || p_item25Qms != null
									&& p_item25Qms != "" || p_item26Qms != null
									&& p_item26Qms != "" || p_item27Qms != null
									&& p_item27Qms != "" || p_item28Qms != null
									&& p_item28Qms != "" || p_item29Qms != null
									&& p_item29Qms != ""|| p_item30Qms != null
									&& p_item30Qms != ""|| p_item31Qms != null
									&& p_item31Qms != ""|| p_item32Qms != null
									&& p_item32Qms != ""|| p_item33Qms != null
									&& p_item33Qms != "") {
								var a = new Array(p_item17Qms, p_item18Qms, p_item19Qms,
										p_item20Qms, p_item21Qms, p_item22Qms, p_item23Qms,
										p_item24Qms, p_item25Qms, p_item26Qms, p_item27Qms,
										p_item28Qms, p_item29Qms,p_item30Qms,p_item31Qms,p_item32Qms,p_item33Qms);
								var p_item34Qms = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item34Qms +=b ;
										}
								}
								$("#p_item34Qms").textbox('setValue',p_item34Qms);
							}
							$("#p_item34Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item43Qcs").textbox({
				
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item15Qcs=$("#p_item15Qcs").val();
							var p_item34Qcs=$("#p_item34Qcs").val();
							var a=new Array(p_item15Qcs,p_item34Qcs);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item43Qcs").textbox('setValue',sum);
							$("#p_item43Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item43Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item15Qms=$("#p_item15Qms").val();
							var p_item34Qms=$("#p_item34Qms").val();
							var a=new Array(p_item15Qms,p_item34Qms);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item43Qms").textbox('setValue',sum);
							$("#p_item43Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item59Qcs").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item45Qcs = $("#p_item45Qcs").val();
							var p_item46Qcs = $("#p_item46Qcs").val();
							var p_item47Qcs = $("#p_item47Qcs").val();
							var p_item48Qcs = $("#p_item48Qcs").val();
							var p_item49Qcs = $("#p_item49Qcs").val();
							var p_item50Qcs = $("#p_item50Qcs").val();
							var p_item51Qcs = $("#p_item51Qcs").val();
							var p_item52Qcs = $("#p_item52Qcs").val();
							var p_item53Qcs = $("#p_item53Qcs").val();
							var p_item54Qcs = $("#p_item54Qcs").val();
							var p_item55Qcs = $("#p_item55Qcs").val();
							var p_item56Qcs = $("#p_item56Qcs").val();
							var p_item57Qcs = $("#p_item57Qcs").val();
							var p_item58Qcs = $("#p_item58Qcs").val();
							if (p_item45Qcs != null && p_item45Qcs != "" || p_item46Qcs != null
									&& p_item46Qcs != "" || p_item47Qcs != null
									&& p_item47Qcs != "" || p_item48Qcs != null
									&& p_item48Qcs != "" || p_item49Qcs != null
									&& p_item49Qcs != "" || p_item50Qcs != null
									&& p_item50Qcs != "" || p_item51Qcs != null
									&& p_item51Qcs != "" || p_item52Qcs != null
									&& p_item52Qcs != "" || p_item53Qcs != null
									&& p_item53Qcs != "" || p_item54Qcs != null
									&& p_item54Qcs != "" || p_item55Qcs != null
									&& p_item55Qcs != "" || p_item56Qcs != null
									&& p_item56Qcs != "" || p_item57Qcs != null
									&& p_item57Qcs != ""|| p_item58Qcs != null
									&& p_item58Qcs != "") {
								var a = new Array(p_item45Qcs, p_item46Qcs, p_item47Qcs,
										p_item48Qcs, p_item49Qcs, p_item50Qcs, p_item51Qcs,
										p_item52Qcs, p_item53Qcs, p_item54Qcs, p_item55Qcs,
										p_item56Qcs, p_item57Qcs,p_item58Qcs);
								var p_item59Qcs = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item59Qcs +=b ;
										}
								}
								$("#p_item59Qcs").textbox('setValue',p_item59Qcs);
							}
							$("#p_item59Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			
			$("#p_item59Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item45Qms = $("#p_item45Qms").val();
							var p_item46Qms = $("#p_item46Qms").val();
							var p_item47Qms = $("#p_item47Qms").val();
							var p_item48Qms = $("#p_item48Qms").val();
							var p_item49Qms = $("#p_item49Qms").val();
							var p_item50Qms = $("#p_item50Qms").val();
							var p_item51Qms = $("#p_item51Qms").val();
							var p_item52Qms = $("#p_item52Qms").val();
							var p_item53Qms = $("#p_item53Qms").val();
							var p_item54Qms = $("#p_item54Qms").val();
							var p_item55Qms = $("#p_item55Qms").val();
							var p_item56Qms = $("#p_item56Qms").val();
							var p_item57Qms = $("#p_item57Qms").val();
							var p_item58Qms = $("#p_item58Qms").val();
							if (p_item45Qms != null && p_item45Qms != "" || p_item46Qms != null
									&& p_item46Qms != "" || p_item47Qms != null
									&& p_item47Qms != "" || p_item48Qms != null
									&& p_item48Qms != "" || p_item49Qms != null
									&& p_item49Qms != "" || p_item50Qms != null
									&& p_item50Qms != "" || p_item51Qms != null
									&& p_item51Qms != "" || p_item52Qms != null
									&& p_item52Qms != "" || p_item53Qms != null
									&& p_item53Qms != "" || p_item54Qms != null
									&& p_item54Qms != "" || p_item55Qms != null
									&& p_item55Qms != "" || p_item56Qms != null
									&& p_item56Qms != "" || p_item57Qms != null
									&& p_item57Qms != "" || p_item58Qms != null
									&& p_item58Qms != "") {
								var a = new Array(p_item45Qms, p_item46Qms, p_item47Qms,
										p_item48Qms, p_item49Qms, p_item50Qms, p_item51Qms,
										p_item52Qms, p_item53Qms, p_item54Qms, p_item55Qms,
										p_item56Qms, p_item57Qms,p_item58Qms);
								var p_item59Qms = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item59Qms +=b ;
										}
								}
								$("#p_item59Qms").textbox('setValue',p_item59Qms);
							}
							$("#p_item59Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item72Qcs").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item61Qcs = $("#p_item61Qcs").val();
							var p_item62Qcs = $("#p_item62Qcs").val();
							var p_item65Qcs = $("#p_item65Qcs").val();
							var p_item66Qcs = $("#p_item66Qcs").val();
							var p_item67Qcs = $("#p_item67Qcs").val();
							var p_item68Qcs = $("#p_item68Qcs").val();
							var p_item69Qcs = $("#p_item69Qcs").val();
							var p_item70Qcs = $("#p_item70Qcs").val();
							var p_item71Qcs = $("#p_item71Qcs").val();
							if (p_item61Qcs != null && p_item61Qcs != "" || p_item62Qcs != null
									&& p_item62Qcs != "" || p_item65Qcs != null
									&& p_item65Qcs != "" || p_item66Qcs != null
									&& p_item66Qcs != "" || p_item67Qcs != null
									&& p_item67Qcs != "" || p_item68Qcs != null
									&& p_item68Qcs != "" || p_item69Qcs != null
									&& p_item69Qcs != "" || p_item70Qcs != null
									&& p_item70Qcs != "" || p_item71Qcs != null
									&& p_item71Qcs != "" ) {
								var a = new Array(p_item61Qcs, p_item62Qcs, p_item65Qcs,
										p_item66Qcs, p_item67Qcs, p_item68Qcs, p_item69Qcs,
										p_item70Qcs, p_item71Qcs);
								var p_item72Qcs = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item72Qcs +=b ;
										}
								}
								$("#p_item72Qcs").textbox('setValue',p_item72Qcs);
							}
							$("#p_item72Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item72Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item61Qms = $("#p_item61Qms").val();
							var p_item62Qms = $("#p_item62Qms").val();
							var p_item65Qms = $("#p_item65Qms").val();
							var p_item66Qms = $("#p_item66Qms").val();
							var p_item67Qms = $("#p_item67Qms").val();
							var p_item68Qms = $("#p_item68Qms").val();
							var p_item69Qms = $("#p_item69Qms").val();
							var p_item70Qms = $("#p_item70Qms").val();
							var p_item71Qms = $("#p_item71Qms").val();
							if (p_item61Qms != null && p_item61Qms != "" || p_item62Qms != null
									&& p_item62Qms != "" || p_item65Qms != null
									&& p_item65Qms != "" || p_item66Qms != null
									&& p_item66Qms != "" || p_item67Qms != null
									&& p_item67Qms != "" || p_item68Qms != null
									&& p_item68Qms != "" || p_item69Qms != null
									&& p_item69Qms != "" || p_item70Qms != null
									&& p_item70Qms != "" || p_item71Qms != null
									&& p_item71Qms != "" ) {
								var a = new Array(p_item61Qms, p_item62Qms, p_item65Qms,
										p_item66Qms, p_item67Qms, p_item68Qms, p_item69Qms,
										p_item70Qms, p_item71Qms);
								var p_item72Qms = 0;
								for (var i = 0; i < a.length; i++) {
										if (a[i] != null && a[i] != ""){
										var b=parseFloat(a[i]);

										p_item72Qms +=b ;
										}
								}
								$("#p_item72Qms").textbox('setValue',p_item72Qms);
							}
							$("#p_item72Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item73Qcs").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item59Qcs=$("#p_item59Qcs").val();
							var p_item72Qcs=$("#p_item72Qcs").val();
							var a=new Array(p_item59Qcs,p_item72Qcs);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item73Qcs").textbox('setValue',sum);
							$("#p_item73Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item73Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item59Qms=$("#p_item59Qms").val();
							var p_item72Qms=$("#p_item72Qms").val();
							var a=new Array(p_item59Qms,p_item72Qms);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item73Qms").textbox('setValue',sum);
							$("#p_item73Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item85Qcs").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item75Qcs=$("#p_item75Qcs").val();
							var p_item76Qcs=$("#p_item76Qcs").val();
							var p_item79Qcs=$("#p_item79Qcs").val();
							var p_item80Qcs=$("#p_item80Qcs").val();
							var p_item81Qcs=$("#p_item81Qcs").val();
							var p_item82Qcs=$("#p_item82Qcs").val();
							var p_item83Qcs=$("#p_item83Qcs").val();
							var p_item84Qcs=$("#p_item84Qcs").val();
							var a=new Array(p_item75Qcs,p_item76Qcs,p_item79Qcs,p_item81Qcs,p_item82Qcs,p_item83Qcs,p_item84Qcs);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							if(p_item80Qcs!=null&&p_item80Qcs!=""){
								var c=parseFloat(p_item80Qcs);
								sum-=c;
							}
							$("#p_item85Qcs").textbox('setValue',sum);
							$("#p_item85Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item85Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item75Qms=$("#p_item75Qms").val();
							var p_item76Qms=$("#p_item76Qms").val();
							var p_item79Qms=$("#p_item79Qms").val();
							var p_item80Qms=$("#p_item80Qms").val();
							var p_item81Qms=$("#p_item81Qms").val();
							var p_item82Qms=$("#p_item82Qms").val();
							var p_item83Qms=$("#p_item83Qms").val();
							var p_item84Qms=$("#p_item84Qms").val();
							var a=new Array(p_item75Qms,p_item76Qms,p_item79Qms,p_item81Qms,p_item82Qms,p_item83Qms,p_item84Qms);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							if(p_item80Qms!=null&&p_item80Qms!=""){
								var c=parseFloat(p_item80Qms);
								sum-=c;
							}
							$("#p_item85Qms").textbox('setValue',sum);
							$("#p_item85Qms").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item86Qcs").textbox( {
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item73Qcs=$("#p_item73Qcs").val();
							var p_item85Qcs=$("#p_item85Qcs").val();
							var a=new Array(p_item73Qcs,p_item85Qcs);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item86Qcs").textbox('setValue',sum);
							$("#p_item86Qcs").textbox({readonly:true});
			        }
			    })
			});
			
			$("#p_item86Qms").textbox({
				 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
			         click : function(e){
			        	 var p_item73Qms=$("#p_item73Qms").val();
							var p_item85Qms=$("#p_item85Qms").val();
							var a=new Array(p_item73Qms,p_item85Qms);
							var sum=0;
							for(var i=0;i<a.length;i++){
								if(a[i]!=null&&a[i]!=""){
									var b=parseFloat(a[i]);
									sum+=b;
								}
							}
							$("#p_item86Qms").textbox('setValue',sum);
							$("#p_item86Qms").textbox({readonly:true});
			        }
			    })
			});
		
	})
