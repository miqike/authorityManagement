<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>集群管理</title>

    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

	<script type="text/javascript" src="../js/husky/husky.common.js"></script>
	<script type="text/javascript" src="../js/formatter.js"></script>

	<script type="text/javascript">
        function formatNodeStatus(val, row) {
            if(val == undefined) {
                return "";
            } else if(val == 1 && (new Date().getTime() - row.heartBeat < 600000)) {
                return '<span class="icon2 r20_c6"></span>';
            } else {
                return '<span class="icon2 r22_c6"></span>';
            }
        }

        function formatWorktime(val, row) {
            if(row.status == 1 && (new Date().getTime() - row.heartBeat < 600000)) {
                var duration = new Date().getTime() - row.startTime;
                return toDuration(duration/1000) ;
            } else {
                return "";
            }
        }

        $(function() {
            $("#btnRefresh").click(function(){
                $("#mainGrid").datagrid("reload");
            });
        });
    </script>
</head>
<body style="padding:5px;">
	<div id="panel" class="easyui-panel" title="">
	    <table id="mainGrid" class="easyui-datagrid" title="" style="height:550px"
			   data-options="
					url:'../common/query?mapper=nodeMapper&queryName=query',
					fitColumns: true,
					method:'get',
					singleSelect:true,
					offset: {height: -15, width:-25},height:450,
					toolbar:'#mainGridToolbar',
					pagination:false">
			<thead>
			<tr>
				<th data-options="field:'ip',halign:'center',align:'center'" width="60">IP</th>
				<th data-options="field:'port',halign:'center',align:'center'" width="30">端口</th>
				<th data-options="field:'platform',halign:'center',align:'center'" width="30">平台</th>
				<th data-options="field:'startTime',halign:'center',align:'center'" width="60" formatter="formatDatetime">启动时间</th>
				<th data-options="field:'heartBeat',halign:'center',align:'center'" width="60" formatter="formatDatetime">心跳</th>
				<th data-options="field:'shutdownTime',halign:'center',align:'center'" width="60" formatter="formatDatetime">停止时间</th>
				<th data-options="field:'i',halign:'center',align:'center'" width="70" formatter="formatWorktime">工作时间</th>
				<th data-options="field:'status',halign:'center',align:'center'" width="50" formatter="formatNodeStatus">状态</th>
			</tr>
			</thead>
		</table>
	</div>
	<div id="mainGridToolbar">
	    <a href="#" id="btnRefresh" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
	</div>
</body>
</html>
