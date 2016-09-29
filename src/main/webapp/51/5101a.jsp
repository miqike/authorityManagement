<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--[if lt IE 7]>
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/><![endif]-->
    <meta http-equiv="X-UA-Compatible" content="IE=100" />

    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <title>计划检查</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=2a0e3002d891662913ceb7d47fb9c188"></script>

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./lodop.js"></script>
    <script type="text/javascript" src="./5101a.js"></script>

    <script type="text/javascript" src="./auditItemLista.js"></script>
    <script type="text/javascript" src="../audit_61/singleAudit.js"></script>
    <script type="text/javascript" src="../audit_61/platAudit.js"></script>
    <script type="text/javascript" src="../audit_61/gridAudit.js"></script>
 <!-- 打印控件引入定义开始 -->
    <script type="text/javascript" src="../js/LodopFuncs.js"></script>
    <object id="LODOP_OB"
            classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
    <!-- 打印控件引入定义结束 -->
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }
        
        div#tabPanel .datagrid-wrap {
            border-left: 0px;
            border-top: 0px;
        }

        td.label {
            text-align: right;
        }

        div.hcsx {
            display: inline-block;
            width: 140px;
            color: brown;
            font-weight: bold;
            text-align: right;
        }
        
        td.hcsx {
            width: 140px;
            color: brown;
            font-weight: bold;
            text-align: right;
            vertical-align: top;
        }
        
        span.commentItem {
	        height:20px;  
			margin:3px 3px 0px 0px; 
        	font-weight:bold;
        	font-size:14px;
			color:blue;
        }
    </style>
    
    <%
    %>
    <script>
	    window.customer = '61';
	    window.planType = 1;
    </script>
</head>
<body style="padding:5px;margin-top:-20px;">
<div id="mainLayout" class="easyui-layout hidden" data-options="fit: true">
	<div id="northPanel" data-options="region: 'north', height:174, title:'任务详细信息', closable:false, collapsible:true,iconCls:'icon2 r2_c11',
		tools: [
			{iconCls:'icon-first', handler:goFirst},
			{iconCls:'icon-previous', handler:goPrev},
			{iconCls:'icon-next', handler:goNext},
			{iconCls:'icon-last', handler:goLast}
	    ]" style="overflow: hidden;">

	    <table id="taskDetailTable">
	        <tr>
	            <td class="label" style="width:60px">计划编号</td>
	            <td style="width:110px;"><input id="p_jhbh" class="easyui-validatebox" readonly="readonly" style="width:110px;"/></td>
	            <td class="label" style="width:75px">计划名称</td>
	            <td colspan="3"><input id="p_jhmc" class="easyui-validatebox" readonly="readonly" style="width:384px;"/></td>
	        </tr>
	        <tr>
	            <td class="label">注册号</td>
	            <td> <input id="p_hcdwXydm" class="easyui-validatebox" readonly="readonly" style="width:110px;"/></td>
	            <td class="label">被抽查企业</td>
	            <td colspan="3"><input id="p_hcdwName" class="easyui-validatebox" readonly="readonly" style="width:384px;"/></td>
	            
	        </tr>
	        <tr>   
	            <td class="label">计划年度</td>
	            <td><input id="p_jhnd" class="easyui-validatebox" readonly="readonly" style="width:110px"/></td>
	            <!-- <td><input id="p_jhnd" class="easyui-validatebox" readonly="readonly" data-options="width:200"/></td> -->
	            <td class="label" >计划下达单位</td>
	            <td><input id="p_djjgmc" class="easyui-validatebox" readonly="readonly" style="width:180px"/></td>
	        </tr>
	    </table>
	    <div class="easyui-panel" data-options="height:64, noheader:true, collapsed:false,collapsible:false," style="padding-top:5px;width:auto">
		    <div id="toobar1" >
			    <a id="btnShowTaskListWindow" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r5_c20'">显示任务列表</a>
			    <shiro:hasPermission name="5105:btnSendHcgzs">
			    	<a href="javascript:void(0);" id="btnSendHcgzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r10_c20" disabled>实地检查告知书</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnSendZllxtzs">
					<a href="javascript:void(0);" id="btnSendZllxtzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r16_c20" disabled>责令履行通知书</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnSendQyzshch">
					<a href="javascript:void(0);" id="btnSendQyzshch" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c11" disabled>企业住所检查函</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnPrintGongShiXinXiGengZhengBiao">
					<a href="javascript:void(0);" id="btnPrintGongShiXinXiGengZhengBiao" class="easyui-linkbutton" plain="true" iconCls="icon2 r8_c19" >公示信息更正审批表</a>
			    </shiro:hasPermission>
			</div>
			<div id="toobar2">
			    <shiro:hasPermission name="5105:btnPullData">
			    	<a href="javascript:void(0);" id="btnPullData" class="easyui-linkbutton" plain="true" iconCls="icon2 r14_c3" disabled>加载在线数据</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnOpenEtlTool">
			    	<a href="#" id="btnOpenEtlTool" class="easyui-linkbutton" iconCls="icon2 r5_c5" plain="true">财务数据核查</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnViewDocument">
					<a href="#" id="btnViewDocument" class="easyui-linkbutton" iconCls="icon2 r17_c1" plain="true" disabled>检查材料</a>
			    </shiro:hasPermission>
			    <span>-</span>
			    <shiro:hasPermission name="5105:btnPrintAuditReport">
					<a href="javascript:void(0);" id="btnPrintAuditReport" class="easyui-linkbutton" plain="true" iconCls="icon2 r8_c13" >年报公示信息核查结果报告</a>
			    </shiro:hasPermission>
			    <shiro:hasPermission name="5105:btnUpdateHcjg">
					<a href="javascript:void(0);" id="btnUpdateHcjg" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19" disabled>设置检查结果</a>
					<input id="p_hcjieguo" class="easyui-combobox"
						   data-options="width:145" codeName="gsjg" disabled/>
					<a href="javascript:void(0);" id="btnConfirmUpdateHcjg" class="easyui-linkbutton" plain="true" iconCls="icon-ok" disabled>确认</a>
			    </shiro:hasPermission>
			</div>
		</div>
	</div>
	<div data-options="region: 'center'" style="padding: 2px;overflow: hidden;"  data-options="collapsible:true,fit:true">
		<div id="auditItemList"  style="overflow: hidden;" ></div>
	</div>
</div>

<div id="myTaskListWindow" >
	<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	    <div data-options="region:'north',split:false,height:70" title="">
		    <div style="padding: 5px 10px 0px 10px">
		        <table id="queryTable">
		            <tr>
		                <td class="label" style="width:70px;">计划年度</td>
		                <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/></td>
		                <td class="label" style="width:70px;">计划编号</td>
		                <td><input id="f_hcjhId" class="easyui-validatebox"/></td>
		            </tr>
		            <tr>
		                <td class="label" style="width:70px;">信用代码</td>
		                <td><input id="f_hcdwXydm" class="easyui-validatebox" data-options="validType:'integer'"/></td>
		                <td class="label" style="width:70px;">单位名称</td>
		                <td><input id="f_hcdwName" class="easyui-validatebox"/></td>
		                
		                <td style="text-align-right;" >
		                    <a href="javascript:void(0);" id="btnLoadMyTask" class="easyui-linkbutton" plain="true"
		                       iconCls="icon-search">查找</a>
		                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
		                       iconCls="icon2 r3_c10">重置</a>
		                    <a href="javascript:void(0);" id="btnMinimizeMyTaskWindow" class="easyui-linkbutton" plain="true"
		                       iconCls="icon-back">确认返回</a>
		                </td>
		            </tr>
		        </table>
		    </div>
	    </div>
	    
	    <div data-options="region:'center',split:true" style="width:340px;">
	        <table id="grid1" class="easyui-datagrid"
	               data-options="collapsible:true,onClickRow:myTaskGridClickHandler,singleSelect:true,ctrlSelect:false,method:'get',
						height:340,onBeforeLoad:checkParam,onLoadSuccess:myTaskGridLoadSucessHandler,pageSize: 100, pagination: true">
	            <thead>
		            <tr>
						<th data-options="field:'rwzt', halign:'center',align:'center'" width="60" codeName="rwzt" formatter="formatCodeList" styler="taskStatusStyler">任务状态</th>
			            <th data-options="field:'jhnd'" halign="center" align="center" sortable="true" width="60">计划年度</th>
		                <th data-options="field:'jhbh'" halign="center" align="left" sortable="true" width="100">公示系统计划编号</th>
		                <th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="170">计划名称</th>
		                <th data-options="field:'djjgmc'" halign="center" align="center" sortable="true" width="170">任务下达单位</th>
		                <th data-options="field:'hcdwXydm',halign:'center',align:'center'" sortable="true" width="115">统一社会信用代码</th>
		                <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="210">单位名称</th>
		                <th data-options="field:'zfryCode1', halign:'center',align:'center'" width="100" formatter="formatZfry">检查人员</th>
                        <!-- <th data-options="field:'jhxdrq', halign:'center',align:'center'" width="80" formatter="formatDate">下达时间</th>
                        <th data-options="field:'jhwcrq', halign:'center',align:'center'" width="80" formatter="formatDate">计划结束时间</th>
                        <th data-options="field:'rlrq', halign:'center',align:'center'" width="80" formatter="formatDate">认领时间</th> -->
		            </tr>
	            </thead>
	        </table> 
	    </div>
	</div>
</div>

</body>
</html>

