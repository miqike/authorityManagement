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
    <title>执法人员库管理</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet" id="easyuiTheme"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>


    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>

    <script type="text/javascript" src="./2102.js"></script>
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
                    <td>姓名</td>
                    <td><input id="f_name" class="easyui-validatebox"/></td>
                    <td>执法(监督)类别</td>
                    <td><input id="f_zflx" class="easyui-combobox" codeName="zfjdlx" data-options="panelHeight:55"/></td>
                </tr>
                <tr>
                    <td>计划编号</td>
                    <td><input id="f_jhid" class="easyui-validatebox"/></td>
                    <td colspan="2" style="text-align: right ">
                        <a href="javascript:void(0);" id="btnLoadMainGrid" class="easyui-linkbutton" plain="true"
                           iconCls="icon-search">查找</a>
                        <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                           iconCls="icon2 r3_c10">重置</a>
                    </td>
                </tr>
            </table>
        </div>

<!-- onDblClickRow:mainGridDblClickHandler, -->
        <table id="mainGrid"
               class="easyui-datagrid"
               data-options="collapsible:true,
         			width: 100, height: 140,
         			onClickRow:mainGridButtonHandler,
	            	enableHeaderClickMenu: false,
					ctrlSelect:true,method:'get',
		            enableHeaderContextMenu: false,
		            enableRowContextMenu: false,
					toolbar: '#mainGridToolbar',
	           		pageSize: 100, pagination: true,
		            offset: { width: -254, height: -76}">
            <thead>
            <tr>
                <th data-options="field:'dwName',halign:'center',align:'left'" sortable="true" width="180">检查机关</th>
                <th data-options="field:'gxdwName',halign:'center',align:'left'" sortable="true" width="180">管辖单位</th>
                <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">姓名</th>
                <th data-options="field:'zfzh',halign:'center',align:'center'" sortable="true" width="85">执法证号</th>
                <th data-options="field:'gender',halign:'center',align:'center'" sortable="true" width="40"
                    codeName="gender"formatter="formatCodeList">性别</th>
                <th data-options="field:'sfzh',halign:'center',align:'right'" sortable="true" width="150">身份证号</th>
                <th data-options="field:'zw',halign:'center',align:'right'" sortable="true" width="100">职务</th>
                <th data-options="field:'zflx',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="zfjdlx" formatter="formatCodeList">执法(监督)类型</th>
                <th data-options="field:'whcd',halign:'center',align:'center'" sortable="true" width="100"
                    codeName="whcd"
                    formatter="formatCodeList">文化程度</th>
                <th data-options="field:'zt',halign:'center',align:'center'" sortable="true" width="50"
                    codeName="zfryStatus" formatter="formatCodeList">状态</th>
                <th data-options="field:'mobile',halign:'center',align:'center'" sortable="true" width="100">联系电话</th>
                <th data-options="field:'mail',halign:'center',align:'center'" sortable="true" width="150">电子邮箱</th>
                <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="80">系统账号</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div id="mainGridToolbar">
            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
            <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
            <a href="#" id="btnAddSysUser" class="easyui-linkbutton" iconCls="icon2 r25_c8" plain="true" disabled>添加操作员</a>
            <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true">注销</a>
            <!-- <a href="#" id="btnTrans" class="easyui-linkbutton" iconCls="icon2 r14_c6" plain="true">调转</a> -->
        </div>
    </div>
</div>

<!-- --------弹出窗口--------------- -->


</body>
</html>