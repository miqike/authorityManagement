<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户列表</title>

	<link rel="stylesheet" href="../css/jquery-easyui-theme/${theme}/easyui.css" />
	<link rel="stylesheet" href="../css/jquery-easyui-theme/icon.css" />
	<link rel="stylesheet" href="../js/jeasyui-extensions-release/jeasyui.extensions.min.css" >
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="../css/content.css"/>

	<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
	<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js" ></script>
	<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
	<script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js" ></script>
    <script type="text/javascript" src="../js/husky.orgTree.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.exhide-3.5.min.js"></script>
	<script type="text/javascript" src="../js/husky/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="./userTree2.js"></script>
	<style type="text/css">
	   /* 
		div #panel .datagrid-wrap{ border: 0px;}
		div #roleWindow .datagrid-wrap{ border-right: 0px;
			border-left: 0px;
			border-bottom: 0px;}

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
            border-right-width:1px;
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
        
        .panel-header {
        	padding-right:0px;
        } */
        
        td.label{
        	text-align:right;
        }
    </style>
</head>
<body style="padding:5px">
    <div class="easyui-layout" data-options="fit:true">
        <div id="treePanel" data-options="region:'west',collapsed:false,title:'',split:true,border:true,width:287">
            <div class="easyui-panel" title="单位列表" style="padding:5px 0px;"
                 data-options="iconCls:'icon-search',collapsible:true,collapsed:true,fit:true,">
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
                <span style="width:300px;">
                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
                </span>
            </div>

			<!--  -->
            <table id="mainGrid"
                   class="easyui-datagrid"
                   data-options="onClickRow:mainGridButtonHandler,ctrlSelect:true,method:'get',
                   offset: { width: -310, height: -40},onDblClickRow:mainGridDblClickHandler,
                   onLoadSuccess:mainGridLoadSuccessHandler,pagination:true,pageSize:100"
                   queryParams="name: $('#f_name').val()" 
                   toolbar="#mainGridToolbar">
                <thead>
                <tr>
                    <!--<th data-options="field:'id',halign:'center',align:'center'" width="70">ID</th>-->
                    <th data-options="field:'orgId',halign:'center',align:'center'" sortable="true" width="70">单位编码</th>
                    <th data-options="field:'orgName',halign:'center',align:'left'" sortable="true" width="260">单位名称</th>
                    <th data-options="field:'userId',halign:'center',align:'center'" sortable="true" width="70">用户代码</th>
                    <th data-options="field:'name',halign:'center',align:'center'" sortable="true" width="70">用户姓名</th>
                    <th data-options="field:'mobile',halign:'center',align:'right'" width="100">电话</th>
                    <th data-options="field:'email',halign:'center',align:'right'" width="150">邮箱</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="60" codeName="userStatus" formatter="formatCodeList">状态</th>
                    <th data-options="field:'ext1',halign:'center',align:'center'" width="60" formatter="formatExt1">数据权限</th>
                    <th data-options="field:'weight',halign:'center',align:'center'" width="50">排名</th>
                    <!-- <th data-options="field:'managerName',halign:'center',align:'center'" width="70">上级</th> -->
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="mainGridToolbar">
                <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
                <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">编辑/查看</a>
                <a href="#" id="btnResetPass" class="easyui-linkbutton" iconCls="icon2 r10_c20" plain="true" disabled="true">重置密码</a>
                <a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
                <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">锁定/解锁</a>
                <!-- <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true" >打印</a> -->
                <!-- <a href="#" id="btnPoiExport" class="easyui-linkbutton" iconCls="icon2 r8_c14" plain="true" >导出</a></div> -->
        </div>
    </div>
</body>
</html>