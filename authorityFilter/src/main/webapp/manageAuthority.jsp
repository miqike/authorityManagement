<%@ page import="com.kysoft.Daos.UserDao" %>
<%@ page import="com.kysoft.beans.Authority" %>
<%@ page import="com.kysoft.beans.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Guohw
  Date: 2017-03-29
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    UserDao userDao=new UserDao();
   List<Authority> da= userDao.getAuthorities();
    request.setAttribute("da",da);
%>
  <c:if test="${requestScope.u!=null}">
   <c:out value="${requestScope.u.getUserName()}" />的权限是：
    <form action="userServlet" method="post">
        <input type="hidden" name="method" value="updateAuthority">
        <input type="hidden" name="user" value="${requestScope.u.getUserName()}">
        <c:forEach items="${requestScope.da}" var="daoa">
         <c:if test="${requestScope.u.getAuthorities().contains(daoa)}">
          <input type="checkbox" name="authority" value="${daoa.getDisplayName()}" checked="checked"/>${daoa.getDisplayName()}
             <br>
         </c:if>
            <c:if test="${!requestScope.u.getAuthorities().contains(daoa)}">
                <input type="checkbox" name="authority" value="${daoa.getDisplayName()}" />${daoa.getDisplayName()}
                <br>
            </c:if>
            </c:forEach>
        <input type="submit" value="submit"/>
    </form>
   </c:if>
<a href="login.jsp"><h3>请登录</h3></a>
</body>
</html>
