<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户列表</title>
    <link href="../css/content.css" rel="stylesheet" />
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../css/themes/icon.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="../js/jquery.min.js" ></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
    <script type="text/javascript" src="../js/husky.easyui.extend.js" ></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.exhide-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="../js/datagrid-filter.js"></script>
    <script type="text/javascript" src="../js/husky.common.js"></script>
    <script type="text/javascript" src="../js/lodop/listPrint.js"></script>

    <script type="text/javascript" src="./userOrg.js"></script>
    <style>


        #treePanel {
            width:300px;
            height: 500px;
            margin-left:5px;
            border-left-width:1px;
            border-right-width:1px;
            border-bottom-width:1px;
        }

        #treePanel panel-header {
            border-top-width:0px;
        }

        #treePanel>div.panel>div {
            border-left-width:0px;
            border-right-width:0px;
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
<%--<shiro:hasPermission name="userOrg">--%>
    <%--
    <div id="mm" class="easyui-menu" style="width:220px;">
        <div id="menu1" data-options="iconCls:'icon-uncheck'" onclick="javascript:window.queryChild=!window.queryChild;queryUser();">查询下级单位数据</div>
    </div>
--%>
    <div class="easyui-layout" data-options="fit:true,height:600" style="height:600px;">
        <div id="treePanel" data-options="region:'west',collapsed:false,title:'',split:false,border:false">
            <div class="easyui-panel" title="单位列表" style="width:295px;height:145px;padding:5px;"
                 data-options="iconCls:'icon-search',collapsible:true,collapsed:true">
                <div id="p">
                    <span style="margin-left:5px;margin-right:0px;">编码</span>
                    <input id="q_ba0101" style="margin:0px 5px 5px 0px; width:100px;"/>
                    <br/>
                    <span style="margin-left:5px;margin-right:0px;">名称</span>
                    <input id="q_ba0111" style="margin:0px 5px 5px 0px; padding-right: 3px;width:100px;"/>
                    <br/>
                </div>
                <span style="margin-left:7px" ><input class="easyui-numberspinner" id="f_expandLevel" value="3" data-options="min:1,width:40,onChange:levelExpandTree" /></span>
                <a href="javascript:void(0);" id="btnSearch1" class="easyui-linkbutton" plain="true" iconCls="icon-search" style="margin-left:5px;">查找</a>
                <a href="javascript:void(0);" id="btnReset1" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
            </div>
            <div style="float:left;margin:0px 5px;solid: lightgray">
                <ul id='orgTree' class="ztree" style="height: 450px"></ul>
            </div>
        </div>
        <div data-options="region:'center'">
            <div style="margin-bottom:3px;margin-top:5px;">
                <span style="margin-left:8px;margin-right:0px;">用户代码/姓名:</span>
                <input id="f_name" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>
                <%--<span style="margin-left:8px;margin-right:0px;">单位:</span>
                <input id="f_organization" style="margin-left:5px;margin-right:10px; padding-right: 3px;"/>--%>
                <span style="width:300px;">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
                </span>
            </div>

            <table id="mainGrid"
                   class="easyui-datagrid"
                   data-options="singleSelect:true,method:'get'"
                   style="height: 200px"
                   pagination="false"
                   pagePosition ="bottom" >
                <thead>
                <tr>
                    <!--<th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70">ID</th>-->
                    <%--<th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>--%>
                    <%--<th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称</th>--%>
                    <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
                    <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
                    <th data-options="field:'mobile',halign:'center',align:'right'" sortable="true" width="100">电话</th>
                    <th data-options="field:'email',halign:'center',align:'right'" sortable="true" width="150">邮箱</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="userStatus"
                        formatter="formatCodeList">状态</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>

            <table id="managedDeptGrid"
                   class="easyui-datagrid"
                   data-options="singleSelect:false,ctrlSelect:true,method:'get',toolbar:'#managedDeptGridToolBar'"
                   style="height: 300px"
                   pagination="false"
                   pagePosition ="bottom"
                   title="可编制计划的单位"
                   toolbar="#managedDeptGridToolBar"
            >
                <thead>
                <tr>
                    <th data-options="field:'orgId',halign:'center',align:'left'" sortable="true" width="70">单位编码</th>
                    <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        <div id="managedDeptGridToolBar">
            <a href="#" id="btnDeptAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加</a>
            <a href="#" id="btnDeptDel" class="easyui-linkbutton" iconCls="icon-delete" plain="true">删除</a>
        </div>
    </div>
<%--</shiro:hasPermission>
<shiro:lacksPermission name="userOrg">
    <script>
        //alert("没有权限，跳转");
    </script>
</shiro:lacksPermission>--%>

<!-- --------弹出窗口--------------- -->

<div id="deptSelectDialog" class="easyui-dialog" title="选择部门"
     style="clear: both; width: 600px; height: 400px;padding:5px;"
     data-options="iconCls:'icon-group',modal:true,closed:true">
    <table id="gridDept"
           class="easyui-treegrid"
           data-options="
                idField: 'id',
                treeField: 'name',
                singleSelect:false,
                ctrlSelect:true,
                collapsible:true,
                selectOnCheck:false,
                checkOnSelect:false,
                toolbar:'#grid4Toolbar',
                method:'get'"
           style="height: 318px">
        <thead>
        <tr>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="100">单位代码</th>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="300">单位名称</th>
        </tr>
        </thead>
    </table>
</div>
<div id="grid4Toolbar">
    <a href="#" id=" " class="easyui-linkbutton" iconCls="icon-cancel" plain="true">取消</a>
    <a href="#" id="btnDeptSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确定</a>
</div>

</body>
</html>