<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>经营异常企业查询</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/jquery-easyui-theme/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jeasyui.extensions.all.min.js"></script>

    <script type="text/javascript" src="../js/formatter.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.depreciated.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./huskyCommonQuery.js" ></script>
    <script>
        //表配置，需要给出表名和显示的列表
        var tableConfig = {tableName:"GOV_EXCEPTIONREASON",columns:[[
            {field:"PRIPID",title:"企业内部序号",width:100},
            {field:"LRSY",title:"列入事由（代码）",width:100},
            {field:"LRRQ",title:"列入日期",width:100,formatter:formatDate},
            {field:"JDJG",title:"决定机关",width:100}
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

            doInitGrid();
        }
        function reset(){
            huskyCommonQueryWheres= new Array();
            doInitGrid();
        }
        $(function() {
             $("#btnSearch").click(search);
             $("#btnReset").click(reset);
        });
    </script>
</head>
<body style="padding:5px;">
<div id="panel" class="easyui-panel" title="">
    <%--查询条件--%>
    <div style="padding: 5px 10px 0px 10px">
        <p style="margin-top: 0px; margin-bottom: 5px;">
            企业内部序号:<input id="PRIPID" style="margin-left:5px;margin-right:8px" value=""/>
            <span style="width:300px;">
			<a href="javascript:void(0);" id="btnSearch" class="easyui-linkbutton" plain="true" iconCls="icon-search">查找</a>
			<a href="javascript:void(0);" id="btnReset" class="easyui-linkbutton" plain="true" iconCls="icon2 r3_c10">重置</a>
			</span>
        </p>
    </div>

    <table id="dg" class="easyui-datagrid" >  </table>
</div>
</body>
</html>