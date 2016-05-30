<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../gaozhishu/zelingluxingtongzhishu.js"></script>
<!-- 打印控件引入定义开始 -->
<script type="text/javascript" src="../js/LodopFuncs.js"></script>
<object id="LODOP_OB"
        classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<!-- 打印控件引入定义结束 -->

<div>
    <div style="display: none;">
        <span style="color:blue; " id="zeling_hcrwId"></span>
        <span style="color:blue; " id="zeling_hcsxId"></span>
        <span style="color:blue; " id="zeling_xydm"></span>
    </div>
    <table>
        <tr>
            <td sytle="text-align:right;">工商行政管理局</td>
            <td><input class="easyui-textbox" type="text" id="zeling_gljmc" data-options="" style="width:200px;"/></td>
        </tr>
        <tr>
            <td sytle="text-align:right;">文号</td>
            <td><input class="easyui-textbox" type="text" id="zeling_wenhao" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">企业名称</td>
            <td><input class="easyui-textbox" type="text" id="zeling_qymc" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">通知内容</td>
            <td><input class="easyui-textbox" type="text" id="zeling_tznr" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印</a>
                <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon-undo" plain="true">取消</a>
            </td>
        </tr>
    </table>
