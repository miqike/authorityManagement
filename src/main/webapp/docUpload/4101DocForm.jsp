<%@ page contentType="text/html; charset=UTF-8" %>
<!-- <script type="text/javascript" src="./userDoc.js"></script> -->
<script type="text/javascript" src="../js/jquery.progressbar.min.js"></script>
<script type="text/javascript" src="../js/easyuiExtend/jeasyui.extend.js"></script>
<script>
    function funcSaveDoc() {
        $("#btnSaveDoc").linkbutton("disable");
        var hcsx = $("#mainGrid").datagrid("getSelected");
        var data = {};
        data.hcdwXydm = hcsx.HCDW_XYDM;
        data.hcjhnd = hcsx.ND;
        data.name = hcsx.HCCL_NAME;
        data.hcclId = hcsx.HCCL_ID;
        data.hcsxId = hcsx.HCSX_ID;
        data.hcrwId = hcsx.HCRW_ID;
        data.yhtg = 1;
        data.hcsxmc = hcsx.HCSXMC;
        data.mongoId = $("#d_mongoId").val();
        var type = "POST";
        var url = "../51/hcclmx";
        $.ajax({
            url: url,
            type: type,
            data: data,
            success: function (response) {
                if (response.status == SUCCESS) {
                    $("#docGrid").datagrid("reload");
                    $("#addDocWindow").window("close");
                    $.messager.show({
                        title: '提示',
                        msg: "核查材料保存成功"
                    });

                    var options = $('#mainGrid').datagrid('options');
                    options.url = '../common/query?mapper=scztMapper&queryName=queryHccl';
                    options.queryParams = {
                        xydm: window.xydm,
                        nd: $("#d_hcjhnd").textbox("getValue")
                    };
                    $("#mainGrid").datagrid(options);

                    $("#documentWindow").window("close");
                } else {
                    $.messager.alert('核查材料保存', response.message, 'error');
                }
            }
        });
    }

    function doInit() {
        $("#btnSaveDoc").click(funcSaveDoc);

        var hcsx = $("#mainGrid").datagrid("getSelected");

        $("#d_hcjhnd").textbox("setValue", hcsx.ND);
        $("#d_hcdwXydm").textbox("setValue", hcsx.HCDW_XYDM);
        $("#d_hcsxId").textbox("setValue", hcsx.HCSX_ID);
        $("#d_hcsxmc").textbox("setValue", hcsx.HCSXMC);

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
                    //$("#a_name").textbox("setValue", fileName);
                    $("#d_mongoId").val(response.mongoId);
                    $("#progressbar").hide();
                    $("#btnSaveDoc").linkbutton("enable");
                }

            });
        });
    }

</script>

<table>
    <tr>
        <td class="label">核查计划年度</td>
        <td>
            <input type="hidden" id="d_mongoId"/>
            <input class="easyui-textbox" , id="d_hcjhnd" disabled/>
        <td class="label">统一社会信用代码</td>
        <td><input class="easyui-textbox" id="d_hcdwXydm" disabled/></td>
    </tr>
    <tr>
        <td class="label">核查事项</td>
        <td><input class="easyui-textbox" id="d_hcsxId" data-options=""/></td>
        <td class="label">核查事项名称</td>
        <td><input class="easyui-textbox" id="d_hcsxmc" data-options=""/></td>
    </tr>
</table>
<a href="#" id="btnUpload" class="easyui-linkbutton" iconCls="icon2 r1_c13" plain="true">选择文件</a>
<a href="#" id="btnSaveDoc" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存</a>
<div id="_docPanel" style="padding:10px;"></div>
<div id="progressbar" style='margin-bottom:10px;display:none'></div>
