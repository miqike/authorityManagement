<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"NNB_ZCZK",columns:[[
        {field:"NBXH",title:"内部序号",width:100},
        {field:"QNYYSR",title:"营业总收入",width:100},
        {field:"FZZE",title:"负债总额",width:100},
        {field:"JLR",title:"净利润",width:100},
        {field:"LRZE",title:"利润总额",width:100},
        {field:"LXDH",title:"联系电话",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"NSZE",title:"纳税总额",width:100},
        {field:"SYZQYHJ",title:"所有者权益合计",width:100},
        {field:"ZCZE",title:"资产总额",width:100},
        {field:"ZYYWSR",title:"主营业务收入",width:100},
    ]]};
    /**
     * 查询语句中WHERE条件设置，需要设置成性数组，数据中存放对象huskyCommonQueryWhere
     * huskyCommonQueryWhere:
     *   columnName:字段名
     *   data:字段对应的查询值
     *   columnType:字段类型 STRING DATE NUBER
     */
    var huskyCommonQueryWheres=new Array();

    function search(){
        huskyCommonQueryWheres= new Array();

        if($("#NBXH").val()!="" && $("#NBXH").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "NBXH";
            huskyCommonQueryWhere.data = $("#NBXH").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','NNB_ZCZK.jsp');
    }
    $(function() {
        $("#btnSearch").click(search);
        $("#btnReset").click(reset);
    });
</script>
<div id="panel" class="easyui-panel" title="" >
    <%--查询条件--%>
    <div style="padding: 5px 10px 0px 10px">
        <p style="margin-top: 0px; margin-bottom: 5px;">
            <span style="width:300px;">
            内部序号:<input id="NBXH" style="margin-left:5px;margin-right:8px" value=""/>
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
