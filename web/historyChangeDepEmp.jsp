<%-- 
    Document   : historyChange
    Created on : Jun 5, 2022, 10:28:38 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/globalstyles.css"/>
        <title>History Change Department</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            #sidebar{
                height: 100vh
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -30px
            }

            .page-title{
                margin-top: 8px;
                display: inline-block
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="headerEmp.jsp"></c:import>
        <c:import url="sidebarEmp.jsp"></c:import>
            <div style="width: 100%; margin: 0 16px">
                <div class="page-header">
                    <div>
                        <h3 class="page-title">Department</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                    <li class="breadcrumb-item "><a href="mainController?action=showDepartmentEmp">Department</a></li>
                                    <li class="breadcrumb-item active">History department</li>
                                </ul>
                            </div>  
                        </div>
                    </div>
                </div>

            <c:if test="${requestScope.listHisDep != null}">
                <div>
                    <table class="table table-bordered" >
                        <thead >
                            <tr>
                                <th scope="col">Employee</th>
                                <th scope="col">Department</th>
                                <th scope="col">Delivery Date</th>
                                <th scope="col">Exact Date</th>
                                <th scope="col">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="listHisDep" varStatus="counter" items="${requestScope.listHisDep}">    
                                <tr>
                                    <td>${listHisDep.nameEmp}</td>
                                    <td>${listHisDep.nameDep}</td>
                                    <td>${listHisDep.deliveryDate}</td>
                                    <td>${listHisDep.exactDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${listHisDep.status eq 1}">
                                                <p style="color:green; margin-bottom: 0">Active</p>
                                            </c:when>
                                            <c:otherwise>
                                                <p style="color:red; margin-bottom: 0">Inactive</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>                        
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
