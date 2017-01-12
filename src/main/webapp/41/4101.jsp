<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>企业资料上传催报管理</title>
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <style>
        td.label {
            text-align: right
        }

        #layout > div.layout-panel-west > div.panel-header {
            border-width: 1px 1px 1px 0px;
        }

        #layout > div.layout-panel-west > div.panel-body {
            border-width: 0px 1px 0px 0px;
        }

        #layout > div.layout-panel-center > div.panel-body {
            border-width: 0px;
        }

        #layout > div.layout-panel-center div.datagrid-wrap {
            border-width: 1px 0px 0px 0px;
        }
	   .validatebox-text {
	        border-width: 1px;
	        border-style: solid;
	        line-height: 17px;
	        padding-top: 1px;
	        padding-left: 3px;
	        padding-bottom: 2px;
	        padding-right: 3px;
	        background-attachment: scroll;
	        background-size: auto;
	        background-origin: padding-box;
	        background-clip: border-box;
	    }
	
	    .validatebox-invalid {
	        border-color: #ffa8a8;
	        background-repeat: repeat-x;
	        background-position: center bottom;
	        background-color: #fff3f3;
	        background-image: none;
	    }
    </style>
</head>
<body style="margin:5px;">
<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	<div data-options="region:'north',split:false,height:200" title=""  >
	    <div style="padding: 5px 10px 0px 10px">
	        <table id="queryTable">
	            <tr>
	                <td class="label">计划年度</td>
	                <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/>
	                </td>
	                <td class="label">计划编号</td>
	                <td><input id="f_jhbh" class="easyui-validatebox"/></td>
	                <td class="label">公示系统计划编号</td>
	                <td><input id="f_gsjhbh" class="easyui-validatebox"/></td>
	            </tr>
	            <tr>
	            	<td class="label">抽查文号</td>
	                <td><input id="f_cxwh" class="easyui-validatebox"/></td>
	                <td class="label">计划名称</td>
	                <td><input id="f_jhmc" class="easyui-validatebox"/></td>
	                <td class="label">检查内容</td>
	                <td><input id="f_nr" class="easyui-combobox" codeName="hcnr"
	                           data-options="panelHeight:80,width:143,onChange:loadGrid1" style=""/></td>
	            </tr>
	            <tr>
	                <td class="label">检查分类</td>
	                <td><input id="f_fl" class="easyui-combobox" codeName="hcfl"
	                           data-options="panelHeight:60,width:143,onChange:loadGrid1" style=""/></td>
	                <td colspan="4" style="text-align-right;">
	                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
	                       iconCls="icon-search">查找</a>
	                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
	                       iconCls="icon2 r3_c10">重置</a>
	                </td>
	            </tr>
	        </table>
	    </div>
	    <div>
	        <table id="grid1"
	               class="easyui-datagrid"
	               data-options="singleSelect:true,collapsible:true,height:105,
					onClickRow:grid1ClickHandler,pagination: false,
					method:'get',onLoadSuccess:grid1LoadSucessHandler"
	               sortOrder="asc">
	            <thead>
	            <tr>
	                <th data-options="field:'nd'" halign="center" align="center" sortable="true" width="50">年度</th>
	                <th data-options="field:'jhbh'" halign="center" align="left" sortable="true" width="70">计划编号</th>
	                <th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示系统计划编号</th>
	                <th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="130">计划名称</th>
	                <th data-options="field:'cxwh'" halign="center" align="center" sortable="true" width="130">抽查文号</th>
	                <th data-options="field:'djjgmc'" halign="center" align="center" sortable="true" width="130">计划下达单位</th>
	                <th data-options="field:'planType'" halign="center" align="center" sortable="true" width="70" codeName="planType" formatter="formatCodeList">计划类型</th>
	                <th data-options="field:'ksrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">计划开始时间 </th>
	                <th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">下达日期</th>
	                <th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">计划结束时间</th>
	                <th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl" formatter="formatCodeList">检查分类</th>
	                <th data-options="field:'nr'" halign="center" align="center" sortable="true" width="60" codeName="hcnr" formatter="formatCodeList">检查内容</th>
	            </tr>
	            </thead>
	        </table>
	    </div>
    </div>
    <!-- 
     <div data-options="region:'west',split:true," title="单位列表" style="width:240px;" >
          <ul id="orgTree" class="ztree"></ul> 
     </div>
     --> 
     <div data-options="region:'center'">
         <table id="grid2"
                class="easyui-datagrid"
                data-options="ctrlSelect:true,collapsible:true,pageSize: 100, pagination: true,fit:true,
					onClickRow:myTaskGridClickHandler,height:400, method:'get'"
                toolbar="#grid2Toolbar"
                sortOrder="asc">
             <thead>
             <tr>
                 <th data-options="field:'FINANCIAL_DATE'" halign="center" align="center" width="110" formatter="formatDate"  styler="docReadyReportFlagStyler">财务数据导入时间</th>
                 <th data-options="field:'SELFCHECK_DATE'" halign="center" align="center" width="100" formatter="formatDate"  styler="docReadyReportFlagStyler">自查表导入时间</th>
                 <th data-options="field:'DOC_READY_REPORT_FLAG'" halign="center" align="center" width="80" codeName="reportDocReadyFlag" formatter="formatCodeList"  styler="docReadyReportFlagStyler">上报标志</th>
                 <th data-options="field:'REPORT_DOC_READY_TIME'" halign="center" align="center" width="100" formatter="formatDate">上报时间</th>
                 <th data-options="field:'DOC_READY_FLAG'" halign="center" align="center" width="80" codeName="docReadyFlag" formatter="formatCodeList" styler="docReadyFlagStyler">上传文档状态</th>
                 <th data-options="field:'DOC_READY_FLAG_FUR'" halign="center" align="center" width="80" codeName="docReadyFlag" formatter="formatCodeList" styler="docReadyFlagStyler">附加文档状态</th>
                 <th data-options="field:'HCDW_XYDM'" halign="center" align="center" width="140">统一社会信用代码</th>
                 <th data-options="field:'HCDW_NAME'" halign="center" align="left" width="180">企业名称</th>
                 <th data-options="field:'LLR'" halign="center" align="center" width="80">工商联络员</th>
                 <th data-options="field:'LXDH'" halign="center" align="center" width="80">联系电话</th>
                 <th data-options="field:'ZTLX'" halign="center" align="center" width="80" codeName="qylxdl" formatter="formatCodeList">企业类型</th>
                 <th data-options="field:'HYFL'" halign="center" align="center" width="80" codeName="hyfl" formatter="formatCodeList">行业分类</th>
                 <th data-options="field:'ZZXS'" halign="center" align="center" width="80" codeName="qyzzxs" formatter="formatCodeList">组织形式</th>
                 <th data-options="field:'JYZT'" halign="center" align="center" width="80" codeName="jyzt" formatter="formatCodeList">经营状态</th>
                 <th data-options="field:'FR'" center="center" align="center" width="70">法人代表</th>
                 <th data-options="field:'ZFRY_NAME1'" center="center" align="center" width="90" formatter="formatZfry">检查人员</th>
                 <th data-options="field:'QYMC'" center="center" align="center" width="80">管辖单位</th>
             </tr>
             </thead>
         </table>
         <div id="grid2Toolbar">
             <a href="#" id="btnViewDocList" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true"
                data-options="disabled:true">上报材料查阅</a>
             <a href="#" id="btnReportDocReady" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true"
                data-options="disabled:true">上报完成/取消完成</a>
             <input class="easyui-searchbox" data-options="width: 260, height: 24, prompt: '快速定位', searcher: quickSearch, menu:'#mm'" />
         </div>
     </div>
</div>

<div id="mm" style="width:150px">
	<div data-options="name:'xydm'">统一社会信用代码</div>
	<div data-options="name:'qymc',selected:true">企业名称</div>
</div>

</body>
</html>

<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
<script type="text/javascript" src="./4101.js"></script>