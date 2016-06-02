<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="../audit/address.js"></script>
<div style="padding-left:4px;">
	核查事项：<span style="color:blue; " id="_hcsxmc_"></span>
</div>

<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    <table>
        <tr>
            <td sytle="text-align:right;">公示系统内容:</td>
            <td>
                <span style="color:blue; " id="_qygsnr_" ></span>
            </td>
            <td>
                <a href="#" id="btnShowInMap1" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">在地图上显示</a>
            </td>
        </tr>
			</td>
        <tr>
            <td sytle="text-align:right;">标准内容:</td>
            <td>
                <span style="color:blue; " id="_bznr_" ></span>
            </td>
            <td>
                <a href="#" id="btnShowInMap2" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">在地图上显示</a>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="#" id="btnSuccess" class="easyui-linkbutton" iconCls="icon-ok" plain="true">通过</a>
                <a href="#" id="btnFail" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">不通过</a>
                <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
            </td>
        </tr>
    </table>

</div>
<div id="mapPanel" class="easyui-panel" data-options="title:'百度地图', collapsible:true,collapsed:true,width:680">
	<div id="map" style="margin-top:5px;width: 680px;height:400px;overflow: hidden;margin:0;font-family:"微软雅黑";"></div>
</div>
<script>
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
