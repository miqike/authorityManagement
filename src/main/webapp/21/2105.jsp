<%--jsp文件的存储格式--%>
<%--<%@ page language="java" pageEncoding="UTF-8"%>--%>
<%--解码格式--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%--控制浏览器的解码方式。如果前面的解码都一致并且无误的话，这个编码格式用不用设置都可以--%>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <title>企业公示信息举报</title>
    <link href="../css/content.css" rel="stylesheet"/>
    <link href="../css/themes/${theme}/easyui.css" rel="stylesheet"/>
    <link href="../css/themes/icon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../css/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="../js/jeasyui-extensions/jeasyui.extensions.css" type="text/css">

    <script type="text/javascript" src="../js/hotkeys.min.js"></script>
    <script type="text/javascript" src="../js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/jeasyui-extensions-release/jquery.jdirk.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="../js/jqueryExtend/jquery.extend.js"></script>

    <script type="text/javascript" src="../js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ztree.excheck-3.5.min.js"></script>
    <script type="text/javascript" src="../js/husky/husky.common.js"></script>
    <script type="text/javascript" src="../js/husky/husky.easyui.codeList.js"></script>
    <script type="text/javascript" src="../js/underscore-min-1.8.3.js"></script>
    <script type="text/javascript" src="./2105.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font: 13px/1.5 \5b8b\4f53, Arial, sans-serif;
            background: #ffffff;
        }

        div .datagrid-wrap {
            border-right: 0px;
            border-left: 0px;
            border-bottom: 0px
        }

        div#tabPanel .datagrid-wrap {
            border-top: 0px;
        }
    </style>
</head>
<body style="padding:5px;">
<%-- <shiro:hasPermission name="user"> --%>
<div id="panel" class="easyui-panel" title="">
    <table id="companyTable">
        <tr>
            <td width="800px" colspan="2" bgcolor="#a9a9a9" align="center">被举报企业信息</td>
        </tr>
        <tr>
            <td width="300px" align="right">统一社会信用代码/注册号</td>
            <td width="500px"><input class="easyui-textbox" id="c_Id" type="text" style="width:200px;"/></td>
        </tr>
        <tr>
            <td width="300px" align="right">名称</td>
            <td><input class="easyui-textbox" type="text" id="c_name" style="width:200px;"/></td>
        </tr>
        <tr>
            <td width="300px" align="right">登记机关</td>
            <td><input class="easyui-textbox" id="c_regist" type="text" style="width:200px;" data-options=""/></td>
        </tr>
        <tr>
            <td colspan="2" bgcolor="#a9a9a9" align="center">举报人信息</td>
        </tr>
        <tr>
            <td width="300px" align="right">姓名</td>
            <td><input class="easyui-textbox" id="p_Id" type="text" style="width:200px;"/></td>
        </tr>
        <tr>
            <td width="300px" align="right">电话</td>
            <td><input class="easyui-textbox" type="text" id="p_name" style="width:200px;"/></td>
        </tr>
        <tr>
            <td width="300px" align="right">电子邮箱</td>
            <td><input class="easyui-textbox" id="p_regist" type="text" style="width:200px;" data-options=""/></td>
        </tr>
        <tr>
            <td colspan="2" bgcolor="#a9a9a9" align="center">举报内容</td>
        </tr>
        <tr>
            <td width="300px" align="right">举报内容</td>
            <td><input class="easyui-textbox" id="con_content" type="text" style="width:200px;"/></td>
        </tr>
    </table>

</div>
<%-- </shiro:hasPermission>
<shiro:lacksPermission name="user">
    <script>
        alert("没有权限，跳转");
    </script>
</shiro:lacksPermission> --%>

</body>
</html>