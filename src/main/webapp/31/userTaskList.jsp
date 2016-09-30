<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function formatZfry(val, row) {
	var result = row.zfryName1 == null? "": row.zfryName1;
	if(row.zfryName2 != null) {
		result =  result + "/" + row.zfryName2;
	}
    return result;
}

function taskStatusStyler(val, row, index) {
	if (val == 1) {
		return "background-color:lightgray";
    } else if (val == 2) {
        return "background-color:orange";
    } else if (val == 3) {
        return "background-color:pink";
    } else if (val == 4) {
        return "background-color:red";
    } else if (val == 5) {
        return "background-color:green";
    }
}
	
function doUserTaskListInit() {
	var hcrwTj = $('#grid2').datagrid('getSelected');
	var grid4Options = $("#grid4").datagrid("options");
    grid4Options.url = '../common/query?mapper=hcrwMapper&queryName=queryForPlanAndAuditor&hcjhId=' + hcrwTj.hcjhId + '&zfryCode=' + hcrwTj.zfryCode;
}


function grid4DblClickHandler(index, row) {
    window.selected = index;
    $('#grid4').datagrid('unselectAll').datagrid('selectRow', window.selected);
    var hcrw = $('#grid4').datagrid('getSelected');
    $.easyui.showDialog({
		title : "检查事项 - " + hcrw.hcdwName,
		width : 590,
		height : 320,
		topMost : false,
		iconCls:'icon2 r16_c14',
		enableSaveButton : false,
		enableApplyButton : false,
		closeButtonText : "返回",
		closeButtonIconCls : "icon-undo",
		href : "./auditItemLista.jsp",
		onLoad : function() {
			doAuditItemListInit();
		}
	});
}


</script>
<div id="userTaskListWindow"  style="padding: 5px;">
    <table id="grid4"
           class="easyui-datagrid"
           data-options="
               singleSelect:true,
               collapsible:true,
               selectOnCheck:false,
               method:'get',
               onDblClickRow:grid4DblClickHandler,
               checkOnSelect:false"
           style="height: 328px">
        <thead>
        <tr>
            <!-- <th data-options="field:'planType', halign:'center',align:'left'" codeName="planType" formatter="formatCodeList" width="70" align="center" >计划类型</th>
            <th data-options="field:'jhbh', halign:'center',align:'left'" width="70" align="center" >计划编号</th>
            <th data-options="field:'jhmc', halign:'center',align:'left'" width="100" align="center" >计划名称</th> -->
            <th data-options="field:'rwzt', halign:'center',align:'center'" width="70" codeName="rwzt" formatter="formatCodeList" styler="taskStatusStyler">任务状态</th>
            <th data-options="field:'hcdwXydm', halign:'center',align:'center'" width="140" >统一社会信用代码</th>
            <th data-options="field:'hcdwName', halign:'center',align:'left'" width="200" >被检单位名称</th>
            <th data-options="field:'djjgmc', halign:'center',align:'left'" width="100" >登记机关</th>
            <th data-options="field:'hcjgmc', halign:'center',align:'left'" width="100" >检查机关</th>
            <th data-options="field:'zfryCode1', halign:'center',align:'center'" width="100" formatter="formatZfry">检查人员</th>
            <th data-options="field:'jhxdrq', halign:'center',align:'center'" width="70" formatter="formatDate">下达时间</th>
            <th data-options="field:'jhwcrq', halign:'center',align:'center'" width="70" formatter="formatDate">计划结束时间</th>
            <th data-options="field:'rlrq', halign:'center',align:'center'" width="70" formatter="formatDate">认领时间</th>
        </tr>
        </thead>
    </table>
</div>


	