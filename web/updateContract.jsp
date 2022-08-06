<%-- 
    Document   : updateContract
    Created on : Jun 7, 2022, 9:13:49 PM
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
        <title>Update Contract Page</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }
            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                margin-top: 16px;
                width: 20%
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
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


            <div style="width: 100%; margin: 0 20%" class="modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Update contract</h5>
                        <ul class="breadcrumb">
                        <c:if test="${requestScope.idEmp eq null}">
                            <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                            </c:if>
                            <c:if test="${requestScope.idEmp ne null}">
                            <li class="breadcrumb-item"><a href="mainController?action=passidemp&empid=${requestScope.idEmp}&type=detail">Employee</a></li>
                            </c:if>
                        <li class="breadcrumb-item"><a href="mainController?action=showlist&type=con">Contract</a></li>
                        <li class="breadcrumb-item active">Update contract</li>
                    </ul>
                </div>

            </div>

            <div class="modal-body">
                <form action="mainController" method="POST" class="form-position" enctype="multipart/form-data">

                    <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                       url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                                       user = "sa"  password = "12345"/>

                    <sql:query dataSource = "${snapshot}" var = "listtype">
                        select idTypeCon, name
                        from TypeContract
                    </sql:query>

                    <p>Contract of employee : ${requestScope.Contract.nameEmp} </p>
                    <p style="color:red">${requestScope.WARNING}</p>

                    <div class="form-group">
                        <label>Type of contract</label>
                        <select name="typecon" class="form-control">
                            <c:forEach var = "rowlist" items = "${listtype.rows}">

                                <option value="${rowlist.idTypeCon}"
                                        <c:if test="${requestScope.Contract.typeCon eq rowlist.name}">
                                            selected=""
                                        </c:if>
                                        >${rowlist.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <div class="form-group">
                            <span style="margin-bottom: 8px">
                                Sign Day
                            </span> 
                            <input class="form-control" type="text" readonly="" value="${requestScope.Contract.signDay}"/>
                        </div>
                        <div class="form-group">
                            <span style="margin-bottom: 8px">
                                Expiration Day 
                            </span>
                            <input class="form-control" type="date" value="${requestScope.Contract.expDay}" name="expday"/>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${requestScope.Contract.status eq 1}">
                            Status: <p style="color:green; margin-bottom: 0">Active</p>
                        </c:when>
                        <c:otherwise>
                            Status: <p style="color:red; margin-bottom: 0">Expired</p>
                        </c:otherwise>
                    </c:choose>

                    <div style="text-align: center">
                        <input type="hidden" value="${requestScope.Contract.idCon}" name="idcon">
                        <input type="hidden" value="${requestScope.Contract.nameEmp}" name="nameEmp">
                        <input class="btn btn-primary" type="submit" value="Save"/> 
                        <input class="btn btn-primary" type="hidden" name="action" value="updateCon"/> 
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
