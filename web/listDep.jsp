<%-- 
    Document   : listDep
    Created on : May 29, 2022, 8:06:05 PM
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
        <title>List Department</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .btn-primary{
                background-color: #55ce63 !important;
                border: 1px solid #55ce63 !important;
                border-radius: 5px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                width: 100%
            }

            .btn-primary:hover{
                transform: scale(0.96);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -16px;
            }

            .page-title{
                margin-top: 8px
            }

            .list-employee__actions{
                display: flex;
                justify-content: space-between;
            }

            .dep-link{
                font-weight: 500;
                padding: 4px 8px;
                background-color: #00a8ef;
                border-radius: 5px;
                color: #fff;
            }

            .dep-link:hover{
                opacity: 0.9;
                transform: scale(0.95);
                color: #000
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file="header.jsp" %>
        </header>

        <%HttpSession ss = request.getSession();%>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="sidebar.jsp"></c:import>
        <c:if test="${requestScope.listDep != null}">
            <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                               url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                               user = "sa"  password = "12345"/>

            <sql:query dataSource = "${snapshot}" var = "listLocation">
                select location
                from Department
            </sql:query>
            <div style="margin: 0 16px" class="list-employee">
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Department</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    <li class="breadcrumb-item active">Department</li>
                                </ul>
                            </div>
                            <div>
                                <p style="color:green">${requestScope.WARNING}<p>
                                <p style="color:green">${sessionScope.COMPLETED}<p>
                                    <%ss.removeAttribute("COMPLETED");%>
                            </div>
                            <div>                     
                                <a style="margin-right: 8px" class="dep-link" href="createNewDep.jsp">Create New Department</a>
                                <a class="dep-link" href="mainController?action=showlist&type=changedep">Change Department</a>
                            </div>
                        </div>
                    </div>
                </div>
                <form action="mainController" method="POST" class="form-reward-penalty">
                    <div class="row filter-row" >
                        <div class="col-sm-6 col-md-4">
                            <div class="form-group mb-3 mt-3">
                                <input placeholder="Enter department name..." type="text" class="form-control " id="email" value="<%= (request.getParameter("txtSearchName") == null) ? "" : request.getParameter("txtSearchName")%>" name="txtSearchName">        
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 mt-3"> 
                            <div class="form-group form-focus select-focus">
                                <select name="locationDep" class="form-select form-select-md-5 mb-1 list-options" > 
                                    <option value="allDep">All Department</option>
                                    <c:forEach var="listLocation" items="${listLocation.rows}">
                                        <option value="${listLocation.location}" ><c:out value="${listLocation.location}"/></option>                       
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 " style="margin-top: 14px">
                            <input class="btn btn-primary" type="submit" value="Search"/>
                            <input  type="hidden" name="action" value="filterDepByLocation"/>
                        </div>
                    </div>
                </form>
                <h5>${requestScope.SearchRS}</h5>
                <div class="list-dep">
                    <table class="table table-bordered" style="font-size: 14px">
                        <thead>
                            <tr>
                                <th scope="col">Dep No.</th>
                                <th scope="col">Name</th>
                                <th scope="col">Description</th>
                                <th scope="col">Location</th>
                                <th scope="col">Date Create</th>
                                <th scope="col">Creator</th>
                                <th scope="col">Update</th>
                                <th scope="col">Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="listDep" varStatus="counter" items="${requestScope.listDep}">
                            <form action="mainController">
                                <tr>
                                    <td>${listDep.depNum}</td>                            
                                    <td>
                                        <div>
                                            <span> ${listDep.depName}</span>
                                            <c:forEach var="numberOfEmp" items="${requestScope.numberOfEmp}">
                                                <c:if test="${listDep.depNum eq numberOfEmp.key}">
                                                    <div>
                                                        ${numberOfEmp.value}

                                                        <i style="margin-left: 2px" class="fas fa-user"></i>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <td>${listDep.description}</td>
                                    <td class="location">${listDep.location}</td>
                                    <td>${listDep.dateCreate}</td>
                                    <td>${listDep.creator}</td>

                                    <td style="text-align: center">
                                        <a href="mainController?action=passiddep&iddep=${listDep.depNum}"><i class="fas fa-edit"></i></a>

                                    </td>
                                    <td style="text-align: center">
                                        <a href="mainController?action=detailDep&iddep=${listDep.depNum}">
                                            <i class="fas fa-info"></i>
                                        </a>
                                    </td>
                                </tr>
                            </form> 
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>
    </body>
</html>
