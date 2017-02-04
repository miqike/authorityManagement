<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"NNB_TZ",columns:[[
        {field:"NBXH",title:"内部序号",width:100},
        {field:"REGNO",title:"投资企业注册号",width:100},
        {field:"DJJG",title:"登记机关",width:100},
        {field:"DZ",title:"投资企业地址",width:100},
        {field:"ENTNAME",title:"投资设立企业或者购买股权企业名称",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"SEQ",title:"序号",width:100},
        {field:"SJJE",title:"实缴金额",width:100},
        {field:"TZBL",title:"投资比例",width:100},
        {field:"TZFS",title:"投资方式（名称）",width:100},
        {field:"TZJE",title:"投资金额",width:100},
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
        if($("#REGNO").val()!="" && $("#REGNO").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "REGNO";
            huskyCommonQueryWhere.data = $("#REGNO").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#ENTNAME").val()!="" && $("#ENTNAME").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "ENTNAME";
            huskyCommonQueryWhere.data = $("#ENTNAME").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }

        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','NNB_TZ.jsp');
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
            投资企业注册号:<input id="REGNO" style="margin-left:5px;margin-right:8px" value=""/>
            投资设立企业或者购买股权企业名称:<input id="ENTNAME" style="margin-left:5px;margin-right:8px" value=""/>
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
