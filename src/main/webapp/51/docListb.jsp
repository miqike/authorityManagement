<%@ page contentType="text/html; charset=UTF-8"%>
<script>
	function formatDocOperation(val, row, rowIndex) {
		if(row.MONGO_ID != null && row.MONGO_ID != undefined) {
			return "<a href=\"javascript: displayAttachment('" + row.MONGO_ID + "');\">查看</a>　<a class='easyui-linkbutton' onclick='uploadFile(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";
		} else {
			return "<a class='easyui-linkbutton' onclick='uploadFile(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";
		}
	}
	
	function formatDocOperation2(val, row, rowIndex) {
		if(row.MONGO_ID != null && row.MONGO_ID != undefined) {
			return "<a href=\"javascript: displayAttachment('" + row.MONGO_ID + "');\">查看</a>　<a class='easyui-linkbutton' onclick='uploadFile2(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";
		} else {
			return "<a class='easyui-linkbutton' onclick='uploadFile2(\"" + rowIndex + "\");' href='javascript:void(0);'>上传</a>";
		}
	}
	
	function uploadFile(rowIndex) {
	    var data = $('#docGrid').datagrid("getData").rows[rowIndex];
	    if (null != data.MONGO_ID) {
	        $.messager.confirm('覆盖文件', '确认覆盖文件？', function (r) {
	            if (r) {
	            	showUploadForm(1);
	            }
	        });
	    } else {
	    	showUploadForm(1);
	    }
	}

	function uploadFile2(rowIndex) {
		var data = $('#furDocgrid').datagrid("getData").rows[rowIndex];
		if (null != data.MONGO_ID) {
			$.messager.confirm('覆盖文件', '确认覆盖文件？', function (r) {
				if (r) {
					showUploadForm(2);
				}
			});
		} else {
			showUploadForm(2);
		}
	}

	function showUploadForm(type) {
		$("#documentWindow").dialog("open");
	    $("#docPanel").panel({
	        href: './docFormb.jsp',
	        onLoad: function () {
	            doInit(type);
	        }
	    });
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

	function displayAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../display?mongoId=" + mongoId + "'/>") .appendTo("body");
	}

	function downloadAttachment(mongoId) {
	    $("<iframe id='download' style='display:none' src='../download?mongoId=" + mongoId + "'/>") .appendTo("body");
	}
	
	function doDocListInit() {
		var hcrw = $("#grid2").datagrid("getSelected");
		$.getJSON("../common/query?mapper=hcclMapper&queryName=queryForTask",  {
				hcrwId:hcrw.ID
			}, function (response) {
			    if (response.status == $.husky.SUCCESS) {
			    	 $("#docGrid").datagrid("loadData",response);
			    }
			});
		
		$.getJSON("../docUpload/" + hcrw.ID + "/furtherDocist", function (response) {
			if (response.status == $.husky.SUCCESS) {
				if(response.data.length > 0) {
					$("#furDocgrid").parent().parent().parent().show()
					$("#furDocgrid").datagrid("loadData",response.data);
				}  else {
					$("#furDocgrid").parent().parent().parent().hide();
				}
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
		doDocListInit();
	});
</script>

<div style="padding:5px 5px 0px 5px;">
    <div style="display: none;">
        <span style="color:blue; " id="_hcrwId_"></span>
        <span style="color:blue; " id="_hcsxId_"></span>
        <span style="color:blue; " id="_qymc_"></span>
    </div>
    
    <div id="tabPanel" class="easyui-tabs" style="width:765px;clear:both;" data-options="">
        <div title="标准核查材料" style="padding:5px;" selected="true">
		    <table id="docGrid"
		           class="easyui-datagrid"
		           data-options="collapsible:true,
		           		singleSelect:true,height:290,width:750,
		           		onClickRow:docGridClickRowHandler,
						ctrlSelect:false,method:'get'">
		        <thead>
		        <tr>
					<th data-options="field:'HCSXMC',halign:'center',align:'left'" sortable="true" width="100">检查事项</th>
		            <th data-options="field:'HCCL_NAME',halign:'center',align:'left'" sortable="true" width="110">材料名称</th>
		            <th data-options="field:'SFBYX',halign:'center',align:'center'" sortable="true" width="70" codeName="yesno" formatter="formatCodeList" styler="sfbyStyler">是否必要项</th>
		            <th data-options="field:'WJLX',halign:'center',align:'center'" sortable="true" width="100" codeName="wjlx" formatter="formatCodeList" >文件类型</th>
		            <th data-options="field:'YHTG',halign:'center',align:'center'" sortable="true" width="90" codeName="yesno" formatter="formatCodeList" styler="sfbyStyler">是否用户提供</th>
		            <th data-options="field:'LY',halign:'center',align:'center'" sortable="true" width="70" codeName="wjly" formatter="formatCodeList">数据来源</th>
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
		            <th data-options="field:'id',halign:'center',align:'center'" sortable="true" width="70"  formatter="formatDocOperation2">操作</th>
		        </tr>
		        </thead>
		    </table>
	    </div>
	</div>
</div>
<!-- 
<div id="docGridToolbar">
    <a href="#" id="btnAddDoc" class="easyui-linkbutton" iconCls="icon2 r16_c13" plain="true" >上传</a>
    <a href="#" id="btnRemoveDoc" class="easyui-linkbutton" iconCls="icon-remove" plain="true" disabled>删除</a>
</div>
 -->

 <div id="documentWindow" title="检查材料" class="easyui-dialog"
     data-options="modal:true,closed:true,iconCls:'icon2 r16_c14'"
     style="width: 600px; height: 205px; padding: 10px;">
    <div id="docPanel" style="padding:10px;"></div>
</div>
 