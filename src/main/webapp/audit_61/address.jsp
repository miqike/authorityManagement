<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="../audit_61/address.js"></script>

<div>
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <!-- <span style="color:blue; " id="_qymc_"></span> -->
        <span style="color:blue; " id="_hcjieguo_"></span>
    </div>
    
    <table>
    	<tr> <td class="hcsx">企业名称：</td><td><span style="color:blue; " id="_qymc_"></span></td></tr>
    	<tr> <td class="hcsx">检查事项：</td><td><span style="color:blue; " id="_hcsxmc_"></span></td></tr>
    	<tr> <td class="hcsx">比对信息来源：</td><td><span style="color:blue; " id="_dbxxly_"></span></td></tr>
    	<tr> <td class="hcsx">检查方法：</td><td><span style="color:blue; " id="_auditApproach_"></span></td></tr>
    	<tr> <td class="hcsx" style="color:blue">公示内容：</td><td><span style="color:blue; " id="_qygsnr_"></span></td>
    		<td><a href="#" id="btnShowInMap1" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">地图</a></td>
    	</tr>
    	<tr> <td class="hcsx" style="color:green">登记/备案内容：</td><td><span style="color:blue; " id="_bznr_"></span></td>
    		<td style="width:100px"><a href="#" id="btnShowInMap2" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">地图</a></td>
    	</tr>
    	<tr> <td class="hcsx" style="color:orange">实际内容：</td><td><span style="color:blue; " id="_sjnr_"></span></td>
    		<td><a href="#" id="btnShowInMap3" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">地图</a></td>
    	</tr>
    	<tr> <td class="hcsx" style="color:black">内容比对结果：</td><td><span style="color:blue; " id="_bdjg_"></span></td></tr>
    </table>
    <!-- 
    <div class="hcsx">检查事项：</div><span style="color:blue; " id="_hcsxmc_"></span><br/>
    <div class="hcsx">检查方法：</div><span style="color:blue; " id="_auditApproach_"></span><br/>
	<div class="hcsx">公示内容：</div><span style="color:blue; " id="_qygsnr_"></span>
		<a href="#" id="btnShowInMap1" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">在地图上显示</a><br/>
   	<div class="hcsx">>登记/备案内容：</div><span style="color:blue; " id="_bznr_"></span>
   		<a href="#" id="btnShowInMap2" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">在地图上显示</a><br/>
   	<div class="hcsx">实际内容：</div><span style="color:blue; " id="_sjnr_"></span>
   		<a href="#" id="btnShowInMap2" class="easyui-linkbutton" iconCls="icon2 r8_c7" plain="true">在地图上显示</a><br/>
   <div class="hcsx" style="color:black">内容比对结果：</div><span id="_bdjg_"></span>   
    -->
   
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
    var map ;
    var myGeo;
    try
    {
        map = new BMap.Map("map");
        // 创建地址解析器实例
        myGeo = new BMap.Geocoder();
    }catch(e)
    {
        $.messager.show("操作提醒", '解析地图需要能连接到互联网', "info", "bottomRight");
    }
</script>
