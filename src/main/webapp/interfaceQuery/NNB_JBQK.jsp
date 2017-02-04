<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"NNB_JBQK",columns:[[
        {field:"REGNO",title:"企业注册号",width:100},
        {field:"NBXH",title:"企业内部序号",width:100},
        {field:"CLRQ",title:"企业成立日期",width:100,formatter:formatDate},
        {field:"CYRS",title:"从业人数",width:100},
        {field:"FDDBR",title:"法人名称",width:100},
        {field:"JYCS",title:"经营场所",width:100},
        {field:"JYFS",title:"经营方式",width:100},
        {field:"JYFS_JYFW",title:"经营方式-经营范围",width:100},
        {field:"JYFW",title:"经营范围",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"QYLX",title:"企业类型",width:100},
        {field:"YYZK",title:"经营状态（名称）",width:100},
        {field:"ZCZJ",title:"注册资金",width:100},
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
        if($("#REGNO").val()!="" && $("#REGNO").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "REGNO";
            huskyCommonQueryWhere.data = $("#REGNO").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#NBXH").val()!="" && $("#NBXH").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "NBXH";
            huskyCommonQueryWhere.data = $("#NBXH").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#FDDBR").val()!="" && $("#FDDBR").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "FDDBR";
            huskyCommonQueryWhere.data = $("#FDDBR").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','NNB_JBQK.jsp');
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
            企业注册号:<input id="REGNO" style="margin-left:5px;margin-right:8px" value=""/>
            内部序号:<input id="NBXH" style="margin-left:5px;margin-right:8px" value=""/>
            法人名称:<input id="FDDBR" style="margin-left:5px;margin-right:8px" value=""/>
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
