<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>计划任务分配</title>
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
	<link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

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
<body>
<div>
	<div style="float:left;width:300px;">
		<div id="toobar1" class="easyui-toolbar">
		    <a id="btnShowPlanListWindow" class="easyui-linkbutton" data-options="plain: true, iconCls: 'icon2 r5_c20'">选择计划列表</a>
			<a href="javascript:void(0);" id="btnGoFirst" class="easyui-linkbutton" iconCls="icon-first" plain="true">首</a>
			<a href="javascript:void(0);" id="btnGoPrev" class="easyui-linkbutton" iconCls="icon-previous" plain="true">上</a>
			<a href="javascript:void(0);" id="btnGoNext" class="easyui-linkbutton" iconCls="icon-next" plain="true">下</a>
			<a href="javascript:void(0);" id="btnGoLast" class="easyui-linkbutton" iconCls="icon-last" plain="true">末</a>
		</div>
	</div>
	<div style="float:right;margin-top:8px;margin-right:10px;"><span>计划编号</span><span id="x_planId"></span><span>计划名称</span><span id="x_planName"></span></div>
</div>

<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	
     <div data-options="region:'west',split:true," title="单位列表" style="width:240px;" >
          <ul id="orgTree" class="ztree"></ul> 
     </div>
     <div data-options="region:'center'">
         <table id="grid2"
                class="easyui-datagrid"
                data-options="ctrlSelect:true,collapsible:true,pageSize: 100, pagination: true,fit:true,
		onClickRow:grid2ClickHandler,height:400,method:'get',
		headerContextMenu: [
                { text: '按任务下达机关+检查人员排序', iconCls: 'icon2 r1_c15', disabled: false, handler: sort1 },
                { text: '按市场主体类型+任务下达机关排序', iconCls: 'icon2 r1_c13', disabled: false, handler: sort2 },
                { text: '按检查人员过滤', iconCls: 'icon2 r25_c10', disabled: false, handler: filterByZfry }
            ],
         enableHeaderClickMenu: false, enableHeaderContextMenu: true, enableRowContextMenu: false
		"
                toolbar="#planGridToolbar" sortOrder="asc">
             <thead>
             <tr>
             	<th data-options="field:'id',checkbox:true"></th>
                 <th data-options="field:'hcjgmc'" halign="center" align="left" width="150">任务下达机关</th>
                 <th data-options="field:'qymc'" halign="center" align="left" width="100">管辖单位</th>
                 <th data-options="field:'zfryCode1'" halign="center" align="center" width="100"
                     formatter="formatZfry">检查人员</th>
                 <th data-options="field:'djjgmc'" halign="center" align="left" width="150">登记机关</th>
                 <th data-options="field:'hcdwXydm'" halign="center" align="center" width="140">统一社会信用代码</th>
                 <th data-options="field:'hcdwName'" halign="center" align="left" width="180">企业名称</th>
                 <th data-options="field:'rlrmc'" halign="center" align="left" width="70">认领人</th>
                 <th data-options="field:'rlrq'" halign="center" align="left" width="70" formatter="formatDate">认领日期</th>
                 <th data-options="field:'clrq'" halign="center" align="left" width="70" formatter="formatDate">成立日期</th>
                 <th data-options="field:'zs'" halign="center" align="left" width="100">住所</th>
                 <th data-options="field:'jhwcrq'" halign="center" align="left" width="70"
                     formatter="formatDate">计划完成</th>
                 <th data-options="field:'sjwcrq'" halign="center" align="left" width="70"
                     formatter="formatDate">实际完成</th>
             </tr>
             </thead>
         </table>
         <div id="planGridToolbar">
             <!-- 
             <a href="#" id="btnSort1" class="easyui-linkbutton" iconCls="icon2 r1_c15" plain="true"
                data-options="disabled:true">按任务下达机关+检查人员排序</a>
             <a href="#" id="btnSort2" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true"
                data-options="disabled:true">按市场主体类型+任务下达机关排序</a>
              -->
              <a href="#" id="btnAccept" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true" data-options="disabled:false">认领</a>
             <a href="#" id="btnUnAccept" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" data-options="disabled:false">取消认领</a>
             <input class="easyui-searchbox" data-options="width: 260, height: 24, prompt: '快速定位', searcher: quickSearch, menu:'#mm'" />
             <!-- 
             <a href="#" id="btnShowDetail" class="easyui-linkbutton" iconCls="icon2 r5_c10" plain="true"
                data-options="disabled:true">详细</a> -->
         </div>
     </div>
</div>

<div id="mm" style="width:150px">
	<div data-options="name:'xydm'">统一社会信用代码</div>
	<div data-options="name:'qymc',selected:true">企业名称</div>
</div>

<div id="myPlanListWindow" >
	<div id="panel" class="easyui-layout" data-options="fit:true" style="overflow: hidden;">
	    <div data-options="region:'north',split:false,height:95" title="">
		    <div style="padding: 5px 10px 0px 10px">
		        <table id="queryTable">
	            <tr>
	                <td class="label">计划年度</td>
	                <td><input id="f_nd" class="easyui-validatebox" data-options="validType:'integer'"/>
	                </td>
	                <td class="label">计划编号</td>
	                <td><input id="f_jhbh" class="easyui-validatebox"/></td>
	                <td class="label">公示系统计划编号</td>
	                <td><input id="f_gsjhbh" class="easyui-validatebox"/></td>
	            </tr>
	            <tr>
	            	<td class="label">抽查文号</td>
	                <td><input id="f_cxwh" class="easyui-validatebox"/></td>
	                <td class="label">计划名称</td>
	                <td><input id="f_jhmc" class="easyui-validatebox"/></td>
	                <td class="label">检查内容</td>
	                <td><input id="f_nr" class="easyui-combobox" codeName="hcnr"
	                           data-options="panelHeight:80,width:143,onChange:loadGrid1" style=""/></td>
	            </tr>
	            <tr>
	                <td class="label">检查分类</td>
	                <td><input id="f_fl" class="easyui-combobox" codeName="hcfl"
	                           data-options="panelHeight:60,width:143,onChange:loadGrid1" style=""/></td>
	                <td class="label">计划类型</td>
	                <td><input id="f_planType" class="easyui-combobox" codeName="planType"
	                           data-options="panelHeight:60,width:143,onChange:loadGrid1" style=""/></td>
	                <td class="label">任务下达机关</td>
	                <td><input id="f_hcjgmc" class="easyui-validatebox" style=""/></td>
					
	                <td style="text-align-right;">
	                    <a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true"
	                       iconCls="icon-search">查找</a>
	                    <a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true"
	                       iconCls="icon2 r3_c10">重置</a>
                       <a href="javascript:void(0);" id="btnMinimizeMyPlanListWindow" class="easyui-linkbutton" plain="true"
	                       iconCls="icon-back">返回</a>
	                </td>
	            </tr>
	        </table>
		    </div>
	    </div>
	    
	    <div data-options="region:'center',split:true" style="width:340px;">
	        <table id="grid1"
	               class="easyui-datagrid"
	               data-options="singleSelect:true,collapsible:true,height:315,
					onClickRow:grid1ClickHandler,pagination:false,
					method:'get',onLoadSuccess:grid1LoadSucessHandler"
	               toolbar="#gridToolbar1"
	               sortOrder="asc">
	            <thead>
	            <tr>
	                <th data-options="field:'nd'" halign="center" align="center" sortable="true" width="35">年度</th>
	                <th data-options="field:'jhbh'" halign="center" align="left" sortable="true" width="70">计划编号</th>
	                <th data-options="field:'gsjhbh'" halign="center" align="left" sortable="true" width="100">公示系统计划编号</th>
	                <th data-options="field:'jhmc'" halign="center" align="center" sortable="true" width="170">计划名称</th>
	                <th data-options="field:'cxwh'" halign="center" align="center" sortable="true" width="130">抽查文号</th>
	                <th data-options="field:'djjgmc'" halign="center" align="center" sortable="true" width="130">任务下达机关</th>
	                <th data-options="field:'planType'" halign="center" align="center" sortable="true" width="65" codeName="planType" formatter="formatCodeList">计划类型</th>
					<th data-options="field:'ksrq'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">计划开始时间</th>
	                <th data-options="field:'yqwcsj'" halign="center" align="center" sortable="true" width="80" formatter="formatDate">计划结束时间</th>
	                <th data-options="field:'fl'" halign="center" align="center" sortable="true" width="60" codeName="hcfl" formatter="formatCodeList">检查分类</th>
	                <th data-options="field:'nr'" halign="center" align="center" sortable="true" width="60" codeName="hcnr" formatter="formatCodeList">检查内容</th>
	                <th data-options="field:'hcrwsl'" halign="center" align="right" sortable="true" width="45">任务数</th>
	                <th data-options="field:'yrlsl'" halign="center" align="right" sortable="true" width="45">已认领</th>
	                <th data-options="field:'wrlsl'" halign="center" align="right" sortable="true" width="45">未认领</th>
	                <th data-options="field:'xdrq'" halign="center" align="center" sortable="true" width="70" formatter="formatDate">下达日期</th>
	                <th data-options="field:'xdrmc'" halign="center" align="center" sortable="true" width="70">下达人</th>
	                <th data-options="field:'sm'" halign="center" align="left" sortable="true" width="250">说明</th>
	            </tr>
	            </thead>
	        </table>
	        <div id="gridToolbar1">
	            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true">增加双随机计划</a>
	            <a href="#" id="btnAddRc" class="easyui-linkbutton" iconCls="icon2 r1_c6" plain="true">增加日常监管计划</a>
	            <a href="#" id="btnModify" class="easyui-linkbutton" iconCls="icon-edit" plain="true" data-options="disabled:true">修改</a>
	            <a href="#" id="btnRemove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" data-options="disabled:true">删除</a>
	            <a href="#" id="btnViewCheckList" class="easyui-linkbutton" iconCls="icon2 r5_c20" plain="true" data-options="disabled:true">检查事项</a>
	            <a href="#" id="btnDispatch" class="easyui-linkbutton" iconCls="icon2 r16_c19" plain="true" data-options="disabled:true">下达/取消下达</a>
	        </div> 
	    </div>
	</div>
</div>

<!-- --------弹出窗口--------------- -->
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
    </div>
</div>

</body>
</html>
<script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
<script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>

<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="../js/husky.orgTree.js"></script>

<script type="text/javascript" src="../js/husky/husky.common.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
<script type="text/javascript" src="./3101.js"></script>