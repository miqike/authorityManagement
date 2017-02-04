<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"JS_HZ_XZXK",columns:[[
        {field:"REGNO",title:"企业注册号",width:100},
        {field:"XKJG",title:"许可机关（名称）",width:100},
        {field:"HDRQ",title:"获得许可日期",width:100,formatter:formatDate},
        {field:"GSSJ",title:"要求公示时间",width:100,formatter:formatDate},
        {field:"XKNR",title:"许可内容",width:100},
        {field:"ID",title:"数据主键，如果没有则写UUID",width:100},
        {field:"READ_FLAG",title:"数据读取标志，需要回写",width:100},
        {field:"XKWJBH",title:"许可文件编号",width:100},
        {field:"XKWJMC",title:"许可文件名称",width:100},
        {field:"XQ",title:"许可详情",width:100},
        {field:"YXQ_KS",title:"允许期限-开始时间",width:100,formatter:formatDate},
        {field:"YXQ_JS",title:"允许期限-结束时间",width:100,formatter:formatDate},
        {field:"ZT",title:"许可状态（名称）",width:100},
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
        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','JS_HZ_XZXK.jsp');
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
            企业注册号:<input id="REGNO" style="margin-left:5px;margin-right:8px" value=""/>
            <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
