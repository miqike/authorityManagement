<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" type="text/css" href="./css/themes/${theme}/easyui.css">
    <link rel="stylesheet" type="text/css" href="./css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="./css/portal.css">
    <link rel="stylesheet" type="text/css" href="./js/qtip/jquery.qtip.min.css"/>
    <style type="text/css">
        .title {
            font-size: 14px;
            padding: 5px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
            height: 26px;
        }

        .t-list {
            padding: 5px;
        }

        #taskTabPanel .tabs-header {
            border-top: 0px;
            border-left: 0px;
        }

        #taskTabPanel .tabs-panels {
            border-left: 0px;
            border-bottom: 0px;
        }
    </style>
</head>
<body class="easyui-layout">
<!-- <div region="north" class="title" border="false">
    <div style="margin-top:5px;margin-left:10px;"></div>
</div> -->
<div region="center" border="false">
    <div id="pp" style="position:relative">
        <div style="width:80%;">
            <div id="taskTabPanel" class="easyui-tabs" data-options="">
                <div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" style="height:420px;" selected="true">
                    <table id="todoTaskGrid" class="easyui-datagrid" style="width:auto;height:auto"
                           data-options="fit:true,border:false,singleSelect:true,method:'get',
                               pagination:true,pageSize:20, idField:'id'">
                        <thead>
                        <tr>
                            <th data-options="field:'jhmc', halign:'center',align:'left'" width="100" align="center" >计划名称</th>
                            <th data-options="field:'hcdwXydm', halign:'center',align:'left'" width="200" >被检单位统一社会信用代码</th>
                            <th data-options="field:'hcdwName', halign:'center',align:'left'" width="200" >被检单位名称</th>
                            <th data-options="field:'djjgmc', halign:'center',align:'left'" width="100" >登记机关</th>
                            <th data-options="field:'hcjgmc', halign:'center',align:'left'" width="100" >检察机关</th>
                            <th data-options="field:'qymc', halign:'center',align:'left'" width="100" >区域名称</th>
                            <th data-options="field:'zfryCode1', halign:'center',align:'left'" width="100" formatter="formatZfry">检察人员</th>
                            <th data-options="field:'jhxdrq', halign:'center',align:'left'" width="100" align="right" formatter="formatDate">下达时间</th>
                            <th data-options="field:'jhyqwcrq', halign:'center',align:'left'" width="100" align="right" formatter="formatDate">要求完成时间</th>
                            <th data-options="field:'rlrq', halign:'center',align:'left'" width="120" align="right" formatter="formatDate">认领时间</th>
                            <!-- 
                            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList">任务状态</th>
                            <th data-options="field:'hcjg', halign:'center',align:'left'" width="60" align="center" codeName="hcjg" formatter="formatCodeList">检查结果</th> -->
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <div style="width:20%;">
            <div title="帮助" collapsible="true" closable="true" style="height:450px;padding:5px;">
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-layout.html">企业公示信息智能检查系统简介</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-panel.html">管理人员操作手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-panel.html">检察人员操作手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-accordion.html">企业用户手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-tabs2.html">基本操作规则</a></div>
            </div>
        </div>
    </div>
</div>
<div id="processDiagramWindow" class="easyui-window" title="流程跟踪"
     style="clear: both; width: 750px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;">
        <img id="processDiagram"/>
        <div id='processImageBorder'></div>
    </div>
</div>
</body>

</html>

<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.browser.min.js"></script>
<script type="text/javascript" src="./js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/jquery.portal.js"></script>
<script type="text/javascript" src="./js/husky.common.js"></script>
<script type="text/javascript" src="./js/qtip/jquery.qtip.pack.js"></script>
<script type="text/javascript" src="./js/welcome.js"></script>
<script type="text/javascript" src="./js/husky.easyui.codeList.js"></script>
<script>

function formatZfry(val, row) {
    return row.zfryName1 + "/" + row.zfryName2;
}

function loadMyTask() {
    var options = $("#todoTaskGrid").datagrid("options");
    options.url = './common/query?mapper=hcrwMapper&queryName=queryForAuditor';
    $('#todoTaskGrid').datagrid('load', {
        
    });
}

$(function(){
    loadMyTask();
});


</script>