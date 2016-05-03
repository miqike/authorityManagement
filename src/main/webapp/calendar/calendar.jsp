<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<link rel="stylesheet" type="text/css" href="../css/themes/${theme}/easyui.css">
	<link rel="stylesheet" type="text/css" href="../css/themes/icon.css">
	<link rel='stylesheet' href='../css/cupertino/jquery-ui.min.css' />
	<link rel='stylesheet' href='../css/fullcalendar.css' />
	<link rel='stylesheet' href='../css/fullcalendar.print.css' media='print' />

	<style>

		body {
			margin: 0;
			padding: 0;
			font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
			font-size: 14px;
		}

		#top {
			background: #eee;
			border-bottom: 1px solid #ddd;
			padding: 0 10px;
			line-height: 40px;
			font-size: 12px;
		}

		#calendar {
			max-width: 900px;
			margin: 40px auto;
			padding: 0 10px;
		}

		.title{
			font-size:14px;
			padding:5px;
			overflow:hidden;
			border-bottom:1px solid #ccc;
			height:26px;
		}

		.ui-widget-content a {
			color: white;
		}
	</style>

</head>
<body class="easyui-layout">
<div region="north" class="title" border="false" >
	<%--<div style="margin-top:5px;margin-left:10px;">欢迎使用非税收入收缴管理系统</div>--%>
</div>
<div region="center" border="false">
	<div id='calendar'></div>
</div>

<div id="taskWindow" class="easyui-window" title="日程信息"
	 data-options="modal:true,closed:true,iconCls:'icon-search'"
	 style="width: 700px; height: 340px; padding: 10px;">
	<div style="display : none">
		计划主键<input type="hidden" id="p_id"  />
		计划主键<input type="hidden" id="p_isDeptPlan"  />
		计划拥有者<input type="hidden" id="p_authorId" />
		计划负责人<input type="hidden" id="p_superintendentId" />
		计划拥有单位ID<input type="hidden" id="p_ownDeptId"  />
		计划拥有单位名称<input type="hidden" id="p_ownDeptName" />
		计划创建者ID<input type="hidden" id="p_ownerId"  />
		计划审批者ID<input type="hidden" id="p_approverId" />
		上级计划主键<input type="hidden" id="p_parentId" />
		上级计划名称<input type="hidden" id="p_parentName" />
		责任部门ID<input type="hidden" id="p_superintendDeptId" />
		核实人ID<input type="hidden" id="p_verifierId" />
		核实人ID<input type="hidden" id="p_weightPer" />
	</div>

	<a href="#" id="btnApprove" class="easyui-linkbutton" iconCls="icon2 r12_c19" plain="true" disabled="true">审批</a>
	<a href="#" id="btnStart" class="easyui-linkbutton" iconCls="icon2 r6_c13" plain="true" disabled="true">开始</a>
	<a href="#" id="btnPause" class="easyui-linkbutton" iconCls="icon2 r6_c16" plain="true" disabled="true">暂停</a>
	<a href="#" id="btnStop" class="easyui-linkbutton" iconCls="icon2 r7_c8" plain="true" disabled="true">终止</a>
	<a href="#" id="btnProgress" class="easyui-linkbutton" iconCls="icon-edit" plain="true" disabled="true">进度</a>
	<a href="#" id="btnComplete" class="easyui-linkbutton" iconCls="icon-ok" plain="true" disabled="true">完成</a>
	<a href="#" id="btnVerify" class="easyui-linkbutton" iconCls="icon-verify" plain="true" disabled="true">核实</a>
	<a href="#" id="btnEstimate" class="easyui-linkbutton" iconCls="icon2 r24_c2" plain="true" disabled="true">评价</a>
	<a href="#" id="btnDelete" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled="true">删除</a>
	<a href="#" id="btnSave" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
	<a href="#" id="btnCancel" class="easyui-linkbutton" iconCls="icon-undo"  plain="true">返回</a>

	<table style="padding-top:5px" id="planTable">
		<tr>
			<td style="text-align:right">编号</td>
			<td><input class="easyui-textbox" id="p_sn" style="width: 50px" data-options="readonly:true"/></td>
			<td style="text-align:right">计划名称</td>
			<td colspan="5"><input class="easyui-textbox" id="p_title" name="title" style="width: 418px" data-options="readonly:true"/></td>
		</tr>
		<tr>
			<td style="text-align:right">目标/要求</td>
			<td colspan="7">
				<input class="easyui-textbox" id="p_description"  style="width: 575px"  data-options="readonly:true"/>
			</td>
		</tr>
		<tr>
			<td style="text-align:right">重要程度</td>
			<td><input class="easyui-combobox" id="p_importance" name="importance" codeName="jhzycd" style="width: 100px" data-options="readonly:true,panelHeight:100"/></td>
			<td style="text-align:right">紧急程度</td>
			<td><input class="easyui-combobox" id="p_instancy" name="instancy" codeName="jhjjcd" style="width: 100px" data-options="readonly:true,panelHeight:100"/></td>
			<td style="text-align:right">状态</td>
			<td><input class="easyui-combobox" id="p_status" name="status" codeName="planStatus" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">进度</td>
			<td ><div class="husky-progressbar" id="p_progress" name="progress" style="width: 100px" editable="false" /></td></tr>

		</tr>
		<tr>
			<td style="text-align:right">责任人</td>
			<td><input class="easyui-textbox" id="p_superintendentName" style="width: 100px"
					   data-options="readonly:true"/></td>
			<td style="text-align:right">执行人</td>
			<td><input class="easyui-textbox" id="p_ownerName" style="width: 100px"
					   data-options="readonly:true"/></td>

			<td style="text-align:right">协助人</td>
			<td><input class="easyui-textbox" id="p_coupler" style="width: 100px"
					   data-options="readonly:true"/></td>
			<td style="text-align:right">权重</td>
			<td>
				<input class="easyui-numberbox" id="p_weight" style="width: 100px"
					   data-options="readonly:true"/>
			</td>
		</tr>
		<tr>
			<td style="text-align:right">责任部门</td>
			<td colspan="3"><input class="easyui-textbox" id="p_superintendDeptName" style="width: 258px"
								   data-options="readonly:true"/></td>
			<td style="text-align:right">协助部门</td>
			<td colspan="3"><input class="easyui-textbox" id="p_coupleDept" style="width: 258px"
								   data-options="readonly:true"/></td>
		</tr>
		<tr>
			<td style="text-align:right">任务来源</td>
			<td><input class="easyui-combobox" id="p_isAssigned" style="width: 100px" codeName="isAssigned" data-options="readonly:true,panelHeight:60" /></td>
			<td style="text-align:right">需要核实</td>
			<td><input class="easyui-combobox" id="p_needVerify" name="end" style="width: 100px" codeName="needVerify" data-options="readonly:true,panelHeight:60" /></td>
			<td style="text-align:right">核实人</td>
			<td><input class="easyui-textbox" id="p_verifierName" name="startAct" style="width: 100px" data-options="readonly:true"/></td>
		</tr>
		<tr>
			<td style="text-align:right">开始时间</td>
			<td><input class="easyui-datebox" id="p_start" name="start" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">结束时间</td>
			<td><input class="easyui-datebox" id="p_end" name="end" style="width: 100px" data-options="readonly:true" validType="laterThan['p_start']" invalidMessage="结束时间必须晚于开始时间" /></td>
			<td style="text-align:right">实际开始</td>
			<td><input class="easyui-datebox" id="p_startAct" name="startAct" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">实际结束</td>
			<td><input class="easyui-datebox" id="p_endAct" name="endAct" style="width: 100px" data-options="readonly:true"/></td>
		</tr>
		<tr>
			<td style="text-align:right">创建人</td>
			<td><input class="easyui-textbox" id="p_authorName" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">创建时间</td>
			<td><input class="easyui-datebox" id="p_createTime" name="createTime" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">审批人</td>
			<td><input class="easyui-textbox" id="p_approverName" name="approverId" style="width: 100px" data-options="readonly:true"/></td>
			<td style="text-align:right">审批时间</td>
			<td><input class="easyui-datebox" id="p_approveTime" style="width: 100px" data-options="readonly:true"/></td>
		</tr>
		<tr>
			<td style="text-align:right">质量自评</td>
			<td><input class="easyui-combobox" id="p_selfQualityEstimate" style="width: 100px" data-options="readonly:true" codeName="qualityEstimate"/></td>
			<td style="text-align:right">时效自评</td>
			<td><input class="easyui-combobox" id="p_selfEffectiveEstimate" style="width: 100px" data-options="readonly:true" codeName="effectiveEstimate"/></td>
			<td style="text-align:right">质量</td>
			<td><input class="easyui-combobox" id="p_qualityEstimate" style="width: 100px" data-options="readonly:true" codeName="qualityEstimate"/></td>
			<td style="text-align:right">时效</td>
			<td><input class="easyui-combobox" id="p_effectiveEstimate" style="width: 100px" data-options="readonly:true" codeName="effectiveEstimate"/></td>
		</tr>
		<tr>
			<td colspan="8" align="center">
			</td>
		</tr>
	</table>
</div>

<div id="progressWindow"  class="easyui-window" title="日程进度信息"
	 data-options="modal:true,closed:true,iconCls:'icon-search'"
	 style="width: 200px; height: 100px; padding: 10px;">
	<input class="easyui-numberspinner" id="k_progress" style="width: 100px" data-options="min:1,max:100,editable:true,required:true" />
	<a href="#" id="btnSaveProgress" class="easyui-linkbutton" iconCls="icon-edit" plain="true">确定</a>
</div>

</body>
</html>

<div id="tabsMenu" style="width: 120px;">
	<div name="reload" data-options="iconCls:'icon-reload'">刷新</div>
	<div name="close" data-options="iconCls:'icon-cancel'">关闭</div>
	<div name="other">关闭其他</div>
	<div name="all">关闭所有</div>
</div>

<script type="text/javascript" src="../js/hotkeys.min.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../js/formatter.js"></script>
<script type="text/javascript" src="../js/husky.common.js"></script>
<script type="text/javascript" src="../js/husky.easyui.extend.js"></script>
<script type="text/javascript" src="../js/husky.easyui.codeList.js"></script>

<%--<script src='../js/moment.js'></script>--%>
<script src='../js/moment.min.js'></script>
<script src='../js/fullcalendar.min.js'></script>
<script src='../js/fullcalendar_zh-cn.js'></script>
<script src="../plan/functionArray.js"></script>
<script src='./calendar.js'></script>
