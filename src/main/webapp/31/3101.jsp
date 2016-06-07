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
                <td class="label">检查内容</td>
                <td><input id="f_nr" class="easyui-combobox" codeName="hcnr"
                           data-options="panelHeight:80,width:143,onChange:queryPlan" style=""/></td>
                <td class="label">检查分类</td>
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
               toolbar="#gridToolbar1"
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
                    formatter="formatCodeList">检查分类
                </th>
                <th data-options="field:'nr'" halign="center" align="center" sortable="true" width="60" codeName="hcnr"
                    formatter="formatCodeList">检查内容
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
        <div id="gridToolbar1">
            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
            <a href="#" id="btnModify" class="easyui-linkbutton" iconCls="icon-edit" plain="true"
               data-options="disabled:true">修改</a>
            <a href="#" id="btnAudit" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true"
               data-options="disabled:true">审核/取消审核</a>
            <a href="#" id="btnViewCheckList" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true"
               data-options="disabled:true">检查事项</a>
            <a href="#" id="btnDispatch" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true"
               data-options="disabled:true">派发/取消派发</a>
        </div>
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
                    <!-- <th data-options="field:'id'" halign="center" align="left" width="30">序号</th> -->
                    <th data-options="field:'hcjgmc'" halign="center" align="left" width="150">检查机关</th>
                    <th data-options="field:'djjgmc'" halign="center" align="left" width="150">登记机关</th>
                    <th data-options="field:'hcdwXydm'" halign="center" align="left" width="180">
                        统一社会信用代码
                    </th>
                    <th data-options="field:'hcdwName'" halign="center" align="left" width="180">企业名称
                    </th>
                    <!--
                                         <th data-options="field:'ztlx'" halign="center" align="left" width="80" codeName="jhlb" formatter="formatCodeList">市场主体类型</th>
                                        <th data-options="field:'zzxs'" halign="center" align="left" width="80" codeName="jhlb" formatter="formatCodeList">组织形式</th>
                     -->
                    <th data-options="field:'qymc'" halign="center" align="left" width="100">区域</th>
                    <th data-options="field:'zfryCode1'" halign="center" align="left" width="100"
                        formatter="formatZfry">检查人员
                    </th>
                    <th data-options="field:'rlrmc'" halign="center" align="left" width="70">认领人</th>
                    <th data-options="field:'rlrq'" halign="center" align="left" width="70"
                        formatter="formatDate">认领日期
                    </th>
                    <th data-options="field:'rwzt'" halign="center" align="left" width="70"
                        codeName="jhlb" formatter="formatCodeList">计划完成
                    </th>
                    <th data-options="field:'sjwcrq'" halign="center" align="left" width="70"
                        formatter="formatDate">实际完成
                    </th>
                </tr>
                </thead>
            </table>
            <div id="planGridToolbar">
                <a href="#" id="btnSort1" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true"
                   data-options="disabled:true">按检查机关+检查人员排序</a>
                <a href="#" id="btnSort2" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true"
                   data-options="disabled:true">按市场主体类型+检查机关排序</a>
                <a href="#" id="btnAccept" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true"
                   data-options="disabled:true">认领/取消认领</a>
                <a href="#" id="btnShowDetail" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true"
                   data-options="disabled:true">详细</a>
            </div>
        </div>

    </div>
</div>


<!-- --------弹出窗口--------------- -->
<div id="planWindow" class="easyui-window" title="检查计划信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <!-- <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add"  plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div> -->
    <!-- <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler"> -->
    <div id="tabPanel" class="easyui-tabs" style="width:715px;clear:both;" data-options="onSelect:tabSelectHandler">
        <div title="基本信息" style="padding:5px;" selected="true">
            <table width="100%" id="planTable">
                <tr>
                    <td colspan="3">
                        <a href="javascript:void(0);" id="btnSavePlan" class="easyui-linkbutton" iconCls="icon-save"
                           plain="true">保存</a>
                        <a href="javascript:void(0);" id="btnImportTask" class="easyui-linkbutton"
                           iconCls="icon2 r10_c1" plain="true" disabled>导入任务信息</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>计划年度</td>
                    <td><input class="easyui-numberspinner add" id="p_nd" type="text"
                               data-options="required:true,min:2016" style="width:200px;"/>
                    </td>
                    <td>计划编号</td>
                    <td><input type="hidden" id="p_id"/>
                        <input class="easyui-textbox add" type="text" id="p_jhbh" data-options="required:true"
                               style="width:200px;"/>
                    </td>
                </tr>
                <tr>
                    <td>计划名称</td>
                    <td>
                        <input class="easyui-textbox add" id="p_jhmc" type="text" style="width:200px;"
                               data-options="required:true"/>
                    </td>
                    <td>公示系统计划编号</td>
                    <td>
                        <input class="easyui-textbox add" id="p_gsjhbh" type="text" style="width:200px;"
                               data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td>下达日期</td>
                    <td><input class="easyui-datebox add modify" id="p_xdrq" type="text" style="width:200px;"
                               data-options="required:true"/></td>
                    <td>要求完成时间</td>
                    <td><input class="easyui-datebox add modify" type="text" id="p_yqwcsj" style="width:200px;"
                               data-options="required:true"/></td>
                </tr>
                <tr>
                    <td>检查分类</td>
                    <td>
                        <input class="easyui-combobox add modify" id="p_fl" type="text" style="width:200px;"
                               data-options="panelHeight:60,required:true" codeName="hcfl"/>
                    </td>
                    <td>检查内容</td>
                    <td colspan="3">
                        <input id="p_nr" class="easyui-combobox add modify" codeName="hcnr"
                               data-options="panelHeight:80,width:200,required:true" style=""/>
                    </td>
                </tr>
                <tr>
                    <td>任务数量</td>
                    <td>
                        <input class="easyui-textbox" id="p_hcrwsl" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>已派发</td>
                    <td><input class="easyui-textbox" validType="email" id="p_ypfsl" type="text" style="width:200px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td>已认领</td>
                    <td>
                        <input class="easyui-textbox" id="p_yrlsl" type="text" style="width:200px;" data-options=""/>
                    </td>
                    <td>未认领</td>
                    <td><input class="easyui-textbox" validType="email" id="p_wrlsl" type="text" style="width:200px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td>审核状态</td>
                    <td>
                        <input class="easyui-combobox" id="p_shzt" type="text" style="width:200px;" data-options=""
                               codeName="shzt"/>
                    </td>
                    <td>审核人</td>
                    <td><input class="easyui-textbox" validType="email" id="p_shr" type="text" style="width:200px;"
                               data-options=""/></td>
                </tr>
                <tr>
                    <td>下达人</td>
                    <td>
                        <input class="easyui-textbox" id="p_xdrmc" type="text" style="width:200px;" data-options=""/>
                    </td>
                </tr>
                <tr>
                    <td>说明</td>
                    <td colspan="3"><input class="easyui-textbox add modify" id="p_sm" type="text" style="width:540px;"
                                           data-options=""/></td>
                </tr>

            </table>
        </div>
        <div title="任务信息" style="width:700px;">
            <table id="grid3"
                   class="easyui-datagrid"
                   data-options="
                   		method:'get',
                   		pageSize: 10, pagination: true,
                       singleSelect:true,
                       collapsible:true,
                       selectOnCheck:false,
                       checkOnSelect:false"
                   style="height: 318px">
                <thead>
                <tr>
                    <th data-options="field:'id'" halign="center" align="center" width="100" formatter="formatZfry">
                        执法人员
                    </th>
                    <th data-options="field:'hcdwXydm',halign:'center',align:'left'" sortable="true" width="200">
                        统一社会信用代码
                    </th>
                    <th data-options="field:'hcdwName',halign:'center',align:'left'" sortable="true" width="300">单位名称
                    </th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>


<div id="checklistWindow" class="easyui-window" title="检查事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd4" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <!-- <a href="javascript:void(0);" id="btnPre" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a> -->
        <a href="javascript:void(0);" id="btnDelete4" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose4" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>

    <table id="grid4"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
           toolbar="#grid4Toolbar"
           style="height: 318px">
        <thead>
        <tr>
            <!-- <th data-options="field:'id'" hidden="true" halign="center" align="left" width="0">主键</th> -->
            <!-- <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="60">事项代码</th> -->
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">名称</th>
            <th data-options="field:'type',halign:'center',align:'left'" sortable="true" width="90" codeName="hclx"
                formatter="formatCodeList">类型
            </th>
            <th data-options="field:'descript',halign:'center',align:'left'" sortable="true" width="150">描述</th>
            <th data-options="field:'hcff',halign:'center',align:'left'" sortable="true" width="70" codeName="hcfs"
                formatter="formatCodeList">检查方法
            </th>
            <th data-options="field:'hcxxfl',halign:'center',align:'left'" sortable="true" width="90" codeName="hcxxfl"
                formatter="formatCodeList">检查信息分类
            </th>
            <th data-options="field:'hclx',halign:'center',align:'left'" sortable="true" width="90" codeName="hclx"
                formatter="formatCodeList">检查类型
            </th>
        </tr>
        </thead>
    </table>
</div>

<div id="addChecklistWindow" class="easyui-window" title="备选检查事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 550px; height: 350px; padding: 10px;">

    <div>
        <a href="javascript:void(0);" id="btnSave5" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnClose5" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>

    <table id="grid5"
           class="easyui-datagrid"
           data-options="
               singleSelect:false,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               checkOnSelect:false"
           toolbar="#grid4Toolbar"
           style="height: 318px">
        <thead>
        <tr>
            <!-- <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="60">事项代码</th> -->
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="250">名称</th>
            <!-- <th data-options="field:'descript',halign:'center',align:'left'" sortable="true" width="150">描述</th> -->
            <th data-options="field:'hclx',halign:'center',align:'left'" sortable="true" width="100" codeName="hclx"
                formatter="formatCodeList">检查类型
            </th>
        </tr>
        </thead>
    </table>
</div>

<div id="importTaskWindow" class="easyui-window" title="导入任务信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 550px; height: 350px; padding: 10px;">
    <input type="radio" name="importType" value="dblink" checked/>从接口表导入
    <input type="radio" name="importType" value="file"/>从文件导入

    <div id="file" style="margin:10px;display:none">
        <input class="easyui-filebox" value="选择文件" style="width:300px" data-options="buttonText:'选择文件'"/>
        <a href="javascript:void(0);" id="btnImportFile" class="easyui-linkbutton" iconCls="icon2 r6_c10" plain="true">导入</a>
    </div>


    <div id="dblink" style="margin:10px;">
        <a href="javascript:void(0);" id="btnTestDblink" class="easyui-linkbutton" iconCls="icon2 r13_c20" plain="true">测试连接</a>
        <a href="javascript:void(0);" id="btnImportDblink" class="easyui-linkbutton" iconCls="icon2 r6_c10"
           plain="true">导入</a>

    </div>
    <div id="importReport" style="margin:10px;display:none">
        检查任务数:
        <sapn id="_hcrws" style="color:red"></sapn>
        <br/>
        检查人员数:
        <sapn id="_hcrys" style="color:blue"></sapn>
        <br/>
        <!-- 新增检查人员:20<br/>
        新增企业信息:14000</br> -->

    </div>
</div>
</body>
</html>
<link href="../css/content.css" rel="stylesheet"/>
<link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
<link href="../css/themes/icon.css" rel="stylesheet"/>
<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

<script type="text/javascript" src="../js/hotkeys.min.js"></script>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>

<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
<!--
-->
<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.orgTree.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="./3101.js"></script>