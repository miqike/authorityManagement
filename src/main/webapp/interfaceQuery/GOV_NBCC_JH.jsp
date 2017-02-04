<%@ page contentType="text/html; charset=UTF-8"%>
<script>
    //表配置，需要给出表名和显示的列表
    var tableConfig = {tableName:"GOV_NBCC_JH",columns:[[
        {field:"CCBL",title:"抽查比例",width:100},
        {field:"CCDJJG",title:"抽查登记机关（代码）",width:100},
        {field:"CCQYS",title:"抽查企业数",width:100},
        {field:"CCWH",title:"抽查文号",width:100},
        {field:"DJJG",title:"登记机关（代码）",width:100},
        {field:"JHLX",title:"计划类型（名称）",width:100},
        {field:"JHMC",title:"计划名称",width:100},
        {field:"JHNR",title:"计划内容",width:100},
        {field:"JHXH",title:"计划编号（代码）",width:100},
        {field:"JHZT",title:"计划状态（名称）",width:100},
        {field:"JSSJ",title:"结束时间",width:100,formatter:formatDate},
        {field:"KSSJ",title:"开始时间",width:100,formatter:formatDate},
        {field:"NBND",title:"抽查年报年度",width:100},
        {field:"ND",title:"计划年度",width:100},
        {field:"QYLX",title:"企业类型（代码）",width:100},
        {field:"QYLXDL",title:"企业类型大类（代码）",width:100}
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
        if($("#JHXH").val()!="" && $("#JHXH").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "JHXH";
            huskyCommonQueryWhere.data = $("#JHXH").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#CCDJJG").val()!="" && $("#CCDJJG").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "CCDJJG";
            huskyCommonQueryWhere.data = $("#CCDJJG").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#DJJG").val()!="" && $("#DJJG").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "DJJG";
            huskyCommonQueryWhere.data = $("#DJJG").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }

        if($("#NBND").val()!="" && $("#NBND").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "NBND";
            huskyCommonQueryWhere.data = $("#NBND").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }
        if($("#JHMC").val()!="" && $("#JHMC").val()!=null) {
            var huskyCommonQueryWhere = {};
            huskyCommonQueryWhere.columnName = "JHMC";
            huskyCommonQueryWhere.data = $("#JHMC").val();
            huskyCommonQueryWhere.columnType = "STRING";
            huskyCommonQueryWheres.push(huskyCommonQueryWhere);
        }

        doInitGrid();
    }
    function reset(){
        $("#panel").panel('refresh','GOV_NBCC_JH.jsp');
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
            <table><tr>
            <td>计划编号（代码）:<input id="JHXH" style="margin-left:5px;margin-right:8px" value=""/></td>
            <td>抽查登记机关（代码）:<input id="CCDJJG" style="margin-left:5px;margin-right:8px" value=""/></td>
            <td>抽查年报年度:<input id="NBND" style="margin-left:5px;margin-right:8px" value=""/></td>

    </tr><tr>
            <td>登记机关（代码）:<input id="DJJG" style="margin-left:5px;margin-right:8px" value=""/></td>
            <td>计划名称:<input id="JHMC" style="margin-left:5px;margin-right:8px" value=""/></td>
           <td> <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span></td>
    </tr>
          </table>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
