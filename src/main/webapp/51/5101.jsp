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
    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./lodop.js"></script>
    <script type="text/javascript" src="./5101.js"></script>

    <script type="text/javascript" src="./auditItemList.js"></script>
    <script type="text/javascript" src="../audit_61/singleAudit.js"></script>
    <script type="text/javascript" src="../audit_61/platAudit.js"></script>
    <script type="text/javascript" src="../audit_61/gridAudit.js"></script>
 <!-- 打印控件引入定义开始 -->
    <script type="text/javascript" src="../js/LodopFuncs.js"></script>
    <!-- 打印控件引入定义结束 -->
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        td.label {
            text-align: right;
        }

    </style>
    
    <%
    %>
    <script>
	    window.customer = '61';
    </script>
</head>
<body style="padding:5px;margin-top:-20px;">

<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
    <div data-options="region:'north',split:false,height:42" title="">
	    <div style="padding: 5px 10px 0px 10px">
	        <table id="queryTable">
	            <tr>
	                <td class="label">计划年度</td>
	                <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/></td>
	                <td class="label">计划编号</td>
	                <td><input id="f_hcjhId" class="easyui-validatebox"/></td>
	                <td class="label">计划名称</td>
	                <td><input id="f_jhmc" class="easyui-validatebox"/></td>
	                <td colspan="2" style="text-align: right">
	                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
	                       iconCls="icon-search">查找</a>
	                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
	                       iconCls="icon2 r3_c10">重置</a>
	                </td>
	            </tr>
	        </table>
	    </div>
    </div>
    
    <div data-options="region:'west',split:true,iconCls:'icon2 r2_c14'," title="我的检查任务" style="width:310px;">
        <table id="grid1">
              <!--  class="easyui-datagrid"
               data-options="collapsible:true,onClickRow:grid1ClickHandler,
     		offset: { width: 0, height: -85},
     		singleSelect:true,ctrlSelect:false,method:'get',
     		pageSize: 20, pagination: true"> -->
            <thead>
	            <tr>
	                <th data-options="field:'hcdwXydm',halign:'center',align:'center'" sortable="true" width="140" styler="taskStatusStyler">统一社会信用代码</th>
	                <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="184">单位名称</th>
	            </tr>
            </thead>
        </table> 
    </div>
    <div data-options="region:'center'">
    
    	<div id="taskDetailLayout" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
    		<div data-options="region:'north',split:false,height:152, title:'任务详细信息', closable:false, collapsible:true,iconCls:'icon2 r2_c11'"
             style="padding-top:5px;width:auto">
	            <table>
	                <tr>
	                    <td class="label" style="width:90px">计划编号</td>
	                    <td style="width:100px;"><input id="p_jhbh" class="easyui-validatebox" readonly="readonly" style="width:100px;"/></td>
	                    <td class="label" style="width:90px">计划名称</td>
	                    <td style="width:100px;"><input id="p_jhmc" class="easyui-validatebox" readonly="readonly" style="width:100px;"/></td>
	                    
	                    <td class="label" style="width:90px">下达时间</td>
	                    <td style="width:100px;"><input id="p_jhxdrq" class="easyui-datebox" readonly="readonly" data-options="width:107"/></td>
	                </tr>
	                <tr>   
	                    <td class="label" style="">计划结束时间</td>
	                    <td><input id="p_jhwcrq" class="easyui-datebox" readonly="readonly" data-options="width:107"/></td>
	                    <td class="label" style="">检查结果确认</td>
	                    <td ><input id="p_hcjieguo" class="easyui-combobox" 
	                               data-options="width:107" codeName="gsjg" disabled/></td>
	                    <td colspan="2">
	                        <a href="javascript:void(0);" id="btnUpdateHcjg" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r12_c19" disabled>更新任务结果</a>
	                        <a href="javascript:void(0);" id="btnConfirmUpdateHcjg" class="easyui-linkbutton"
	                           plain="true" iconCls="icon-ok" disabled>确认</a></td>
	                </tr>
	                <tr>
	                    <td colspan="8" style="text-align:left">
	                        <a href="javascript:void(0);" id="btnSendHcgzs" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r10_c20" disabled>实地检查告知书</a>
	                        <a href="javascript:void(0);" id="btnSendZllxtzs" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r16_c20" disabled>责令履行通知书</a>
	                        <a href="javascript:void(0);" id="btnSendQyzshch" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r12_c11" disabled>企业住所检查函</a>
	                        <a href="javascript:void(0);" id="btnPullData" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r14_c3" disabled>加载在线数据</a>
	                        <a href="#" id="btnOpenEtlTool" class="easyui-linkbutton" iconCls="icon2 r5_c5" plain="true">财务数据核查</a>
	                        <a href="#" id="btnViewDocument" class="easyui-linkbutton" iconCls="icon2 r17_c1"
	                           plain="true" disabled>检查材料</a>
	                        
	                        <a href="javascript:void(0);" id="btnPrintHeChaJieGuo" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r8_c13" disabled>年报公示信息核查结果报告</a>
	                        <a href="javascript:void(0);" id="btnPrintGongShiXinXiGengZheng" class="easyui-linkbutton" plain="true"
	                           iconCls="icon2 r8_c19" disabled>公示信息更正审批表</a>
	                    </td>
	                </tr>
	            </table>
        	</div>
        	
        	<div id="auditItemList" data-options="region:'center',fit:true,collapsible:true"></div>
        </div>
    </div>
</div>

</body>
</html>

