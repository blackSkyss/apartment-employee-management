<%-- 
    Document   : AdminHome
    Created on : May 29, 2022, 1:39:45 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <h1>Welcome Back Admin Home</h1>
        <h3><a href="logoutController?action=logout">Log out</a> </h3>
        <h2>Hello <c:out value="${sessionScope.USER_LOGGIN.name}"/> </h2>
    </body>
</html>
