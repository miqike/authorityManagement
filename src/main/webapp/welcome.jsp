<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link rel="stylesheet" type="text/css" href="./css/index.css">
    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="./js/jquery-easyui-theme/${theme}/easyui.css">
    <link rel="stylesheet" type="text/css" href="./css/portal.css">
    <link rel="stylesheet" type="text/css" href="./js/qtip/jquery.qtip.min.css"/>
    <link rel="stylesheet" type="text/css" href="./css/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="./css/bubble.css">
    
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
<body>
<!-- 
<div region="north" class="title" border="false">
    <div style="margin-top:5px;margin-left:10px;"></div>
</div> 
<div region="center" border="false">
 -->
     <div id="pp" style="position:relative">
        <div style="width:80%;height:auto">
            <div id="taskTabPanel" class="easyui-tabs" data-options="">
                <div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" style="height:800px;" selected="true">
                    <table id="todoTaskGrid"></table>
                    <!-- 
                    <table id="todoTaskGrid" class="easyui-datagrid" style="width:auto;height:auto"
                           data-options="fit:true,border:false,singleSelect:true,method:'get',offset:{}
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
                            
                            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList">任务状态</th>
                            <th data-options="field:'hcjg', halign:'center',align:'left'" width="60" align="center" codeName="hcjg" formatter="formatCodeList">检查结果</th>
                        </tr>
                        </thead>
                    </table> -->
                </div>
            </div>
        </div>
        <div style="width:20%;">
            <div title="帮助" collapsible="true" closable="true" style="height:450px;padding:5px;">
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-layout.html">企业公示信息智能检查系统简介</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-panel.html">管理人员操作手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-panel.html">检查人员操作手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-accordion.html">企业用户手册</a></div>
                <div class="t-list"><a href="http://www.w3cschool.cc/jeasyui/jeasyui-layout-tabs2.html">基本操作规则</a></div>
            </div>
        </div>
    </div>
<!--     
</div>
 -->
 <!-- 
<div id="processDiagramWindow" class="easyui-window" title="流程跟踪"
     style="clear: both; width: 750px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;">
        <img id="processDiagram"/>
        <div id='processImageBorder'></div>
    </div>
</div> 
 -->
 <!-- 
<h2>jEasyUI DataGrid Extensions - 自动适应屏幕大小(Offset)</h2>
<p>该部分扩展由文件 jeasyui.extensions.datagrid.js 实现。</p>
<hr />
<p>请试着调整浏览器窗口大小，在移动时/后，可以观察到表格的大小也随之而改变</p>
<table id="todoTaskGrid"></table>
 -->
</body>

</html>
<!-- 
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
 -->
<script type="text/javascript" src="./js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="./js/jquery.portal.js"></script>
<script type="text/javascript" src="./js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/welcome.js"></script>


<script>

function formatZfry(val, row) {
    return row.zfryName1 + "/" + row.zfryName2;
}

function loadMyTask() {
    var options = $("#todoTaskGrid").datagrid("options");
    options.url = './common/query?mapper=hcrwMapper&queryName=queryForAuditor';
    $('#todoTaskGrid').datagrid('load', {});
}

$(function(){
    //loadMyTask();
    
    
    $("#todoTaskGrid").datagrid({
        title: 'test datagrid',
        width: 1200,
        height: 400,
        method: "get",
        /* url: "datagrid/datagrid-data.json", */
        idField: 'ID',
        remoteSort: false,
        frozenColumns: [[
            { field: 'ck', checkbox: true },
            { field: 'ID', title: 'ID', width: 80, sortable: true }
        ]],
        columns: [[
            { field: 'Code', title: '编号(Code)', width: 120 },
            { field: 'Name', title: '名称(Name)', width: 140 },
            { field: 'Age', title: '年龄(Age)', width: 120 },
            { field: 'Height', title: '身高(Height)', width: 140 },
            { field: 'Weight', title: '体重(Weight)', width: 140 },
            { field: 'CreateDate', title: '创建日期(CreateDate)', width: 180 },
            { field: 'undefined', title: '测试(不存在的字段)', width: 150 }
        ]],
        enableHeaderClickMenu: false,
        enableHeaderContextMenu: false,
        enableRowContextMenu: false,
        offset: { width: -250, height: -150}   //该属性属性表示当屏幕大小调整时候随屏幕大小尺寸调整而自身大小调整的偏移量，具体设置方式参见 API 文档说明
    });
});

</script>