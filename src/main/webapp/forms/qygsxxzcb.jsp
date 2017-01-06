<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="80%" border="1" cellspacing="0" align="center">
	<caption align="top" style="font-size: 30px;">企业公示信息自查表</caption>
	<tr>
	<th>企业名称</th>
	<th colspan="3"><input type="text" name="qymc"style="border: none; width: 100%;" /></th>
	</tr>
	<tr>
	<td>注册号</td>
	<td><input type="text" name="xydm"style="border: none; width: 100%;" /></td>
	<td>法定代表人</td>
	<td><input type="text" name="fddbr"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td>工商联络员</td>
	<td><input type="text" name="gslly"style="border: none; width: 100%;" /></td>
	<td>联系电话</td>
	<td><input type="text" name="lxdh"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td>实际经营地址</td>
	<td><input type="text" name="sjjydz"style="border: none; width: 100%;" /></td>
	<td>电子邮箱</td>
	<td><input type="text" name="dzyx"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td>网站/网店名称</td>
	<td><input type="text" name="wzwd"style="border: none; width: 100%;" /></td>
	<td>从业人数</td>
	<td><input type="text" name="cyrs"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td>经营状态</td>
	<td><input type="text" name="jyzt"style="border: none; width: 100%;" /></td>
	<td>邮政编码</td>
	<td><input type="text" name="yzbm"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td>全年工资总额（万元）</td>
	<td><input type="text" name="qngzze"style="border: none; width: 100%;" /></td>
	<td>全年纳税总额（万元）</td>
	<td><input type="text" name="qnnsze"style="border: none; width: 100%;" /></td>
	</tr>
	<tr>
	<td rowspan="8">企业公示信息</td>
	<td colspan="3" align="center">是否存在应当公示的信息</td>
	<tr>
	<td>是否有股东或发起人认缴和实缴的出资额、出资时间、出资方式等信息</td>
	<td>
	<select name="sfy_gdcz">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="gdjczxx.jsp">股东及出资信息表</a></td>
	</tr>
	<tr><td>是否有有限公司股东股权转让等股权变更信息</td>
	<td>
	<select name="sfy_gqbg">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="gqbgxxb.jsp">股权转让等股权变更信息</a></td>
	</tr>
	<tr><td>是否有企业投资设立企业、购买股权信息</td>
	<td>
	<select name="sfy_dwtz">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="qytzslqygmgqxxb.jsp">企业投资设立企业、购买股权信息</a></td>
	</tr>
	<tr><td>是否有对外提供保证担保信息</td>
	<td>
	<select name="sfy_dwdb">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="dwdbxxb.jsp">对外担保信息</a></td>
	</tr>
	<tr><td>是否有行政许可取得、变更、延续信息</td>
	<td>
	<select name="sfy_xzxk">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="xzxkxxb.jsp">行政许可取得、变更、延续信息</a></td>
	</tr>
	<tr><td>是否有知识产权出质登记信息</td>
	<td>
	<select name="sfy_zscq">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="zscqczdjxxb.jsp">知识产权出质登记信息</a></td>
	</tr>
	<tr><td>是否有受到行政处罚信息</td>
	<td>
	<select name="sfy_xzcf">
	<option id="1">是</option>
	<option id="0">否</option>
	</select>
	</td>
	<td><a href="xzcfxxb.jsp">受到行政处罚信息</a></td>
	</tr>
	</tr>
	<tr>
	<td colspan="4" align="center">本企业郑重承诺：上述自查内容属实，如有隐瞒真实情况、弄虚作假，愿承担由此产生的法律责任。</td>
	</tr>
</table>
</body>
</html>