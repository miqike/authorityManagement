<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("input[name='item5Bqfse']").focus(
				function() {
					var item2Bqfse = $("input[name='item2Bqfse']").val();
					var item3Bqfse = $("input[name='item3Bqfse']").val();
					var item4Bqfse = $("input[name='item4Bqfse']").val();
					if (item2Bqfse != null && item2Bqfse != ""
							|| item3Bqfse != null && item3Bqfse != ""
							|| item4Bqfse != null && item4Bqfse != "") {
						var a = new Array(item2Bqfse, item3Bqfse, item4Bqfse);
						var item5Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item5Bqfse += b;
							}
						}

						$("input[name='item5Bqfse']").val(item5Bqfse);
					}

				});

		$("input[name='item5Sqfse']").focus(
				function() {
					var item2Sqfse = $("input[name='item2Sqfse']").val();
					var item3Sqfse = $("input[name='item3Sqfse']").val();
					var item4Sqfse = $("input[name='item4Sqfse']").val();
					if (item2Sqfse != null && item2Sqfse != ""
							|| item3Sqfse != null && item3Sqfse != ""
							|| item4Sqfse != null && item4Sqfse != "") {
						var a = new Array(item2Sqfse, item3Sqfse, item4Sqfse);
						var item5Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item5Sqfse += b;
							}
						}

						$("input[name='item5Sqfse']").val(item5Sqfse);
					}

				});

		$("input[name='item10Bqfse']").focus(
				function() {
					var item6Bqfse = $("input[name='item6Bqfse']").val();
					var item7Bqfse = $("input[name='item7Bqfse']").val();
					var item8Bqfse = $("input[name='item8Bqfse']").val();
					var item9Bqfse = $("input[name='item9Bqfse']").val();
					if (item6Bqfse != null && item6Bqfse != ""
							|| item7Bqfse != null && item7Bqfse != ""
							|| item8Bqfse != null && item8Bqfse != ""
							|| item9Bqfse != null && item9Bqfse != "") {
						var a = new Array(item6Bqfse, item7Bqfse, item8Bqfse,
								item9Bqfse);
						var item10Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item10Bqfse += b;
							}
						}

						$("input[name='item10Bqfse']").val(item10Bqfse);
					}

				});

		$("input[name='item10Sqfse']").focus(
				function() {
					var item6Sqfse = $("input[name='item6Sqfse']").val();
					var item7Sqfse = $("input[name='item7Sqfse']").val();
					var item8Sqfse = $("input[name='item8Sqfse']").val();
					var item9Sqfse = $("input[name='item9Sqfse']").val();
					if (item6Sqfse != null && item6Sqfse != ""
							|| item7Sqfse != null && item7Sqfse != ""
							|| item8Sqfse != null && item8Sqfse != ""
							|| item9Sqfse != null && item9Sqfse != "") {
						var a = new Array(item6Sqfse, item7Sqfse, item8Sqfse,
								item9Sqfse);
						var item10Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item10Sqfse += b;
							}
						}

						$("input[name='item10Sqfse']").val(item10Sqfse);
					}

				});

		$("input[name='item23Bqfse']").focus(
				function() {
					var item19Bqfse = $("input[name='item19Bqfse']").val();
					var item20Bqfse = $("input[name='item20Bqfse']").val();
					var item21Bqfse = $("input[name='item21Bqfse']").val();
					var item22Bqfse = $("input[name='item22Bqfse']").val();
					if (item19Bqfse != null && item19Bqfse != ""
							|| item20Bqfse != null && item20Bqfse != ""
							|| item21Bqfse != null && item21Bqfse != ""
							|| item22Bqfse != null && item22Bqfse != "") {
						var a = new Array(item19Bqfse, item20Bqfse,
								item21Bqfse, item22Bqfse);
						var item23Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item23Bqfse += b;
							}
						}

						$("input[name='item23Bqfse']").val(item23Bqfse);
					}

				});

		$("input[name='item23Sqfse']").focus(
				function() {
					var item19Sqfse = $("input[name='item19Sqfse']").val();
					var item20Sqfse = $("input[name='item20Sqfse']").val();
					var item21Sqfse = $("input[name='item21Sqfse']").val();
					var item22Sqfse = $("input[name='item22Sqfse']").val();
					if (item19Sqfse != null && item19Sqfse != ""
							|| item20Sqfse != null && item20Sqfse != ""
							|| item21Sqfse != null && item21Sqfse != ""
							|| item22Sqfse != null && item22Sqfse != "") {
						var a = new Array(item19Sqfse, item20Sqfse,
								item21Sqfse, item22Sqfse);
						var item23Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item23Sqfse += b;
							}
						}

						$("input[name='item23Sqfse']").val(item23Sqfse);
					}

				});

		$("input[name='item36Bqfse']").focus(
				function() {
					var item11Bqfse = $("input[name='item11Bqfse']").val();
					var item24Bqfse = $("input[name='item24Bqfse']").val();
					var item34Bqfse = $("input[name='item34Bqfse']").val();
					var item35Bqfse = $("input[name='item35Bqfse']").val();
					if (item11Bqfse != null && item11Bqfse != ""
							|| item24Bqfse != null && item24Bqfse != ""
							|| item34Bqfse != null && item34Bqfse != ""
							|| item35Bqfse != null && item35Bqfse != "") {
						var a = new Array(item11Bqfse, item24Bqfse,
								item34Bqfse, item35Bqfse);
						var item36Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item36Bqfse += b;
							}
						}

						$("input[name='item36Bqfse']").val(item36Bqfse);
					}

				});

		$("input[name='item36Sqfse']").focus(
				function() {
					var item11Sqfse = $("input[name='item11Sqfse']").val();
					var item24Sqfse = $("input[name='item24Sqfse']").val();
					var item34Sqfse = $("input[name='item34Sqfse']").val();
					var item35Sqfse = $("input[name='item35Sqfse']").val();
					if (item11Sqfse != null && item11Sqfse != ""
							|| item24Sqfse != null && item24Sqfse != ""
							|| item34Sqfse != null && item34Sqfse != ""
							|| item35Sqfse != null && item35Sqfse != "") {
						var a = new Array(item11Sqfse, item24Sqfse,
								item34Sqfse, item35Sqfse);
						var item36Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item36Sqfse += b;
							}
						}

						$("input[name='item36Sqfse']").val(item36Sqfse);
					}

				});

		$("input[name='item29Bqfse']")
				.focus(
						function() {
							var item26Bqfse = $("input[name='item26Bqfse']")
									.val();
							var item27Bqfse = $("input[name='item27Bqfse']")
									.val();
							var item28Bqfse = $("input[name='item28Bqfse']")
									.val();
							if (item26Bqfse != null && item26Bqfse != ""
									|| item27Bqfse != null && item27Bqfse != ""
									|| item28Bqfse != null && item28Bqfse != "") {
								var a = new Array(item26Bqfse, item27Bqfse,
										item28Bqfse);
								var item29Bqfse = 0;
								for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != "") {
										var b = parseFloat(a[i]);

										item29Bqfse += b;
									}
								}

								$("input[name='item29Bqfse']").val(item29Bqfse);
							}

						});

		$("input[name='item29Sqfse']")
				.focus(
						function() {
							var item26Sqfse = $("input[name='item26Sqfse']")
									.val();
							var item27Sqfse = $("input[name='item27Sqfse']")
									.val();
							var item28Sqfse = $("input[name='item28Sqfse']")
									.val();
							if (item26Sqfse != null && item26Sqfse != ""
									|| item27Sqfse != null && item27Sqfse != ""
									|| item28Sqfse != null && item28Sqfse != "") {
								var a = new Array(item26Sqfse, item27Sqfse,
										item28Sqfse);
								var item29Sqfse = 0;
								for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != "") {
										var b = parseFloat(a[i]);

										item29Sqfse += b;
									}
								}

								$("input[name='item29Sqfse']").val(item29Sqfse);
							}

						});

		$("input[name='item33Bqfse']")
				.focus(
						function() {
							var item30Bqfse = $("input[name='item30Bqfse']")
									.val();
							var item31Bqfse = $("input[name='item31Bqfse']")
									.val();
							var item32Bqfse = $("input[name='item32Bqfse']")
									.val();
							if (item30Bqfse != null && item30Bqfse != ""
									|| item31Bqfse != null && item31Bqfse != ""
									|| item32Bqfse != null && item32Bqfse != "") {
								var a = new Array(item30Bqfse, item31Bqfse,
										item32Bqfse);
								var item33Bqfse = 0;
								for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != "") {
										var b = parseFloat(a[i]);

										item33Bqfse += b;
									}
								}

								$("input[name='item33Bqfse']").val(item33Bqfse);
							}

						});

		$("input[name='item33Sqfse']")
				.focus(
						function() {
							var item30Sqfse = $("input[name='item30Sqfse']")
									.val();
							var item31Sqfse = $("input[name='item31Sqfse']")
									.val();
							var item32Sqfse = $("input[name='item32Sqfse']")
									.val();
							if (item30Sqfse != null && item30Sqfse != ""
									|| item31Sqfse != null && item31Sqfse != ""
									|| item32Sqfse != null && item32Sqfse != "") {
								var a = new Array(item30Sqfse, item31Sqfse,
										item32Sqfse);
								var item33Sqfse = 0;
								for (var i = 0; i < a.length; i++) {
									if (a[i] != null && a[i] != "") {
										var b = parseFloat(a[i]);

										item33Sqfse += b;
									}
								}

								$("input[name='item33Sqfse']").val(item33Sqfse);
							}

						});

		$("input[name='item11Bqfse']").focus(
				function() {
					var item5Bqfse = $("input[name='item5Bqfse']").val();
					var item10Bqfse = $("input[name='item10Bqfse']").val();
					if (item5Bqfse != null && item5Bqfse != ""
							|| item10Bqfse != null && item10Bqfse != "") {
						var item11Bqfse = 0;

						if (item5Bqfse != null && item5Bqfse != "") {
							var b = parseFloat(item5Bqfse);

							item11Bqfse += b;
						}

						if (item10Bqfse != null && item10Bqfse != "") {
							var b = parseFloat(item10Bqfse);

							item11Bqfse -= b;
						}
						$("input[name='item11Bqfse']").val(item11Bqfse);
					}

				});

		$("input[name='item11Sqfse']").focus(
				function() {
					var item5Sqfse = $("input[name='item5Sqfse']").val();
					var item10Sqfse = $("input[name='item10Sqfse']").val();
					if (item5Sqfse != null && item5Sqfse != ""
							|| item10Sqfse != null && item10Sqfse != "") {
						var item11Sqfse = 0;

						if (item5Sqfse != null && item5Sqfse != "") {
							var b = parseFloat(item5Sqfse);

							item11Sqfse += b;
						}

						if (item10Sqfse != null && item10Sqfse != "") {
							var b = parseFloat(item10Sqfse);

							item11Sqfse -= b;
						}
						$("input[name='item11Sqfse']").val(item11Sqfse);
					}

				});

		$("input[name='item24Bqfse']").focus(
				function() {
					var item18Bqfse = $("input[name='item18Bqfse']").val();
					var item23Bqfse = $("input[name='item23Bqfse']").val();
					if (item18Bqfse != null && item18Bqfse != ""
							|| item23Bqfse != null && item23Bqfse != "") {
						var item24Bqfse = 0;

						if (item18Bqfse != null && item18Bqfse != "") {
							var b = parseFloat(item18Bqfse);

							item24Bqfse += b;
						}

						if (item23Bqfse != null && item23Bqfse != "") {
							var b = parseFloat(item23Bqfse);

							item24Bqfse -= b;
						}
						$("input[name='item24Bqfse']").val(item24Bqfse);
					}

				});

		$("input[name='item24Sqfse']").focus(
				function() {
					var item18Sqfse = $("input[name='item18Sqfse']").val();
					var item23Sqfse = $("input[name='item23Sqfse']").val();
					if (item18Sqfse != null && item18Sqfse != ""
							|| item23Sqfse != null && item23Sqfse != "") {
						var item24Sqfse = 0;

						if (item18Sqfse != null && item18Sqfse != "") {
							var b = parseFloat(item18Sqfse);

							item24Sqfse += b;
						}

						if (item23Sqfse != null && item23Sqfse != "") {
							var b = parseFloat(item23Sqfse);

							item24Sqfse -= b;
						}
						$("input[name='item24Sqfse']").val(item24Sqfse);
					}

				});
		
		$("input[name='item34Bqfse']").focus(
				function() {
					var item29Bqfse = $("input[name='item29Bqfse']").val();
					var item33Bqfse = $("input[name='item33Bqfse']").val();
					if (item29Bqfse != null && item29Bqfse != ""
							|| item33Bqfse != null && item33Bqfse != "") {
						var item34Bqfse = 0;

						if (item29Bqfse != null && item29Bqfse != "") {
							var b = parseFloat(item29Bqfse);

							item34Bqfse += b;
						}

						if (item33Bqfse != null && item33Bqfse != "") {
							var b = parseFloat(item33Bqfse);

							item34Bqfse -= b;
						}
						$("input[name='item34Bqfse']").val(item34Bqfse);
					}

				});

		$("input[name='item34Sqfse']").focus(
				function() {
					var item29Sqfse = $("input[name='item29Sqfse']").val();
					var item33Sqfse = $("input[name='item33Sqfse']").val();
					if (item29Sqfse != null && item29Sqfse != ""
							|| item33Sqfse != null && item33Sqfse != "") {
						var item34Sqfse = 0;

						if (item29Sqfse != null && item29Sqfse != "") {
							var b = parseFloat(item29Sqfse);

							item34Sqfse += b;
						}

						if (item33Sqfse != null && item33Sqfse != "") {
							var b = parseFloat(item33Sqfse);

							item34Sqfse -= b;
						}
						$("input[name='item34Sqfse']").val(item34Sqfse);
					}

				});
		
		
		$("input[name='item18Bqfse']").focus(
				function() {
					var item13Bqfse = $("input[name='item13Bqfse']").val();
					var item14Bqfse = $("input[name='item14Bqfse']").val();
					var item15Bqfse = $("input[name='item15Bqfse']").val();
					var item16Bqfse = $("input[name='item16Bqfse']").val();
					var item17Bqfse = $("input[name='item17Bqfse']").val();
					if (item13Bqfse != null && item13Bqfse != "" || item14Bqfse != null
							&& item14Bqfse != "" || item15Bqfse != null
							&& item15Bqfse != "" || item16Bqfse != null
							&& item16Bqfse != "" || item17Bqfse != null
							&& item17Bqfse != "" ) {
						var a=new Array(item13Bqfse,item14Bqfse,item15Bqfse,item16Bqfse,item17Bqfse);
						var item18Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item18Bqfse +=b ;
								}
						}
						
						$("input[name='item18Bqfse']").val(item18Bqfse);
					}

				});
		
		$("input[name='item18Sqfse']").focus(
				function() {
					var item13Sqfse = $("input[name='item13Sqfse']").val();
					var item14Sqfse = $("input[name='item14Sqfse']").val();
					var item15Sqfse = $("input[name='item15Sqfse']").val();
					var item16Sqfse = $("input[name='item16Sqfse']").val();
					var item17Sqfse = $("input[name='item17Sqfse']").val();
					if (item13Sqfse != null && item13Sqfse != "" || item14Sqfse != null
							&& item14Sqfse != "" || item15Sqfse != null
							&& item15Sqfse != "" || item16Sqfse != null
							&& item16Sqfse != "" || item17Sqfse != null
							&& item17Sqfse != "" ) {
						var a=new Array(item13Sqfse,item14Sqfse,item15Sqfse,item16Sqfse,item17Sqfse);
						var item18Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item18Sqfse +=b ;
								}
						}
						
						$("input[name='item18Sqfse']").val(item18Sqfse);
					}

				});
		

		$("input[name='item38Bqfse']")
		.focus(
				function() {
					var item36Bqfse = $("input[name='item36Bqfse']")
							.val();
					var item37Bqfse = $("input[name='item37Bqfse']")
							.val();
					if (item36Bqfse != null && item36Bqfse != ""
							|| item37Bqfse != null && item37Bqfse != "") {
						var a = new Array(item36Bqfse, item37Bqfse);
						var item38Bqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item38Bqfse += b;
							}
						}

						$("input[name='item38Bqfse']").val(item38Bqfse);
					}

				});

$("input[name='item38Sqfse']")
		.focus(
				function() {
					var item36Sqfse = $("input[name='item36Sqfse']")
							.val();
					var item37Sqfse = $("input[name='item37Sqfse']")
							.val();
					if (item36Sqfse != null && item36Sqfse != ""
							|| item37Sqfse != null && item37Sqfse != "") {
						var a = new Array(item36Sqfse, item37Sqfse);
						var item38Sqfse = 0;
						for (var i = 0; i < a.length; i++) {
							if (a[i] != null && a[i] != "") {
								var b = parseFloat(a[i]);

								item38Sqfse += b;
							}
						}

						$("input[name='item38Sqfse']").val(item38Sqfse);
					}

				});

	})
</script>
</head>
<body>

	<table width="80%" border="1" cellspacing="0" align="center">

		<caption align="top" style="font-size: 30px;">现金流量表</caption>

		<tr>
			<th>项 目</th>
			<th>本期发生额</th>
			<th>上期发生额</th>
		</tr>
		<tr>
			<td>一、经营活动产生的现金流量：</td>
			<td><input type="text" name="item1Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item1Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>销售商品、提供劳务收到的现金</td>
			<td><input type="text" name="item2Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item2Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>收到的税费返还</td>
			<td><input type="text" name="item3Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item3Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>收到其他与经营活动有关的现金</td>
			<td><input type="text" name="item4Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item4Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>经营活动现金流入小计</td>
			<td><input type="text" name="item5Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item5Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>购买商品、接受劳务支付的现金</td>
			<td><input type="text" name="item6Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item6Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>支付给职工以及为职工支付的现金</td>
			<td><input type="text" name="item7Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item7Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>支付的各项税费</td>
			<td><input type="text" name="item8Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item8Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>支付其他与经营活动有关的现金</td>
			<td><input type="text" name="item9Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item9Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>经营活动现金流出小计</td>
			<td><input type="text" name="item10Bqfse"
				style="border: none; width: 100%;background-color: cyan;" readonly="readonly"/></td>
			<td><input type="text" name="item10Sqfse"
				style="border: none; width: 100%;background-color: cyan;" readonly="readonly"/></td>
		</tr>
		<tr>
			<td>经营活动产生的现金流量净额</td>
			<td><input type="text" name="item11Bqfse"
				style="border: none; width: 100%;background-color: cyan;" readonly="readonly" /></td>
			<td><input type="text" name="item11Sqfse"
				style="border: none; width: 100%;background-color: cyan;" readonly="readonly" /></td>
		</tr>
		<tr>
			<td>二、投资活动产生的现金流量：</td>
			<td><input type="text" name="item12Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item12Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>收回投资收到的现金</td>
			<td><input type="text" name="item13Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item13Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>取得投资收益收到的现金</td>
			<td><input type="text" name="item14Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item14Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>处置固定资产、无形资产和其他长期资产收回的现金净额</td>
			<td><input type="text" name="item15Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item15Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>处置子公司及其他营业单位收到的现金净额</td>
			<td><input type="text" name="item16Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item16Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>收到其他与投资活动有关的现金</td>
			<td><input type="text" name="item17Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item17Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>投资活动现金流入小计</td>
			<td><input type="text" name="item18Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item18Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>购建固定资产、无形资产和其他长期资产支付的现金</td>
			<td><input type="text" name="item19Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item19Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>投资支付的现金</td>
			<td><input type="text" name="item20Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item20Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>取得子公司及其他营业单位支付的现金净额</td>
			<td><input type="text" name="item21Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item21Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>支付其他与投资活动有关的现金</td>
			<td><input type="text" name="item22Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item22Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>投资活动现金流出小计</td>
			<td><input type="text" name="item23Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item23Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>投资活动产生的现金流量净额</td>
			<td><input type="text" name="item24Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item24Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>三、筹资活动产生的现金流量：</td>
			<td><input type="text" name="item25Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item25Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>吸收投资收到的现金</td>
			<td><input type="text" name="item26Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item26Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>取得借款收到的现金</td>
			<td><input type="text" name="item27Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item27Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>收到其他与筹资活动有关的现金</td>
			<td><input type="text" name="item28Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item28Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>筹资活动现金流入小计</td>
			<td><input type="text" name="item29Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item29Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>偿还债务支付的现金</td>
			<td><input type="text" name="item30Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item30Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>分配股利、利润或偿付利息支付的现金</td>
			<td><input type="text" name="item31Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item31Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>支付其他与筹资活动有关的现金</td>
			<td><input type="text" name="item32Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item32Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>筹资活动现金流出小计</td>
			<td><input type="text" name="item33Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item33Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>筹资活动产生的现金流量净额</td>
			<td><input type="text" name="item34Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item34Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>四、汇率变动对现金及现金等价物的影响</td>
			<td><input type="text" name="item35Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item35Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>五、现金及现金等价物净增加额</td>
			<td><input type="text" name="item36Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item36Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>加：期初现金及现金等价物余额</td>
			<td><input type="text" name="item37Bqfse"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="item37Sqfse"
				style="border: none; width: 100%;" /></td>
		</tr>
		<tr>
			<td>六、期末现金及现金等价物余额</td>
			<td><input type="text" name="item38Bqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
			<td><input type="text" name="item38Sqfse"
				style="border: none; width: 100%; background-color: cyan;"
				readonly="readonly" /></td>
		</tr>

	</table>

</body>
</html>