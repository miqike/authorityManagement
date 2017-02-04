<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"GOV_NBCC_JH_QY",columns:[[
        {field:"CCWH",title:"抽查文号",width:100},
        {field:"DJJG",title:"登记机关（代码）",width:100},
        {field:"FDDBR",title:"法人",width:100},
        {field:"GXDW",title:"管辖单位（代码）",width:100},
        {field:"JHXH",title:"核查计划序号",width:100},
        {field:"LRR",title:"列入人",width:100},
        {field:"LRSJ",title:"列入时间",width:100,formatter:formatDate},
        {field:"NBXH",title:"企业内部序号",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"QYLXDL",title:"企业类型大类",width:100},
        {field:"QYMC",title:"企业名称",width:100},
        {field:"WCBJ",title:"完成标志（名称）",width:100},
        {field:"XCR",title:"核查人，以,分隔",width:100},
        {field:"XCSJ",title:"巡查时间",width:100},
        {field:"XH",title:"序号",width:100},
        {field:"XYDM",title:"企业信用代码",width:100},
        {field:"ZCH",title:"企业注册号或信用代码",width:100},
        {field:"ZCH_OLD",title:"注册号",width:100},
        {field:"ZZXS",title:"企业组织形式，如果没有则等于QYLXDL",width:100}

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
        $("#panel").panel('refresh','GOV_NBCC_JH_QY.jsp');
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
