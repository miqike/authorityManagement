<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>单位数据授权</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet" type="text/css"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.menu.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.panel.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions/jeasyui.extensions.datagrid.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.extend.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.exhide-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/datagrid-filter.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/lodop/listPrint.js"></script>

    <script type="text/javascript" src="./1106.js"></script>
    <style>


        #treePanel {
            width: 300px;
            height: 500px;
            margin-left: 5px;
            border-left-width: 1px;
            border-right-width: 1px;
            border-bottom-width: 1px;
        }

        #treePanel panel-header {
            border-top-width: 0px;
        }

        #treePanel > div.panel > div {
            border-left-width: 0px;
            border-right-width: 0px;
        }

        div.datagrid-wrap {
            border-left-width: 0px;
            border-right-width: 0px;
        }

        #userWindow div.datagrid-wrap {
            border-top-width: 0px;
            border-bottom-width: 0px;
        }

        #cc div.datagrid-wrap {
            border-top-width: 0px;
            border-bottom-width: 0px;
        }

    </style>

    <!-- 打印控件引入定义开始 -->
    <script type="text/javascript" src="../js/LodopFuncs.js"></script>
    <object id="LODOP_OB"
            classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
    <!-- 打印控件引入定义结束 -->

</head>
<body style="padding:1px;">
<%--<shiro:hasPermission name="userTree">--%>
<%--
<div id="mm" class="easyui-menu" style="width:220px;">
    <div id="menu1" data-options="iconCls:'icon-uncheck'" onclick="javascript:window.queryChild=!window.queryChild;queryUser();">查询下级单位数据</div>
</div>
--%>
<div class="easyui-layout" data-options="fit:true,height:300" style="height:300px;">
    <div id="treePanel" data-options="region:'west',collapsed:false,title:'',split:false,border:false">
        <div style="float:left;margin:0px 5px;solid: lightgray">
            <ul id='orgTree' class="ztree" style="height: 150px"></ul>
        </div>
    </div>
    <div data-options="region:'center'">
        <div style="margin-bottom:3px;margin-top:5px;">
            <span style="margin-left:8px;margin-right:0px;">用户代码/姓名:</span>
            <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
            <%--<span style="margin-left:8px;margin-right:0px;">单位:</span>
            <input id="f_organization" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>--%>
                <span style="width:300px;">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
                       iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
                       iconCls="icon2 r3_c10">重置</a>
                </span>
        </div>
        <div style="height:150px;">
            <table id="mainGrid"
                   class="easyui-datagrid"
                   data-options="offset: { width: -310, height: -40},
                   ctrlSelect:true,method:'get',method:'get'"
                   pagination="false"
                   pagePosition="bottom">
                <thead>
                <tr>
                    <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
                    <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>
                    <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称
                    </th>
                    <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码
                    </th>
                    <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
                    <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
                    <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70"
                        codeName="userStatus"
                        formatter="formatCodeList">状态
                    </th>
                    <th data-options="field:'managerName',halign:'center',align:'center'" sortable="true" width="70">
                        上级
                    </th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="height:100px;">
            <table id="deptGrid"
                   class="easyui-datagrid"
                   data-options="offset: { width: -310, height: -40},
                   ctrlSelect:true,method:'get',method:'get'"
                   toolbar="#mainGridToolbar"
                   pagination="false"
                   pagePosition="bottom">
                <thead>
                <tr>
                    <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
                    <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码
                    </th>
                    <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称
                    </th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div id="mainGridToolbar">
            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
            <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        </div>

    </div>
    <%--</shiro:hasPermission>
    <shiro:lacksPermission name="userTree">
        <script>
            //alert("没有权限，跳转");
        </script>
    </shiro:lacksPermission>--%>
</div>
<!-- --------弹出窗口--------------- -->

<!-- 选择单位弹出层 -->
<div id="organizationSelectDialog" class="easyui-dialog" title="选择单位"
     style="clear: both; width: 600px; height: 400px;"
     data-options="iconCls:'icon-edit',modal:true,closed:true">
    <div style=" display: inline-block; position: relative;padding:5px 10px">
        <div>
            <a href="#" id="btnOrganizationSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true"
               disabled="true">确定</a>
        </div>
        <ul id="orgTreeSelect" class="ztree"></ul>
    </div>
</div>

</body>
</html>