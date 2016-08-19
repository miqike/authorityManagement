<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--[if lt IE 7]>
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/><![endif]-->
    <meta http-equiv="X-UA-Compatible" content="IE=100" />

    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <title>即时信息检查</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">
    <%--<script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=2a0e3002d891662913ceb7d47fb9c188"></script>--%>

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
    <script type="text/javascript" src="./5102.js"></script>

    <script type="text/javascript" src="./auditItemLista_js.js"></script>
    <%--<script type="text/javascript" src="../audit_61/singleAudit.js"></script>--%>
    <%--<script type="text/javascript" src="../audit_61/platAudit.js"></script>--%>
    <script type="text/javascript" src="../audit_61/gridAudit_js.js"></script>
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

<div id="planWindow" style="padding: 5px;">
    <%-- <jsp:include page="../sys/iterationBar.jsp"/> --%>
    <div id="tabPanel" class="easyui-tabs" style="width:1000px;height: 700px; clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="未按规定公示即时信息企业" style="padding:5px;" selected="true">
            <div style="padding: 5px 10px 0px 10px">
                <table id="queryWGSTable">
                    <tr>
                        <td class="label">统一社会信用代码</td>
                        <td><input id="f_hcdwXydm" class="easyui-validatebox" style=""/></td>
                        <td class="label">登记机关</td>
                        <td><input id="f_djjgmc" class="easyui-validatebox" style=""/></td>
                        <td class="label">登记机关</td>
                        <td><input id="f_hcjgmc" class="easyui-validatebox" style=""/></td>
                        <td style="text-align:right;">
                            <a href="javascript:void(0);" id="btnRenLing" class="easyui-linkbutton" plain="true"
                               iconCls="icon2 r9_c5">认领</a>
                            <a href="javascript:void(0);" id="btnUnRenLing" class="easyui-linkbutton" plain="true"
                               iconCls="icon2 r9_c4">取消认领</a>
                            <a href="javascript:void(0);" id="btnSearchWGS" class="easyui-linkbutton" plain="true"
                               iconCls="icon-search">查找</a>
                            <a href="javascript:void(0);" id="btnResetWGS" class="easyui-linkbutton" plain="true"
                               iconCls="icon2 r3_c10">重置</a>
                            <a href="javascript:void(0);" id="btnPrintZLLXTZS" class="easyui-linkbutton" plain="true"
                               iconCls="icon-print">责令履行通知书</a>
                        </td>
                    </tr>
                </table>
            </div>
            <table id="gridWGS"
                   class="easyui-datagrid"
                   data-options="
                   		method:'get',
                   		pageSize: 100, pagination: true,
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'zfryName'" halign="center" align="center" width="100" >执法人员</th>
                    <th data-options="field:'hcdwXydm',halign:'center',align:'left'" sortable="true" width="200">统一社会信用代码</th>
                    <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="300">企业名称</th>
                    <th data-options="field:'rlr',halign:'center',align:'left'" sortable="true" width="100">认领人</th>
                    <th data-options="field:'rlrq',halign:'center',align:'left'" sortable="true" width="80" formatter="formatDate">认领日期</th>
                    <th data-options="field:'djjgmc',halign:'center',align:'left'" sortable="true" width="200">登记机关名称</th>
                    <th data-options="field:'hcjgmc',halign:'center',align:'left'" sortable="true" width="200">登记机关</th>
                </tr>
                </thead>
            </table>
        </div>
        <div title="即时信息核查" style="width:700px;">
        
        	<div id="mainLayout" class="easyui-layout hidden" data-options="fit: true">
				<div id="northPanel" data-options="region: 'north', height:154, title:'任务详细信息', closable:false, collapsible:true,iconCls:'icon2 r2_c11'" style="overflow: hidden;">
		            <table id="taskDetailTable">
		                <tr>
		                    <td class="label">统一社会信用代码</td>
		                    <td> <input id="p_hcdwXydm" class="easyui-validatebox" readonly="readonly" style="width:110px;"/></td>
		                    <td class="label">被抽查企业名称</td>
		                    <td ><input id="p_hcdwName" class="easyui-validatebox" readonly="readonly" style="width:384px;"/></td>
		                </tr>
		                <tr>
		                    <td class="label"  style="width:50px;">检查结果</td>
		                    <td colspan="3"><input id="p_hcjieguo" class="easyui-combobox"
		                                data-options="width:145" codeName="gsjg" disabled/>
		                        <a href="javascript:void(0);" id="btnConfirmUpdateHcjg" class="easyui-linkbutton" plain="true" iconCls="icon-ok" disabled>确认</a>
		                    </td></td>
		                </tr>
		            </table>
		            <div class="easyui-panel" data-options="height:64, noheader:true, collapsed:false,collapsible:false," style="padding-top:5px;width:auto">
		                <div id="toobar1" >
		                    <a id="btnShowTaskListWindow" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r5_c20'">显示任务列表</a>
		                    <a href="javascript:void(0);" id="btnSendHcgzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r10_c20" disabled>实地检查告知书</a>
		                    <a href="javascript:void(0);" id="btnSendZllxtzs" class="easyui-linkbutton" plain="true" iconCls="icon2 r16_c20" disabled>责令履行通知书</a>
		                    <a href="javascript:void(0);" id="btnSendQyzshch" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c11" disabled>企业住所检查函</a>
		                    <a href="javascript:void(0);" id="btnPrintGongShiXinXiGengZhengBiaoJs" class="easyui-linkbutton" plain="true" iconCls="icon2 r8_c19" >公示信息更正审批表</a>
		                </div>
		                <div id="toobar2">
		                    <a href="javascript:void(0);" id="btnPullData" class="easyui-linkbutton" plain="true" iconCls="icon2 r14_c3" disabled>加载在线数据</a>
		                    <%--<a href="#" id="btnOpenEtlTool" class="easyui-linkbutton" iconCls="icon2 r5_c5" plain="true">财务数据核查</a>--%>
		                    <a href="#" id="btnViewDocument" class="easyui-linkbutton" iconCls="icon2 r17_c1" plain="true" disabled>检查材料</a>
		                    <span>-</span>
		                    <a href="javascript:void(0);" id="btnUpdateHcjg" class="easyui-linkbutton" plain="true" iconCls="icon2 r12_c19">更新任务结果</a>
		                </div>
					</div>
				</div>
	            <div data-options="region: 'center'" style="padding: 2px;overflow: hidden;"  data-options="collapsible:true,fit:true">
	                <div id="auditItemList"  style="overflow: hidden;" ></div>
	            </div>
        </div>
    </div>
</div>
<div id="myTaskListWindow" >
    <div class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
        <div data-options="region:'north',split:false,height:70" title="">
            <div style="padding: 5px 10px 0px 10px">
                <table id="queryTable">
                    <tr>
                        <td class="label" >统一社会信用代码</td>
                        <td><input id="o_hcdwXydm" class="easyui-validatebox" data-options="validType:'integer'"/></td>
                        <td class="label" >企业名称</td>
                        <td><input id="f_hcdwName" class="easyui-validatebox"/></td>

                        <td style="text-align:right;padding-left:15px;" colspan="2">
                            <a href="javascript:void(0);" id="btnLoadMyTask" class="easyui-linkbutton" plain="true"
                               iconCls="icon-search">查找</a>
                            <a href="javascript:void(0);" id="btnResetTask" class="easyui-linkbutton" plain="true"
                               iconCls="icon2 r3_c10">重置</a>
                            <a href="javascript:void(0);" id="btnMinimizeMyTaskWindow" class="easyui-linkbutton" plain="true"
                               iconCls="icon-back">返回</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div data-options="region:'center',split:true" style="width:340px;">
            <table id="myTaskGrid" class="easyui-datagrid"
                   data-options="collapsible:true,onClickRow:myTaskGridClickHandler,singleSelect:true,ctrlSelect:false,method:'get',
						height:340,pageSize: 100, pagination: true">
                <thead>
                <tr>
                    <th data-options="field:'hcdwXydm',halign:'center',align:'center'" sortable="true" width="115">统一社会信用代码</th>
                    <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="210">企业名称</th>
                    <th data-options="field:'zfryName', halign:'center',align:'center'" width="100" >检查人员</th>
                    <th data-options="field:'rlrq', halign:'center',align:'center'" width="80" formatter="formatDate">认领时间</th>
                    <th data-options="field:'rwzt', halign:'center',align:'center'" width="60" codeName="rwzt" formatter="formatCodeList" styler="taskStatusStyler">任务状态</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
</body>
</html>
