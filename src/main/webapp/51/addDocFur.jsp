<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function formatDocOperation(val, row) {
		if(row.mongoId != null && row.mongoId != undefined) {
			return "<a href=\"javascript: displayAttachment('"+ row.mongoId + "');\">查看</a>";
		} else {
			return "";
		}
	}
	
	function addDocFur() {
 		
		$.easyui.showDialog({
 			iniframe: false,
    		title: "附加检查材料",
    		width: 550,
    		height: 275,
    		topMost: false,
    		iconCls:'icon2 r16_c14',
    		enableSaveButton: true,
    		saveButtonText: "保存",
    		enableApplyButton: false,
    		closeButtonText: "返回",
    		closeButtonIconCls: "icon-undo",
    		href: "./docFurForm.jsp",
    		onLoad: function() {
    			doInitDocFurForm();
    		},
    		onSave: function() {
    			return doSaveDocFur();
    		}
    	});
	}
	
	function displayAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../display?mongoId=" + mongoId + "'/>") .appendTo("body");
	}

	function downloadAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../download?mongoId=" + mongoId + "'/>") .appendTo("body");
	}
	
	function removeDocFur () {
		var row = $('#docFurGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认', '确认删除检查材料', function (r) {
				if (r) {
					deleteDocFur(row.id);
				}
			});
		}
	}

	function deleteDocFur(docFurId) {
	    $.ajax({
	        url: "./docFur/" + docFurId ,
	        type: 'DELETE',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	            	$('#docFurGrid').datagrid('reload');
	                $.messager.show('操作提示',"文件已删除", "info", "bottomRight");
	            } else {
	                $.messager.alert('错误', '文件删除失败：' + response.message, 'error');
	            }
	        }
	    });
	}

	function doDocFurListInit() {
		$("#docFurGrid").datagrid("load", {hcrwId:$('#grid1').datagrid('getSelected').id}); 
	}
	
	function docFurGridClickRowHandler() {
		if($('#docFurGrid').datagrid('getSelected') != null) {
			$('#btnRemoveDocFur').linkbutton('enable');
		} else {
			$('#btnRemoveDocFur').linkbutton('disable');
		}
	}
	
	function checkParam(param) {
		return param.hcrwId != undefined;
	}
</script>

<div style="padding:5px 5px 0px 5px;">
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    <table id="docFurGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,
           		singleSelect:true,height:325,width:680,
           		onClickRow:docFurGridClickRowHandler,
				ctrlSelect:false,method:'get',
				toolbar: '#docFurGridToolbar',
				url:'../common/query?mapper=hcclmxMapper&queryName=queryDocFurForTask',
				onBeforeLoad:checkParam,
           		pageSize: 100, pagination: true">
        <thead>
        <tr>
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="110">名称</th>
            <th data-options="field:'hcsxmc',halign:'center',align:'left'" sortable="true" width="100">检查事项</th>
            <th data-options="field:'uploadTime',halign:'center',align:'left'" sortable="true" width="110" formatter="formatDatetime2Min">上传时间</th>
            <th data-options="field:'wjlx',halign:'center',align:'center'" sortable="true" width="70" codeName="wjlx" formatter="formatCodeList">文件类型</th>
            <th data-options="field:'sfbyx',halign:'center',align:'center'" sortable="true" width="70" codeName="yesno" formatter="formatCodeList">是否必要项</th>
            <th data-options="field:'id',halign:'center',align:'left'" sortable="true" width="70" formatter="formatDocOperation">显示</th>
        </tr>
        </thead>
    </table>

</div>
<div id="docFurGridToolbar">
    <a href="#" id="btnAddDocFur" class="easyui-linkbutton" iconCls="icon-add" plain="true" >增加</a>
    <a href="#" id="btnRemoveDocFur" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>

