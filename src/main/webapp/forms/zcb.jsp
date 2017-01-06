<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>单位数据授权</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet" id="easyuiTheme"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
  <!--   <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
 -->

    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript">
$(function() {
	$('#tt').tree({
		onClick: function(node){
			if(node.id!='1'&&node.id!=undefined){
				
				$("#center").load(node.id+'.jsp');
				}
		}
	});
	
})
</script>
</head>
<body class="easyui-layout">
	<div id="form" data-options="region:'north',split:true" style="height:80px;" align="center"><font size="50px;">自查表</font></div>
    <div id="list" data-options="region:'west'" style="width:300px" >
    <div class="easyui-panel" style="padding: 5px;height: 800px;">
		<ul id= "tt"class="easyui-tree">
			<li data-options="state:'closed'"><span>自查表</span>
				<ul>
					<li id="zcfz">资产负债表</li>
					<li id="lr">利润表</li>
					<li id="xjll">现金流量表</li>
					<li id="qygsxxzcb">企业公示信息自查表</li>
					<li id="gdjczxx">股东及出资信息表</li>
					<li id="gqbgxxb">股东股权转让等股权变更信息表</li>
					<li id="qytzslqygmgqxxb">企业投资设立企业、购买股权信息表</li>
					<li id="dwdbxxb">对外担保信息表</li>
					<li id="xzxkxxb">行政许可取得、变更、延续信息表</li>
					<li id="zscqczdjxxb">知识产权出质登记信息表</li>
					<li id="xzcfxxb">行政处罚信息表</li>
				</ul></li>
		</ul>
	</div>
    </div>
    <div id="center" data-options="region:'center',href:'lr.html'" ></div>
</body>
</body>
</html>