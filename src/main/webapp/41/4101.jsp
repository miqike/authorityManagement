<%@ page contentType="text/html; charset=UTF-8" %>
<%
	if(session.getAttribute("xydm") == null || session.getAttribute("token") == null) {
		System.out.println(session.getAttribute("xydm"));
		System.out.println(session.getAttribute("token"));
		response.sendRedirect("../upload.jsp"); 
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>企业抽查资料上报</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/metro-blue/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>

    <script type="text/javascript" src="../js/husky/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script>
    	window.xydm = "${xydm}";
    </script>
    <script type="text/javascript" src="./4101.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        div .datagrid-wrap {
            border-right: 0px;
            border-left: 0px;
            border-bottom: 0px
        }

        div#tabPanel .datagrid-wrap {
            border-top: 0px;
        }
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="">

    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get'"
           pagePosition="bottom">
        <thead>
        <tr>
            <th data-options="field:'JHMC',halign:'center',align:'center'" sortable="true" width="100">计划名称</th>
            <th data-options="field:'HCDW_NAME',halign:'center',align:'left'" sortable="true" width="260">企业名称</th>
            <th data-options="field:'HCSXMC',halign:'center',align:'left'" sortable="true" width="300">检查事项名称</th>
            <th data-options="field:'HCCL_NAME',halign:'center',align:'left'" sortable="true" width="300">检查材料名称</th>
            <th data-options="field:'MONGO_ID',halign:'center',align:'center'" sortable="true" width="100"
                formatter="formatUploadButton">操作
            </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<%-- </shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission> --%>
<!-- --------弹出窗口--------------- -->
<div id="documentWindow" title="检查材料"
     data-options="modal:true,closed:true,iconCls:'icon2 r16_c14'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div id="docPanel" style="padding:10px;"></div>
</div>

</body>
</html>