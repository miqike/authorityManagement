<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"NNB_QTXX",columns:[[
        {field:"NBXH",title:"内部序号",width:100},
        {field:"COLEMPLNUM",title:"高校毕业生_雇工人数",width:100},
        {field:"COLGRANUM",title:"高校毕业生_经营人数",width:100},
        {field:"CYRS",title:"从业人数",width:100},
        {field:"DISEMPLNUM",title:"残疾人_雇工人数",width:100},
        {field:"DISPERNUM",title:"残疾人_经营人数",width:100},
        {field:"DYRS",title:"党员人数",width:100},
        {field:"JYZDSJBZ",title:"经营者党书记标志（名称）",width:100},
        {field:"JYZDYBZ",title:"经营者党员标志（名称）",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"RETEMPLNUM",title:"退役士兵_雇工人数",width:100},
        {field:"RETSOLNUM",title:"退役士兵_经营人数",width:100},
        {field:"SFYDWTZ",title:"是否有对外投资（名称）",width:100},
        {field:"SFYWZWD",title:"是否有网址网店（名称）",width:100},
        {field:"UNEEMPLNUM",title:"再就业_雇工人数",width:100},
        {field:"UNENUM",title:"再就业__经营人数",width:100},
        {field:"BZ",title:"备注",width:100},
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
        $("#panel").panel('refresh','NNB_QTXX.jsp');
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
