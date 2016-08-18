<%@ page contentType="text/html; charset=UTF-8" %>
<script>
    function saveDoc() {
        $("#btnSaveDoc").linkbutton("disable");
        $.ajax({
            url: './hcjh/statement/' +  $("#d_id").val(),
            type: "POST",
            data: {
            	statement: $("#d_statement").val()
            },
            success: function (response) {
                if (response.status == $.husky.SUCCESS) {
                    $.messager.show('提示',"实施方案保存成功", "info", "bottomRight");
                    $("#documentWindow").window("close");
                    $("#grid1").datagrid("reload");
                } else {
                    $.messager.alert('实施方案保存失败', response.message, 'error');
                }
            }
        });
    }

    function doInit() {
		var hcjh = $("#grid1").datagrid("getSelected");
		$.husky.loadForm("docPanel", hcjh);
        $.getScript("../js/fileuploader.js", function () {
            window.uploader = new qq.FileUploaderBasic({
                button: document.getElementById('btnUpload'),
                allowedExtensions: [],
                action: '../ajaxUpload',
                multiple: false,
                debug: false,

                onSubmit: function (id, fileName) {
                    uploader.setParams({
                        owner: "AUTHOR",
                        col: "BI0511",
                        ownerKey: "#datagridBi05"
                    });
                    $("#progressbar").show().width('260px');
                },

                onProgress: function (id, fileName, loaded, total) {
                    var percentLoaded = (loaded / total) * 100;
                    $("#progressbar").progressBar(percentLoaded);
                },
                // display a fancy message
                onComplete: function (id, fileName, response) {
                    //$("#a_name").val(fileName);
                    $("#d_statement").val(response.mongoId);
                    $("#progressbar").hide();
                    $("#btnSaveDoc").linkbutton("enable");
                }
            });
        });
		
    }

    $(function () {
    	$.codeListLoader.parse($('#docPanel'))
    });
</script>

<table>
    <tr>
        <td class="label">检查计划年度</td>
        <td>
            <input type="hidden" id="d_id"/>
            <input type="hidden" id="d_statement"/>
            <input class="easyui-validatebox" id="d_nd" disabled/>
        <td class="label">计划编号</td>
        <td><input class="easyui-validatebox" id="d_jhbh" disabled/></td>
    </tr>
    <tr>
        <td class="label">公示系统计划编号</td>
        <td><input class="easyui-validatebox" id="d_gsjhbh" data-options="" disabled/></td>
        <td class="label">计划名称</td>
        <td><input class="easyui-validatebox" id="d_jhmc" data-options="" disabled/></td>
    </tr>
    <tr>
        <td class="label">抽查文号</td>
        <td><input class="easyui-validatebox" id="d_cxwh" data-options="" codeName="yesno"  disabled/></td>
        <td class="label">任务下达机关</td>
        <td><input class="easyui-validatebox" id="d_djjgmc" data-options="" codeName="wjlx" disabled /></td>
    </tr>
</table>
<a plain="true" iconcls="icon2 r1_c13" class="l-btn l-btn-small l-btn-plain" id="btnUpload" href="#" group="" style="position: relative; overflow: hidden; direction: ltr;">
	<span class="l-btn-left l-btn-icon-left">
	<span class="l-btn-text">选择文件</span>
		<span class="l-btn-icon icon2 r1_c13">&nbsp;</span>
	</span>
	<input type="file" name="file" style="position: absolute; right: 0px; top: 0px; font-family: Arial; font-size: 118px; margin: 0px; padding: 0px; cursor: pointer; opacity: 0;">
</a>

<a href="#" id="btnSaveDoc" class="easyui-linkbutton" iconCls="icon-save" plain="true" disabled>保存</a>
<div id="_docPanel" style="padding:10px;"></div>
<div id="progressbar" style='margin-bottom:10px;display:none'></div>
