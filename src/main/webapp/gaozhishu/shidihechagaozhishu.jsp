<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../gaozhishu/shidihechagaozhishu.js"></script>
<!-- 打印控件引入定义开始 -->
<script type="text/javascript" src="../js/LodopFuncs.js"></script>
<object id="LODOP_OB"
        classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<!-- 打印控件引入定义结束 -->

<div>
    <div style="display: none;">
        <span style="color:blue; " id="shidi_hcrwId"></span>
        <span style="color:blue; " id="shidi_hcsxId"></span>
    </div>
    <table>
        <tr>
            <td><input class="easyui-textbox" type="text" id="shidi_gljmc" data-options="" style="width:200px;"/></td>
            <td sytle="text-align:right;">工商行政管理局</td>
        </tr>
        <tr>
            <td colspan="2" sytle="text-align:right;">企业公示信息实地核查记录表</td>
        </tr>
        <tr>
            <td sytle="text-align:right;">企业名称</td>
            <td><input class="easyui-textbox" type="text" id="shidi_qymc" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">注册号</td>
            <td><input class="easyui-textbox" type="text" id="shidi_xydm" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">法定代表人（负责人）</td>
            <td><input class="easyui-textbox" type="text" id="shidi_fr" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">核查实施机关</td>
            <td><input class="easyui-textbox" type="text" id="shidi_hcjg" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">核查情况</td>
            <td><input class="easyui-textbox" type="text" id="shidi_hcqk" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">备注</td>
            <td><input class="easyui-textbox" type="text" id="shidi_bz" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">企业盖章：</td>
            <td sytle="text-align:right;">核查人（签字）：</td>
        </tr>
        <tr>
            <td sytle="text-align:right;">或法定代表人（负责人）签字</td>
            <td sytle="text-align:right;">核查时间：</td>
        </tr>
        <tr>
            <td sytle="text-align:right;">见证人签字：</td>
        </tr>
        <tr>
            <td sytle="text-align:right;">注：个体工商户、农民专业合作社适用此表。</td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印</a>
                <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
            </td>
        </tr>
    </table>

</div>
