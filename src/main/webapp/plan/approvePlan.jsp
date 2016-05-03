<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>待审批计划</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/pinyin.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>

    <script type="text/javascript" src="./approvePlan.js"></script>

    <style>
        html,body{
            height: 99%;
        }

        body {
            margin:0;
            padding:5px;
            font:13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background:#ffffff;
        }

        div#mainPanel .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}
        .textbox textarea.textbox-text {
            white-space: pre-wrap;
        }

        /*div#tabPanel .datagrid-wrap{ border-top: 0px;}*/
    </style>
</head>
<body>

<table id="grid1"
       class="easyui-treegrid"
       data-options="title:'', rownumbers:false,animate: true,collapsible: false,method: 'get',idField: 'id',treeField: 'title',showFooter: true,toolbar:'#grid1Toolbar',
           singleSelect:true,collapsible:true,selectOnCheck:false,checkOnSelect:false">
    <thead data-options="frozen:true">
    <tr>
        <th data-options="field:'sn'" halign="center" align="left" width="40" rowspan="2">编号</th>
        <th data-options="field:'title'" halign="center" align="left" width="200" rowspan="2">名称</th>
        <th data-options="field:'description'" halign="center" align="left" width="100" rowspan="2">目标/要求</th>
        <th data-options="field:'isAssigned'" halign="center" align="center" width="35" formatter="formatIsAssigned" rowspan="2">来源</th>
        <th data-options="field:'progress',halign:'center',align:'center'" sortable="true" width="60" formatter="formatProgress" rowspan="2">进度</th>
        <th colspan='2'>计划时间</th>
        <th colspan='2'>实际时间</th>
    </tr>
    <tr>
        <th data-options="field:'start',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">开始</th>
        <th data-options="field:'end',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">结束</th>
        <th data-options="field:'startAct',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">开始</th>
        <th data-options="field:'endAct',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">结束</th>
    </tr>
    </thead>
    <thead>
    <tr>
        <th data-options="field:'superintendentName',halign:'center',align:'center'" sortable="true" width="60" rowspan="2">责任人</th>
        <th data-options="field:'superintendDeptName',halign:'center',align:'center'" sortable="true" width="70" rowspan="2">责任部门</th>
        <th data-options="field:'ownerName',halign:'center',align:'center'" sortable="true" width="60" rowspan="2">执行人</th>
        <th data-options="field:'coupler',halign:'center',align:'center'" sortable="true" width="70" rowspan="2" formatter="formatCoupler">协助人</th>
        <th data-options="field:'coupleDept',halign:'center',align:'center'" sortable="true" width="70" rowspan="2" formatter="formatCoupler">协助单位</th>
        <th data-options="field:'wbs'" halign="center" align="left" width="60" rowspan="2">项目编号</th>
        <th data-options="field:'importance'" halign="center" align="center" width="60" codeName="jhzycd" formatter="formatImportance" rowspan="2">重要程度</th>
        <th data-options="field:'instancy'" halign="center" align="center" width="60" codeName="jhjjcd" formatter="formatInstancy" rowspan="2">紧急程度</th>
        <th data-options="field:'status'" halign="center" align="center" width="60" codeName="planStatus" formatter="formatCodeList" rowspan="2">状态</th>
        <th data-options="field:'needVerify'" halign="center" align="center" width="40" formatter="formatNeedVerify" rowspan="2">需核实</th>
        <th data-options="field:'verifierName'" halign="center" align="left" width="60" rowspan="2">核实者</th>
        <th colspan='2'>自评</th>
        <th colspan='2'>评价</th>
    </tr>
    <tr>
        <th data-options="field:'selfQualityEstimate',halign:'center',align:'center'" width="60" codeName="qualityEstimate" formatter="formatCodeList">质量</th>
        <th data-options="field:'selfEffectiveEstimate'" halign="center" align="center" width="60" codeName="effectiveEstimate" formatter="formatCodeList">时效</th>
        <th data-options="field:'qualityEstimate',halign:'center',align:'center'" width="60" codeName="qualityEstimate" formatter="formatCodeList">质量</th>
        <th data-options="field:'effectiveEstimate'" halign="center" align="center" width="60" codeName="effectiveEstimate" formatter="formatCodeList">时效</th>
    </tr>
    </thead>
</table>
<div id="grid1Toolbar">
    <a href="#" id="btnApprove" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" >审批</a>
</div>
</body>
</html>