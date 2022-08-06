<%-- 
    Document   : createNewEmp
    Created on : Jun 10, 2022, 4:17:53 PM
    Author     : lehon
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Employee</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important
            }
            /*Create new employee*/

            .form__title-gender{
                margin-top: 10px;
                padding: 2px 0;
            }

            .form__title{
                padding: 4px 0;
            }

            .btn-primary{
                background-color: 00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                min-width: 150px;
                padding: 10px 20px;
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .modal-content{
                background-color: #fff;
                margin-bottom: 16px !important
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 

            <div class="modal-content" style="margin: 0 15%">           
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Add Employee</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=emp">Employee</a></li>
                                <li class="breadcrumb-item active">Add Employee</li>
                            </ul>
                        </div>
                    </div>
                </div>


                <div>
                    <div >
                        <p style="color:red">${requestScope.WARNINGFIELD}</p>
                    <p style="color:green">${requestScope.COMPLETED}</p>
                    <p style="color: red">${requestScope.FAILINSERT}</p>
                </div>
            </div>


            <div class="modal-body">
                <form action="mainController" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Name</label>
                                <input class="form-control"  type="text" name="empname"
                                       <c:if test="${not empty requestScope.namereg}">value="${requestScope.namereg}"</c:if>>
                                <p style="color: red">${requestScope.WARNINGNAME}</p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Base salary($)</label>
                                <input class="form-control"  type="number" name="salary"
                                       <c:if test="${not empty requestScope.salaryreg}">value="${requestScope.salaryreg}"</c:if>>
                                <p style="color: red">${requestScope.WARNINGSALARY}</p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Address</label>
                                <input class="form-control" type="text" name="empadd"
                                       <c:if test="${not empty requestScope.addreg}">value="${requestScope.addreg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGADD}</p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Phone </label>
                                <input class="form-control" type="text" name="empphone"
                                       <c:if test="${not empty requestScope.phonereg}">value="${requestScope.phonereg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGPHONE}</p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Day of birth </label>
                                <input class="form-control" type="date" name="empdob"
                                       <c:if test="${not empty requestScope.dobreg}">value="${requestScope.dobreg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGDOB}</p>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Image</label>
                                <input class="form-control" name="empimg" type="file" accept="image/*">
                            </div>
                        </div>
                        <div class="col-sm-6">  
                            <div class="form-group">
                                <label class="col-form-label">Email</label>
                                <input type="text" class="form-control" name="empmail" 
                                       <c:if test="${not empty requestScope.emailreg}">value="${requestScope.emailreg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGMAIL}</p>
                                <p style="color:red">${requestScope.WARNINGMAILS}</p>

                            </div>
                        </div>
                        <div class="col-sm-6">  
                            <div class="form-group">
                                <label class="col-form-label">Password</label>
                                <input type="text" class="form-control" name="emppass" 
                                       <c:if test="${not empty requestScope.passreg}">value="${requestScope.passreg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGPASS}</p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="form__title-gender">Gender</div>
                                <select class="form-control" name="empgen">

                                    <option value="Male" 
                                            <c:if test="${requestScope.genreg == 'Male'}">selected=""</c:if>>Male
                                            </option>

                                            <option value="Female" 
                                            <c:if test="${requestScope.genreg == 'Female'}">selected=""</c:if>>Female
                                            </option>

                                            <option value="Other" 
                                            <c:if test="${requestScope.genreg == 'Other'}">selected=""</c:if>>Other
                                            </option>

                                    </select>
                                </div>
                            </div>

                        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                                           user = "sa"  password = "12345"/>

                        <!--list department-->
                        <div class="col-md-6">
                            <div class="form-group">
                                <sql:query dataSource = "${snapshot}" var = "listdep">
                                    select depNum, depName
                                    from Department
                                </sql:query>
                                <div class="form__title">Department</div>
                                <fmt:parseNumber var="iddep" type="number" value="${requestScope.depreg}"></fmt:parseNumber>
                                    <select name="empdep" class="form-control">
                                    <c:forEach var = "rowdep" items = "${listdep.rows}">
                                        <option value="${rowdep.depNum}"
                                                <c:if test="${rowdep.depNum eq iddep}">selected=""</c:if>>${rowdep.depName}
                                                </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!--list position-->
                        <div class="col-sm-6">
                            <div class="form-group">
                                <sql:query dataSource = "${snapshot}" var = "listpos">
                                    select idPos, posName
                                    from Position
                                </sql:query>
                                <div class="form__title">Position</div>
                                <fmt:parseNumber var="idpos" type="number" value="${requestScope.posreg}"></fmt:parseNumber>
                                    <select name="emppos" class="form-control" >
                                    <c:forEach var = "rowpos" items = "${listpos.rows}">
                                        <option value="${rowpos.idPos}"
                                                <c:if test="${rowpos.idPos eq idpos}">selected=""</c:if>>${rowpos.posName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <%Date d = new Date();%>
                                <label class="col-form-label">Join Day</label>
                                <input class="form-control" type="text" name="empjoin" readonly="" value="<%=d%>">
                            </div>
                        </div>  

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Exact Date </label>
                                <input class="form-control" type="date" name="exact"
                                       <c:if test="${not empty requestScope.exactreg}">value="${requestScope.exactreg}"</c:if>>
                                <p style="color:red">${requestScope.WARNINGEXACT}</p>
                            </div>
                        </div>    

                    </div>



                    <div style="text-align: center">
                        <input type="hidden" name="action" value="createEmp">
                        <input class="btn btn-primary" type="submit" value="Create">
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>
