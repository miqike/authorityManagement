<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function formatDocOperation(val, row) {
		if(row.MONGO_ID != null && row.MONGO_ID != undefined) {
			
			return "<a href=\"javascript: displayAttachment('"+ row.MONGO_ID + "');\">查看</a>";
		} else {
			return "";
		}
	}
	
	function sfbyStyler(val,row,index) {
		if(val == 1) {
			return "background-color:lightcoral";
		} else {
			return "background-color:lightgreen";
		}
	}
	
	
	function wjlyStyler(val,row,index) {
		if(val == 1) {
			return "background-color:lightgreen";
		} else {
			return "background-color:orange";
		}
	}
	/* 
	function addDoc() {
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
    		href: "./docForma.jsp",
    		onLoad: function() {
    			doInitDocForm();
    		},
    		onSave: function() {
    			return doSaveDoc();
    		}
    	});
	}
	
	function removeDoc () {
		var row = $('#docGrid').datagrid('getSelected');
		if (row) {
			$.messager.confirm('确认', '确认删除检查材料', function (r) {
				if (r) {
					deleteAttachment(row.id);
				}
			});
		}
	}
	 */
	function displayAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../display?mongoId=" + mongoId + "'/>") .appendTo("body");
	}

	function downloadAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../download?mongoId=" + mongoId + "'/>") .appendTo("body");
	}
/* 
	function deleteAttachment(hcclmxId) {
	    $.ajax({
	        url: "./hcclmx/" + hcclmxId ,
	        type: 'DELETE',
	        success: function (response) {
	            if (response.status == $.husky.SUCCESS) {
	            	doDocListInit();
	                $.messager.show('操作提示', "文件已删除", "info", "bottomRight");
	            } else {
	                $.messager.alert('错误', '文件删除失败：' + response.message, 'error');
	            }
	        }
	    });
	} */
	
	function doDocListInit() {
		var hcrw = $("#grid2").datagrid("getSelected");
		$.getJSON("../common/query?mapper=hcclMapper&queryName=queryForTask",  {
				hcrwId:hcrw.ID
			}, function (response) {
			    if (response.status == $.husky.SUCCESS) {
			    	 $("#docGrid").datagrid("loadData",response);
			    }
			});
		 
	}
	
	function docGridClickRowHandler() {
		/* 
		if($('#docGrid').datagrid('getSelected') != null) {
			$('#btnRemoveDoc').linkbutton('enable');
		} else {
			$('#btnRemoveDoc').linkbutton('disable');
		} */
	}
	
	$(function () {
		//$.codeListLoader.parse($('#docGrid'))
		doDocListInit();
	});
</script>

<div style="padding:5px 5px 0px 5px;">
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    <table id="docGrid"
           class="easyui-datagrid"
           data-options="collapsible:true,
           		singleSelect:true,height:335,width:695,
           		onClickRow:docGridClickRowHandler,
				ctrlSelect:false,method:'get'">
        <thead>
        <tr>
            <th data-options="field:'HCCL_NAME',halign:'center',align:'left'" sortable="true" width="110">名称</th>
            <th data-options="field:'HCSXMC',halign:'center',align:'left'" sortable="true" width="100">检查事项</th>
            <th data-options="field:'SFBYX',halign:'center',align:'center'" sortable="true" width="70" codeName="yesno" formatter="formatCodeList" styler="sfbyStyler">是否必要项</th>
            <th data-options="field:'WJLX',halign:'center',align:'center'" sortable="true" width="100" codeName="wjlx" formatter="formatCodeList" >文件类型</th>
            <th data-options="field:'YHTG',halign:'center',align:'center'" sortable="true" width="90" codeName="yesno" formatter="formatCodeList" styler="sfbyStyler">是否用户提供</th>
            <th data-options="field:'UPLOAD_TIME',halign:'center',align:'center'" sortable="true" width="110" formatter="formatDatetime2Min">上传时间</th>
            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70" formatter="formatDocOperation">显示</th>
<!-- 
            <th data-options="field:'LY',halign:'center',align:'center'" sortable="true" width="80" codeName="wjly" formatter="formatCodeList" styler="wjlyStyler">分类</th>
            <th data-options="field:'wjlx',halign:'center',align:'center'" sortable="true" width="70" codeName="wjlx" formatter="formatCodeList">文件类型</th>
 -->        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

</div>
<!-- 
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon2 r16_c13" plain="true" >上传</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>
 -->
