<%-- 
    Document   : createNewCon
    Created on : Jun 7, 2022, 8:09:10 AM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create new contract Page</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }
            .certificate-select{
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                width: 100%;
                height: 42px
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
            }

            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                margin-top: 16px;
                width: 20%;
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
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

        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                           user = "sa"  password = "12345"/>

        <sql:query dataSource = "${snapshot}" var = "resultemp">
            select DISTINCT idEmp, name
            from Employee
            where idEmp not in (
            select e.idEmp
            from Employee as e, Contract as c, HistoryContract as hc
            where c.idContract = hc.idContract and e.idEmp = hc.idEmp and hc.status = 1 ) and idEmp not in(select e.idEmp
            from Employee as e, Contract as c, HistoryContract as hc
            where c.idContract = hc.idContract and e.idEmp = hc.idEmp and hc.status = 0) and role = 0
        </sql:query>

        <sql:query dataSource = "${snapshot}" var = "resulttype">
            select idTypeCon, name
            from TypeContract
        </sql:query>


        <c:if test="${resultemp.rowCount != 0}">
            <div style="width: 100%; margin: 0 20%" class="modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Create new contract</h5>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                            <li class="breadcrumb-item"><a href="mainController?action=showlist&type=con">Contract</a></li>
                            <li class="breadcrumb-item active">Create new contract</li>
                        </ul>
                    </div>

                </div>

                <div class="modal-body">
                    <form action="mainController" method="post" class="form-position" enctype="multipart/form-data">
                        <div class="form-group">
                            <div style="margin-bottom: 8px">Choose Employee</div>
                            <select name="idemp" class="certificate-select">
                                <c:forEach var = "rowemp" items = "${resultemp.rows}">
                                    <option value="${rowemp.idEmp}" 


                                            <c:if test="${requestScope.empreg != null}">
                                                <c:if test="${requestScope.empreg eq rowemp.idEmp}">selected=""</c:if>
                                            </c:if>>ID: ${rowemp.idEmp} - ${rowemp.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <div style="margin-bottom: 8px">Type of contract</div>
                            <select name="typecon" class="certificate-select">
                                <c:forEach var = "rowtype" items = "${resulttype.rows}">
                                    <option value="${rowtype.idTypeCon}"

                                            <c:if test="${requestScope.conreg != null}">
                                                <c:if test="${requestScope.conreg eq rowtype.idTypeCon}">selected=""</c:if>
                                            </c:if>>${rowtype.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <%Date d = new Date();%>
                        <div class="form-group">
                            <label>Sign Day</label>
                            <input class="form-control" type="text" name="signday" value="<%=d%>" readonly="">
                        </div>


                        <div class="form-group">
                            <label>Expiration Day</label>
                            <input class="form-control" type="date" name="expday" 
                                   <c:if test="${not empty requestScope.expreg}">value="${requestScope.expreg}"</c:if>
                                       >
                            </div>
                            <p style="color:red">${requestScope.WARNING}</p>
                        <p style="color:green">${requestScope.COMPLETE}</p>  

                        <input type="hidden" name="action" value="createcon">
                        <div style="text-align: center">
                            <input class="btn btn-primary" type="submit" value="Create"> 
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
        <c:if test="${resultemp.rowCount == 0}">
            <p style="color:green">All employees have been registered for the contract</p>
        </c:if>
    </body>
</html>
