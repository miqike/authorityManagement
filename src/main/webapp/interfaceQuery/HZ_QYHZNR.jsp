<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"HZ_QYHZNR",columns:[[
        {field:"PRIPID",title:"企业内部序号",width:100},
        {field:"REGNO",title:"企业注册号",width:100},
        {field:"UNISCID",title:"统一社会信用代码",width:100},
        {field:"ENTNAME",title:"企业名称",width:100},
        {field:"DOM",title:"企业住所",width:100},
        {field:"EMAIL",title:"企业邮箱",width:100},
        {field:"EMPNUM",title:"从业人数",width:100},
        {field:"ENTTYPE",title:"企业类型",width:100},
        {field:"ESTDATE",title:"企业成立日期",width:100,formatter:formatDate},
        {field:"LEREP",title:"企业法人",width:100},
        {field:"LOCALADM",title:"管辖单位",width:100},
        {field:"ND",title:"年度",width:100},
        {field:"OPSTATE",title:"企业经营状态（名称）",width:100},
        {field:"POSTALCODE",title:"邮政编码",width:100},
        {field:"QYLXDL",title:"企业类型大类",width:100},
        {field:"REGORG",title:"登记机关",width:100},
        {field:"TEL",title:"联系电话",width:100},
        {field:"ZZXS",title:"企业组织形式，如果没有则等于QYLXDL",width:100},
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
        if($("#PRIPID").val()!="" && $("#PRIPID").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "PRIPID";
            huskyCommonQueryWhere.data = $("#PRIPID").val();
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
        if($("#UNISCID").val()!="" && $("#UNISCID").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "UNISCID";
            huskyCommonQueryWhere.data = $("#UNISCID").val();
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
        $("#panel").panel('refresh','HZ_QYHZNR.jsp');
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
            企业内部序号:<input id="PRIPID" style="margin-left:5px;margin-right:8px" value=""/>
            企业注册号:<input id="REGNO" style="margin-left:5px;margin-right:8px" value=""/>
            统一社会信用代码:<input id="UNISCID" style="margin-left:5px;margin-right:8px" value=""/>
            <br>
            &nbsp;&nbsp;企业名称:<input id="ENTNAME" style="margin-left:5px;margin-right:8px" value=""/>
            <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
