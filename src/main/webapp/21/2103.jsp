<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>抽检事项清单管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>
    <script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="./2103.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        div .datagrid-wrap {
            border-right: 0px;
            border-left: 0px;
            border-bottom: 0px
        }
        
        td.label {text-align:right;}
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="">

    <div style="padding: 5px 10px 0px 10px">
        <table id="queryTable">
            <tr>
                <td>核查类型</td>
                <td><input id="f_businessKey" class="easyui-combobox" codeName="hclx" data-options="panelHeight:60"/>
                </td>
                <td>核查信息分类</td>
                <td><input id="f_errorNo" class="easyui-combobox" codeName="hcxxfl" data-options="panelHeight:60"/></td>
                <td>公示项目</td>
                <td><input id="f_module" class="easyui-textbox"/></td>
                <td colspan="2" style="text-align:right">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                       iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                       iconCls="icon2 r3_c10">重置</a>
                </td>
            </tr>
        </table>
    </div>
    <table id="mainGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,onClickRow:mainGridButtonHandler,
           		width: 400,height:300,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get',
				toolbar: '#mainGridToolbar',
				method: 'get',
           		pageSize: 20, pagination: true"
           pagePosition="bottom">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">名称</th>
            <th data-options="field:'type',halign:'center',align:'left'" sortable="true" width="90" codeName="hclx"
                formatter="formatCodeList">类型
            </th>
            <th data-options="field:'descript',halign:'center',align:'left'" sortable="true" width="150">描述</th>
            <th data-options="field:'hccl',halign:'center',align:'left'" sortable="true" width="70">核查材料</th>
            <th data-options="field:'hcff',halign:'center',align:'left'" sortable="true" width="70" codeName="hcfs"
                formatter="formatCodeList">核查方法
            </th>
            <th data-options="field:'hcxxfl',halign:'center',align:'left'" sortable="true" width="90" codeName="hcxxfl"
                formatter="formatCodeList">核查信息分类
            </th>
            <th data-options="field:'qyzzxs',halign:'center',align:'left'" sortable="true" width="100" codeName="qyzzxs"
                formatter="formatCodeList">企业组织形式
            </th>
            <th data-options="field:'gsxm',halign:'center',align:'left'" sortable="true" width="70">对应公示项目</th>
            <th data-options="field:'hcffsm',halign:'center',align:'left'" sortable="true" width="70">核查方法说明</th>
            <th data-options="field:'jgcl',halign:'center',align:'left'" sortable="true" width="70" codeName="gsjg"
                formatter="formatCodeList">结果处理
            </th>
            <th data-options="field:'xxdb',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">登记信息和公示信息比对
            </th>
            <th data-options="field:'dbxxly',halign:'center',align:'left'" sortable="true" width="70">比对信息来源</th>
            <th data-options="field:'sfxysdhc',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否需要实地核查
            </th>
            <th data-options="field:'sfxyrghd',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否需要人工核对
            </th>
            <th data-options="field:'gzqx',halign:'center',align:'left'" sortable="true" width="70">改正期限</th>
            <th data-options="field:'sfbjxm',halign:'center',align:'left'" sortable="true" width="70" codeName="yesno"
                formatter="formatCodeList">是否必检项
            </th>
            <th data-options="field:'zxrq',halign:'center',align:'left'" sortable="true" width="70"
                formatter="formatDate">注销日期
            </th>
            <th data-options="field:'zxsm',halign:'center',align:'left'" sortable="true" width="70">注销说明</th>
        </tr>
        </thead>
    </table>
    <div id="mainGridToolbar">
        <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled>编辑</a>
        <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
        <a href="#" id="btnDrop" class="easyui-linkbutton" iconCls="icon-print" plain="true" disabled>注销/取消注销</a>
        <a href="#" id="btnShowDocWindow" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" disabled>核查材料清单</a>
    </div>
</div>
<%-- </shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission> --%>
<!-- --------弹出窗口--------------- -->
<div id="baseWindow" class="easyui-window" title="抽检事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
</div>
<%-- 
<div id="baseWindow" class="easyui-window" title="抽检事项"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd1" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre1" class="easyui-linkbutton" iconCls="icon-previous"
           plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext1" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst1" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast1" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete1" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose1" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>
    <div id="baseInfo">
        <div style="display: none">
            <input class="easyui-textbox" id="p_id" type="text" style="width:200px;"/>
        </div>

        <table width="100%" id="baseTable">
            <tr>
                <td>
                    <a href="javascript:void(0);" id="btnSave" class="easyui-linkbutton" iconCls="icon-save"
                       plain="true">保存</a>
                </td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td class="label">核查事项名称</td>
                <td><input class="easyui-textbox" id="p_name" type="text" style="width:200px;" data-options=""/></td>
                <td class="label">类型</td>
                <td><input class="easyui-combobox" id="p_type" type="text" style="width:200px;" data-options=""
                           codeName="hclx"/></td>
            </tr>
            <tr>
                <td class="label">描述</td>
                <td><input class="easyui-textbox" id="p_descript" type="text" style="width:200px;" data-options=""/>
                </td>
                <td class="label">核查材料</td>
                <td><input class="easyui-textbox" id="p_hccl" type="text" style="width:200px;" data-options=""/></td>
            </tr>
            <tr>
                <td class="label">核查方法</td>
                <td><input class="easyui-combobox" id="p_hcff" type="text" style="width:200px;" data-options=""
                           codeName="hcfs"/></td>
                <td class="label">核查信息分类</td>
                <td><input class="easyui-combobox" id="p_hcxxfl" type="text" style="width:200px;" data-options=""
                           codeName="hcxxfl"/></td>
            </tr>
            <tr>
                <td class="label">核查类型</td>
                <td><input class="easyui-combobox" id="p_hclx" type="text" style="width:200px;" data-options=""
                           codeName="hclx"/></td>
                <td class="label">企业组织形式</td>
                <td><input class="easyui-combobox" id="p_qyzzxs" type="text" style="width:200px;" data-options=""
                           codeName="qyzzxs"/></td>
            </tr>
            <tr>
                <td class="label">对应公示项目</td>
                <td><input class="easyui-textbox" id="p_gsxm" type="text" style="width:200px;" data-options=""/></td>
                <td class="label">是否必检项</td>
                <td><input class="easyui-combobox" id="p_sfbjxm" type="text" style="width:200px;" data-options=""
                           codeName="yesno"/></td>
            </tr>
            <tr>
                <td class="label">结果处理</td>
                <td><input class="easyui-combobox" id="p_jgcl" type="text" style="width:200px;" data-options=""
                           codeName="gsjg"/></td>
                <td class="label">登记信息和公示信息比对</td>
                <td><input class="easyui-combobox" id="p_xxdb" type="text" style="width:200px;" data-options=""
                           codeName="yesno"/></td>
            </tr>
            <tr>
                <td class="label">比对信息来源</td>
                <td><input class="easyui-textbox" id="p_dbxxly" type="text" style="width:200px;" data-options=""/></td>
                <td class="label">是否需要实地核查</td>
                <td><input class="easyui-combobox" id="p_sfxysdhc" type="text" style="width:200px;" data-options=""
                           codeName="yesno"/>
                </td>
            </tr>
            <tr>
                <td class="label">是否需要人工核对</td>
                <td><input class="easyui-combobox" id="p_sfxyrghd" type="text" style="width:200px;" data-options=""
                           codeName="yesno"/>
                </td>
                <td class="label">改正期限</td>
                <td><input class="easyui-numberbox" id="p_gzqx" type="text" data-options="min:0,precision:0"
                           style="width:200px;"/></td>
            </tr>
            <tr>
                <td class="label">核查方法说明</td>
                <td colspan="3"><input class="easyui-textbox" id="p_hcffsm" type="text" style="width:200px;"
                                       data-options=""/></td>
                <td colspan="3"><textarea id="p_hcffsm" type="text" style="width:200px;"
                                          data-options=""/></td>
            </tr>
            <tr>
                <td class="label">注销日期</td>
                <td><input class="easyui-datebox" id="p_zxrq" type="text" style="width:200px;" data-options=""/></td>
                <td class="label">注销说明</td>
                <td><input class="easyui-textbox" id="p_zxsm" type="text" style="width:200px;" data-options=""/></td>
            </tr>
        </table>
    </div>
</div>

 --%>

<div id="docWindow" class="easyui-window" title="抽检材料清单"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
	<div id="docPanel"></div>
</div>
<!-- 
<div id="detailWindow1" class="easyui-window" title="抽检材料清单"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <div>
        <a href="javascript:void(0);" id="btnAdd2" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
        <a href="javascript:void(0);" id="btnPre2" class="easyui-linkbutton" iconCls="icon-previous"
           plain="true">上一个</a>
        <a href="javascript:void(0);" id="btnNext2" class="easyui-linkbutton" iconCls="icon-next" plain="true">下一个</a>
        <a href="javascript:void(0);" id="btnFirst2" class="easyui-linkbutton" iconCls="icon-first" plain="true">首个</a>
        <a href="javascript:void(0);" id="btnLast2" class="easyui-linkbutton" iconCls="icon-last" plain="true">末个</a>
        <a href="javascript:void(0);" id="btnDelete2" class="easyui-linkbutton" iconCls="icon-remove"
           plain="true">删除</a>
        <a href="javascript:void(0);" id="btnClose2" class="easyui-linkbutton" iconCls="icon-undo" plain="true">关闭</a>
    </div>
    <div>
        <table id="detailTable1"
               class="easyui-datagrid"
               data-options="collapsible:true,
           		width: 400,height:300,
           		offset: { width: 0, height: 0},
				ctrlSelect:true,method:'get',
				toolbar: '',
           		pageSize: 20, pagination: true"
               pagePosition="bottom">
            <thead>
            <tr>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">序号</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">材料名称</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">是否必要项</th>
                <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70">文件类型</th>
            </tr>
            </thead>
        </table>
    </div>

</div>
 -->

</body>
</html>