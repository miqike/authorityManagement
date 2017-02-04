<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"GOV_NBCC_RC_QY",columns:[[
        {field:"CLRQ",title:"企业成立日期",width:100,formatter:formatDate},
        {field:"DJJG",title:"企业登记机关（代码）",width:100},
        {field:"DJJG_MC",title:"企业登记机关（名称）",width:100},
        {field:"FDDBR",title:"法人",width:100},
        {field:"GXDW",title:"企业管辖单位（代码）",width:100},
        {field:"GXDW_MC",title:"GXDW_MC",width:100},
        {field:"JDJG",title:"做出异常处理决定的机关代码",width:100},
        {field:"JDJG_MC",title:"做出异常处理决定的机关名称",width:100},
        {field:"LRRQ",title:"列入异常的日期",width:100,formatter:formatDate},
        {field:"LRSY",title:"列入异常的事由（名称）",width:100},
        {field:"NBXH",title:"日常监管企业名录（异常名录）",width:100},
        {field:"ND",title:"核查年度",width:100},
        {field:"QYLXDL",title:"企业类型大类（代码）",width:100},
        {field:"QYMC",title:"企业名称",width:100},
        {field:"QYZZXS",title:"企业组织形式（如果没有则同QYLXDL）",width:100},
        {field:"XCR",title:"核查人名称，以,分隔",width:100},
        {field:"XCSJ",title:"核查时间",width:100,formatter:formatDate},
        {field:"XYDM",title:"企业信用代码",width:100},
        {field:"ZCH",title:"企业注册号或信用代码",width:100},
        {field:"ZCH_OLD",title:"注册号",width:100},
        {field:"ZS",title:"企业住所",width:100},

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
        if($("#QYMC").val()!="" && $("#QYMC").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "QYMC";
            huskyCommonQueryWhere.data = $("#QYMC").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#XYDM").val()!="" && $("#XYDM").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "XYDM";
            huskyCommonQueryWhere.data = $("#XYDM").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }

        if($("#ZCH_OLD").val()!="" && $("#ZCH_OLD").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "ZCH_OLD";
            huskyCommonQueryWhere.data = $("#ZCH_OLD").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }

        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','GOV_NBCC_RC_QY.jsp');
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
            企业名称:<input id="QYMC" style="margin-left:5px;margin-right:8px" value=""/>
            企业信用代码:<input id="XYDM" style="margin-left:5px;margin-right:8px" value=""/>
            &nbsp;注册号:<input id="ZCH_OLD" style="margin-left:5px;margin-right:8px" value=""/>
            <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
