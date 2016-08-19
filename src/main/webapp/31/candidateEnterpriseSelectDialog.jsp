<%@ page contentType="text/html; charset=UTF-8"%>
<script>
function checkParam(param) {
	return param.hcjhId != undefined;
}

function doCandidateEnterpriseSelectDialogInit() {
	//$("#btnQueryCandidateEnterprise").click(queryCandidateEnterprise);
	//$("#btnResetCandidateEnterpriseQuery").click(resetCandidateEnterpriseQuery);
	//loadCandidateEnterpriseGrid();
}

function loadCandidateEnterpriseGrid() {
	/* $("#f_qymc").val('');
    $("#f_zch").val('');
    $("#f_lrrq_a").datebox('clear');
    $("#f_lrrq_b").datebox('clear'); */
    queryCandidateEnterprise();
}

function resetCandidateEnterpriseQuery() {
	$("#f_qymc").val('');
    $("#f_zch").val('');
    $("#f_lrrq_a").datebox('clear');
    $("#f_lrrq_b").datebox('clear');
}

function queryCandidateEnterprise() {
	var queryParams = {
		hcjhId:$("#k_id").val(),
		qymc: $("#f_qymc").val(),
        zch: $("#f_zch").val(),
        lrrq_a: $("#f_lrrq_a").datebox('getValue'),
        lrrq_b: $("#f_lrrq_b").datebox('getValue')
	}
	if(queryParams.qymc == "" && queryParams.zch== "") {
		$.messager.alert("操作提示", "必须输入企业名称或者注册号进行查询")
	} else {
		$('#candidateEnterpriseGrid').datagrid("load", queryParams);
	}
}

function addEnterprise() {
	var rows = $('#candidateEnterpriseGrid').datagrid('getSelections');
	if(rows.length > 0) {
		var param = new Array();
		$.each(rows, function(idx, elem) {
			param.push(elem.zch);
		});
		 $.ajax({
			url:"../31/hcjh/addEnterprise/" +$("#k_id").val(),
			data:JSON.stringify(param),
			type:"put",
			contentType: "application/json; charset=utf-8",
			cache:false,
			success: function(response) {
				if(response.status == $.husky.SUCCESS) {
					$.messager.show("操作提醒", "添加核查单位成功", "info", "bottomRight");
					$("#grid1").datagrid("reload");
					$("#grid3b").datagrid("reload");;
					loadCandidateEnterpriseGrid();
				} else {
					$.messager.alert("错误", "添加核查单位失败");
				}
			}
		}); 
	} else {
		$.messager.alert("操作提醒", "请首先选择需要核查的企业");
	}
}

function candidateEnterpriseGridLoadSucessHandler(data) {
	if(data.rows.length == 0) {
		$.messager.alert("操作提示", "业务系统尚未推送列入经营异常名录的企业或名单中没有您可访问的数据,请到业务系统中确认");
	}
}

</script>

<div id="candidateEnterpriseSelectDialog" >
	<div style="margin-bottom: 3px; margin-top: 5px;">
		<table>
			<tr>
				<td style="text-align:right" >企业名称</td><td><input id="f_qymc" class="easyui-validatebox"/></td>
				<td style="text-align:right">统一信用代码</td><td><input id="f_zch" class="easyui-validatebox"/></td>
			</tr>
			<tr>
				<td style="text-align:right">举报或列入经营异常起始日</td><td> <input id="f_lrrq_a" class="easyui-datebox" /></td>
				<td style="text-align:right">终止日</td><td><input id="f_lrrq_b" class="easyui-datebox" /></td>
				<td>
					<a href="javascript:void(0);" id="btnQueryCandidateEnterprise" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a> 
					<a href="javascript:void(0);" id="btnResetCandidateEnterpriseQuery" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
				</td>
			</tr>
			
		</table>
	</div>
    <table id="candidateEnterpriseGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,ctrlSelect:true, method:'get',fit:false,pagination:true, pageSize:100,height:505,onBeforeLoad:checkParam,
           url:'../common/query?mapper=hcrwRcMapper&queryName=selectExclude',onLoadSuccess:candidateEnterpriseGridLoadSucessHandler" >
        <thead>
        <tr>
            <th data-options="field:'nbxh',halign:'center',align:'center'" width="106">企业内部序号</th>
            <th data-options="field:'zch',halign:'center',align:'center'" width="106">统一信用代码</th>
            <th data-options="field:'qymc',halign:'center',align:'left'" width="200">名称</th>
            <th data-options="field:'fddbr',halign:'center',align:'center'" width="70">法人</th>
            <th data-options="field:'qylxdl',halign:'center',align:'center'" width="106" codeName="qylxdl" formatter="formatCodeList">类型大类</th>
            <th data-options="field:'djjgMc',halign:'center',align:'left'" width="80">登记机构</th>
            <th data-options="field:'gxdwMc',halign:'center',align:'center'" width="80">管辖单位</th>
            <th data-options="field:'qyzzxs',halign:'center',align:'center'" width="106" codeName="zzxs" formatter="formatCodeList">组织形式</th>
            <th data-options="field:'jdjgMc',halign:'center',align:'left'" width="80">做出决定机关</th>
            <th data-options="field:'lrrq',halign:'center',align:'center'" width="80" formatter="formatDate">列入日期</th>
            <th data-options="field:'lrsy',halign:'center',align:'center'" width="106">列入事由</th>
                
        </tr>
        </thead>
    </table>
</div>

