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

    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/pinyin.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="./deptPlan.js"></script>
    <style>
        body {
            margin:0;
            padding:0;
            font:13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background:#ffffff;
        }

        div#mainPanel .datagrid-wrap{ border-right: 0px; border-left: 0px; border-bottom: 0px}

        /*div#tabPanel .datagrid-wrap{ border-top: 0px;}*/
    </style>
</head>
<body style="padding:5px;">
<%--<shiro:hasPermission name="user">--%>
<div id="mainPanel" class="easyui-panel" title="" >

    <div style="margin-bottom:3px;margin-top:5px;">
        <span style="margin-left:8px;margin-right:0px;">计划类型</span>
        <input class="easyui-combobox" id="f_isAnnualPlan" name="isAnnualPlan" codeName="jhlx" style="width: 100px" data-options="panelHeight:70,required:true"/>
        <span style="margin-left:8px;margin-right:0px;">计划名称</span>
        <input id="f_title" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>


        <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
               iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
               iconCls="icon2 r3_c10">重置</a>
			</span>
    </div>

    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,ctrlSelect:true,method:'get',rownumbers: false,onClickRow:mainGridRowClickHandler,
           striped:true,url:'../common/query?mapper=planMapper&queryName=queryDeptPlan',toolbar:mainGridToolbar<%--,pageSize:20,
           pagination:true, pagePosition:'bottom'--%>, onRowContextMenu:mainGridRowContextMenuHandler"
           style="height: 500px"
            >
        <thead>
        <tr>
            <th data-options="field:'sn',halign:'center',align:'left'" sortable="true" width="40" >编号</th>
            <th data-options="field:'title',halign:'center',align:'left'" sortable="true" width="260" formatter="formatShowPlanDetail">名称</th>
            <th data-options="field:'description',halign:'center',align:'center'" sortable="true" width="60" formatter="formatShowTooltip">标准/要求</th>
            <th data-options="field:'importance',halign:'center',align:'center'" sortable="true" width="70" codeName="jhzycd" formatter="formatImportance">重要程度</th>
            <th data-options="field:'createTime',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">创建时间</th>
            <th data-options="field:'start',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">计划开始时间</th>
            <th data-options="field:'end',halign:'center',align:'center'" sortable="true" width="80" formatter="formatDate">计划结束时间</th>
            <th data-options="field:'progress',halign:'center',align:'center'" sortable="true" width="100" formatter="formatProgress">进度</th>
            <th data-options="field:'superintendentName',halign:'center',align:'center'" sortable="true" width="70" >责任人</th>
            <%--<th data-options="field:'deptName',halign:'center',align:'center'" sortable="true" width="70" >责任部门</th>--%>
            <th data-options="field:'ownerName',halign:'center',align:'center'" sortable="true" width="70" >执行人</th>
            <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="50" codeName="planStatus" formatter="formatCodeList" styler="planStatusStyler">状态</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnPropose" class="easyui-linkbutton" iconCls="icon2 r19_c7" plain="true" disabled="true">提交审批</a>
        <a href="#" id="btnApprove" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" disabled="true">审批</a>
        <a href="#" id="btnStart" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
        <a href="#" id="btnPause" class="easyui-linkbutton" iconCls="icon2 r6_c16" plain="true" disabled="true">暂停</a>
        <a href="#" id="btnStop" class="easyui-linkbutton" iconCls="icon2 r7_c8" plain="true" disabled="true">终止</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
    </div>
</div>
<%--</shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission>--%>
<!-- --------弹出窗口--------------- -->
<div id="popWindow" class="easyui-window" title="计划详细信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 900px; height: 620px; padding: 5px;">
    <div id="popPageRow">
        <a href="javascript:void(0);" id="btnFirst1" class="easyui-linkbutton" iconCls="icon-first"  plain="true" >首个</a>
        <a href="javascript:void(0);" id="btnPre1" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext1" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnLast1" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnSave1" class="easyui-linkbutton" iconCls="icon-save"  plain="true">保存</a>
        <a href="javascript:void(0);" id="btnPropose1" class="easyui-linkbutton" iconCls="icon2 r19_c7" plain="true" disabled="true">提交审批</a>
        <a href="javascript:void(0);" id="btnApprove1" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" disabled="true">审批</a>
        <a href="javascript:void(0);" id="btnStart1" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
        <a href="javascript:void(0);" id="btnPause1" class="easyui-linkbutton" iconCls="icon2 r6_c16"  plain="true" disabled="true">暂停</a>
        <a href="javascript:void(0);" id="btnStop1" class="easyui-linkbutton" iconCls="icon2 r7_c8"  plain="true" disabled="true">终止</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" disabled="true">删除</a>
        <a href="javascript:void(0);" id="btnClose1" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    <div style="border: 1px solid lightblue; border-bottom-width: 0px; padding: 3px;">
        <form id="planForm">
            <div style="display : none">
                计划主键<input type="hidden" id="p_id"  />
                计划拥有者<input type="hidden" id="p_authorIId" />
                计划负责人<input type="hidden" id="p_superintendentId" />
                计划拥有单位ID<input type="hidden" id="p_deptId"  />
                计划拥有单位名称<input type="hidden" id="p_deptName" />
                <%--计划创建时间<input class="easyui-datebox" id="p_createTime" name="createTime" />--%>
                计划创建者ID<input type="hidden" id="p_ownerId"  />
                计划审批者ID<input type="hidden" id="p_approverId" />
                上级计划主键<input type="hidden" id="p_parentId" />
                上级计划名称<input type="hidden" id="p_parentName" />
                <%--计划类别<input type="hidden" id="p_isDeptPlan" name="isDeptPlan" />--%>
                <%--协助单位<input type="hidden" id="p_coupleDep" name="isDeptPlan" />--%>
            </div>
            <table style="padding-top:5px" id="planTable">
                <tr>
                    <td style="text-align:right">编号</td>
                    <td><input class="easyui-textbox" id="p_sn" style="width: 50px" data-options="required:true"/></td>
                    <td style="text-align:right">计划名称/目标</td>
                    <td colspan="5"><input class="easyui-textbox" id="p_title" name="title" style="width: 460px" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td style="text-align:right">描述</td>
                    <td colspan="7"><input class="easyui-textbox" id="p_description"  style="width: 646px" /></td>
                </tr>
                <tr>
                    <td style="text-align:right">重要程度</td>
                    <td><input class="easyui-combobox" id="p_importance" name="importance" codeName="jhzycd" style="width: 100px" data-options="required:true,panelHeight:100"/></td>
                    <td style="text-align:right">紧急程度</td>
                    <td><input class="easyui-combobox" id="p_instancy" name="instancy" codeName="jhjjcd" style="width: 100px" data-options="required:true,panelHeight:100"/></td>
                    <td style="text-align:right">状态</td>
                    <td><input class="easyui-combobox" id="p_status" name="status" codeName="planStatus" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">进度</td>
                    <td ><div class="husky-progressbar" id="p_progress" name="progress" style="width: 100px" editable="false" /></td></tr>

                </tr>
                <tr>
                    <td style="text-align:right">负责人</td>
                    <td><input class="easyui-textbox" id="p_superintendentName" name="superintendentName" style="width: 100px"
                               data-options="required:true,editable:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectSuperintendent
                                    }]"/></td>
                    <td style="text-align:right">协助人</td>
                    <td><input class="easyui-textbox" id="p_coupler" style="width: 100px"
                               data-options="required:false,editable:false,
                                    icons:[{
                                        iconCls:'icon-man',
                                        handler: selectCoupler
                                    }]"/></td>
                    <td style="text-align:right">协助单位</td>
                    <td colspan="3"><input class="easyui-textbox" id="p_coupleDep" style="width: 280px"
                               data-options="required:false,editable:false,
                                icons:[{
                                    iconCls:'icon-man',
                                    handler: selectCoupleDep
                                }]"/></td>
                </tr>
                <tr>
                    <td style="text-align:right">开始时间</td>
                    <td><input class="easyui-datebox" id="p_start" name="start" style="width: 100px" /></td>
                    <td style="text-align:right">结束时间</td>
                    <td><input class="easyui-datebox" id="p_end" name="end" style="width: 100px" validType="laterThan['p_start']" invalidMessage="结束时间必须晚于开始时间" /></td>
                    <td style="text-align:right">实际开始</td>
                    <td><input class="easyui-datebox" id="p_startAct" name="startAct" style="width: 100px" data-options="readonly:true"/></td>
                    <td style="text-align:right">实际结束</td>
                    <td><input class="easyui-datebox" id="p_endAct" name="endAct" style="width: 100px" data-options="readonly:true"/></td>
                    <%--<td style="text-align:right">权重</td>
                    <td><input class="easyui-numberspinner" id="p_weight" name="sn" style="width: 100px" data-options="min:10,max:100,editable:false,required:true"/></td>--%>

                </tr>
                <tr>
                    <td style="text-align:right">创建人</td>
                    <td><input class="easyui-textbox" id="p_authorName" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">创建时间</td>
                    <td><input class="easyui-datebox" id="p_createTime" name="createTime" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">审批人</td>
                    <td><input class="easyui-textbox" id="p_approverName" name="approverId" style="width: 100px" data-options="required:false,readonly:false"/></td>
                    <td style="text-align:right">审批时间</td>
                    <td><input class="easyui-datebox" id="p_approveTime" style="width: 100px" data-options="readonly:true"/></td>
                </tr>

            </table>
        </form>
    </div>

    <div id="grid2Div">
        <table id="grid2"
               class="easyui-treegrid"
               data-options="title:'计划项列表',rownumbers: false,animate: true,collapsible: false,method: 'post',idField: 'id',treeField: 'title',showFooter: true,toolbar:'#grid2Toolbar',
               singleSelect:true,collapsible:true,selectOnCheck:false,checkOnSelect:false"
               style="width: 876px;height: 358px">
            <thead frozen="true">
            <tr>
                <th data-options="field:'sn'" halign="center" align="left" width="60" >编号</th>
                <th data-options="field:'title'" halign="center" align="center" width="100">计划项名称</th>
                <%--<th data-options="field:'cycle',halign:'center',align:'center'" sortable="true" width="70" >周期</th>--%>
                <th data-options="field:'importance'" halign="center" align="center" width="60" codeName="jhzycd" formatter="formatImportance">重要程度</th>
                <th data-options="field:'instancy'" halign="center" align="left" width="60" codeName="jhjjcd" formatter="formatInstancy">紧急程度</th>
                <th data-options="field:'status'" halign="center" align="left" width="60" codeName="planStatus" formatter="formatCodeList">状态</th>
                <th data-options="field:'weight',halign:'center',align:'center'" sortable="true" width="60" >权重</th>
                <th data-options="field:'progress',halign:'center',align:'center'" sortable="true" width="60" formatter="formatProgress">进度</th>
            </tr>
            </thead>
            <thead>
            <tr>
                <th data-options="field:'start',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">开始时间</th>
                <th data-options="field:'startAct',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">实际</th>
                <th data-options="field:'end',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">结束时间</th>
                <th data-options="field:'endAct',halign:'center',align:'center'" sortable="true" width="100" formatter="formatDate">实际</th>

                <th data-options="field:'superintendentName',halign:'center',align:'center'" sortable="true" width="70" >责任人</th>
                <th data-options="field:'deptName',halign:'center',align:'center'" sortable="true" width="70" >责任部门</th>
                <th data-options="field:'ownerName',halign:'center',align:'center'" sortable="true" width="70" >执行人</th>

                <th data-options="field:'needVerify'" halign="center" align="left" width="60" codeName="jhhs" formatter="formatCodeList">核实</th>
                <th data-options="field:'verifierName'" halign="center" align="left" width="60">核实者</th>
                <%--<th data-options="field:'description'" halign="center" align="left" width="100">描述</th>--%>
            </tr>
            </thead>
        </table>
        <div id="grid2Toolbar">
            <a href="#" id="btnAddPlanItem" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
            <a href="#" id="btnViewPlanItem" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
            <a href="#" id="btnStartPlanItem" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
            <a href="#" id="btnPausePlanItem" class="easyui-linkbutton" iconCls="icon2 r6_c16" plain="true" disabled="true">暂停</a>
            <a href="#" id="btnStopPlanItem" class="easyui-linkbutton" iconCls="icon2 r7_c8" plain="true" disabled="true">终止</a>
            <a href="#" id="btnDeletePlanItem" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
        </div>
    </div>
</div>

<div id="popWindow2" class="easyui-window" title="计划项详细信息"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 730px; height: 245px; padding: 5px;">
    <div id="popPageRow2">
        <a href="javascript:void(0);" id="btnFirst2" class="easyui-linkbutton" iconCls="icon-first"  plain="true">首个</a>
        <a href="javascript:void(0);" id="btnPre2" class="easyui-linkbutton" iconCls="icon-previous"  plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext2" class="easyui-linkbutton" iconCls="icon-next"  plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnLast2" class="easyui-linkbutton" iconCls="icon-last"  plain="true">末个</a>
        <a href="javascript:void(0);" id="btnSave2" class="easyui-linkbutton" iconCls="icon-save"  plain="true">保存</a>
        <a href="javascript:void(0);" id="btnStart2" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
        <a href="javascript:void(0);" id="btnPause2" class="easyui-linkbutton" iconCls="icon2 r6_c16"  plain="true">暂停</a>
        <a href="javascript:void(0);" id="btnStop2" class="easyui-linkbutton" iconCls="icon2 r7_c8"  plain="true">终止</a>
        <a href="javascript:void(0);" id="btnDelete2" class="easyui-linkbutton" iconCls="icon-remove"  plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose2" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">关闭</a>
    </div>
    <div style="border: 1px solid lightblue; padding: 3px;">
        <form id="planItemForm">
            <div style="display : none">
                计划主键<input type="hidden" id="k_id" name="id" />
                计划拥有者<input type="hidden" id="k_authorId" name="authorName" />
                计划负责人<input type="hidden" id="k_superintendentId" name="superintendentId" />
                计划拥有单位ID<input type="hidden" id="k_deptId" name="deptId" />
                计划拥有单位名称<input type="hidden" id="k_deptName" name="deptName" />
                计划创建者ID<input type="hidden" id="k_approverId" name="approverName" />
                上级计划主键<input type="hidden" id="k_parentId" name="parentId" />
                上级计划名称<input type="hidden" id="k_parentName" name="parentName" />
            </div>
            <table style="padding-top:5px" id="planItemTable">
                <tr>
                    <td style="text-align:right">编号</td>
                    <td><input class="easyui-textbox" id="k_sn" style="width: 100px" data-options="required:true"/></td>
                    <td style="text-align:right">名称/目标</td>
                    <td colspan="5"><input class="easyui-textbox" id="k_title" name="title" style="width: 461px" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td style="text-align:right">描述</td>
                    <td colspan="7"><input class="easyui-textbox" id="k_description"  style="width: 623px" /></td>
                </tr>
                <tr>
                    <td style="text-align:right">重要程度</td>
                    <td><input class="easyui-combobox" id="k_importance" name="importance" codeName="jhzycd" style="width: 100px" data-options="required:true,panelHeight:100"/></td>
                    <td style="text-align:right">紧急程度</td>
                    <td><input class="easyui-combobox" id="k_instancy" name="instancy" codeName="jhjjcd" style="width: 100px" data-options="required:true,panelHeight:100"/></td>
                    <td style="text-align:right">状态</td>
                    <td><input class="easyui-combobox" id="k_status" name="status" codeName="planStatus" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">进度</td>
                    <td ><div class="husky-progressbar" id="k_progress" name="progress" style="width: 100px" editable="true" /></td></tr>

                </tr>
                <tr>
                    <td style="text-align:right">负责人</td>
                    <td><input class="easyui-textbox" id="k_superintendentName" name="superintendentName" style="width: 100px" data-options="required:true,
                        icons:[{
                            iconCls:'icon-man',
                            handler: selectItemSuperintendent
                        }]"/></td>
                    <td style="text-align:right">协助人</td>
                    <td><input class="easyui-textbox" id="k_coupler" style="width: 100px" data-options="iconCls:'icon-man',iconWidth:20"/></td>
                    <td style="text-align:right">协助单位</td>
                    <td colspan="3"><input class="easyui-textbox" id="k_coupleDepName" name="coupleDepName" style="width: 281px" data-options=""/></td>
                </tr>
                <tr>
                    <td style="text-align:right">开始时间</td>
                    <td><input class="easyui-datebox" id="k_start" name="start" style="width: 100px" /></td>
                    <td style="text-align:right">结束时间</td>
                    <td><input class="easyui-datebox" id="k_end" name="end" style="width: 100px" validType="laterThan['k_start']" invalidMessage="结束时间必须晚于开始时间" /></td>
                    <td style="text-align:right">实际开始</td>
                    <td><input class="easyui-datebox" id="k_startAct" name="startAct" style="width: 100px" data-options="readonly:true"/></td>
                    <td style="text-align:right">实际结束</td>
                    <td><input class="easyui-datebox" id="k_endAct" name="endAct" style="width: 100px" data-options="readonly:true"/></td>
                    <%--<td style="text-align:right">权重</td>
                    <td><input class="easyui-numberspinner" id="k_weight" name="sn" style="width: 100px" data-options="min:10,max:100,editable:false,required:true"/></td>--%>

                </tr>
                <tr>
                    <td style="text-align:right">创建人</td>
                    <td><input class="easyui-textbox" id="k_authorName" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">创建时间</td>
                    <td><input class="easyui-datebox" id="k_createTime" name="createTime" style="width: 100px" data-options="required:true,readonly:true"/></td>
                    <td style="text-align:right">审批人</td>
                    <td><input class="easyui-textbox" id="k_approverName" name="approverId" style="width: 100px" data-options="required:false,readonly:true"/></td>
                    <td style="text-align:right">审批时间</td>
                    <td><input class="easyui-datebox" id="k_approveTime" style="width: 100px" data-options="readonly:true"/></td>
                </tr>
            </table>
        </form>

    </div>
</div>
</body>
</html>

<div id="menu" class="easyui-menu" style="width: 30px; display: none;" data-options="onClick:cmClickHandler">
    <div id="cmPropose" data-options="iconCls:'icon2 r19_c7'">提交审批</div>
    <div id="cmApprove" data-options="iconCls:'icon2 r12_c19'">审批</div>
    <div id="cmStart" data-options="iconCls:'icon2 r6_c13'">开始</div>
    <div id="cmPause" data-options="iconCls:'icon2 r6_c16'">暂停</div>
    <div id="cmStop" data-options="iconCls:'icon2 r7_c8'">终止</div>
    <div id="cmDelete" data-options="iconCls:'icon-remove'">删除</div>
</div>

<div id="personSelectDialog" class="easyui-dialog" title="选择协助人"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-man',modal:true,closed:true">
    <!--<div style=" display: inline-block; position: relative;padding:5px 10px">-->
    <div>
        <a href="#" id="btnPersonSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
    </div>
    <table id="grid3"
           <%--o_nClickRow:grid3ButtonHandler,--%>
           class="easyui-datagrid"
           data-options="
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                method:'get'"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="100">用户姓名</th>
            <th data-options="field:'orgId',halign:'center',align:'right'" sortable="true" width="150">单位代码</th>
            <th data-options="field:'orgName',halign:'center',align:'right'" sortable="true" width="150">单位名称</th>
            <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
            <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
        </tr>
        </thead>
    </table>
</div>

<div id="coupleDepSelectDialog" class="easyui-dialog" title="选择协作单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-man',modal:true,closed:true">
    <!--<div style=" display: inline-block; position: relative;padding:5px 10px">-->
    <div>
        <a href="#" id="btnCoupleDepSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
    </div>
    <table id="grid4"
    <%--o_nClickRow:grid3ButtonHandler,--%>

           class="easyui-datagrid"
           data-options="
                singleSelect:true,
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                method:'get'"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">单位代码</th>
            <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="100">单位姓名</th>
        </tr>
        </thead>
    </table>
</div>