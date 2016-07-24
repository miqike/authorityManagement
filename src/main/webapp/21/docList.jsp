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
        $("#docGrid").datagrid("clearSelections");
		$.easyui.showDialog({
    		title : "修改抽检事项信息",
    		width : 400,
    		height : 280,
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
    function funcModifyDoc() {
        var doc=$("#docGrid").datagrid("getSelected");
        if(null!=doc) {
            $.easyui.showDialog({
                title: "修改抽检事项信息",
                width: 400,
                height: 280,
                topMost: false,
                enableSaveButton: true,
                enableApplyButton: false,
                closeButtonText: "返回",
                closeButtonIconCls: "icon-undo",
                href: "./docForm.jsp",
                onLoad: function () {
                    doInit();
                },
                onSave: function (d) {
                    funcSaveDoc();
                }
            });
        }else{
            $.messager.show({
                title: '提示',
                msg: "请选择要修改的数据！"
            });
        }
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
					            	var auditItem = $("#mainGrid").datagrid("getSelected");
					            	var rowIndex = $("#mainGrid").datagrid("getRowIndex", auditItem);
					            	loadDocGrid(auditItem.id);
					        		$('#mainGrid').datagrid('reload');
					            	setTimeout(function() {$("#mainGrid").datagrid("selectRow", rowIndex);}, 1000);
					        		//TODO
					        		$.messager.show("操作提醒", "文件已删除", "info", "bottomRight");
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
		$("#btnModifyDoc").click(funcModifyDoc);
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
		$.getJSON("../common/query?mapper=hcclMapper&queryName=queryForAuditItem",  {hcsxId:hcsxId}, function(response) {
			$("#docGrid").datagrid().datagrid("loadData", response);
		});
	}
</script>

<div style="height: 345px">
    <div style="padding:5px;">
        <span>抽检事项:</span>
        <span style="color:blue; " id="_name_"></span>
    </div>
    <table id="docGrid" class="easyui-datagrid" 
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
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon-add" plain="true" >新增</a>
    <a href="#" id="btnModifyDoc" class="easyui-linkbutton" iconCls="icon-add" plain="true" >修改</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>
