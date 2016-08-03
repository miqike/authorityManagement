<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <link id="easyuiTheme" rel="stylesheet" type="text/css" href="./css/jquery-easyui-theme/${theme}/easyui.css">
    <link rel="stylesheet" type="text/css" href="./css/portal.css">
    <link rel="stylesheet" type="text/css" href="./css/jquery-easyui-theme/icon.css">
    
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
            border-right: 0px;
        }

        #taskTabPanel .tabs-panels {
            border-left: 0px;
            border-bottom: 0px;
            border-right: 0px;
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
     <div id="pp">
        <div style="width:70%;height:520px;" class="easyui-panel" data-options="fit:true">
            <div id="taskTabPanel" class="easyui-tabs" data-options="fit:true">
                <div id="todoTaskGridDiv" title="待办任务" data-options="closable:false,collapsible:true" selected="true">
                    <!-- 
                    <table id="todoTaskGrid"></table>
 -->
                    <table id="todoTaskGrid" class="easyui-datagrid" style="width:auto;"
                           data-options="fit:true,border:false,singleSelect:true,method:'get',
                               pagination:true,pageSize:100, idField:'id'">
                        <thead>
                        <tr>
                            <th data-options="field:'jhmc', halign:'center',align:'left'" width="100" align="center" >计划名称</th>
                            <th data-options="field:'hcdwXydm', halign:'center',align:'center'" width="120" >统一社会信用代码</th>
                            <th data-options="field:'hcdwName', halign:'center',align:'left'" width="200" >被检单位名称</th>
                            <th data-options="field:'djjgmc', halign:'center',align:'left'" width="100" >登记机关</th>
                            <th data-options="field:'hcjgmc', halign:'center',align:'left'" width="100" >检查机关</th>
                            <th data-options="field:'qymc', halign:'center',align:'left'" width="100" >区域名称</th>
                            <!-- 
                            -->
                            <th data-options="field:'zfryCode1', halign:'center',align:'center'" width="100" formatter="formatZfry">检查人员</th>
                            <th data-options="field:'jhxdrq', halign:'center',align:'center'" width="100" align="right" formatter="formatDate">下达时间</th>
                            <th data-options="field:'jhyqwcrq', halign:'center',align:'center'" width="100" align="right" formatter="formatDate">计划结束时间</th>
                            <th data-options="field:'rlrq', halign:'center',align:'center'" width="120" align="right" formatter="formatDate">认领时间</th>
                            
                            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList">任务状态</th>
                            <th data-options="field:'hcjg', halign:'center',align:'left'" width="60" align="center" codeName="hcjg" formatter="formatCodeList">检查结果</th> 
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <div style="width:30%;height:auto"  data-options="fit:true">
            <div title="帮助" collapsible="true" closable="true" style="padding:5px;">
                <div class="t-list"><a href="./help/前端取数(V5.0).doc">数据加载说明</a></div>
                <div class="t-list"><a href="./help/手工帐取数操作流程.doc">手工帐取数操作流程</a></div>
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
<script type="text/javascript" src="./js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="./js/jquery.portal.js"></script>
<script type="text/javascript" src="./js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="./js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="./js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
<script type="text/javascript" src="./js/husky/husky.common.depreciated.js"></script>
<script type="text/javascript" src="./js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="./js/formatter.js"></script>
<script type="text/javascript" src="./js/welcome.js"></script>


<script>
var ctx = "."
function formatZfry(val, row) {
	var result = row.zfryName1 == null? "": row.zfryName1;
	if(row.zfryName2 != null) {
		result =  result + "/" + row.zfryName2;
	}
    return result;
}

function loadMyTask() {
    var options = $("#todoTaskGrid").datagrid("options");
    options.url = './common/query?mapper=hcrwMapper&queryName=queryForAuditor';
}

$(function(){
    loadMyTask();
});

</script>