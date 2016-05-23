<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>计划任务分配</title>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <style>
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
                <td>公示分类</td>
                <td><input id="f_businessKey" class="easyui-textbox"/></td>
                <td>组织形式</td>
                <td><input id="f_errorNo" class="easyui-textbox"/></td>
                <td>项目名称</td>
                <td><input id="f_operator" class="easyui-textbox"/></td>
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
        <table id="grid1"
               class="easyui-datagrid"
               data-options="singleSelect:true,collapsible:true,
				method:'get',
				onSelect:showPlanDetail,
				onUnselect:disableUpdateAndDeleteButton"
               toolbar="#gridToolbar1"
               style="height: 250px"
               sortOrder="asc">
            <thead>
            <tr>
                <th data-options="field:'bi1521'" halign="center" align="left" sortable="true" width="70">公示分类</th>
                <th data-options="field:'ba01861'" halign="center" align="left" sortable="true" width="70">组织形式</th>
                <th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="100">项目编号</th>
                <th data-options="field:'bi1512d'" halign="center" align="center" sortable="true" width="130">项目名称</th>
                <th data-options="field:'bi1516c'" halign="center" align="center" sortable="true" width="100"
                    formatter="formatDate">对应数据库字段?
                </th>
            </tr>
            </thead>
        </table>
        <div id="gridToolbar1">
            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
            <a href="#" id="btnEdit" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
               data-options="disabled:true">修改</a>
        </div>
    </div>

    <div class="easyui-panel" title="明细项目">
        <table id="planGrid"
               class="easyui-datagrid"
               data-options="singleSelect:true,collapsible:true,
				method:'get',
				onSelect:showPlanDetail,
				onUnselect:disableUpdateAndDeleteButton"
               toolbar="#planGridToolbar"
               style="height: 250px"
               sortOrder="asc">
            <thead>
            <tr>
                <th data-options="field:'bi1521'" halign="center" align="left" sortable="true" width="30">序号</th>
                <th data-options="field:'ba01861'" halign="center" align="left" sortable="true" width="150">名称</th>
                <th data-options="field:'ba01861'" halign="center" align="left" sortable="true" width="150">表名</th>
                <th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">字段名</th>
                <th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">字段类型</th>
                <th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="150">字段长度</th>
                <th data-options="field:'ba01862'" halign="center" align="left" sortable="true" width="80">描述</th>

            </tr>
            </thead>
        </table>
        <div id="planGridToolbar">
        </div>

    </div>

</div>


</body>
</html>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.combobox.codeList.js"></script>
<script type="text/javascript" src="../js/husky.common.js"></script>
<script type="text/javascript" src="../js/pinyin.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="../js/jquery.ztree.exhide-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.combobox.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<!-- <script type="text/javascript" src="../bill/billFormat.js" ></script> -->
<script type="text/javascript" src="../31/applyCommon.js"></script>
<script type="text/javascript" src="./1108.js"></script>