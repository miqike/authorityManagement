<%@ page contentType="text/html; charset=UTF-8"%>
<!-- <script type="text/javascript" src="./userDoc.js"></script> -->
<script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
<script>
	function funcSaveDoc() {
		$("#btnSaveDoc").linkbutton("disable");
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
	
	function doInit() {
		$.codeListLoader.parse($("#addDocWindow"));
		$("#btnSaveDoc").click(funcSaveDoc);
		
		var hcrw = $("#grid1").datagrid("getSelected");
		var hcsx = getAuditItem();
		
		$("#d_hcrwId").textbox("setValue", hcrw.id);
		$("#d_hcdwXydm").textbox("setValue", hcrw.hcdwXydm);
		$("#d_hcjhnd").textbox("setValue", hcrw.nd);
		
		
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
		        debug: false,

		        onSubmit: function(id, fileName){
		            uploader.setParams({
		                owner:"AUTHOR",
		                col:"BI0511",
		                ownerKey:"#datagridBi05"
		            });
		            $("#progressbar").show().width('260px');
		        },

		        onProgress: function(id, fileName, loaded, total){
		            var percentLoaded = (loaded / total) * 100;
		            $( "#progressbar" ).progressBar(percentLoaded);
		        },
		        // display a fancy message
		        onComplete: function (id, fileName, response) {
		        	//$("#a_name").textbox("setValue", fileName);
            		$("#d_mongoId").val(response.mongoId);
		            $("#progressbar").hide();
		            $("#btnSaveDoc").linkbutton("enable");
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
    		$("#btnUpload").linkbutton("disable");
		} else {
			$("#d_sfbyx").combobox("setValue", hccl.sfbyx);
    		$("#d_wjlx").combobox("setValue", hccl.wjlx);
    		$("#d_yhtg").combobox("setValue", hccl.yhtg);
    		$("#d_ly").combobox("setValue", 2);
    		$("#btnUpload").linkbutton("enable");
		}
		
	}
	
</script>

    <table>
    	<tr>
    		<td class="label">检查计划年度</td><td>
    			<input type="hidden" id="d_id" />
     			<input type="hidden" id="d_mongoId" />
    			<input class="easyui-textbox", id="d_hcjhnd" disabled/>
    		<td class="label">统一社会信用代码</td><td><input class="easyui-textbox", id="d_hcdwXydm" disabled/></td>
    	</tr>
    	<tr>
    		<td class="label">检查任务编号</td><td><input class="easyui-textbox", id="d_hcrwId" disabled/></td>
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
    	</tr>
    	<tr>
    		<td class="label">是否用户提供</td><td><input class="easyui-combobox", id="d_yhtg" codeName="yesno"  data-options="panelHeight:70" disabled/></td>
    		<td class="label">来源</td><td><input class="easyui-combobox", id="d_ly" codeName="wjly" data-options="panelHeight:70" disabled/></td>
    	</tr>
    </table>
    <a href="#" id="btnUpload" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true" disabled>选择文件</a>
    <a href="#" id="btnSaveDoc" class="easyui-linkbutton" iconCls="icon-save" plain="true" disabled>保存</a>
	<div id="_docPanel" style="padding:10px;"></div>
	<div id="progressbar" style='margin-bottom:10px;display:none'></div>
