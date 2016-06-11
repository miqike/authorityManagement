<%@ page contentType="text/html; charset=UTF-8"%>
<!-- <script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
<script type="text/javascript" src="../js/husky/husky.easyui.extend.1.3.6.js"></script> -->
<script>
	function doSaveDoc() {
		if( $("#d_mongoId").val() == "") {
			$.messager.alert("操作提醒", "保存之前必须上传文件", "warning");
			return false;
		} else {
			var data = $.easyuiExtendObj.drillDownForm('addDocWindow');
			data.name = $("#d_hcclId").combobox("getText");
			data.hcsxmc = $("#d_hcsxId").combobox("getText");
			data.mongoId = $("#d_mongoId").val();
		    var type = "POST";
		    var url = "./hcclmx";
		    $.ajax({
		        url: url,
		        type: type,
		        data: data,
		        success: function (response) {
		            if (response.status == SUCCESS) {
		                $("#docGrid").datagrid("reload");
		                $("#addDocWindow").window("close");
		                $.messager.show({
							title : '提示',
							msg : "检查材料保存成功"
						});
		            } else {
		                $.messager.alert('检查材料保存', response.message, 'error');
		            }
		        }
		    });
		}
	}
	
	function doInitDocForm() {
		$.codeListLoader.parse($("#addDocWindow"));
		var hcrw = $("#grid1").datagrid("getSelected");
		var hcsx = getAuditItem();
		
		$("#d_hcrwId").val(hcrw.id);
		$("#d_hcdwXydm").val(hcrw.hcdwXydm);
		$("#d_hcjhnd").val(hcrw.nd);
		
		
		$("#d_hcsxId").combobox({url: "./" + hcrw.id + "/hcsx", method:'get',valueField: 'VALUE', textField: 'LITERAL',
			onLoadSuccess: function() { $("#d_hcclId").combobox("loadData" , []);},
			onChange: function(newValue,oldValue) {
				$("#d_hcclId").combobox({url: "../21/" + newValue +  "/hccl", method:'get',valueField: 'id', textField: 'name',
					onChange: function(newValue,oldValue) {
						setForm(newValue);
					},
					onUnselect: function(record) { setForm(null);}
				});				
			},
			onUnselect: function(record) { $("#d_hcclId").combobox("loadData" , []); }
		});
		
		$.getScript("../js/fileuploader.js", function() {
			window.uploader = new qq.FileUploaderBasic({
		        button: document.getElementById('btnUpload'),
		        allowedExtensions: [],
		        action: '../ajaxUpload',
		        multiple: false,
		        debug: true,

		        onSubmit: function(id, fileName){
		            uploader.setParams({
		                owner:"AUTHOR",
		                col:"BI0511",
		                ownerKey:"#datagridBi05"
		            });
		            //$("#progressbar").show().width('260px');
		        },

		        onProgress: function(id, fileName, loaded, total){
		            var percentLoaded = (loaded / total) * 100;
		            //$( "#progressbar" ).progressBar(percentLoaded);
		        },
		        // display a fancy message
		        onComplete: function (id, fileName, response) {
		        	//$("#a_name").val(fileName);
            		$("#d_mongoId").val(response.mongoId);
		            //$("#progressbar").hide();
		        }

		    });
		});
	}
	
	function setForm(value) {
		var hccl = null;
		if(value != null) {
			var hcclArray = $("#d_hcclId").combobox("getData");
			for(var i=0; i<hcclArray.length; i++) {
				if(hcclArray[i].id == value) {
					hccl = hcclArray[i];
					break;
				}
			}
		}
		if(hccl == null ) {
    		$("#d_sfbyx").combobox("clear");
    		$("#d_wjlx").combobox("clear");
    		$("#d_yhtg").combobox("clear");
		} else {
			$("#d_sfbyx").combobox("setValue", hccl.sfbyx);
    		$("#d_wjlx").combobox("setValue", hccl.wjlx);
    		$("#d_yhtg").combobox("setValue", hccl.yhtg);
    		$("#d_ly").combobox("setValue", 2);
		}
	}
	
</script>
<div id="addDocWindow" style="padding:10px;height:175px;">
    <table>
    	<tr>
    		<td class="label">检查计划年度</td><td>
    			<input type="hidden" id="d_id" />
     			<input type="hidden" id="d_mongoId" />
    			<input class="easyui-validatebox", id="d_hcjhnd" disabled/>
    		<td class="label">统一社会信用代码</td><td><input class="easyui-validatebox", id="d_hcdwXydm" disabled/></td>
    	</tr>
    	<tr>
    		<td class="label">检查任务编号</td><td><input class="easyui-validatebox", id="d_hcrwId" disabled/></td>
    	</tr>
    	<tr>
    		<td class="label">检查事项</td><td><input class="easyui-combobox", id="d_hcsxId" data-options=""/></td>
    		<td class="label">检查材料</td><td><input class="easyui-combobox", id="d_hcclId"/ ></td>
    	</tr>
    	<tr>
    		<td class="label">是否必要项</td><td><input class="easyui-combobox", id="d_sfbyx" codeName="yesno" data-options="panelHeight:70" disabled/></td>
    		<td class="label">文件类型</td><td><input class="easyui-combobox", id="d_wjlx" codeName="wjlx" data-options="panelHeight:100" disabled/></td>
    	</tr>
    	<tr>
    		<td class="label">是否用户提供</td><td><input class="easyui-combobox", id="d_yhtg" codeName="yesno"  data-options="panelHeight:70" disabled/></td>
    		<td class="label">来源</td><td><input class="easyui-combobox", id="d_ly" codeName="wjly" data-options="panelHeight:70" disabled/></td>
    	</tr>
    	<tr>
		    <td colspan="4">
		    	<!-- <a href="#" id="btnUpload"  iconCls="icon2 r1_c13" plain="true" disabled>选择文件</a> -->
		    	<a plain="true" class="l-btn l-btn-small l-btn-plain" id="btnUpload" href="#" group="" style="position: relative; overflow: hidden; direction: ltr;">
		    		<span class="l-btn-left l-btn-icon-left">
		    			<span class="l-btn-text">选择文件</span>
		    			<span class="l-btn-icon icon2 r1_c13">&nbsp;</span>
		    		</span>
		    	</a>	
		    	
		    </td>
    	</tr>
    </table>
           
	
</div>
