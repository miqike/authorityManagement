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
    <title>市场主体管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet" id="easyuiTheme"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <!--
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">
    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script> 
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    -->

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>


    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
     <script type="text/javascript" src="../js/formatter.js"></script>

    <script type="text/javascript" src="./2101.js"></script>
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

        div#tabPanel .datagrid-wrap {
            border-top: 0px;
        }

        td.label {
            text-align: right;
        }

        .validatebox-text {
            border-width: 1px;
            border-style: solid;

            line-height: 17px;
            padding-top: 1px;
            padding-left: 3px;
            padding-bottom: 2px;
            padding-right: 3px;
            background-attachment: scroll;
            background-size: auto;
            background-origin: padding-box;
            background-clip: border-box;
        }

        .validatebox-invalid {
            border-color: ffa8a8;
            background-repeat: repeat-x;
            background-position: center bottom;
            background-color: fff3f3;
            background-image: url("");
        }

    </style>
</head>
<body style="padding:5px;">
<div id="layout" class="easyui-layout" data-options="fit:true">

    <div data-options="region:'west',split:true" title="单位列表" style="width:240px;">
        <ul id="orgTree" class="ztree"></ul>
    </div>
    <div data-options="region:'center'">
        <div style="padding: 5px 10px 0px 10px">
            <table id="queryTable">
                <tr>
                    <td class="label">计划年度</td>
                    <td><input id="f_jhnd" class="easyui-validatebox"/></td>
                    <td class="label">计划编号</td>
                    <td><input id="f_jhbh" class="easyui-validatebox"/></td>
                    <td class="label">检查人员</td>
                    <td><input id="f_hcry" class="easyui-validatebox"/></td>
                    <td class="label">企业名称</td>
                    <td><input id="f_qymc" class="easyui-validatebox"/></td>
                </tr>
                <tr>
                    <td class="label">统一社会信用代码</td>
                    <td><input id="f_xydm" class="easyui-validatebox"/></td>
                    <td class="label">行业分类</td>
                    <td><input id="f_hyfl" class="easyui-combobox" codeName="hyfl"/></td>
                    <td class="label">区域</td>
                    <td><input id="f_qy" class="easyui-validatebox" style=""/></td>
                    <td class="label">组织形式</td>
                    <td><input id="f_zzxs" codeName="zzxs" class="easyui-combobox"/></td>
                </tr>
                <tr>
                    <td class="label">经营状态</td>
                    <td><input id="f_jyzt" class="easyui-combobox" codeName="jyzt"
                               data-options="panelHeight:120,width:144" style=""/></td>
                    <td class="label">检查结果</td>
                    <td><input id="f_hcjg" class="easyui-combobox" codeName="gsjg"
                               data-options="panelHeight:120,width:144" style=""/></td>

                    <%--
                                        <td colspan="3">
                                            <input type="radio"/> 全部
                                            <input type="radio"/> 按检查计划
                                            <input type="radio"/> 定向
                                            <input type="radio"/> 不定向
                                        </td>
                    --%>
                    <td style="text-align:right">
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
               data-options="collapsible:true,onClickRow:mainGridButtonHandler,title:'市场主体列表',
		            	width: 100, height: 140,
		            	enableHeaderClickMenu: false,
						ctrlSelect:true,method:'get',
						onDblClickRow:mainGridDblClickHandler,
			            enableHeaderContextMenu: false,
			            enableRowContextMenu: false,
						toolbar: '#mainGridToolbar',
		           		pageSize: 20, pagination: true,
			            offset: { width: -265, height: -110}">
            <thead>
            <tr>
                <th data-options="field:'djjg',halign:'center',align:'left'" sortable="true" width="100">登记机关</th>
                <th data-options="field:'mc',halign:'center',align:'left'" sortable="true" width="100">检查机关</th>
                <th data-options="field:'qymc',halign:'center',align:'left'" sortable="true" width="70">所在区域</th>
                <th data-options="field:'xydm',halign:'center',align:'center'" sortable="true" width="70">信用代码</th>
                <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">企业(机构)名称</th>
                <th data-options="field:'ztlx',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="ztlx"
                    formatter="formatCodeList">市场主体类型
                </th>
                <th data-options="field:'hyfl',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="hyfl"
                    formatter="formatCodeList">行业分类
                </th>
                <th data-options="field:'zzxs',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="qyzzxs"
                    formatter="formatCodeList">组织形式
                </th>
                <th data-options="field:'jyzt',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="jyzt"
                    formatter="formatCodeList">经营状态
                </th>
                <th data-options="field:'fr',halign:'center',align:'left'" sortable="true" width="100">法人代表/负责人</th>
                <th data-options="field:'lxdh',halign:'center',align:'left'" sortable="true" width="100">联系电话</th>
                <th data-options="field:'mail',halign:'center',align:'left'" sortable="true" width="150">电子邮箱</th>
                <th data-options="field:'llr',halign:'center',align:'left'" sortable="true" width="70">工商联络员</th>
                <th data-options="field:'hcrws',halign:'center',align:'right'" sortable="true" width="70">检查记录</th>
            </tr>
            </thead>
        </table>
        <div id="mainGridToolbar">
            <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">检查记录</a>
        </div>
    </div>
</div>

<!-- --------弹出窗口--------------- -->
<div id="examHistory" class="easyui-window" title="企业检查记录"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 750px; height: 400px; padding: 10px;">
    <table id="grid2"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               selectOnCheck:false,method:'get',
               checkOnSelect:false"
           toolbar="#grid2Toolbar"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'hcjgmc'" halign="center" align="left" width="150">检查机关</th>
            <th data-options="field:'djjgmc'" halign="center" align="left" width="150">登记机关</th>
            <th data-options="field:'hcdwXydm'" halign="center" align="left" width="180">统一社会信用代码</th>
            <th data-options="field:'hcdwName'" halign="center" align="left" width="180">企业名称</th>
            <th data-options="field:'qymc'" halign="center" align="left" width="100">区域</th>
            <th data-options="field:'zfryCode1'" halign="center" align="left" width="100"formatter="formatZfry">检查人员</th>
            <th data-options="field:'rlrmc'" halign="center" align="left" width="70">认领人</th>
            <th data-options="field:'rlrq'" halign="center" align="left" width="70"formatter="formatDate">认领日期</th>
            <th data-options="field:'rwzt'" halign="center" align="left" width="70"codeName="jhlb" formatter="formatCodeList">计划完成</th>
            <th data-options="field:'sjwcrq'" halign="center" align="left" width="70"formatter="formatDate">实际完成</th>
        </tr>
        </thead>
    </table>
    <div id="grid2Toolbar">
        <a href="#" id="btnViewHcsxjg" class="easyui-linkbutton" iconCls="icon-edit" plain="true">事项核查结果</a>
        <a href="#" id="btnCloseHistory" class="easyui-linkbutton" iconCls="icon-edit" plain="true">返回</a>
    </div>
</div>

<div id="examHistoryHcsxjg" class="easyui-window" title="事项核查结果列表"
     data-options="modal:true,closed:true,iconCls:'icon-search'"
     style="width: 950px; height: 500px; padding: 10px;">
    <table id="grid3"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               selectOnCheck:false,method:'get',
               checkOnSelect:false"
           toolbar="#grid3Toolbar"
           style="height: 418px">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">检查事项</th>
            <th data-options="field:'hcfs',halign:'center',align:'center'" sortable="true" width="70" codeName="hcfs" formatter="formatCodeList">检查方式</th>
            <th data-options="field:'qygsnr',halign:'center',align:'left'" sortable="true" width="70">公示内容</th>
            <th data-options="field:'bznr',halign:'center',align:'left'" sortable="true" width="150">标准内容</th>
            <th data-options="field:'hczt',halign:'center',align:'center'" sortable="true" width="100" codeName="xmzt" formatter="formatCodeList"  styler="stylerHczt">检查状态</th>
            <th data-options="field:'hcjg',halign:'center',align:'center'" sortable="true" width="100" codeName="hcjg" formatter="formatCodeList" styler="stylerHcjg">检查结果</th>
            <th data-options="field:'sm',halign:'center',align:'center'" sortable="true" width="150" >结果说明</th>
        </tr>
        </thead>
    </table>
    <div id="grid3Toolbar">
        <a href="#" id="btnCloseHcsxjg" class="easyui-linkbutton" iconCls="icon-edit" plain="true">返回</a>
    </div>
</div>
</body>
</html>