<%--
  Created by IntelliJ IDEA.
  User: Guohw
  Date: 2017-03-30
  Time: 10:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>登录页面</h3>
    <form action="userServlet" method="post">
        <input type="hidden" name="method" value="login"/>
       <input type="text" name="user"/>
        <input type="submit" value="submit"/>
    </form>
</body>
</html>
