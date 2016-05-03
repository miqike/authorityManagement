<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:100%;height:500px;}
		p{margin-left:5px; font-size:14px;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=2a0e3002d891662913ceb7d47fb9c188"></script>
	<title>根据关键字本地搜索</title>
</head>
<body>
	<div id="allmap"></div>
	<p>返回大连市“北良公寓”关键字的检索结果，并展示在地图上</p>
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	/* var map = new BMap.Map("allmap");          
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
	var local = new BMap.LocalSearch(map, {
		renderOptions:{map: map}
	});
	local.search("大连市质监局"); */
	
	var map = new BMap.Map("allmap");            // 创建Map实例
	var myKeys = ["北良公寓"];
	var local = new BMap.LocalSearch(map, {
		renderOptions:{map: map, panel:"r-result"},
		pageCapacity:5
	});
	local.searchInBounds(myKeys, map.getBounds());
</script>