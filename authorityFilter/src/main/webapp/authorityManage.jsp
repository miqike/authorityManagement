<%@ page import="com.kysoft.Daos.UserDao" %>
<%@ page import="com.kysoft.beans.Authority" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Guohw
  Date: 2017-03-29
  Time: 1:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>权限管理页面</h3>
   <form action="userServlet" method="get">
       <input type="hidden" name="method" value="getUser"/>
       <input type="text" name="userName"/>
       <input type="submit" value="submit"/>
   </form>
</body>
</html>
