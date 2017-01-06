<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[name='item15Bqfse']").focus(
				function() {
					var item1Bqfse = $("input[name='item1Bqfse']").val();
					var item4Bqfse = $("input[name='item4Bqfse']").val();
					var item7Bqfse = $("input[name='item7Bqfse']").val();
					var item8Bqfse = $("input[name='item8Bqfse']").val();
					var item9Bqfse = $("input[name='item9Bqfse']").val();
					var item10Bqfse = $("input[name='item10Bqfse']").val();
					var item11Bqfse = $("input[name='item11Bqfse']").val();
					var item12Bqfse = $("input[name='item12Bqfse']").val();
					var item13Bqfse = $("input[name='item13Bqfse']").val();
					if (item1Bqfse != null && item1Bqfse != "" || item4Bqfse != null
							&& item4Bqfse != "" || item7Bqfse != null
							&& item7Bqfse != "" || item8Bqfse != null
							&& item8Bqfse != "" || item9Bqfse != null
							&& item9Bqfse != "" || item10Bqfse != null
							&& item10Bqfse != "" || item11Bqfse != null
							&& item11Bqfse != "" || item12Bqfse != null
							&& item12Bqfse != "" || item13Bqfse != null
							&& item13Bqfse != "" ) {
						var a = new Array(item1Bqfse,item12Bqfse,item13Bqfse);
						var d=new Array(item4Bqfse,item7Bqfse,item8Bqfse,item9Bqfse,item10Bqfse,item11Bqfse);
						var item15Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item15Bqfse +=b ;
								}
						}
						for (var i = 0; i < d.length; i++) {
							if (d[i] != null && d[i] != ""){
							var b=parseFloat(d[i]);

							item15Bqfse -=b ;
							}
					}
						$("input[name='item15Bqfse']").val(item15Bqfse);
					}

				});
		
		$("input[name='item15Sqfse']").focus(
				function() {
					var item1Sqfse = $("input[name='item1Sqfse']").val();
					var item4Sqfse = $("input[name='item4Sqfse']").val();
					var item7Sqfse = $("input[name='item7Sqfse']").val();
					var item8Sqfse = $("input[name='item8Sqfse']").val();
					var item9Sqfse = $("input[name='item9Sqfse']").val();
					var item10Sqfse = $("input[name='item10Sqfse']").val();
					var item11Sqfse = $("input[name='item11Sqfse']").val();
					var item12Sqfse = $("input[name='item12Sqfse']").val();
					var item13Sqfse = $("input[name='item13Sqfse']").val();
					if (item1Sqfse != null && item1Sqfse != "" || item4Sqfse != null
							&& item4Sqfse != "" || item7Sqfse != null
							&& item7Sqfse != "" || item8Sqfse != null
							&& item8Sqfse != "" || item9Sqfse != null
							&& item9Sqfse != "" || item10Sqfse != null
							&& item10Sqfse != "" || item11Sqfse != null
							&& item11Sqfse != "" || item12Sqfse != null
							&& item12Sqfse != "" || item13Sqfse != null
							&& item13Sqfse != "" ) {
						var a = new Array(item1Sqfse,item12Sqfse,item13Sqfse);
						var d=new Array(item4Sqfse,item7Sqfse,item8Sqfse,item9Sqfse,item10Sqfse,item11Sqfse);
						var item15Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item15Sqfse +=b ;
								}
						}
						for (var i = 0; i < d.length; i++) {
							if (d[i] != null && d[i] != ""){
							var b=parseFloat(d[i]);

							item15Sqfse -=b ;
							}
					}
						$("input[name='item15Sqfse']").val(item15Sqfse);
					}

				});
		
		
			$("input[name='item20Bqfse']").focus(
					function() {
						var item15Bqfse = $("input[name='item15Bqfse']").val();
						var item16Bqfse = $("input[name='item16Bqfse']").val();
						var item18Bqfse = $("input[name='item18Bqfse']").val();
						if (item15Bqfse != null && item15Bqfse != "" || item16Bqfse != null
								&& item16Bqfse != "" || item18Bqfse != null
								&& item18Bqfse != "" ) {
							var a = new Array(item15Bqfse,item16Bqfse);
							var item20Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									item20Bqfse +=b ;
									}
							}
							if(item18Bqfse != null&& item18Bqfse != ""){
								var c=parseFloat(item18Bqfse);
								item20Bqfse-=c;
							}
							$("input[name='item20Bqfse']").val(item20Bqfse);
						}

					});
			
			$("input[name='item20Sqfse']").focus(
					function() {
						var item15Sqfse = $("input[name='item15Sqfse']").val();
						var item16Sqfse = $("input[name='item16Sqfse']").val();
						var item18Sqfse = $("input[name='item18Sqfse']").val();
						if (item15Sqfse != null && item15Sqfse != "" || item16Sqfse != null
								&& item16Sqfse != "" || item18Sqfse != null
								&& item18Sqfse != "" ) {
							var a = new Array(item15Sqfse,item16Sqfse);
							var item20Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									item20Sqfse +=b ;
									}
							}
							if(item18Sqfse != null&& item18Sqfse != ""){
								var c=parseFloat(item18Sqfse);
								item20Sqfse-=c;
							}
							$("input[name='item20Sqfse']").val(item20Sqfse);
						}

					});
			
			
			$("input[name='item22Bqfse']").focus(
					function() {
						var item20Bqfse = $("input[name='item20Bqfse']").val();
						var item21Bqfse = $("input[name='item21Bqfse']").val();
						if (item20Bqfse != null && item20Bqfse != "" || item21Bqfse != null
								&& item21Bqfse != ""  ) {
							var item22Bqfse = 0;
							
							if (item20Bqfse != null && item20Bqfse!= ""){
									var b=parseFloat(item20Bqfse);

									item22Bqfse +=b ;
									}
							
							if (item21Bqfse != null && item21Bqfse!= ""){
								var b=parseFloat(item21Bqfse);

								item22Bqfse -=b ;
								}
							$("input[name='item22Bqfse']").val(item22Bqfse);
						}

					});
			
			$("input[name='item22Sqfse']").focus(
					function() {
						var item20Sqfse = $("input[name='item20Sqfse']").val();
						var item21Sqfse = $("input[name='item21Sqfse']").val();
						if (item20Sqfse != null && item20Sqfse != "" || item21Sqfse != null
								&& item21Sqfse != ""  ) {
							var item22Sqfse = 0;
							
							if (item20Sqfse != null && item20Sqfse!= ""){
									var b=parseFloat(item20Sqfse);

									item22Sqfse +=b ;
									}
							
							if (item21Sqfse != null && item21Sqfse!= ""){
								var b=parseFloat(item21Sqfse);

								item22Sqfse -=b ;
								}
							$("input[name='item22Sqfse']").val(item22Sqfse);
						}

					});
			
			$("input[name='item35Bqfse']").focus(
					function() {
						var item22Bqfse = $("input[name='item22Bqfse']").val();
						var item23Bqfse = $("input[name='item23Bqfse']").val();
						var item24Bqfse = $("input[name='item24Bqfse']").val();
						var item25Bqfse = $("input[name='item25Bqfse']").val();
						var item26Bqfse = $("input[name='item26Bqfse']").val();
						var item27Bqfse = $("input[name='item27Bqfse']").val();
						var item28Bqfse = $("input[name='item28Bqfse']").val();
						var item29Bqfse = $("input[name='item29Bqfse']").val();
						var item30Bqfse = $("input[name='item30Bqfse']").val();
						var item31Bqfse = $("input[name='item31Bqfse']").val();
						var item32Bqfse = $("input[name='item32Bqfse']").val();
						var item33Bqfse = $("input[name='item33Bqfse']").val();
						var item34Bqfse = $("input[name='item34Bqfse']").val();
						if (item22Bqfse != null && item22Bqfse != "" || item23Bqfse != null
								&& item23Bqfse != "" || item24Bqfse != null
								&& item24Bqfse != "" || item25Bqfse != null
								&& item25Bqfse != "" || item26Bqfse != null
								&& item26Bqfse != "" || item27Bqfse != null
								&& item27Bqfse != "" || item28Bqfse != null
								&& item28Bqfse != "" || item29Bqfse != null
								&& item29Bqfse != "" || item30Bqfse != null
								&& item30Bqfse != "" || item31Bqfse != null
								&& item31Bqfse != ""|| item32Bqfse != null
								&& item32Bqfse != ""|| item33Bqfse != null
								&& item33Bqfse != ""|| item34Bqfse != null
								&& item34Bqfse != "") {
							var a = new Array(item22Bqfse,item23Bqfse,item24Bqfse);
							var d=new Array(item25Bqfse,item26Bqfse,item27Bqfse,item28Bqfse,item29Bqfse,item30Bqfse,item31Bqfse,item32Bqfse,item33Bqfse,item34Bqfse);
							var item35Bqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									item35Bqfse +=b ;
									}
							}
							for (var i = 0; i < d.length; i++) {
								if (d[i] != null && d[i] != ""){
								var b=parseFloat(d[i]);

								item35Bqfse -=b ;
								}
						}
							$("input[name='item35Bqfse']").val(item35Bqfse);
						}

					});
			
			$("input[name='item35Sqfse']").focus(
					function() {
						var item22Sqfse = $("input[name='item22Sqfse']").val();
						var item23Sqfse = $("input[name='item23Sqfse']").val();
						var item24Sqfse = $("input[name='item24Sqfse']").val();
						var item25Sqfse = $("input[name='item25Sqfse']").val();
						var item26Sqfse = $("input[name='item26Sqfse']").val();
						var item27Sqfse = $("input[name='item27Sqfse']").val();
						var item28Sqfse = $("input[name='item28Sqfse']").val();
						var item29Sqfse = $("input[name='item29Sqfse']").val();
						var item30Sqfse = $("input[name='item30Sqfse']").val();
						var item31Sqfse = $("input[name='item31Sqfse']").val();
						var item32Sqfse = $("input[name='item32Sqfse']").val();
						var item33Sqfse = $("input[name='item33Sqfse']").val();
						var item34Sqfse = $("input[name='item34Sqfse']").val();
						if (item22Sqfse != null && item22Sqfse != "" || item23Sqfse != null
								&& item23Sqfse != "" || item24Sqfse != null
								&& item24Sqfse != "" || item25Sqfse != null
								&& item25Sqfse != "" || item26Sqfse != null
								&& item26Sqfse != "" || item27Sqfse != null
								&& item27Sqfse != "" || item28Sqfse != null
								&& item28Sqfse != "" || item29Sqfse != null
								&& item29Sqfse != "" || item30Sqfse != null
								&& item30Sqfse != "" || item31Sqfse != null
								&& item31Sqfse != ""|| item32Sqfse != null
								&& item32Sqfse != ""|| item33Sqfse != null
								&& item33Sqfse != ""|| item34Sqfse != null
								&& item34Sqfse != "") {
							var a = new Array(item22Sqfse,item23Sqfse,item24Sqfse);
							var d=new Array(item25Sqfse,item26Sqfse,item27Sqfse,item28Sqfse,item29Sqfse,item30Sqfse,item31Sqfse,item32Sqfse,item33Sqfse,item34Sqfse);
							var item35Sqfse = 0;
							for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != ""){
									var b=parseFloat(a[i]);

									item35Sqfse +=b ;
									}
							}
							for (var i = 0; i < d.length; i++) {
								if (d[i] != null && d[i] != ""){
								var b=parseFloat(d[i]);

								item35Sqfse -=b ;
								}
						}
							$("input[name='item35Sqfse']").val(item35Sqfse);
						}

					});
			
			
			$("input[name='item36Bqfse']").focus(
					function() {
						var item37Bqfse = $("input[name='item37Bqfse']").val();
						var item40Bqfse = $("input[name='item40Bqfse']").val();
						if (item37Bqfse != null && item37Bqfse != "" || item40Bqfse != null
								&& item40Bqfse != ""  ) {
							var item36Bqfse = 0;
							
							var a=new Array(item37Bqfse,item40Bqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item36Bqfse +=b ;
									}	
							}
							$("input[name='item36Bqfse']").val(item36Bqfse);
						}

					});
			
			$("input[name='item36Sqfse']").focus(
					function() {
						var item37Sqfse = $("input[name='item37Sqfse']").val();
						var item40Sqfse = $("input[name='item40Sqfse']").val();
						if (item37Sqfse != null && item37Sqfse != "" || item40Sqfse != null
								&& item40Sqfse != ""  ) {
							var item36Sqfse = 0;
							var a=new Array(item37Sqfse,item40Sqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item36Sqfse +=b ;
									}	
							}
							
							$("input[name='item36Sqfse']").val(item36Sqfse);
						}

					});
			

			$("input[name='item37Bqfse']").focus(
					function() {
						var item38Bqfse = $("input[name='item38Bqfse']").val();
						var item39Bqfse = $("input[name='item39Bqfse']").val();
						if (item38Bqfse != null && item38Bqfse != "" || item39Bqfse != null
								&& item39Bqfse != ""  ) {
							var item37Bqfse = 0;
							
							var a=new Array(item38Bqfse,item39Bqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item37Bqfse +=b ;
									}	
							}
							$("input[name='item37Bqfse']").val(item37Bqfse);
						}

					});
			
			$("input[name='item37Sqfse']").focus(
					function() {
						var item38Sqfse = $("input[name='item38Sqfse']").val();
						var item39Sqfse = $("input[name='item39Sqfse']").val();
						if (item38Sqfse != null && item38Sqfse != "" || item39Sqfse != null
								&& item39Sqfse != ""  ) {
							var item37Sqfse = 0;
							var a=new Array(item38Sqfse,item39Sqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item37Sqfse +=b ;
									}	
							}
							
							$("input[name='item37Sqfse']").val(item37Sqfse);
						}

					});
			
			

			$("input[name='item40Bqfse']").focus(
					function() {
						var item41Bqfse = $("input[name='item41Bqfse']").val();
						var item42Bqfse = $("input[name='item42Bqfse']").val();
						var item43Bqfse = $("input[name='item43Bqfse']").val();
						var item44Bqfse = $("input[name='item44Bqfse']").val();
						var item45Bqfse = $("input[name='item45Bqfse']").val();
						var item46Bqfse = $("input[name='item46Bqfse']").val();
						if (item41Bqfse != null && item41Bqfse != "" || item42Bqfse != null
								&& item42Bqfse != "" || item43Bqfse != null
								&& item43Bqfse != "" || item44Bqfse != null
								&& item44Bqfse != "" || item45Bqfse != null
								&& item45Bqfse != "" || item46Bqfse != null
								&& item46Bqfse != ""  ) {
							var item40Bqfse = 0;
							
							var a=new Array(item41Bqfse,item42Bqfse,item43Bqfse,item44Bqfse,item45Bqfse,item46Bqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item40Bqfse +=b ;
									}	
							}
							$("input[name='item40Bqfse']").val(item40Bqfse);
						}

					});
			
			$("input[name='item40Sqfse']").focus(
					function() {
						var item41Sqfse = $("input[name='item41Sqfse']").val();
						var item42Sqfse = $("input[name='item42Sqfse']").val();
						var item43Sqfse = $("input[name='item43Sqfse']").val();
						var item44Sqfse = $("input[name='item44Sqfse']").val();
						var item45Sqfse = $("input[name='item45Sqfse']").val();
						var item46Sqfse = $("input[name='item46Sqfse']").val();
						if (item41Sqfse != null && item41Sqfse != "" || item42Sqfse != null
								&& item42Sqfse != "" || item43Sqfse != null
								&& item43Sqfse != "" || item44Sqfse != null
								&& item44Sqfse != "" || item45Sqfse != null
								&& item45Sqfse != "" || item46Sqfse != null
								&& item46Sqfse != ""  ) {
							var item40Sqfse = 0;
							
							var a=new Array(item41Sqfse,item42Sqfse,item43Sqfse,item44Sqfse,item45Sqfse,item46Sqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item40Sqfse +=b ;
									}	
							}
							$("input[name='item40Sqfse']").val(item40Sqfse);
						}
					});
			
			$("input[name='item47Bqfse']").focus(
					function() {
						var item22Bqfse = $("input[name='item22Bqfse']").val();
						var item36Bqfse = $("input[name='item36Bqfse']").val();
						if (item22Bqfse != null && item22Bqfse != "" || item36Bqfse != null
								&& item36Bqfse != ""  ) {
							var item47Bqfse = 0;
							
							var a=new Array(item22Bqfse,item36Bqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item47Bqfse +=b ;
									}	
							}
							$("input[name='item47Bqfse']").val(item47Bqfse);
						}

					});
			
			$("input[name='item47Sqfse']").focus(
					function() {
						var item22Sqfse = $("input[name='item22Sqfse']").val();
						var item36Sqfse = $("input[name='item36Sqfse']").val();
						if (item22Sqfse != null && item22Sqfse != "" || item36Sqfse != null
								&& item36Sqfse != ""  ) {
							var item47Sqfse = 0;
							var a=new Array(item22Sqfse,item36Sqfse);
							for(var i=0;i<a.length;i++){
								if (a[i] != null && a[i]!= ""){
									var b=parseFloat(a[i]);

									item47Sqfse +=b ;
									}	
							}
							
							$("input[name='item47Sqfse']").val(item47Sqfse);
						}

					});
			
			
	})
	</script>
</head>
<body>
	<table width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">利润表</caption>
		<tr>
			<th>项 目</th>
			<th>行次</th> 
			<th>本期发生额</th>
			<th>上期发生额</th>
		</tr>
		<tr>
			<td>一、营业收入</td>
			<td>1</td>
			<td><input type="text" name="item1Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item1Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：主营业务收入</td>
			<td>2</td>
			<td><input type="text" name="item2Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item2Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他业务收入</td>
			<td>3</td>
			<td><input type="text" name="item3Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item3Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：营业成本</td>
			<td>4</td>
			<td><input type="text" name="item4Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item4Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：主营业务成本</td>
			<td>5</td>
			<td><input type="text" name="item5Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item5Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他业务成本</td>
			<td>6</td>
			<td><input type="text" name="item6Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item6Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>营业税金及附加</td>
			<td>7</td>
			<td><input type="text" name="item7Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item7Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>销售费用</td>
			<td>8</td>
			<td><input type="text" name="item8Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item8Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>管理费用</td>
			<td>9</td>
			<td><input type="text" name="item9Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item9Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>财务费用</td>
			<td>10</td>
			<td><input type="text" name="item10Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item10Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>资产减值损失</td>
			<td>11</td>
			<td><input type="text" name="item11Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item11Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>加：公允价值变动收益（损失以“-”号填列）</td>
			<td>12</td>
			<td><input type="text" name="item12Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item12Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>投资收益（损失以“-”号填列）</td>
			<td>13</td>
			<td><input type="text" name="item13Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item13Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：对联营企业和合营企业的投资收益</td>
			<td>14</td>
			<td><input type="text" name="item14Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item14Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>二、营业利润(亏损以“-”号填列)</td>
			<td>15</td>
			<td><input type="text" name="item15Bqfse"
				style="border: none; width: 100%; background-color: cyan;" readonly="readonly" /></td>
			<td><input type="text" name="item15Sqfse"
				style="border: none; width: 100%; background-color: cyan;" readonly="readonly" /></td>
		</tr>
		<tr>
			<td>加：营业外收入</td>
			<td>16</td>
			<td><input type="text" name="item16Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item16Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：非流动资产处置利得</td>
			<td>17</td>
			<td><input type="text" name="item17Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item17Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：营业外支出</td>
			<td>18</td>
			<td><input type="text" name="item18Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item18Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其中：非流动资产处置损失</td>
			<td>19</td>
			<td><input type="text" name="item19Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item19Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>三、利润总额(亏损总额“-”号填列)</td>
			<td>20</td>
			<td><input type="text" name="item20Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item20Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>减：所得税费用</td>
			<td>21</td>
			<td><input type="text" name="item21Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item21Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>四、净利润(净亏损以“-”号填列)</td>
			<td>22</td>
			<td><input type="text" name="item22Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item22Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>加：年初未分配利润</td>
			<td>23</td>
			<td><input type="text" name="item23Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item23Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>其他转入</td>
			<td>24</td>
			<td><input type="text" name="item24Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item24Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>减：提取法定盈余公积</td>
			<td>25</td>
			<td><input type="text" name="item25Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item25Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取法定公益金</td>
			<td>26</td>
			<td><input type="text" name="item26Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item26Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取职工奖励及福利基金</td>
			<td>27</td>
			<td><input type="text" name="item27Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item27Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取储备基金</td>
			<td>28</td>
			<td><input type="text" name="item28Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item28Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取企业发展基金</td>
			<td>29</td>
			<td><input type="text" name="item29Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item29Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>利润归还投资</td>
			<td>30</td>
			<td><input type="text" name="item30Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item30Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>应付优先股股利</td>
			<td>31</td>
			<td><input type="text" name="item31Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item31Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>提取任意盈余公积</td>
			<td>32</td>
			<td><input type="text" name="item32Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item32Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>应付普通股股利</td>
			<td>33</td>
			<td><input type="text" name="item33Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item33Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>转做资本（或股本）的普通股股利</td>
			<td>34</td>
			<td><input type="text" name="item34Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item34Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>未分配利润</td>
			<td>35</td>
			<td><input type="text" name="item35Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item35Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>五、其他综合收益的税后净额</td>
			<td>36</td>
			<td><input type="text" name="item36Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item36Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>（一）以后不能重分类进损益的其他综合收益</td>
			<td>37</td>
			<td><input type="text" name="item37Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item37Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>1.重新计量设定受益计划净负债或净资产的变动</td>
			<td>38</td>
			<td><input type="text" name="item38Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item38Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>2.权益法下在被投资单位不能重分类进损益的其他综合收益中享有的份额</td>
			<td>39</td>
			<td><input type="text" name="item39Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item39Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>（二）以后将重分类进损益的其他综合收益</td>
			<td>40</td>
			<td><input type="text" name="item40Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item40Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>1.权益法下在被投资单位以后将重分类进损益的其他综合收益中享有的份额</td>
			<td>41</td>
			<td><input type="text" name="item41Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item41Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>2.可供出售金融资产公允价值变动损益</td>
			<td>42</td>
			<td><input type="text" name="item42Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item42Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>3.持有至到期投资重分类为可供出售金融资产损益</td>
			<td>43</td>
			<td><input type="text" name="item43Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item43Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>4.现金流量套期损益的有效部分</td>
			<td>44</td>
			<td><input type="text" name="item44Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item44Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>5.外币财务报表折算差额</td>
			<td>45</td>
			<td><input type="text" name="item45Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item45Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>6.其他</td>
			<td>46</td>
			<td><input type="text" name="item46Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item46Sqfse" style="border: none;" /></td>
		</tr>
		<tr>
			<td>六、综合收益总额</td>
			<td>47</td>
			<td><input type="text" name="item47Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item47Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>七、每股收益：</td>
			<td>48</td>
			<td><input type="text" name="item48Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item48Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>(一)基本每股收益</td>
			<td>49</td>
			<td><input type="text" name="item49Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item49Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>(二)稀释每股收益</td>
			<td>50</td>
			<td><input type="text" name="item50Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item50Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>




	</table>
</body>
</html>