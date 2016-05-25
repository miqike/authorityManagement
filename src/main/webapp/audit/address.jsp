<%@ page contentType="text/html; charset=UTF-8"%>
<div >
	<table>
		<tr>
			<td>公示企业通信地址: 
			</td>
			<td>
				<span style="color:blue; " id="" style="cursor:pointer;" onclick="javascript:showInMap(this);">大连市中山区鲁迅路42-1</span>
			</td>
		</tr>
		<tr>
			<td>实际企业通信地址: 
			</td>
			<td>
				<span style="color:blue; " id="" style="cursor:pointer;" onclick="javascript:showInMap(this);">大连市西岗区市场街</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<!-- <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">验证邮箱是否存在</a> 
        		<a href="#" id="btnSentVerifyMail" class="easyui-linkbutton" iconCls="icon2 r5_c3" plain="true">发送验证邮件</a>
        		<a href="#" id="btnCloseAuditWindow" class="easyui-linkbutton" iconCls="icon-undo" plain="true">返回</a>-->
			</td>
		</tr>
	</table>
	
</div>
<div id="map" style="margin-top:5px;width: 400px;height:300px;overflow: hidden;margin:0;font-family:"微软雅黑";"></div>
<script>
	function doInit() {
	}

	function showInMap(elem) {
		myGeo.getPoint($(elem).text(), function(point){
			if (point) {
				map.centerAndZoom(point, 14);
				map.addOverlay(new BMap.Marker(point));
			}else{
				alert("您选择地址没有解析到结果!");
			}
		});
		
	}
	
	// 百度地图API功能
	var map = new BMap.Map("map");
	
	// 创建地址解析器实例
	var myGeo = new BMap.Geocoder();
</script>
