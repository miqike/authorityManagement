<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript" src="../gaozhishu/qiyezhusuohechahan.js"></script>
<!-- 打印控件引入定义开始 -->
<script type="text/javascript" src="../js/LodopFuncs.js"></script>
<!-- 打印控件引入定义结束 -->

<div style="padding:10px;">
    <div style="display: none;">
        <span style="color:blue; " id="zhusuo_hcrwId"></span>
        <span style="color:blue; " id="zhusuo_hcsxId"></span>
        <span style="color:blue; " id="zhusuo_xydm"></span>
    </div>
    <table>
        <tr>
            <td sytle="text-align:right;">工商行政管理局</td>
            <td><input class="easyui-validatebox" type="text" id="zhusuo_gljmc" data-options="" style="width:200px;"/></td>
        </tr>
        <tr>
            <td sytle="text-align:right;">企业名称</td>
            <td><input class="easyui-validatebox" type="text" id="zhusuo_qymc" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">联系人</td>
            <td><input class="easyui-validatebox" type="text" id="zhusuo_lxr" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <tr>
            <td sytle="text-align:right;">联系电话</td>
            <td><input class="easyui-validatebox" type="text" id="zhusuo_lxdh" data-options=""
                       style="width:200px;"/>
            </td>
        </tr>
        <!-- <tr>
            <td colspan="2">
                <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print" plain="true">打印</a>
                <a href="#" id="btnClose" class="easyui-linkbutton" iconCls="icon2 r3_c4" plain="true">返回</a>
            </td>
        </tr> -->
    </table>
