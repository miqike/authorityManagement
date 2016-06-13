<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function wjlyStyler(val,row,index) {
		if(val == 1) {
			return "background-color:lightgreen";
		} else {
			return "background-color:orange";
		}
	}
	
	function funcAddComment() {
		$.easyui.showDialog({
    		title : "修改常见问题说明信息",
    		width : 600,
    		height : 200,
    		topMost : false,
    		enableSaveButton : true,
    		enableApplyButton : false,
    		closeButtonText : "返回",
    		closeButtonIconCls : "icon-undo",
    		href : "./commentForm.jsp",
    		onLoad : function() {
    			doInit();
    		},
    		onSave: function (d) {
    			funcSaveComment();
            }
    	});
	}

	function funcRemoveComment () {
		if(!$(this).linkbutton('options').disabled) {
			var row = $('#commentGrid').datagrid('getSelected');
			if (row) {
				$.messager.confirm('确认', '确认删除检查材料', function (r) {
					if (r) {
						$.ajax({
					        url: "./comment/" + row.id ,
					        type: 'DELETE',
					        success: function (response) {
					            if (response.status == SUCCESS) {
					            	$('#commentGrid').datagrid('reload');
					                
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
	
	
	function commentGridClickRowHandler() {
		if($('#commentGrid').datagrid('getSelected') != null) {
			$('#btnRemoveComment').linkbutton('enable');
		} else {
			$('#btnRemoveComment').linkbutton('disable');
		}
	}
	
	function loadCommentGrid(hcsxId) {
		$.getJSON("../common/query?mapper=auditItemCommentMapper&queryName=queryForAuditItem",  {hcsxId:hcsxId}, function(response) {
			$("#commentGrid").datagrid().datagrid("loadData", response);
		});
	}
</script>

<div style="height: 345px">
    <div style="padding:5px;">
        <span>抽检事项:</span>
        <span style="color:blue; " id="_name_comment_"></span>
    </div>
    <table id="commentGrid" class="easyui-datagrid" 
           data-options="collapsible:true,fit:true,
           		singleSelect:true,width:680,
           		onClickRow:commentGridClickRowHandler,
				ctrlSelect:false,method:'get',
				toolbar: '#commentGridToolbar'">
        <thead>
        <tr>
            <th data-options="field:'content',halign:'center',align:'left'" sortable="true" width="650">常见问题说明</th>
            <th data-options="field:'weight',halign:'center',align:'center'" sortable="true" width="80">排序权重</th>
        </tr>
        </thead>
    </table>

</div>
<div id="commentGridToolbar">
    <a href="#" id="btnAddComment" class="easyui-linkbutton" iconCls="icon-add" plain="true" >新增</a>
    <a href="#" id="btnRemoveComment" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>
