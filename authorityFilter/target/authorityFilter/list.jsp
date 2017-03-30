<%--
  Created by IntelliJ IDEA.
  User: Guohw
  Date: 2017-03-30
  Time: 10:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${requestScope.message!=null}">
<span style="color: red"><c:out value="${requestScope.message}"></c:out></span>
</c:if>
<h3>lesson1&nbsp;&nbsp;<a href="lesson1.jsp">lesson1</a></h3>
<br>
<h3>lesson2&nbsp;&nbsp;<a href="lesson2.jsp">lesson2</a></h3>
<br>
<h3>lesson3&nbsp;&nbsp;<a href="lesson3.jsp">lesson3</a></h3>
<br>
<h3>lesson4&nbsp;&nbsp;<a href="lesson4.jsp">lesson4</a></h3>
<br>
<h3>lesson5&nbsp;&nbsp;<a href="lesson5.jsp">lesson5</a></h3>
<br>
<a href="userServlet?method=logout"><h5>bye</h5></a>
</body>
</html>
