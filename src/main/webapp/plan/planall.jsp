<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>计划建立分解</title>
	<link href="../css/content.css" rel="stylesheet"/>
	<link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
	<link href="../css/themes/icon.css" rel="stylesheet"/>
	<link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">

	<script type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>

	<script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="../js/husky.common.js"></script>
	<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>
	<script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
	<script type="text/javascript" src="../js/husky.jquery.ztree.js"></script>
	<script type="text/javascript" src="../js/formatter.js"></script>

	<script type="text/javascript" src="planall.js"></script>
	<style type="text/css">

		#west div.panel-header {
			border-width:0px 1px 1px 0px;
		}

		#west div.panel-body {
			border-width:0px 1px 1px 0px;
		}

		#tabPanel>div {
			border:0px;
		}

		#tabPanel div.datagrid-wrap {
			border: 0px;
		}

		#popWindowFa01 div.datagrid-wrap {
			border-width:1px 0px 0px 0px;
		}

		#popWindowBi01 div.datagrid-wrap {
			border:0px;
		}
	</style>
</head>
<body style="padding:5px;">
<div class="easyui-layout" style="height:650px;">
	<div id="west" data-options="region:'west',split:false" title="" style="width:400px;">
		<ul id="tree" class="ztree"></ul>
	</div>
	<div data-options="region:'center',title:''" >
        <div title="基本信息" style="padding:5px;" selected="true">
            <a href="#" id="btnAdd" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加计划</a>
            <a href="#" id="btnAddChild" class="easyui-linkbutton" iconCls="icon-add" plain="true" >分解计划</a>
            <a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true" >保存</a>
            <a href="#" id="btnCancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" >取消</a>
            <a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
            <a href="#" id="btnAudit" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" >审核/取消审核</a>
            <form action="" id="planForm" method="post">
                <div style="display : none">
                    计划主键<input class="easyui-textbox" id="f_id" name="id" />
                    计划拥有者<input class="easyui-textbox" id="f_authorName" name="authorName" />
                    计划拥有单位ID<input class="easyui-textbox" id="f_deptId" name="deptId" />
                    计划拥有单位名称<input class="easyui-textbox" id="f_deptName" name="deptName" />
                    计划创建时间<input class="easyui-datebox" id="f_createTime" name="createTime" />
                    计划创建者ID<input class="easyui-textbox" id="f_ownerName" name="ownerName" />
                    计划审批者ID<input class="easyui-textbox" id="f_approverName" name="approverName" />
                    上级计划主键<input class="easyui-textbox" id="f_parentId" name="parentId" />
                    上级计划名称<input class="easyui-textbox" id="f_parentName" name="parentName" />
                </div>
                <table style="padding-top:5px">
                    <tr>
                        <td style="text-align:right">计划名称</td>
                        <td colspan="3"><input class="easyui-textbox" id="f_title" name="title" style="width: 483px" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">计划类别</td>
                        <td><input class="easyui-combobox" id="f_isDeptPlan" name="isDeptPlan" codeName="jhlb" style="width: 200px" data-options="required:true"/></td>
                        <td style="text-align:right">计划类型</td>
                        <td><input class="easyui-combobox" id="f_isAnnualPlan" name="isAnnualPlan" codeName="jhlx" style="width: 200px" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">创建者</td>
                        <td><input class="easyui-combobox" id="f_authorId" name="authorId" style="width: 200px" data-options="required:true"/></td>
                        <td style="text-align:right">拥有者</td>
                        <td><input class="easyui-combobox" id="f_ownerId" name="ownerId" style="width: 200px" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">审批者名称</td>
                        <td><input class="easyui-combobox" id="f_approverId" name="approverId" style="width: 200px" data-options="required:true"/></td>
                        <td style="text-align:right">通过时间</td>
                        <td><input class="easyui-datebox" id="f_approveTime" name="approveTime" style="width: 200px" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">计划周期</td>
                        <td><input class="easyui-textbox" id="f_cycle" name="cycle" style="width: 200px" data-options="required:true"></td>
                        <td style="text-align:right">计划状态</td>
                        <td><input class="easyui-combobox" id="f_status" name="status" codeName="jhzt" style="width: 200px" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">重要程度</td>
                        <td><input class="easyui-combobox" id="f_importance" name="importance" codeName="jhzycd" style="width: 200px" data-options="required:true"/></td>
                        <td style="text-align:right">紧急程度</td>
                        <td><input class="easyui-combobox" id="f_instancy" name="instancy" codeName="jhjjcd" style="width: 200px" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">计划开始时间</td>
                        <td><input class="easyui-datebox" id="f_start" name="start" style="width: 200px" /></td>
                        <td style="text-align:right">计划结束时间</td>
                        <td><input class="easyui-datebox" id="f_end" name="end" style="width: 200px" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">核实</td>
                        <td><input class="easyui-combobox" id="f_needVerify" name="needVerify" codeName="jhhs" style="width: 200px" data-options="required:true"/></td>
                        <td style="text-align:right">核实者</td>
                        <td><input class="easyui-textbox" id="f_verifier" name="verifier" style="width: 200px" /></td>
                    </tr>
                    <tr>
                        <td style="text-align:right">计划描述</td>
                        <td ><input class="easyui-textbox" id="f_descript" name="descript" style="width: 200px" /></td>
                        <td style="text-align:right">计划进度</td>
                        <td ><input class="easyui-textbox" id="f_progress" name="progress" style="width: 200px" data-options="required:true" /></td>
                    </tr>
                </table>
            </form>
        </div>
	</div>
</div>

<!--弹出层-->

</body>
</html>
