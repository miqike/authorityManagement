<%@ page contentType="text/html; charset=UTF-8"%>
<script>

</script>
<div id="runAsWindow" >
    <table>
        <tr>
            <td>当前身份:</td>
            <td>
                <span id="t_current" style="margin-right:10px;color:blue;font-weight:bold"></span>
            </td>
            <td>原身份:</td>
            <td>
                <span id="t_last" style="margin-right:10px;color:blueviolet;"></span>
            </td>
            <td>
                <a href="javascript:void(0);" id="btnBackTo" class="easyui-linkbutton" plain="true" iconCls="icon2 r20_c12" onclick="switchBack()">切换回原身份</a>
            </td>
        </tr>
    </table>
    <div id="runAsTab" class="easyui-tabs" style="height:228px;" data-options="fit:true,">
        <div title="切换">
            <table id="fromUserTable" style="padding-left:8px;"></table>
        </div>
        <div title="授权">
            <table id="toUserTable" style="padding-left:8px;"></table>
        </div>
    </div>
</div>