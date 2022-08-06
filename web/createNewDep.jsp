<%-- 
    Document   : createNewDep
    Created on : May 31, 2022, 7:53:10 AM
    Author     : lehon
--%>

<%@page import="management.dto.EmployeeDTO"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Department Page</title>
        <link rel="stylesheet" href="css/globalstyles.css"/>
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
                margin-bottom: 0 !important
            }

            .modal-content{
                background-color: #fff;
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
                        <h5 class="modal-title">Create new department</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=dep">Department</a></li>
                                <li class="breadcrumb-item active">Create new departmnet</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="modal-body">
                    <form action="mainController" method="POST" class="form-position">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput" name="depname" placeholder="Enter name..."
                            <c:if test="${not empty requestScope.namereg}">value="${requestScope.namereg}"</c:if>>
                        <p style="color:red">${requestScope.messName}</p>
                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput2">Description</label>
                        <input type="text" name="depdes" class="form-control" id="formGroupExampleInput2" placeholder="Enter description..."
                               <c:if test="${not empty requestScope.desreg}">value="${requestScope.desreg}"</c:if>>
                        <p style="color:red">${requestScope.messDes}</p>
                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput2">Location</label>
                        <input type="text" name="deploc" class="form-control" id="formGroupExampleInput2" placeholder="Enter location..."
                               <c:if test="${not empty requestScope.locreg}">value="${requestScope.locreg}"</c:if>>
                        <p style="color:red"> ${requestScope.messLoc}</p>
                    </div>
                    <%Date d = new Date();%>
                    <%EmployeeDTO emp = (EmployeeDTO) session.getAttribute("USER_LOGGIN");
                        String name = emp.getName();%>

                    <div class="form-group">
                        <label for="formGroupExampleInput2">Date Create</label>
                        <input type="text" name="depdate" class="form-control" value="<%=d%>" readonly="" id="formGroupExampleInput2" placeholder="Another input">
                    </div>    

                    <div class="form-group">
                        <label for="formGroupExampleInput2">Creator</label>
                        <input type="text" name="depcre" class="form-control" value="<%=name%>"readonly="" id="formGroupExampleInput2" placeholder="Another input">
                    </div>   
                    <div>
                        <p style="color:red">${requestScope.WARNING}</p>
                    </div>
                    <div style="text-align: center">
                        <input class="btn btn-primary" type="submit" name="action" value="Create"/>    
                    </div>
                    <c:if test="${requestScope.SUCCESS != null}">
                        <p style="color:green">${requestScope.SUCCESS}</p>
                    </c:if>
                </form>
            </div>
        </div>
    </body>
</html>
