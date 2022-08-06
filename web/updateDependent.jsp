<%-- 
    Document   : updateDependent
    Created on : Jun 12, 2022, 9:11:32 PM
    Author     : AD
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Dependent</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .page-title{
                text-align: initial !important;
                margin-left: 16px !important;
                margin-top: 8px;
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: 2px
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import>

        <c:if test="${requestScope.depenObject != null}">

            <div style=" width: 100%; margin: 0 16px">
                <div class="page-header">
                    <div>
                        <h4 class="page-title">Update Dependent</h4>   
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item"><a href="mainController?action=listDependent">Dependent</a></li>
                                <li class="breadcrumb-item active">Update dependent</li>
                            </ul>
                        </div>
                    </div>

                    <c:if test="${requestScope.filedBlank != null}" >
                        <p style="color: red" ><c:out value="${requestScope.filedBlank}" /></p>
                    </c:if>




                    <table class="table table-striped list-certificate" style="font-size: 14px">
                        <thead>
                            <tr style="text-align: center">
                                <th scope="col">EmployeeID</th>
                                <th scope="col">Employee name</th>                      
                                <th scope="col">Dependent ID</th>
                                <th scope="col">Dependent name</th>
                                <th scope="col">Gender</th>
                                <th scope="col">Date of birth</th>
                                <th scope="col">Relationship</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <form action="mainController">
                            <c:forEach var="depenObject" items="${requestScope.depenObject}">    
                                <tr style="text-align: center">
                                    <td scope="row">${depenObject.idEmp}</td>
                                    <td>${depenObject.empName}</td>                            
                                    <td>${depenObject.idDepen}</td>
                                    <td><input name="name" value="${depenObject.name}"></td>
                                        <c:if test="${requestScope.nameInvalid != null}" >
                                    <p style="color: red" ><c:out value="${requestScope.nameInvalid}" /></p>
                                </c:if>
                                <td>
                                    <select name="gender">
                                        <option value="Male" <c:if test="${depenObject.gender eq 'Male'}">selected="${Male}"</c:if>>Male</option>
                                        <option value="Female"<c:if test="${depenObject.gender eq 'Female'}">selected="${Female}"</c:if>>Female</option>
                                        <option value="Other" <c:if test="${depenObject.gender eq 'Other'}">selected="${Other}"</c:if>>Other</option>
                                        </select>                                    
                                    </td>
                                    <td><input type="date" name="dob" value="${depenObject.dob}" required="">
                                    <c:if test="${requestScope.checkDob != null}" >
                                        <p style="color: red" ><c:out value="${requestScope.checkDob}" /></p>
                                    </c:if>
                                </td>
                                <td><input name="relationship" value="${depenObject.relationship}">
                                    <c:if test="${requestScope.checkRelationship != null}" >
                                        <p style="color: red" ><c:out value="${requestScope.checkRelationship}" /></p>
                                    </c:if>
                                    <input type="hidden" name="idEmp" value="${depenObject.idEmp}">
                                    <input type="hidden" name="idDepen" value="${depenObject.idDepen}"></td>
                                <input type="hidden" name="action" value="Save Dependent"></td>
                                <td><input class="btn btn-secondary btn-sm" type="submit" value="Save"></td>
                                </tr>                        
                            </c:forEach>
                        </form>
                        </tbody>
                    </table>
                </div>
            </c:if>

    </body>
</html>
