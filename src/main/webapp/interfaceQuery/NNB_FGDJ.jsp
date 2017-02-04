<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"NNB_FGDJ",columns:[[
        {field:"NBXH",title:"内部序号",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"XH",title:"序号",width:100},
        {field:"PARINS",title:"是否建立党组织标志（名称）",width:100},
        {field:"NUMPARM",title:"党员总数",width:100},
        {field:"RESPARMSIGN",title:"法人是否党员标志",width:100},
        {field:"RESPARSECSIGN",title:"其他职务党员人数",width:100},
        {field:"ZJSJ",title:"组建时间",width:100,formatter:formatDate},
        {field:"QYLX",title:"企业类型",width:100},
        {field:"BNXZDYRS",title:"本年发展党员数",width:100},
        {field:"LXDH",title:"党建联系电话",width:100},
        {field:"ZCDYS",title:"在册党员数",width:100},
        {field:"WZRS",title:"现有入党积极分子数量",width:100},
        {field:"JJFZS",title:"积极分子数",width:100},
        {field:"WJLZZYY",title:"未建立党组织原因",width:100},
        {field:"DZZJZ",title:"是否建立党组织标志（名称）",width:100},
        {field:"FRDBSFDZZSJ",title:"法人是否党组织书记标志（名称）",width:100},
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
        $("#panel").panel('refresh','NNB_FGDJ.jsp');
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
            内部序号:<input id="NBXH" style="margin-left:5px;margin-right:8px" value=""/>
            <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
