<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function wjlyStyler(val,row,index) {
		if(val == 1) {
			return "background-color:lightgreen";
		} else {
			return "background-color:orange";
		}
	}
	
	function funcAddDoc() {
		/* <div id="addDocWindow" class="easyui-window" title="检查材料"
		     data-options="modal:true,closed:true,iconCls:'icon2 r16_c14'"
		     style="width: 300px; height: 200px; padding: 10px;">
		    
		</div>
		 */
		$.easyui.showDialog({
    		title : "修改抽检事项信息",
    		width : 300,
    		height : 200,
    		topMost : false,
    		enableSaveButton : true,
    		enableApplyButton : false,
    		closeButtonText : "返回",
    		closeButtonIconCls : "icon-undo",
    		href : "./docForm.jsp",
    		onLoad : function() {
    			doInit();
    		},
    		onSave: function (d) {
    			funcSaveDoc();
            }
    	});
	}

	function funcRemoveDoc () {
		if(!$(this).linkbutton('options').disabled) {
			var row = $('#docGrid').datagrid('getSelected');
			if (row) {
				$.messager.confirm('确认', '确认删除检查材料', function (r) {
					if (r) {
						$.ajax({
					        url: "./hccl/" + row.id ,
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
				});
			}
		}
	}
	
	function doDocListInit() {
		$("#btnAddDoc").click(funcAddDoc); 
		$("#btnRemoveDoc").click(funcRemoveDoc); 
		var auditItem = $("#mainGrid").datagrid("getSelected");
		$("#_name_").text(auditItem.name);
		loadDocGrid(auditItem.id);
	}
	
	function docGridClickRowHandler() {
		if($('#docGrid').datagrid('getSelected') != null) {
			$('#btnRemoveDoc').linkbutton('enable');
		} else {
			$('#btnRemoveDoc').linkbutton('disable');
		}
	}
	
	function loadDocGrid(hcsxId) {
		/* $.getJSON("../common/query?mapper=hcclMapper&queryName=queryForAuditItem",  {hcsxId:hcsxId}, function(response) {
			$("#docGrid").datagrid().datagrid("loadData", response);
		}); */
	}
</script>

<div style="height: 345px">
    <div style="padding:5px;">
        <span>抽检事项:</span>
        <span style="color:blue; " id="_name_"></span>
    </div>
    <table id="commentGrid" class="easyui-datagrid" 
           data-options="collapsible:true,fit:true,
           		singleSelect:true,width:680,
           		onClickRow:docGridClickRowHandler,
				ctrlSelect:false,method:'get',
				toolbar: '#docGridToolbar'">
        <thead>
        <tr>
            <!-- <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="120">序号</th> -->
            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="150">材料名称</th>
            <th data-options="field:'sfbyx',halign:'center',align:'center'" sortable="true" width="80"codeName="yesno" formatter="formatCodeList">是否必要项</th>
            <th data-options="field:'wjlx',halign:'center',align:'center'" sortable="true" width="100" codeName="wjlx" formatter="formatCodeList">文件类型</th>
            <th data-options="field:'yhtg',halign:'center',align:'center'" sortable="true" width="80" codeName="yesno" formatter="formatCodeList">是否用户提供</th>
                
        </tr>
        </thead>
    </table>

</div>
<div id="commentGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon-add" plain="true" >新增</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>
