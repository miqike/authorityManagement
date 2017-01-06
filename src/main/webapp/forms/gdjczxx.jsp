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
		$("#btn")
				.click(
						function() {

							var tr = "<tr><td height='35px'><input type='text' name='id'style='border: none; width: 100%;height:100%;' /></td><td><input type='text' name='gd'style='border: none; width: 100%;height: 100%' /></td><td><input type='text' name='sjcze'style='border: none; width: 100%;height: 100%;' /></td><td><input type='text' name='sjczsj'style='border: none; width: 100%;height: 100%' /></td><td><input type='text'name='czfs'style='border: none; width: 100%;height: 100%' /></td><td><input type='text' name='jzrq'style='border: none; width: 100%;height: 100%' /></td><td><input type='text' name='pzh'style='border: none; width: 100%;height: 100%'/></td> </tr>";

							$("table").append(tr);
						});
	})
</script>
</head>
<body>
	<table width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">股东及出资信息</caption>
		<tr>
			<th rowspan="2">序号</th>
			<th rowspan="2">股 东</th>
			<th rowspan="2">实缴出资额（万元）</th>
			<th rowspan="2">实缴出资时间</th>
			<th rowspan="2">出资方式</th>
			<th colspan="2">相关财务凭证信息
				<tr>
					<td>记账日期</td>
					<td>凭证号</td>
				</tr>
			</th>
		</tr>
		<tr>
			<td height="35px"><input type="text" name="xh"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="gd"
				style="border: none; width: 100%; height: 100%;" /></td>
			<td><input type="text" name="sjcze"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjczsj"
				style="border: none; width: 100%;" /></td>
			<td><input type="text" name="czfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="jzrq"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="pzh"
				style="border: none; width: 100%; height: 100%" /></td>

		</tr>
		<tr>
			<td height="35px"><input type="text" name="id"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="gd"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjcze"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjczsj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="czfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="jzrq"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="pzh"
				style="border: none; width: 100%;" /></td>

		</tr>
		<tr>
			<td height="35px"><input type="text" name="id"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="gd"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjcze"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjczsj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="czfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="jzrq"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="pzh"
				style="border: none; width: 100%;" /></td>

		</tr>
		<tr>
			<td height="35px"><input type="text" name="id"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="gd"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjcze"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjczsj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="czfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="jzrq"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="pzh"
				style="border: none; width: 100%; height: 100%" /></td>

		</tr>
		<tr id="5">
			<td height="35px"><input type="text" name="id"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="gd"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjcze"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="sjczsj"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="czfs"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="jzrq"
				style="border: none; width: 100%; height: 100%" /></td>
			<td><input type="text" name="pzh"
				style="border: none; width: 100%; height: 100%" /></td>

		</tr>

	</table>
	<input type="button" id="btn" value="增加一行"
		style="position: relative; bottom: -20px; left: 890px;" />


</body>
</html>