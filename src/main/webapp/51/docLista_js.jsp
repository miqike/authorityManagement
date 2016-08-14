<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function formatDocOperation(val, row) {
		if(row.mongoId != null && row.mongoId != undefined) {
			return "<a href=\"javascript: displayAttachment('"+ row.mongoId + "');\">查看</a>";
		} else if(row.MONGO_ID != null && row.MONGO_ID != undefined) {
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
		} else if(val == 2)  {
			return "background-color:orange";
		}
	}
	
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
    		href: "./docForma_js.jsp",
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
	            if (response.status == $.husky.SUCCESS) {
                    doDocListInit();
	                $.messager.show('操作提示', "文件已删除", "info", "bottomRight");
	            } else {
	                $.messager.alert('错误', '文件删除失败：' + response.message, 'error');
	            }
	        }
	    });
	}
	
	function doDocListInit() {
		var hcrw = $("#myTaskGrid").datagrid("getSelected");
        $.getJSON("../common/query?mapper=hcclmxMapper&queryName=queryForTask", {
            hcrwId: hcrw.id
        }, function (response) {
            if (response.status == $.husky.SUCCESS) {
                $("#docGrid").datagrid("loadData", response);
            }
        });

        $.getJSON("../docUpload/" + hcrw.id + "/furtherDocList", function (response) {
            if (response.status == $.husky.SUCCESS) {
                if (response.data.length > 0) {
                    $("#furDocgrid").parent().parent().parent().show()
                    $("#furDocgrid").datagrid("loadData", response.data);
                } else {
                    $("#furDocgrid").parent().parent().parent().hide();
                }
            }
        });
	}
	
	function docGridClickRowHandler() {
		if($('#docGrid').datagrid('getSelected') != null) {
			$('#btnRemoveDoc').linkbutton('enable');
		} else {
			$('#btnRemoveDoc').linkbutton('disable');
		}
	}
	
	$(function () {
        doDocListInit();
	});
</script>

<div style="padding:10px 10px 0px 10px;">
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    
    <div id="tabPanel" class="easyui-tabs" style="width:695px;clear:both;" data-options="">
        <div title="标准核查材料" style="padding:5px;" selected="true">
		    <table id="docGrid"
		           class="easyui-datagrid"
		           data-options="collapsible:true,
		           		singleSelect:true,height:325,width:680,
		           		onClickRow:docGridClickRowHandler,
						ctrlSelect:false,method:'get',
						toolbar: '#docGridToolbar'">
		        <thead>
		        <tr>
		            <th data-options="field:'name',halign:'center',align:'left'" sortable="true" width="110">名称</th>
		            <th data-options="field:'ly',halign:'center',align:'center'" sortable="true" width="80" codeName="wjly" formatter="formatCodeList" styler="wjlyStyler">来源</th>
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
	    <div title="附加核查材料" style="padding:5px;" selected="true">
			<table id="furDocgrid"
		           class="easyui-datagrid"
		           data-options="collapsible:true,
						ctrlSelect:true,method:'get'"
		           pagePosition="bottom">
		        <thead>
		        <tr>
		            <th data-options="field:'NAME',halign:'center',align:'left'" sortable="true" width="110">检查材料名称</th>
		            <th data-options="field:'HCSXMC',halign:'center',align:'left'" sortable="true" width="100">检查事项</th>
		            <th data-options="field:'SFBYX',halign:'center',align:'center'" sortable="true" width="70" codeName="yesno" styler="sfbyStyler" formatter="formatCodeList">是否必要项</th>
		            <th data-options="field:'WJLX',halign:'center',align:'center'" sortable="true" width="100" codeName="wjlx" formatter="formatCodeList">文件类型</th>
		            <th data-options="field:'UPLOAD_TIME',halign:'center',align:'center'" sortable="true" width="110" formatter="formatDatetime2Min" >上传时间</th>
		            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70"  formatter="formatDocOperation">操作</th>
		        </tr>
		        </thead>
		    </table>
	    </div>
	</div>
</div>
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon2 r16_c13" plain="true" >上传</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>

