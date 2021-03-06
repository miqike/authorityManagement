<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/content.css" rel="stylesheet" />
<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
<link href="../css/themes/icon.css" rel="stylesheet" />

<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js" ></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.depreciated.js" ></script>

<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>

<script type="text/javascript" src="../js/formatter.js"></script>
<script type="text/javascript" src="./eaiLog.js" ></script>
<style type="text/css">
    #panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
</style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="">
    <div style="padding: 5px 10px 0px 10px">
			<p style="margin-top: 0px; margin-bottom: 5px;">
			单据编号<input id="f_businessKey" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
			异常编码<input id="f_errorNo" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
            <span style="margin-left:13px">操作人</span><input id="f_operator" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
			公司编码<input id="f_company" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
			</p>
			<p style="margin-top: 0px; margin-bottom: 5px;">
			<span style="margin-right: 5px">日志级别</span><select id="f_level" name="f_level" style="width:155px;margin-right:10px">
			    <option ></option>
			    <option value="INFO">INFO</option>
			    <option value="ERROR">ERROR</option>
		    </select>
			<span style="margin-left:13px;">节点IP</span><input id="f_hostIp" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
			节点端口<input id="f_hostPort" style="width:150px;margin-left:5px;margin-right:10px" value=""/>
            <span style="margin-left:13px;">关键字</span><input id="f_key" style="width:150px;margin-left:5px;margin-right:8px" value=""/>
			</p>
			<p style="margin-top: 0px; margin-bottom: 5px;">
			<span style="margin-right:0px;">起始时间</span>
				<input id="f_startTime" style="width:154px;margin-right:10px; "
					data-options="formatter:formatDatetime2Min,parser:datetimeParser"
					value="" class="easyui-datetimebox"/>
			
			<span style="margin-left:8px;margin-right:0px;">结束时间</span>
				<input id="f_endTime" style="width:154px;margin-right:10px; "
				data-options="formatter:formatDatetime2Min,parser:datetimeParser"
				value="" class="easyui-datetimebox"/>
			<span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			<a href="javascript:void(0);" id="btnShowDetail" class="easyui-linkbutton" plain="true" iconCls="icon2 r2_c10">详细</a>
			</span>
			</p>
		</div>

		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
				onDblClickRow:mainGridDblClickHandler,method:'get',
				url:'../sys/log?eai=1',
                onLoadSuccess: loadSuccess,
               height:450"
		    pageSize="50"
			pagination="true">
			<thead>
				<tr>
					<th data-options="field:'level',halign:'center',align:'center'" width="40" formatter="formatLogLevel"></th>
                    <th data-options="field:'interfaceCode',halign:'center',align:'center'" width="100">接口</th>
					<th data-options="field:'interfaceType',halign:'center',align:'center'" width="50" formatter="formatInterfaceType">类型</th>
                    <th data-options="field:'timestamp',halign:'center',align:'center'" width="170" formatter="formatDatetime">调用时间</th>
                    <th data-options="field:'operator',halign:'center',align:'center'" width="110">操作人</th>
                    <th data-options="field:'operatorName',halign:'center',align:'center'" width="50">姓名</th>
                    <th data-options="field:'company',halign:'center',align:'center'" width="70">公司编码</th>
                    <th data-options="field:'companyName',halign:'center',align:'center'" width="150">公司名称</th>
                    <!--<th data-options="field:'sendStartTime',halign:'center',align:'center'" width="100" formatter="formatTimeOnly">发送开始</th>-->
					<!--<th data-options="field:'sendStartTime',halign:'center',align:'center'" width="100" formatter="formatTimeOnly">发送结束</th>-->
					<!--<th data-options="field:'postProcessStartTime',halign:'center',align:'center'" width="100" formatter="formatTimeOnly">报文处理开始</th>-->
					<!--<th data-options="field:'postProcessCompleteTime',halign:'center',align:'center'" width="100" formatter="formatTimeOnly">报文处理结束</th>-->
					<th data-options="field:'hostIp',halign:'center',align:'left'" width="110">节点IP</th>
					<th data-options="field:'hostPort',halign:'center',align:'right'" width="40">PORT</th>
					<th data-options="field:'errorNo',halign:'center',align:'center'" width="100">异常编码</th>
					<th data-options="field:'message',halign:'center',align:'left'" width="150">操作描述</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
    </div>

    <div id="popWindow" class="easyui-window" title="接口日志"
         data-options="modal:true,closed:true,iconCls:'icon-search'"
         style="width: 750px; height: 440px; padding: 5px;">
        <div id="tabPanel" class="easyui-tabs" style="width:725px;clear:both;" data-options="onSelect:tabSelectHandler">
            <div title="接口定义" style="padding:5px;" selected="true">
                <table width="100%" id="outboundInterfaceTable">
                    <tr>
                        <td style="text-align: right">接口代码</td>
                        <td><input class="easyui-textbox" id="p_interfaceCode" type="text"
                                   data-options="required:true,disabled:true" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">接口类型</td>
                        <td>
                            <input id="p_sync" class="easyui-combobox" codeName="interfaceType" style="width:70px;" data-options="disabled:true" />
                        <td style="text-align: right">重发</td>
                        <td>
                            <input id="p_recallLimits" class="easyui-numberspinner" style="width:200px;" data-options="required:true,disabled:true"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">适配器</td>
                        <td>
                            <input class="easyui-combobox" id="p_adapter" codeName="outboundInterfaceBean" data-options="disabled:true" style="width:200px;"/>
                        </td>
                        <td style="text-align: right">业务类</td>
                        <td><input class="easyui-textbox" validType="email" id="p_postProcessor" type="text" style="width:200px;" data-options="disabled:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align: right">地址</td>
                        <td colspan="3"><input class="easyui-textbox" id="p_serverAddress" type="text" style="width:566px;" data-options="disabled:true"/>
                        </td>

                    </tr>
                    <tr>
                        <td style="text-align: right">WS方法</td>
                        <td>
                            <input id="p_method" class="easyui-textbox" style="width:200px;" data-options="required:true,disabled:true" />
                        </td>
                        <td style="text-align: right">Namespace</td>
                        <td>
                            <input id="p_namespace" class="easyui-textbox" style="width:199px;" data-options="disabled:true" />
                    </tr>
                    <tr>
                        <td style="text-align: right">用户名</td>
                        <td>
                            <input id="p_userName" class="easyui-textbox" style="width:200px;" data-options="disabled:true" />
                        <td style="text-align: right">密码</td>
                        <td>
                            <input id="p_passwd" class="easyui-textbox" style="width:199px;" data-options="required:true,disabled:true"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">备注</td>
                        <td colspan="3">
                            <input id="p_remark" class="easyui-textbox" style="width:566px;" data-options="required:true,disabled:true" />
                        </td>
                    </tr>
                </table>
                <table width="100%" id="inboundInterfaceTable" style="display:none">
                    <tr>
                        <td style="text-align: right">接口代码</td>
                        <td><input class="easyui-textbox" id="i_uuid" type="text"
                                   data-options="required:true,disabled:true" style="width:200px;"/>
                        </td>
                        <td style="text-align: right">Service类型</td>
                        <td>
                            <input class="easyui-combobox" id="i_serviceType" codeName="serviceType" data-options="disabled:true" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">地址</td>
                        <td>
                            <input id="i_path" class="easyui-textbox" style="width:200px;" data-options="required:true,disabled:true" />
                        </td>
                        <td style="text-align: right">端口</td>
                        <td>
                            <input id="i_port" class="easyui-textbox" style="width:200px;" data-options="disabled:true" />
                    </tr>
                    <tr>
                        <td style="text-align: right">业务类</td>
                        <td><input class="easyui-textbox" id="i_service" type="text" style="width:200px;" data-options="disabled:true"/></td>
                        <td style="text-align: right">线程数</td>
                        <td>
                            <input id="i_thread" class="easyui-textbox" style="width:200px;" data-options="disabled:true" />
                    </tr>
                    <tr>
                        <td style="text-align: right">备注</td>
                        <td colspan="3">
                            <input id="i_remark" class="easyui-textbox" style="width:574px;" data-options="required:true,disabled:true" />
                        </td>
                    </tr>
                </table>
            </div>
            <div title="发送报文" style="width:600px;padding:5px;">
                <!--<div id="outboundMessageDiv" style="height: 350px; width: 695px;" />-->
                <!--<iframe id="outboundMessage" style="height: 350px; width: 695px;"></iframe>-->
            </div>
            <div title="接收报文" style="width:600px;padding:5px;">
                <!--<div id="inboundMessageDiv" style="height: 350px; width: 695px;"/>-->
                <!--<iframe id="inboundMessage" style="height: 350px; width: 695px;"></iframe>-->
            </div>
        </div>
    </div>

</body>
</html>