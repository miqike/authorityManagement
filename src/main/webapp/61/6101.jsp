<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>企业抽查结果统计分析</title>
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
<div id="panel" class="easyui-panel" title="" data-options="fit:true" style="overflow: hidden">
    <div id="layout" class="easyui-layout" data-options="fit:true">
        <div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
            <ul id="orgTree" class="ztree"></ul>
        </div>
        <div data-options="region:'center'">
            <div style="padding: 5px 10px 0px 10px">
                <table id="queryTable">
                    <tr>
                        <td class="label">计划年度</td>
                        <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/></td>
                        <td class="label">计划编号</td>
                        <td><input id="f_jhbh" class="easyui-textbox"/></td>
                        <td class="label">市场主体类型</td>
                        <td><input id="f_ztlx" class="easyui-combobox" codeName="qylxdl"/></td>
                    </tr>
                    <tr>
                        <td class="label">行业分类</td>
                        <td><input id="f_hyfl" class="easyui-combobox" codeName="hyfl"/></td>
                        <td colspan="4" style="text-align:right;">
                            <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                               iconCls="icon-search">统计</a>
                            <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                               iconCls="icon2 r3_c10">重置</a>
                            <%--<a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true"
                               data-options="">打印</a>--%>
                        </td>
                    </tr>
                </table>
            </div>
            <table id="grid2"
                   class="easyui-datagrid"
                   data-options="singleSelect:true,collapsible:true,method:'get',fit:false,offset: { width: -80, height: -220}"
                   sortOrder="asc">
                <thead>
                <tr>
                    <th rowspan="2" data-options="field:'NAME'" halign="center" align="left" sortable="true"
                        width="150">检查单位
                    </th>
                    <th rowspan="2" data-options="field:'HEJI'" halign="center" align="right" sortable="true"
                        width="150">合计
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">正常
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">未按规定公示年报
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">未按规定公示其他应公示信息
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">隐瞒真实情况、弄虚作假
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">登记住所无法联系
                    </th>
                    <th colspan="2" data-options="" halign="center" align="left" sortable="true"
                        width="150">不予配合情节严重
                    </th>
                </tr>
                <tr>
                    <th data-options="field:'SL_1'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_1'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                    <th data-options="field:'SL_2'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_2'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                    <th data-options="field:'SL_3'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_3'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                    <th data-options="field:'SL_4'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_4'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                    <th data-options="field:'SL_5'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_5'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                    <th data-options="field:'SL_6'" halign="center" align="right" sortable="true"
                        width="100">数量
                    </th>
                    <th data-options="field:'BZ_6'" halign="center" align="right" sortable="true"
                        width="100">比重
                    </th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
</body>
</html>


<script type="text/javascript" src="../js/hotkeys.min.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.orgTree.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>


<!-- 打印控件引入定义开始 -->
<script type="text/javascript" src="../js/LodopFuncs.js"></script>
<!-- 打印控件引入定义结束 -->
<script type="text/javascript" src="../js/lodop/lodopCommonPrint.js"></script>

<script type="text/javascript" src="./6101.js"></script>