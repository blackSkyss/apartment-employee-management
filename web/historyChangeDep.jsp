<%-- 
    Document   : historyChange
    Created on : Jun 5, 2022, 10:28:38 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
            
            .btn-primary{
                border: 1px solid #00c5fb;
                border-radius: 50px;
                color: #fff;
                font-weight: 500;
                text-decoration: none;
                cursor: pointer;
                display: flex;
                width: 100%;
                height: 38px;
                background-color: #55ce63;
                text-transform: uppercase;
                margin-top: 16px
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -24px;
                margin-bottom: 0 !important
            }
            
            .dependent-name{
                display: flex;
                align-items: center
            }

            .dependent-name span{
                margin-right: 6px
            }

            .dependent-name p{
                margin-bottom: 0;
                color: #000;
                font-weight: 500
            }
            
            .table>:not(:first-child) {
                border-top: none; 
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 

        <c:if test="${requestScope.listHisDep != null}">
            <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                               url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                               user = "sa"  password = "12345"/>

            <sql:query dataSource = "${snapshot}" var = "listDep">
                select depName
                from Department
            </sql:query>

            <sql:query dataSource = "${snapshot}" var = "listEmp">
                select e.idEmp, name
                from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc
                where e.idEmp = hd.idEmp and hd.depNum = d.depNum and
                e.idEmp = hp.idEmp and hp.idPos = p.idPos and
                hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and
                statusLog = 1 and role = 0 and hc.status = 1
                order by idEmp ASC
            </sql:query>

            <div style="margin: 0 16px; width: 100%">
                <div class="modal-header">
                    <div style="width: 100%">
                        <h4 style="margin-left: -12px" class="page-title">History change department</h4>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=dep">Department</a></li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=changedep">Change Department</a></li>
                                <li class="breadcrumb-item active">History change departmnet</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <form action="mainController" method="POST" class="form-reward-penalty">
                    <div class="row filter-row">
                        <div class="col-sm-6 col-md-3">
                            <div class="form-group mb-3 mt-3">
                                <input type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchName") == null) ? "" : request.getParameter("txtSearchName")%>" placeholder="Enter name" name="txtSearchName">

                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3 mt-3"> 
                            <div class="form-group form-focus select-focus">
                                <select name="status" class="form-select form-select-md-5 mb-1 list-options" >
                                    <option value="allStatus">All Status</option>
                                    <option value="0">Inactive</option>
                                    <option value="1">Active</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3 mt-3"> 
                            <div class="form-group form-focus select-focus">
                                <select name="depName" class="form-select form-select-md-5 mb-1 list-options" > 
                                    <option value="allDep">All Department</option>
                                    <c:forEach var="listDep" items="${listDep.rows}">
                                        <option value="${listDep.depName}" ><c:out value="${listDep.depName}"/></option>                       
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <input class="btn btn-primary" type="submit" value="Search"/>
                            <input  type="hidden" name="action" value="filterHisDep"/>
                        </div>
                    </div>
                </form>
                <h5>${requestScope.SearchRS}</h5>

                <!--Begin for each-->

                <c:forEach var="listEmp" items="${listEmp.rows}">
                    <div class="accordion accordion-flush" id="accordionFlush${listEmp.idEmp}">
                        <div class="accordion-item">
                            <c:if test="${requestScope.empId ne null || requestScope.nameEmp ne null}">
                                <c:if test="${requestScope.empId eq listEmp.idEmp && fn:contains(fn:toLowerCase(listEmp.name),fn:toLowerCase(requestScope.nameEmp)) || fn:contains(fn:toLowerCase(listEmp.name),fn:toLowerCase(requestScope.nameEmp)) && requestScope.nameEmp ne null}">
                                    <h2 class="accordion-header" id="flush-headingOne">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${listEmp.idEmp}" aria-expanded="false" aria-controls="flush-collapse${listEmp.idEmp}">
                                            <div class="dependent-name">
                                                <span>Id ${listEmp.idEmp} - </span>
                                                <p>${listEmp.name}</p>
                                            </div>
                                        </button>
                                    </h2>
                                </c:if>
                            </c:if>
                            <c:if test="${requestScope.empId eq null && requestScope.nameEmp eq null}">
                                <h2 class="accordion-header" id="flush-headingOne">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${listEmp.idEmp}" aria-expanded="false" aria-controls="flush-collapse${listEmp.idEmp}">
                                        <div class="dependent-name">
                                            <span>Id ${listEmp.idEmp} - </span>
                                            <p>${listEmp.name}</p>
                                        </div>
                                    </button>
                                </h2>
                            </c:if>
                            <div id="flush-collapse${listEmp.idEmp}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlush${listEmp.idEmp}">
                                <div class="accordion-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>                 
                                                <th>ID history</th>
                                                <th>ID department</th>
                                                <th>Department</th>
                                                <th>Delivery date</th>
                                                <th>Exact Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <c:forEach var="listHisDep" items="${requestScope.listHisDep}">
                                            <c:if test="${listEmp.idEmp eq listHisDep.idemp}">
                                                <tbody>
                                                    <tr>
                                                        <td>${listHisDep.idHidDep}</td>
                                                        <td>${listHisDep.iddep}</td>
                                                        <td>${listHisDep.nameDep}</td>
                                                        <td>${listHisDep.deliveryDate}</td>
                                                        <td>${listHisDep.exactDate}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${listHisDep.status eq 0}">
                                                                    <p style="color: red">Inactive</p>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <p style="color:green">Active</p>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                    </tr>
                                                </tbody>
                                            </c:if>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!--End for each-->

            </div>
        </c:if>
    </body>
</html>
