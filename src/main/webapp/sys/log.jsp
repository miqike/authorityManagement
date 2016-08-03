<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>


<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<script type="text/javascript" src="./log.js" ></script>
<style type="text/css">
	#panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
	#queryTable td:nth-child(odd) {text-align:right;}
</style>
</head>
<body style="padding:5px;">
	<div id="panel" class="easyui-panel" title="">
		<div style="padding: 5px 10px 0px 10px">
			<table id="queryTable">
				<tr>
					<td>业务主键</td>
					<td><input id="f_businessKey" /></td>
					<td>异常编码</td>
					<td><input id="f_errorNo" /></td>
					<td>操作人</td>
					<td><input id="f_operator" /></td>
					<td>单位</td>
					<td><input id="f_org" /></td>
				</tr>
				<tr>
					<td>模块名称</td>
					<td><input id="f_module" /></td>
					<td>日志级别</td>
					<td><select id="f_logLevel" name="f_level" >
					    <option ></option>
					    <option value="DEBUG">DEBUG</option>
					    <option value="INFO">INFO</option>
					    <option value="WARN">WARN</option>
					    <option value="ERROR">ERROR</option>
					    <option value="FATAL">FATAL</option>
				    </select></td>
					<td>节点IP</td>
					<td><input id="f_hostIp" /></td>
					<td>节点端口</td>
					<td><input id="f_hostPort" /></td>
				</tr>
				<tr>
					<td>关键字</td>
					<td><input id="f_key" /></td>
					<td>起始时间</td>
					<td ><input id="f_startTime" data-options="formatter:formatDatetime2Min,parser:datetimeParser" class="easyui-datetimebox"/></td>
					<td>结束时间</td>
					<td ><input id="f_endTime" data-options="formatter:formatDatetime2Min,parser:datetimeParser" class="easyui-datetimebox"/></td>
					<td colspan="2" style="text-align-right;">
							<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
							<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
							<a href="javascript:void(0);" id="btnShowDetail" class="easyui-linkbutton" plain="true" iconCls="icon2 r2_c10">详细</a>
						</td>
				</tr>
			</table>
		</div>

		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="singleSelect:true,collapsible:true,onClickRow:mainGridButtonHandler,
				onDblClickRow:mainGridDblClickHandler,method:'get',
				url:'../sys/log',
				onLoadSuccess: loadSuccessHandler,
				height:450"
		    pageSize="100"
			pagination="true">
			<thead>
				<tr>
					<th data-options="field:'operateTime',halign:'center',align:'center'" width="120" formatter="datetimeFormatter">时间</th>
					<th data-options="field:'logLevel',halign:'center',align:'center'" width="50" styler="logLevelStyler">级别</th>
					<th data-options="field:'operator',halign:'center',align:'center'" width="50">操作人</th>
					<th data-options="field:'operatorName',halign:'center',align:'center'" width="50">姓名</th>
					<th data-options="field:'org',halign:'center',align:'left'" width="70">单位编码</th>
					<th data-options="field:'orgName',halign:'center',align:'center'" width="150">单位名称</th>
					<th data-options="field:'businessKey',halign:'center',align:'center'" width="100">业务主键</th>
					<th data-options="field:'module',halign:'center',align:'center'" width="50">模块</th>
					<th data-options="field:'remoteAddr',halign:'center',align:'center'" width="70">客户IP</th>
					<th data-options="field:'hostIp',halign:'center',align:'left'" width="100">节点IP</th>
					<th data-options="field:'hostPort',halign:'center',align:'right'" width="40">PORT</th>
					<th data-options="field:'errorNo',halign:'center',align:'center'" width="100">异常编码</th>
					<th data-options="field:'message',halign:'center',align:'left'" width="150">描述</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
    </div>
</body>
</html>