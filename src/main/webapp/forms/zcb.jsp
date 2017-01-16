<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>

    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/myJs/common.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.function.ztree.js"></script>
    <script type="text/javascript" src="../js/myJs/formatter.js"></script>
    <script type="text/javascript" src="zcb.js"></script>
     
</head>
<body id="cc" class="easyui-layout"  align="center" data-options="fit:true">
<!-- <div class="easyui-layout">
    <div data-options="region:'north',split:true" style="height:80px;" align="center"><font size="50px;">自查表</font></div>
    <div data-options="region:'west',split:true" style="width:250px"><div id= "tt" class="easyui-tree"/></div>
    <div data-options="region:'center',split:true" style="width:340px;"/>
</div> -->

   <div data-options="region:'north',split:true" style="height:100px;" align="center"><font size="50px;">自查表</font></div>
   <div data-options="region:'west',title:'West',split:true" style="width:250px;"><div id= "tt" class="easyui-tree"/></div></div>
    <div data-options="region:'center',title:'Center',split:true" style="padding: 2px;overflow: hidden;"  data-options="collapsible:true,fit:true,content:'lr.html'">
		<div id="main"></div>
	</div>
  

</body>
</html>