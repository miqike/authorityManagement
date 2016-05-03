<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>部门计划</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>

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

    </style>
</head>
<body>
    <div id="popPageRow">
        <div style="float:left;padding-left: 10px;">
            <input type="radio" name="cycleType" id="cycleTypeWeek" value="4"/>周
            <input type="radio" name="cycleType" id="cycleTypeMonth" value="1" checked="true" />月度
            <input type="radio" name="cycleType" id="cycleTypeQuarter" value="2"/>季度
            <input type="radio" name="cycleType" id="cycleTypeYear" value="3"/>年度
        </div>
        <div style="float:right">
            排序
            <input class="easyui-combobox" id="sort" style="width: 100px" data-options="panelHeight:270,valueField: 'value',textField: 'literal',data: sortFields,onChange:sortChangeHandler"/>
            <input class="easyui-combobox" id="order" style="width: 100px" data-options="panelHeight:50,valueField: 'value',textField: 'literal',onChange:sortChangeHandler, data: [{literal:'升序',value:'ASC'},{literal:'降序',value:'DESC'}]"/>
        </div>
        <div style="margin-left:350px;">
            <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous" plain="true"></a>
            <%--<span id="deptName" style="padding: 5px;color:blue;">${user.orgName}</span>--%>
            <input class="easyui-combobox" id="deptName" style="width: 100px" data-options="panelHeight:100"/>
            <span id="currentYear" style="padding: 5px;color:red;"></span>年度
            <span id="currentCycle" style="padding: 5px;color:red;"></span><span id="cycleTypeLiteral">月份</span>工作计划
            <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true"></a>
        </div>
    </div>

    <table id="grid1"
           class="easyui-treegrid"
           data-options="title:'', rownumbers:false,animate: true,collapsible: false,method: 'get',idField: 'id',treeField: 'title',showFooter: true,toolbar:'#grid1Toolbar',
           singleSelect:true,collapsible:true,selectOnCheck:false,checkOnSelect:false">
        <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'sn'" halign="center" align="left" width="100" rowspan="2">编号</th>
                <th data-options="field:'title'" halign="center" align="left" width="200" rowspan="2">名称</th>
                <th data-options="field:'description'" halign="center" align="left" width="100" rowspan="2">目标/要求</th>
                <th data-options="field:'level'" halign="center" align="center" width="35" codeName="planLevel" formatter="formatCodeList" rowspan="2">来源</th>
                <th data-options="field:'progress',halign:'center',align:'center'"  width="60" formatter="formatProgress" rowspan="2">进度</th>
                <th data-options="field:'status'" halign="center" align="center" width="60" codeName="planStatus" formatter="formatCodeList" rowspan="2">状态</th>
                <th data-options="field:'weightPer',halign:'center',align:'center'" width="40" formatter="formatWeight"  rowspan="2">权重</th>
                <th colspan='2'>计划时间</th>
                <th colspan='2'>实际时间</th>
            </tr>
            <tr>
                <th data-options="field:'start',halign:'center',align:'center'"  width="80" formatter="formatDate">开始</th>
                <th data-options="field:'end',halign:'center',align:'center'"  width="80" formatter="formatDate">结束</th>
                <th data-options="field:'startAct',halign:'center',align:'center'"  width="80" formatter="formatDate">开始</th>
                <th data-options="field:'endAct',halign:'center',align:'center'"  width="80" formatter="formatDate">结束</th>
            </tr>
        </thead>
        <thead>
            <tr>
                <th data-options="field:'authorName',halign:'center',align:'center'"  width="60" rowspan="2">创建人</th>
                <th data-options="field:'superintendentName',halign:'center',align:'center'"  width="60" rowspan="2">责任人</th>
                <th data-options="field:'superintendDeptName',halign:'center',align:'center'"  width="70" rowspan="2">责任部门</th>
                <th data-options="field:'ownerName',halign:'center',align:'center'"  width="60" rowspan="2">执行人</th>
                <th data-options="field:'coupler',halign:'center',align:'center'"  width="70" rowspan="2" formatter="formatCoupler">协助人</th>
                <th data-options="field:'coupleDept',halign:'center',align:'center'"  width="70" rowspan="2" formatter="formatCoupler">协助部门</th>
                <th data-options="field:'wbs'" halign="center" align="left" width="60" rowspan="2">项目编号</th>
                <th data-options="field:'importance'" halign="center" align="center" width="60" codeName="jhzycd" formatter="formatCodeList" rowspan="2">重要程度</th>
                <th data-options="field:'instancy'" halign="center" align="center" width="60" codeName="jhjjcd" formatter="formatCodeList" rowspan="2">紧急程度</th>
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
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnSplit" class="easyui-linkbutton" iconCls="icon2 r24_c1" plain="true">分解</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
        <a href="#" id="btnPropose" class="easyui-linkbutton" iconCls="icon2 r19_c7" plain="true" disabled="true">提交审批</a>
        <a href="#" id="btnApprove" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" disabled="true">审批</a>
        <a href="#" id="btnStart" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
        <a href="#" id="btnPause" class="easyui-linkbutton" iconCls="icon2 r6_c16" plain="true" disabled="true">暂停</a>
        <a href="#" id="btnStop" class="easyui-linkbutton" iconCls="icon2 r7_c8" plain="true" disabled="true">终止</a>
        <a href="#" id="btnVerify" class="easyui-linkbutton" iconCls="icon-verify" plain="true" disabled="true">核实</a>
        <a href="#" id="btnEstimate" class="easyui-linkbutton" iconCls="icon2 r24_c2" plain="true" disabled="true">评价</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
    </div>
</body>
</html>

<jsp:include page="planForm.jsp" />
<div id="progressbar" style='margin-bottom:10px;display:none'></div>

<script type="text/javascript" src="../js/hotkeys.min.js"></script>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/fileuploader.js"></script>
<script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/pinyin.js"></script>
<script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="../js/husky.common.js"></script>
<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<script type="text/javascript" src="./planCommon.js"></script>
<script type="text/javascript" src="./functionArray.js"></script>
<script type="text/javascript" src="./deptPlan.js"></script>
