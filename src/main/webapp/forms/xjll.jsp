 <%@ page contentType="text/html; charset=UTF-8" %>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" >
    $(function() {

		$("#p_item5Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item2Bqfse = $("#p_item2Bqfse").val();
						var p_item3Bqfse = $("#p_item3Bqfse").val();
						var p_item4Bqfse = $("#p_item4Bqfse").val();
						if (p_item2Bqfse != null && p_item2Bqfse != ""
								|| p_item3Bqfse != null && p_item3Bqfse != ""
								|| p_item4Bqfse != null && p_item4Bqfse != "") {
							var a = new Array(p_item2Bqfse, p_item3Bqfse, p_item4Bqfse);
							var p_item5Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item5Bqfse += b;
								}
							}

							$("#p_item5Bqfse").textbox('setValue',p_item5Bqfse);
						}
		        	 $("#p_item5Bqfse").textbox({readonly:true});
		        }
		    })
					

				});

		$("#p_item5Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item2Sqfse = $("#p_item2Sqfse").val();
						var p_item3Sqfse = $("#p_item3Sqfse").val();
						var p_item4Sqfse = $("#p_item4Sqfse").val();
						if (p_item2Sqfse != null && p_item2Sqfse != ""
								|| p_item3Sqfse != null && p_item3Sqfse != ""
								|| p_item4Sqfse != null && p_item4Sqfse != "") {
							var a = new Array(p_item2Sqfse, p_item3Sqfse, p_item4Sqfse);
							var p_item5Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item5Sqfse += b;
								}
							}

							$("#p_item5Sqfse").textbox('setValue',p_item5Sqfse);
						}
		        	 $("#p_item5Sqfse").textbox({readonly:true});
		        }
		    })
					

				});

		$("#p_item10Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item6Bqfse = $("#p_item6Bqfse").val();
						var p_item7Bqfse = $("#p_item7Bqfse").val();
						var p_item8Bqfse = $("#p_item8Bqfse").val();
						var p_item9Bqfse = $("#p_item9Bqfse").val();
						if (p_item6Bqfse != null && p_item6Bqfse != ""
								|| p_item7Bqfse != null && p_item7Bqfse != ""
								|| p_item8Bqfse != null && p_item8Bqfse != ""
								|| p_item9Bqfse != null && p_item9Bqfse != "") {
							var a = new Array(p_item6Bqfse, p_item7Bqfse, p_item8Bqfse,
									p_item9Bqfse);
							var p_item10Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item10Bqfse += b;
								}
							}

							$("#p_item10Bqfse").textbox('setValue',p_item10Bqfse);
						}

		        	 $("#p_item10Bqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item10Sqfse").textbox( {
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item6Sqfse = $("#p_item6Sqfse").val();
						var p_item7Sqfse = $("#p_item7Sqfse").val();
						var p_item8Sqfse = $("#p_item8Sqfse").val();
						var p_item9Sqfse = $("#p_item9Sqfse").val();
						if (p_item6Sqfse != null && p_item6Sqfse != ""
								|| p_item7Sqfse != null && p_item7Sqfse != ""
								|| p_item8Sqfse != null && p_item8Sqfse != ""
								|| p_item9Sqfse != null && p_item9Sqfse != "") {
							var a = new Array(p_item6Sqfse, p_item7Sqfse, p_item8Sqfse,
									p_item9Sqfse);
							var p_item10Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item10Sqfse += b;
								}
							}

							$("#p_item10Sqfse").textbox('setValue',p_item10Sqfse);
						}

		        	 $("#p_item10Sqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item23Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item19Bqfse = $("#p_item19Bqfse").val();
						var p_item20Bqfse = $("#p_item20Bqfse").val();
						var p_item21Bqfse = $("#p_item21Bqfse").val();
						var p_item22Bqfse = $("#p_item22Bqfse").val();
						if (p_item19Bqfse != null && p_item19Bqfse != ""
								|| p_item20Bqfse != null && p_item20Bqfse != ""
								|| p_item21Bqfse != null && p_item21Bqfse != ""
								|| p_item22Bqfse != null && p_item22Bqfse != "") {
							var a = new Array(p_item19Bqfse, p_item20Bqfse,
									p_item21Bqfse, p_item22Bqfse);
							var p_item23Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item23Bqfse += b;
								}
							}

							$("#p_item23Bqfse").textbox('setValue',p_item23Bqfse);
						}

		        	 $("#p_item23Bqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item23Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item19Sqfse = $("#p_item19Sqfse").val();
						var p_item20Sqfse = $("#p_item20Sqfse").val();
						var p_item21Sqfse = $("#p_item21Sqfse").val();
						var p_item22Sqfse = $("#p_item22Sqfse").val();
						if (p_item19Sqfse != null && p_item19Sqfse != ""
								|| p_item20Sqfse != null && p_item20Sqfse != ""
								|| p_item21Sqfse != null && p_item21Sqfse != ""
								|| p_item22Sqfse != null && p_item22Sqfse != "") {
							var a = new Array(p_item19Sqfse, p_item20Sqfse,
									p_item21Sqfse, p_item22Sqfse);
							var p_item23Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item23Sqfse += b;
								}
							}

							$("#p_item23Sqfse").textbox('setValue',p_item23Sqfse);
						}

		        	 $("#p_item23Sqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item36Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item11Bqfse = $("#p_item11Bqfse").val();
						var p_item24Bqfse = $("#p_item24Bqfse").val();
						var p_item34Bqfse = $("#p_item34Bqfse").val();
						var p_item35Bqfse = $("#p_item35Bqfse").val();
						if (p_item11Bqfse != null && p_item11Bqfse != ""
								|| p_item24Bqfse != null && p_item24Bqfse != ""
								|| p_item34Bqfse != null && p_item34Bqfse != ""
								|| p_item35Bqfse != null && p_item35Bqfse != "") {
							var a = new Array(p_item11Bqfse, p_item24Bqfse,
									p_item34Bqfse, p_item35Bqfse);
							var p_item36Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item36Bqfse += b;
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
		        	 var p_item11Sqfse = $("#p_item11Sqfse").val();
						var p_item24Sqfse = $("#p_item24Sqfse").val();
						var p_item34Sqfse = $("#p_item34Sqfse").val();
						var p_item35Sqfse = $("#p_item35Sqfse").val();
						if (p_item11Sqfse != null && p_item11Sqfse != ""
								|| p_item24Sqfse != null && p_item24Sqfse != ""
								|| p_item34Sqfse != null && p_item34Sqfse != ""
								|| p_item35Sqfse != null && p_item35Sqfse != "") {
							var a = new Array(p_item11Sqfse, p_item24Sqfse,
									p_item34Sqfse, p_item35Sqfse);
							var p_item36Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != "") {
									var b = parseFloat(a[i]);

									p_item36Sqfse += b;
								}
							}

							$("#p_item36Sqfse").textbox('setValue',p_item36Sqfse);
						}

		        	 $("#p_item36Sqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item29Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        		var p_item26Bqfse = $("#p_item26Bqfse")
						.val();
				var p_item27Bqfse = $("#p_item27Bqfse")
						.val();
				var p_item28Bqfse = $("#p_item28Bqfse")
						.val();
				if (p_item26Bqfse != null && p_item26Bqfse != ""
						|| p_item27Bqfse != null && p_item27Bqfse != ""
						|| p_item28Bqfse != null && p_item28Bqfse != "") {
					var a = new Array(p_item26Bqfse, p_item27Bqfse,
							p_item28Bqfse);
					var p_item29Bqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item29Bqfse += b;
						}
					}

					$("#p_item29Bqfse").textbox('setValue',p_item29Bqfse);
				}

		        	 $("#p_item29Bqfse").textbox({readonly:true});
		        }
		    })
						
						});

		$("#p_item29Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item26Sqfse = $("#p_item26Sqfse")
						.val();
				var p_item27Sqfse = $("#p_item27Sqfse")
						.val();
				var p_item28Sqfse = $("#p_item28Sqfse")
						.val();
				if (p_item26Sqfse != null && p_item26Sqfse != ""
						|| p_item27Sqfse != null && p_item27Sqfse != ""
						|| p_item28Sqfse != null && p_item28Sqfse != "") {
					var a = new Array(p_item26Sqfse, p_item27Sqfse,
							p_item28Sqfse);
					var p_item29Sqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item29Sqfse += b;
						}
					}

					$("#p_item29Sqfse").textbox('setValue',p_item29Sqfse);
				}

		        	 $("#p_item29Sqfse").textbox({readonly:true});
		        }
		    })
							
						});

		$("#p_item33Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item30Bqfse = $("#p_item30Bqfse")
						.val();
				var p_item31Bqfse = $("#p_item31Bqfse")
						.val();
				var p_item32Bqfse = $("#p_item32Bqfse")
						.val();
				if (p_item30Bqfse != null && p_item30Bqfse != ""
						|| p_item31Bqfse != null && p_item31Bqfse != ""
						|| p_item32Bqfse != null && p_item32Bqfse != "") {
					var a = new Array(p_item30Bqfse, p_item31Bqfse,
							p_item32Bqfse);
					var p_item33Bqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item33Bqfse += b;
						}
					}

					$("#p_item33Bqfse").textbox('setValue',p_item33Bqfse);
				}

		        	 $("#p_item33Bqfse").textbox({readonly:true});
		        }
		    })
							
						});

		$("#p_item33Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item30Sqfse = $("#p_item30Sqfse")
						.val();
				var p_item31Sqfse = $("#p_item31Sqfse")
						.val();
				var p_item32Sqfse = $("#p_item32Sqfse")
						.val();
				if (p_item30Sqfse != null && p_item30Sqfse != ""
						|| p_item31Sqfse != null && p_item31Sqfse != ""
						|| p_item32Sqfse != null && p_item32Sqfse != "") {
					var a = new Array(p_item30Sqfse, p_item31Sqfse,
							p_item32Sqfse);
					var p_item33Sqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item33Sqfse += b;
						}
					}

					$("#p_item33Sqfse").textbox('setValue',p_item33Sqfse);
				}
		        	 $("#p_item33Sqfse").textbox({readonly:true});
		        }
		    })
							

						});

		$("#p_item11Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item5Bqfse = $("#p_item5Bqfse").val();
						var p_item10Bqfse = $("#p_item10Bqfse").val();
						if (p_item5Bqfse != null && p_item5Bqfse != ""
								|| p_item10Bqfse != null && p_item10Bqfse != "") {
							var p_item11Bqfse = 0;

							if (p_item5Bqfse != null && p_item5Bqfse != "") {
								var b = parseFloat(p_item5Bqfse);

								p_item11Bqfse += b;
							}

							if (p_item10Bqfse != null && p_item10Bqfse != "") {
								var b = parseFloat(p_item10Bqfse);

								p_item11Bqfse -= b;
							}
							$("#p_item11Bqfse").textbox('setValue',p_item11Bqfse);
						}
		        	 $("#p_item11Bqfse").textbox({readonly:true});
		        }
		    })
					

				});

		$("#p_item11Sqfse").textbox( {
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        		var p_item5Sqfse = $("#p_item5Sqfse").val();
						var p_item10Sqfse = $("#p_item10Sqfse").val();
						if (p_item5Sqfse != null && p_item5Sqfse != ""
								|| p_item10Sqfse != null && p_item10Sqfse != "") {
							var p_item11Sqfse = 0;

							if (p_item5Sqfse != null && p_item5Sqfse != "") {
								var b = parseFloat(p_item5Sqfse);

								p_item11Sqfse += b;
							}

							if (p_item10Sqfse != null && p_item10Sqfse != "") {
								var b = parseFloat(p_item10Sqfse);

								p_item11Sqfse -= b;
							}
							$("#p_item11Sqfse").textbox('setValue',p_item11Sqfse);
						}
		        	 $("#p_item11Sqfse").textbox({readonly:true});
		        }
		    })
				

				});

		$("#p_item24Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item18Bqfse = $("#p_item18Bqfse").val();
						var p_item23Bqfse = $("#p_item23Bqfse").val();
						if (p_item18Bqfse != null && p_item18Bqfse != ""
								|| p_item23Bqfse != null && p_item23Bqfse != "") {
							var p_item24Bqfse = 0;

							if (p_item18Bqfse != null && p_item18Bqfse != "") {
								var b = parseFloat(p_item18Bqfse);

								p_item24Bqfse += b;
							}

							if (p_item23Bqfse != null && p_item23Bqfse != "") {
								var b = parseFloat(p_item23Bqfse);

								p_item24Bqfse -= b;
							}
							$("#p_item24Bqfse").textbox('setValue',p_item24Bqfse);
						}

		        	 $("#p_item24Bqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item24Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item18Sqfse = $("#p_item18Sqfse").val();
						var p_item23Sqfse = $("#p_item23Sqfse").val();
						if (p_item18Sqfse != null && p_item18Sqfse != ""
								|| p_item23Sqfse != null && p_item23Sqfse != "") {
							var p_item24Sqfse = 0;

							if (p_item18Sqfse != null && p_item18Sqfse != "") {
								var b = parseFloat(p_item18Sqfse);

								p_item24Sqfse += b;
							}

							if (p_item23Sqfse != null && p_item23Sqfse != "") {
								var b = parseFloat(p_item23Sqfse);

								p_item24Sqfse -= b;
							}
							$("#p_item24Sqfse").textbox('setValue',p_item24Sqfse);
						}

		        	 $("#p_item24Sqfse").textbox({readonly:true});
		        }
		    })
					
				});
		
		$("#p_item34Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item29Bqfse = $("#p_item29Bqfse").val();
						var p_item33Bqfse = $("#p_item33Bqfse").val();
						if (p_item29Bqfse != null && p_item29Bqfse != ""
								|| p_item33Bqfse != null && p_item33Bqfse != "") {
							var p_item34Bqfse = 0;

							if (p_item29Bqfse != null && p_item29Bqfse != "") {
								var b = parseFloat(p_item29Bqfse);

								p_item34Bqfse += b;
							}

							if (p_item33Bqfse != null && p_item33Bqfse != "") {
								var b = parseFloat(p_item33Bqfse);

								p_item34Bqfse -= b;
							}
							$("#p_item34Bqfse").textbox('setValue',p_item34Bqfse);
						}

		        	 $("#p_item34Bqfse").textbox({readonly:true});
		        }
		    })
					
				});

		$("#p_item34Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        		var p_item29Sqfse = $("#p_item29Sqfse").val();
						var p_item33Sqfse = $("#p_item33Sqfse").val();
						if (p_item29Sqfse != null && p_item29Sqfse != ""
								|| p_item33Sqfse != null && p_item33Sqfse != "") {
							var p_item34Sqfse = 0;

							if (p_item29Sqfse != null && p_item29Sqfse != "") {
								var b = parseFloat(p_item29Sqfse);

								p_item34Sqfse += b;
							}

							if (p_item33Sqfse != null && p_item33Sqfse != "") {
								var b = parseFloat(p_item33Sqfse);

								p_item34Sqfse -= b;
							}
							$("#p_item34Sqfse").textbox('setValue',p_item34Sqfse);
						}
		        	 $("#p_item34Sqfse").textbox({readonly:true});
		        }
		    })
				

				});
		
		
		$("#p_item18Bqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item13Bqfse = $("#p_item13Bqfse").val();
						var p_item14Bqfse = $("#p_item14Bqfse").val();
						var p_item15Bqfse = $("#p_item15Bqfse").val();
						var p_item16Bqfse = $("#p_item16Bqfse").val();
						var p_item17Bqfse = $("#p_item17Bqfse").val();
						if (p_item13Bqfse != null && p_item13Bqfse != "" || p_item14Bqfse != null
								&& p_item14Bqfse != "" || p_item15Bqfse != null
								&& p_item15Bqfse != "" || p_item16Bqfse != null
								&& p_item16Bqfse != "" || p_item17Bqfse != null
								&& p_item17Bqfse != "" ) {
							var a=new Array(p_item13Bqfse,p_item14Bqfse,p_item15Bqfse,p_item16Bqfse,p_item17Bqfse);
							var p_item18Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									p_item18Bqfse +=b ;
									}
							}
							
							$("#p_item18Bqfse").textbox('setValue',p_item18Bqfse);
						}
		        	 $("#p_item18Bqfse").textbox({readonly:true});
		        }
		    })
					

				});
		
		$("#p_item18Sqfse").textbox({
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){

						var p_item13Sqfse = $("#p_item13Sqfse").val();
						var p_item14Sqfse = $("#p_item14Sqfse").val();
						var p_item15Sqfse = $("#p_item15Sqfse").val();
						var p_item16Sqfse = $("#p_item16Sqfse").val();
						var p_item17Sqfse = $("#p_item17Sqfse").val();
						if (p_item13Sqfse != null && p_item13Sqfse != "" || p_item14Sqfse != null
								&& p_item14Sqfse != "" || p_item15Sqfse != null
								&& p_item15Sqfse != "" || p_item16Sqfse != null
								&& p_item16Sqfse != "" || p_item17Sqfse != null
								&& p_item17Sqfse != "" ) {
							var a=new Array(p_item13Sqfse,p_item14Sqfse,p_item15Sqfse,p_item16Sqfse,p_item17Sqfse);
							var p_item18Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									p_item18Sqfse +=b ;
									}
							}
							
							$("#p_item18Sqfse").textbox('setValue',p_item18Sqfse);
						}

		        	 $("#p_item18Sqfse").textbox({readonly:true});
		        }
		    })
				});
		

		$("#p_item38Bqfse").textbox( {
			 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
		         click : function(e){
		        	 var p_item36Bqfse = $("#p_item36Bqfse")
						.val();
				var p_item37Bqfse = $("#p_item37Bqfse")
						.val();
				if (p_item36Bqfse != null && p_item36Bqfse != ""
						|| p_item37Bqfse != null && p_item37Bqfse != "") {
					var a = new Array(p_item36Bqfse, p_item37Bqfse);
					var p_item38Bqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item38Bqfse += b;
						}
					}

					$("#p_item38Bqfse").textbox('setValue',p_item38Bqfse);
				}

		        	 $("#p_item38Bqfse").textbox({readonly:true});
		        }
		    })
					
				});

$("#p_item38Sqfse").textbox({
	 inputEvents:$.extend({},$.fn.textbox.defaults.inputEvents,{
         click : function(e){

				var p_item36Sqfse = $("#p_item36Sqfse")
						.val();
				var p_item37Sqfse = $("#p_item37Sqfse")
						.val();
				if (p_item36Sqfse != null && p_item36Sqfse != ""
						|| p_item37Sqfse != null && p_item37Sqfse != "") {
					var a = new Array(p_item36Sqfse, p_item37Sqfse);
					var p_item38Sqfse = 0;
					for (var i = 0; i < a.length; i++) {
						if (a[i] != null && a[i] != "") {
							var b = parseFloat(a[i]);

							p_item38Sqfse += b;
						}
					}

					$("#p_item38Sqfse").textbox('setValue',p_item38Sqfse);
				}

        	 $("#p_item38Sqfse").textbox({readonly:true});
        }
    })
				});
				$('#btnSave').click(function() {
				    
				    var data=$.easyuiExtendObj.drillDownForm('xjll111');
				
				    $.ajax({
				       
				        type: 'POST',
				        url: '../zcb/saveXJLL',
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
	<table id="xjll111" width="80%" border="1" cellspacing="0" align="center">

		<caption align="top" style="font-size: 30px;">现金流量表</caption>
		<tr style="height: 20px;">
                <td>信用代码</td>
                <td ><input id="p_xydm" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td>年度</td>
                <td ><input id="p_nd" class="easyui-textbox" data-options="required:true" style="width:100%;height:100%;"></td>
                <td >填报日期</td>
                <td ><input id="p_tbrq" class="easyui-textbox"  style="width:100%;height:100%;"></td>
            </tr>

		<tr>
			<th colspan="2">项 目</th>
			<th colspan="2">本期发生额</th>
			<th colspan="2">上期发生额</th>
		</tr>
		<tr>
			<td colspan="2">一、经营活动产生的现金流量：</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item1Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item1Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">销售商品、提供劳务收到的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item2Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item2Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">收到的税费返还</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item3Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item3Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">收到其他与经营活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item4Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item4Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">经营活动现金流入小计</td>
			<td style="background-color: cyan;" colspan="2"><input class="easyui-textbox" id="p_item5Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td style="background-color: cyan;" colspan="2"><input class="easyui-textbox" id="p_item5Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">购买商品、接受劳务支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item6Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item6Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">支付给职工以及为职工支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item7Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item7Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">支付的各项税费</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item8Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item8Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">支付其他与经营活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item9Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item9Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">经营活动现金流出小计</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item10Bqfse"
				style="border: none; width: 100%;" /></td>
			<td  colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item10Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">经营活动产生的现金流量净额</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item11Bqfse"
				style="border: none; width: 100%;"  /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item11Sqfse"
				style="border: none; width: 100%;"  /></td>
		</tr>
		<tr>
			<td colspan="2" >二、投资活动产生的现金流量：</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item12Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item12Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">收回投资收到的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item13Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item13Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">取得投资收益收到的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item14Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item14Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">处置固定资产、无形资产和其他长期资产收回的现金净额</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item15Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item15Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">处置子公司及其他营业单位收到的现金净额</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item16Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item16Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">收到其他与投资活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item17Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item17Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">投资活动现金流入小计</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item18Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item18Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">购建固定资产、无形资产和其他长期资产支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item19Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item19Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">投资支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item20Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item20Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">取得子公司及其他营业单位支付的现金净额</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item21Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item21Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">支付其他与投资活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item22Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item22Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">投资活动现金流出小计</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item23Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item23Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2" >投资活动产生的现金流量净额</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item24Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item24Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">三、筹资活动产生的现金流量：</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item25Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item25Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">吸收投资收到的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item26Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item26Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">取得借款收到的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item27Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item27Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">收到其他与筹资活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item28Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item28Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">筹资活动现金流入小计</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item29Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item29Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">偿还债务支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item30Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item30Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">分配股利、利润或偿付利息支付的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item31Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item31Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">支付其他与筹资活动有关的现金</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item32Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item32Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">筹资活动现金流出小计</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item33Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item33Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">筹资活动产生的现金流量净额</td>
			<td  colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item34Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item34Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">四、汇率变动对现金及现金等价物的影响</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item35Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item35Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">五、现金及现金等价物净增加额</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item36Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item36Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>
		<tr>
			<td colspan="2">加：期初现金及现金等价物余额</td>
			<td colspan="2"><input class="easyui-textbox" id="p_item37Bqfse"
				style="border: none; width: 100%;" /></td>
			<td colspan="2"><input class="easyui-textbox" id="p_item37Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td colspan="2">六、期末现金及现金等价物余额</td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item38Bqfse"
				style="border: none; width: 100%;"
				 /></td>
			<td colspan="2" style="background-color: cyan;"><input class="easyui-textbox" id="p_item38Sqfse"
				style="border: none; width: 100%;"
				 /></td>
		</tr>

	</table>
<div style="position: relative;bottom: -9px;left: 130px;">
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	</div>