<%-- 
    Document   : renewalContract
    Created on : Jun 8, 2022, 4:38:47 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Renewal Contract</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 5px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                width: 20%;
                margin-top: 10px;
                text-transform: uppercase
            }

            .btn-primary:hover{
                transform: scale(0.95);
                cursor: pointer;
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
            }

            .modal-content{
                height: 100%
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import>

            <div class="modal-content" style="margin: 0 20%">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Renewal Contract</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item"><a href="mainController?action=showlist&type=con">Contract</a></li>
                                <li class="breadcrumb-item active">Renewal contract</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div>
                    <p style="margin: 16px 16px 0 16px">Contract of employee : ${requestScope.Contract.nameEmp}</p>
            </div>
            <p style="color:red">${sessionScope.WARNING}</p>
            <div class="modal-body">
                <form action="mainController" method="POST" class="form-position" enctype="multipart/form-data">

                    <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                       url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                                       user = "sa"  password = "12345"/>

                    <sql:query dataSource = "${snapshot}" var = "listtype">
                        select idTypeCon, name
                        from TypeContract
                    </sql:query>
                    <sql:query dataSource = "${snapshot}" var = "idEmp">
                        select hc.idEmp , e.name
                        from HistoryContract as hc, Contract as c , Employee as e
                        where hc.idContract = c.idContract and e.idEmp=hc.idEmp and c.idContract = ${requestScope.Contract.idCon}
                    </sql:query>
                    <div class="form-group">
                        <label>Type of contract</label>
                        <c:forEach var = "rowlist" items = "${listtype.rows}">
                            <c:if test="${requestScope.Contract.typeCon eq rowlist.name}">
                                <input class="form-control" type="text" value="${rowlist.name}" readonly="">
                            </c:if>
                        </c:forEach>
                    </div>

                    <div class="form-group">
                        <label>Sign Day </label>
                        <input class="form-control" type="text" readonly="" value="${requestScope.Contract.signDay}"/>
                    </div>
                    <div class="form-group">
                        <label>Expiration Day</label> 
                        <input class="form-control" type="date" value="${requestScope.Contract.expDay}" name="expday"/>
                    </div>
                    <c:choose>
                        <c:when test="${requestScope.Contract.status eq 1}">
                            Status: <p style="color:green">OK</p>
                        </c:when>
                        <c:otherwise>
                            Status: <p style="color:red">Expired</p>
                        </c:otherwise>
                    </c:choose>

                    <div style="text-align: center">
                        <input type="hidden" value="${requestScope.Contract.idCon}" name="idcon">
                        <input class="btn btn-primary" type="submit" value="Save"/>
                    </div>
                    <c:forEach var="empId" items="${idEmp.rows}">
                        <input type="hidden" name="idemp" value="${empId.idEmp}"/>
                        <input type="hidden" name="nameEmp" value="${empId.name}"/>
                    </c:forEach>
                    <c:forEach var = "rowlist" items = "${listtype.rows}">
                        <c:if test="${requestScope.Contract.typeCon eq rowlist.name}">
                            <input type="hidden" name="typecon" value="${rowlist.idTypeCon}" >
                        </c:if>
                    </c:forEach>
                    <input class="btn btn-primary" type="hidden" name="action" value="renewal"/>
                </form>
            </div>
        </div>
        <%
            session.removeAttribute("WARNING");
        %>
    </body>
</html>
