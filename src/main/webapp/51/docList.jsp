<%@ page contentType="text/html; charset=UTF-8"%>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script>
<script>
	function formatDocOperation(val, row) {
		return "<a href=\"javascript: displayAttachment('"+ row.mongoId + "');\">查看</a>";
	}
	
	function wjlyStyler(val,row,index) {
		if(val == 1) {
			return "background-color:lightgreen";
		} else {
			return "background-color:orange";
		}
	}
	
	function funcAddDoc() {
	 	if (!$(this).linkbutton('options').disabled) {
	 		$.easyui.showDialog({
	 			iniframe: false,
	    		title: "上传检查材料",
	    		width: 550,
	    		height: 275,
	    		topMost: false,
	    		iconCls:'icon2 r16_c14',
	    		enableSaveButton: true,
	    		saveButtonText: "保存",
	    		enableApplyButton: false,
	    		closeButtonText: "返回",
	    		closeButtonIconCls: "icon-undo",
	    		href: "./docForm.jsp",
	    		onLoad: function() {
	    			doInitDocForm();
	    		},
	    		onSave: function() {
	    			return doSaveDoc();
	    		}
	    	});
	    }
	}
	
	
	function funcRemoveDoc () {
		if(!$(this).linkbutton('options').disabled) {
			var row = $('#docGrid').datagrid('getSelected');
			if (row) {
				$.messager.confirm('确认', '确认删除检查材料', function (r) {
					if (r) {
						deleteAttachment(row.id);
					}
				});
			}
		}
	}
	
	function displayAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../display?mongoId=" + mongoId + "'/>") .appendTo("body");
	}

	function downloadAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../download?mongoId=" + mongoId + "'/>") .appendTo("body");
	}

	function deleteAttachment(hcclmxId) {
	    $.ajax({
	        url: "./hcclmx/" + hcclmxId ,
	        type: 'DELETE',
	        success: function (response) {
	            if (response.status == SUCCESS) {
	            	$('#docGrid').datagrid('reload');
	                
	                $.messager.show({
	                    title: '提示',
	                    msg: "文件已删除"
	                });
	            } else {
	                $.messager.alert('错误', '文件删除失败：' + response.message, 'error');
	            }
	        }
	    });
	}
	
	function doDocListInit() {
		$("#btnAddDoc").click(funcAddDoc); 
		$("#btnRemoveDoc").click(funcRemoveDoc); 
		
		var hcrw = $("#grid1").datagrid("getSelected");
		var hcsx = getAuditItem();
		$("#docGrid").datagrid({ 
			url:'../common/query?mapper=hcclmxMapper&queryName=queryForTask',
			queryParams: {hcrwId:hcrw.id}
		});
	}
	
	function docGridClickRowHandler() {
		if($('#docGrid').datagrid('getSelected') != null) {
			$('#btnRemoveDoc').linkbutton('enable');
		} else {
			$('#btnRemoveDoc').linkbutton('disable');
		}
	}
	
</script>

<div style="padding:10px 10px 0px 10px;">
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    <table id="docGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,
           		singleSelect:true,height:325,width:680,
           		onClickRow:docGridClickRowHandler,
				ctrlSelect:false,method:'get',
				toolbar: '#docGridToolbar',
           		pageSize: 20, pagination: true">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="110">名称</th>
            <th data-options="field:'ly',halign:'center',align:'center'" sortable="true" width="80" codeName="wjly" formatter="formatCodeList" styler="wjlyStyler">分类</th>
            <th data-options="field:'hcsxmc',halign:'center',align:'left'" sortable="true" width="100">检查事项</th>
            <th data-options="field:'uploadTime',halign:'center',align:'left'" sortable="true" width="110" formatter="formatDatetime2Min">上传时间</th>
            <th data-options="field:'wjlx',halign:'center',align:'center'" sortable="true" width="70" codeName="wjlx" formatter="formatCodeList">文件类型</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70" formatter="formatDocOperation">显示</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

</div>
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon2 r16_c13" plain="true" >上传</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>

