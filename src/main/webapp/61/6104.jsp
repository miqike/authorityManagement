<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>抽查结果公示表</title>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link href="../css/content.css" rel="stylesheet"/>
    <style>

        td.label {
            text-align: right
        }

        #layout > div.layout-panel-west > div.panel-header {
            border-width: 1px 1px 1px 0px;
        }

        #layout > div.layout-panel-west > div.panel-body {
            border-width: 0px 1px 0px 0px;
        }

        #layout > div.layout-panel-center > div.panel-body {
            border-width: 0px;
        }

        #layout > div.layout-panel-center div.datagrid-wrap {
            border-width: 1px 0px 0px 0px;
        }
    </style>
</head>
<body style="margin:5px;">
<div id="panel" class="easyui-panel" title="" style="overflow: hidden;height:600px;">
    <div style="padding: 5px 10px 0px 10px">
        <table id="queryTable">
            <tr>
                <td class="label">计划年度</td>
                <td><input id="f_nd" class="easyui-numberspinner" data-options="min:2016"/>
                </td>
                <td class="label">计划编号</td>
                <td><input id="f_jhbh" class="easyui-textbox"/></td>
                <td class="label">公示系统计划编号</td>
                <td><input id="f_gsjhbh" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td class="label">计划名称</td>
                <td><input id="f_jhmc" class="easyui-textbox"/></td>
                <td class="label">核查内容</td>
                <td><input id="f_nr" class="easyui-combobox" codeName="hcnr"
                           data-options="panelHeight:80,width:143,onChange:queryPlan" style=""/></td>
                <td class="label">核查分类</td>
                <td><input id="f_fl" class="easyui-combobox" codeName="hcfl"
                           data-options="panelHeight:60,width:143,onChange:queryPlan" style=""/></td>
                <td colspan="2" style="text-align-right;">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                       iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                       iconCls="icon2 r3_c10">重置</a>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <!-- 				onUnselect:disableUpdateAndDeleteButton" -->
        <table id="grid1"
               class="easyui-datagrid"
               data-options="singleSelect:true,collapsible:true,
				onClickRow:grid1ClickHandler,pageSize: 10, pagination: true,
				method:'get'"
               style="height: 250px"
               sortOrder="asc">
            <thead>
            <tr>
                <th data-options="field:'nd'" halign="center" align="center" sortable="true" width="50">年度</th>
                <th data-options="field:'jhbh'" halign="center" align="left" sortable="true" width="70">计划编号</th>
                <th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示计划编号</th>
                <th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="130">计划名称</th>
                <th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="80"
                    formatter="formatDate">下达日期
                </th>
                <th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80"
                    formatter="formatDate">要求完成时间
                </th>
                <th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl"
                    formatter="formatCodeList">核查分类
                </th>
                <th data-options="field:'nr'" halign="center" align="center" sortable="true" width="60" codeName="hcnr"
                    formatter="formatCodeList">核查内容
                </th>
                <th data-options="field:'hcrwsl'" halign="center" align="left" sortable="true" width="60">任务数</th>
                <th data-options="field:'ypfsl'" halign="center" align="left" sortable="true" width="50">已派发</th>
                <th data-options="field:'yrlsl'" halign="center" align="left" sortable="true" width="50">已认领</th>
                <th data-options="field:'wrlsl'" halign="center" align="left" sortable="true" width="50">未认领</th>
                <th data-options="field:'shzt'" halign="center" align="left" sortable="true" width="90" codeName="shzt"
                    formatter="formatCodeList">审核状态
                </th>
                <th data-options="field:'shrmc'" halign="center" align="center" sortable="true" width="90">审核人</th>
                <th data-options="field:'xdrmc'" halign="center" align="center" sortable="true" width="90">下达人</th>
                <th data-options="field:'sm'" halign="center" align="left" sortable="true" width="250">说明</th>
            </tr>
            </thead>
        </table>
    </div>

    <div id="layout" class="easyui-layout" data-options="fit:true">
        <div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
            <ul id="orgTree" class="ztree"></ul>
        </div>
        <div data-options="region:'center'">
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="singleSelect:true,collapsible:true,pageSize: 10, pagination: true,
					onClickRow:grid2ClickHandler,
					method:'get'"
                   toolbar="#planGridToolbar"
                   style="height: 285px"
                   sortOrder="asc">
                <thead>
                <tr>
                    <!-- <th data-options="field:'id'" halign="center" align="left" sortable="true" width="30">序号</th> -->
                    <th data-options="field:'hcjgmc'" halign="center" align="left" sortable="true" width="150">检查机关</th>
                    <th data-options="field:'djjgmc'" halign="center" align="left" sortable="true" width="150">登记机关</th>
                    <th data-options="field:'hcdwXydm'" halign="center" align="left" sortable="true" width="180">
                        统一社会信用代码
                    </th>
                    <th data-options="field:'hcdwName'" halign="center" align="left" sortable="true" width="180">企业名称
                    </th>
                    <!--
                                         <th data-options="field:'ztlx'" halign="center" align="left" sortable="true" width="80" codeName="jhlb" formatter="formatCodeList">市场主体类型</th>
                                        <th data-options="field:'zzxs'" halign="center" align="left" sortable="true" width="80" codeName="jhlb" formatter="formatCodeList">组织形式</th>
                     -->
                    <th data-options="field:'qymc'" halign="center" align="left" sortable="true" width="100">区域</th>
                    <th data-options="field:'zfryCode1'" halign="center" align="left" sortable="true" width="100"
                        formatter="formatZfry">检查人员
                    </th>
                    <th data-options="field:'rlrmc'" halign="center" align="left" sortable="true" width="70">认领人</th>
                    <th data-options="field:'rlrq'" halign="center" align="left" sortable="true" width="70"
                        formatter="formatDate">认领日期
                    </th>
                    <th data-options="field:'rwzt'" halign="center" align="left" sortable="true" width="70"
                        codeName="jhlb" formatter="formatCodeList">计划完成
                    </th>
                    <th data-options="field:'sjwcrq'" halign="center" align="left" sortable="true" width="70"
                        formatter="formatDate">实际完成
                    </th>
                    <th data-options="field:'hcjieguo'" halign="center" align="left" sortable="true" width="70"
                        formatter="formatCodeList" codeName="hcjg">核查结果
                    </th>
                </tr>
                </thead>
            </table>
            <div id="planGridToolbar">
                <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true"
                   data-options="">打印</a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
<link href="../css/content.css" rel="stylesheet"/>
<link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
<link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

<script type="text/javascript" src="../js/hotkeys.min.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>

<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.orgTree.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>


<!-- 打印控件引入定义开始 -->
<script type="text/javascript" src="../js/LodopFuncs.js"></script>
<object id="LODOP_OB"
        classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<!-- 打印控件引入定义结束 -->
<script type="text/javascript" src="../js/lodop/listPrint.js"></script>

<script type="text/javascript" src="./6104.js"></script>