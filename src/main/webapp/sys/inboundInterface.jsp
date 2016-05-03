<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="../css/content.css" rel="stylesheet" />
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet" />
	<link href="../css/themes/icon.css" rel="stylesheet" />

	<script type="text/javascript" src="../js/jquery.min.js" ></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js" ></script>
	<script type="text/javascript" src="../js/husky.easyui.extend.js" ></script>

	<script type="text/javascript" src="../js/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>

	<script type="text/javascript" src="../js/formatter.js"></script>
	<script type="text/javascript" src="./inboundInterface.js" ></script>
    <style type="text/css">
        #panel .datagrid-wrap{ border-width: 1px 0px 0px 0px;}
    </style>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="">
    <div style="padding: 5px 10px 0px 10px">
			<p style="margin-top: 0px; margin-bottom: 5px;">
			关键字:<input id="f_key" style="margin-left:5px;margin-right:8px" value=""/>
			<span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
			</p>
		</div>

		<table id="mainGrid"
			class="easyui-datagrid" 
			data-options="singleSelect:false,collapsible:true,onClickRow:mainGridButtonHandler,
				method:'get',
				url:'../common/query?mapper=inboundInterfaceMapper&queryName=query',
				onLoadSuccess: loadSuccess,toolbar:mainGridToolbar,height:450,pagination:false">

            <thead>
				<tr>
					<th data-options="field:'uuid',halign:'center',align:'center'" width="120" >接口码</th>
					<th data-options="field:'serviceType',halign:'center',align:'center'" width="100" codeName="serviceType"
                        formatter="formatCodeList">类型</th>
					<th data-options="field:'path',halign:'center',align:'left'" width="250">地址</th>
                    <th data-options="field:'port',halign:'center',align:'center'" width="70" >端口</th>
                    <th data-options="field:'thread',halign:'center',align:'center'" width="150">线程数</th>
					<th data-options="field:'service',halign:'center',align:'center'" width="150">业务对象</th>
					<th data-options="field:'remark',halign:'center',align:'center'" width="200">备注</th>
                    <th data-options="field:'status',halign:'center',align:'center'" sortable="true" width="70" codeName="interfaceStatus"
                        formatter="formatCodeList">状态</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="mainGridToolbar">
            <!--<a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>-->
            <a href="#" id="btnView" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">查看</a>
            <a href="#" id="btnLock" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">启用/禁用</a>
            <a href="#" id="btnInvalid" class="easyui-linkbutton" iconCls="icon2 r14_c1" plain="true" disabled="true">作废</a>
            <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
		</div>
    </div>

	<div id="popWindow" class="easyui-window" title="接口定义"
		 data-options="modal:true,closed:true,iconCls:'icon-search'"
		 style="width: 750px; height: 440px; padding: 5px;">
        <div id="tabPanel" class="easyui-tabs" style="width:726px;clear:both;" data-options="onSelect:tabSelectHandler">
            <div title="基本信息" style="padding:5px;" selected="true">
                <table width="100%" id="interfaceTable">
                    <!--<tr>
                        <td colspan="2">
                            <a href="javascript:void(0);" id="btnEditOrSave" class="easyui-linkbutton" iconCls="icon-edit"  plain="true">编辑</a>
                        </td>
                        <td colspan="2"></td>
                    </tr>-->
                    <tr>
                        <td style="text-align: right">接口代码</td>
                        <td><input class="easyui-textbox" id="i_uuid" type="text"
                                   data-options="required:true,disabled:true" style="width:200px;"/>
                        </td>
                        <td style="text-align: right">Service类型</td>
                        <td>
                            <input class="easyui-combobox" id="i_serviceType" codeName="serviceType" data-options="disabled:true" style="width:200px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right">地址</td>
                        <td>
                            <input id="i_path" class="easyui-textbox" style="width:200px;" data-options="required:true,disabled:true" />
                        </td>
                        <td style="text-align: right">端口</td>
                        <td>
                            <input id="i_port" class="easyui-textbox" style="width:200px;" data-options="disabled:true" />
                    </tr>
                    <tr>
                        <td style="text-align: right">业务类</td>
                        <td><input class="easyui-textbox" id="i_service" type="text" style="width:200px;" data-options="disabled:true"/></td>
                        <td style="text-align: right">线程数</td>
                        <td>
                            <input id="i_thread" class="easyui-textbox" style="width:200px;" data-options="disabled:true" />
                    </tr>
                    <tr>
                        <td style="text-align: right">备注</td>
                        <td colspan="3">
                            <input id="i_remark" class="easyui-textbox" style="width:574px;" data-options="required:true,disabled:true" />
                        </td>
                    </tr>
                </table>
            </div>
            <div title="报文模板" style="width:700px;padding:5px;">
                <iframe id="template" style="height: 350px; width: 695px;"></iframe>
            </div>

        </div>
	</div>

    <!--<div id="orgTypeSelectDialog" class="easyui-dialog" style="width:250px;height:130px"
         data-options="title:'请选择是否财政单位',toolbar:'#tb',modal:true">
        <div style=";padding:20px">
            <input type="radio" name="isFinancial" value="1"/>是
            <input type="radio" name="isFinancial" value="0" selected/>否
            <a href="#" id="btnOrgTypeSelect" class="easyui-linkbutton" iconCls="icon-ok" plain="true">确认</a>
        </div>
    </div>-->
</body>
</html>