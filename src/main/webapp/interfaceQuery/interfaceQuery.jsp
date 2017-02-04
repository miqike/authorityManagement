<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>经营异常企业查询</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./interfaceQuery.js"></script>
    <script type="text/javascript" src="./huskyCommonQuery.js" ></script>
</head>
<body id="cc" class="easyui-layout"  align="center" data-options="fit:true">
<div data-options="region:'north',split:true" style="height:100px;" align="center"><font size="50px;">接口查询</font></div>
<div data-options="region:'west',title:'West',split:true" style="width:250px;"><div id= "tt" class="easyui-tree" data-options="lines:true,data:[{
			id: 'interfaceQuery',
			text: '接口查询',
			children: [{id:'GOV_EXCEPTIONREASON',text: '经营异常企业名录'},{id:'GOV_NBCC_JH',text: '年报核查计划信息'},
			           {id:'GOV_NBCC_JH_QY', text: '年报核查企业名录'},{id:'GOV_NBCC_RC_QY',text: '经营异常企业名录'},
			           {id:'HZ_DWDB', text: '注册登记_对外担保信息'},{id:'HZ_DWTZ', text: '注册登记_对外投资信息'},
			           {id:'HZ_FGDJ',text: '注册登记_非公党建信息'},{ id:'HZ_GQBG',text: '注册登记_股权变更信息'},
			           {id:'HZ_QYHZNR',text: '注册登记_企业核准内容'},{id:'HZ_QYTZF',text: '注册登记_企业投资方（股东）'},
			           {id:'HZ_WZXX',text: '注册登记_网址信息'},{id:'JS_GS_GDCZ',text: '即时_股东出资公示信息'},
			           {id:'JS_GS_GQBG',text: '即时_股权变更公示信息'},{id:'JS_GS_XZCF',text: '即时_行政处罚公示信息'},
			           {id:'JS_GS_XZXK',text: '即时_行政许可公示信息'},{id:'JS_GS_ZSCQ',text: '即时_知识产权公示信息'},
			           {id:'JS_HZ_GDCZ',text: '即时_股东出资信息'},{id:'JS_HZ_GQBG',text: '即时_股权变更信息'},
			           {id:'JS_HZ_XZCF',text: '即时_行政处罚信息'},{id:'JS_HZ_XZXK',text: '即时_行政许可信息'},
			           {id:'JS_HZ_ZSCQ',text: '即时_知识产权信息'},{id:'NNB_DWDB',text: '年报_对外担保信息'},
			           {id:'NNB_FGDJ',text: '年报_非公党建信息'},{id:'NNB_FR',text: '年报_法人（股东）信息'},
			           {id:'NNB_FRCZQK',text: '年报_企业法人（股东）出资情况'},{id:'NNB_GQBG',text: '年报_股权变更信息'},
			           {id:'NNB_JBQK',text: '年报_基本情况信息'},{id:'NNB_QTXX',text: '年报_企业其他信息'},
			           {id:'NNB_TXXX',text: '年报_企业通信信息'},{id:'NNB_TZ',text: '年报_企业投资信息'},
			           {id:'NNB_WZXX',text: '年报_网址信息'},{id:'NNB_ZCZK',text: '年报_企业资产状况'} ]
		}]"/></div></div>
<div data-options="region:'center',title:'Center',split:true" style="padding: 2px;overflow: hidden;"  data-options="collapsible:true,fit:true,content:'lr.html'">
    <div id="main"></div>
</div>


</body>
</html>