<%-- 
    Document   : historyPromoteAndDemote
    Created on : Jun 6, 2022, 3:32:01 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History of promote and demote</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .search-btn{
                border: 1px solid #00c5fb;
                border-radius: 50px;
                color: #fff;
                font-weight: 500;
                text-decoration: none;
                cursor: pointer;
                width: 100%;
                height: 38px;
                background-color: #55ce63;
                text-transform: uppercase;
                margin-top: 15px
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -14px;
                margin-bottom: 0 !important;
                padding-top: 0 !important
            }

            .search-btn:hover{
                transform: scale(0.95)
            }

            .pd-body td{
                padding: 0 !important;
                vertical-align: middle !important
            }

            .page-title{
                margin-left: 4px;
                margin-top: 16px
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

        <sql:query dataSource = "${snapshot}" var = "listDep">
            select depName
            from Department
        </sql:query>
        <%
            String typeHisPos = String.valueOf(session.getAttribute("typehispos"));
            String status = String.valueOf(session.getAttribute("statushispos"));
            String empName = request.getParameter("empname");
            if (typeHisPos.equals("null") || typeHisPos.trim().isEmpty()) {
                typeHisPos = "";
            }
            if (status.equals("null")) {
                status = "";
            }
            if (empName == null) {
                empName = "";
            }
        %>
        <sql:query dataSource = "${snapshot}" var = "listEmp">
            SELECT distinct(e.idEmp), e.name
            FROM Employee as e, Position as p, HistoryPos as hp, Contract as c, HistoryContract as hc
            WHERE e.idEmp = hp.idEmp AND p.idPos = hp.idPos and c.idContract=hc.idContract and hc.idEmp=e.idEmp and e.role = 0 and hc.status = 1
            and e.name like '%<%= empName%>%' and hp.type like '%<%= typeHisPos%>%' and hp.status like '%<%= status%>%'
            order by idEmp ASC
        </sql:query>
        <div style="margin: 0 16px; width: 100%">
            <div class="page-header">
                <div class="row">
                    <h3 class="page-title">History of promote and demote</h3>
                    <div class="col-sm-12 list-employee__actions">                       
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=listPosition">Position</a></li>
                                <li class="breadcrumb-item "><a href="mainController?action=searchPro">Promote/Demote</a></li>
                                <li class="breadcrumb-item active">History of promote and demote</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <form action="mainController" method="post" >
                <div class="row filter-row" style="margin-bottom: 16px">
                    <div class="col-sm-6 col-md-3">
                        <div class="form-group mb-3 mt-3">
                            <input type="text" class="form-control" id="email" value="<%= (request.getParameter("empname") == null) ? "" : request.getParameter("empname")%>" placeholder="Enter employee name..." name="empname">
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3" style="margin-top: 15px"> 
                        <select class="form-select form-select-md-5 mb-1 list-options" name="typehispos"> 
                            <option value="" <c:if test="${null eq sessionScope.typehispos}">selected=""</c:if>>All Type</option>
                            <option value="1" <c:if test="${'1' eq sessionScope.typehispos}">selected="1"</c:if>>Promote</option>
                            <option value="0" <c:if test="${'0' eq sessionScope.typehispos}">selected="0"</c:if>>Demote</option>
                            </select>
                        </div>
                        <div class="col-sm-6 col-md-3" style="margin-top: 15px">
                            <select class="form-select form-select-md-5 mb-1 list-options" name="statushispos"> 
                                <option value="" <c:if test="${null eq sessionScope.statushispos}">selected=""</c:if>>All Status</option>
                            <option value="1" <c:if test="${'1' eq sessionScope.statushispos}">selected="1"</c:if>>Active</option>
                            <option value="0" <c:if test="${'0' eq sessionScope.statushispos}">selected="0"</c:if>>Inactive</option>
                            </select>
                        </div> 
                        <div class="col-sm-6 col-md-3 ">
                            <input type="hidden" value="searchHisPos" name="action" class="btn search-btn">
                            <input type="submit" value="Search" class="btn search-btn">
                        </div>
                    </div>
                </form>
            <c:if test="${requestScope.listHisPos != null}">
                <c:forEach var="listEmp" items="${listEmp.rows}">
                    <div class="accordion accordion-flush" id="accordionFlush${listEmp.idEmp}">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingOne">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${listEmp.idEmp}" aria-expanded="false" aria-controls="flush-collapse${listEmp.idEmp}">
                                    <div class="dependent-name">
                                        <span>Id ${listEmp.idEmp} - </span>
                                        <p>${listEmp.name}</p>
                                    </div>
                                </button>
                            </h2>
                            <div id="flush-collapse${listEmp.idEmp}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlush${listEmp.idEmp}">
                                <div class="accordion-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>                 
                                                <th>ID history</th>
                                                <th>Position</th>
                                                <th>Delivery date</th>
                                                <th>Exact Date</th>
                                                <th>Type</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <c:forEach var="listHisPos" items="${requestScope.listHisPos}">
                                            <c:if test="${listEmp.idEmp eq listHisPos.idEmp}">
                                                <tbody>
                                                    <tr>
                                                        <td>${listHisPos.idHisPos}</td>
                                                        <td>${listHisPos.posName}</td>
                                                        <td>${listHisPos.deliveryDate}</td>
                                                        <td>${listHisPos.exactDate}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${listHisPos.type eq 0}">
                                                                    <p style="color: red">Demote</p>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <p style="color:green">Promote</p>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${listHisPos.status eq 0}">
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
            </c:if>
        </div>
    </body>
</html>
