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
        <title>History Contract</title>
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

            .list-contract{
                display: flex;
                align-items: center
            }

            .list-contract span{
                margin-right: 6px
            }

            .list-contract p{
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
        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                           user = "sa"  password = "12345"/>

        <sql:query dataSource = "${snapshot}" var = "listTyCon">
            select name
            from TypeContract
        </sql:query>
        <%
            String typeCon = String.valueOf(session.getAttribute("typecon"));
            String status = String.valueOf(session.getAttribute("statuscon"));
            String empName = request.getParameter("empname");
            if (typeCon.equals("null") || typeCon.trim().isEmpty()) {
                typeCon = "";
            }
            if (status.equals("null")) {
                status = "";
            }
            if (empName == null) {
                empName = "";
            }
        %>
        <sql:query dataSource="${snapshot}" var="listEmp">
            select  distinct(e.idEmp), e.name
            from Contract as c, Employee as e, TypeContract as tc, HistoryContract as hc
            where hc.idEmp = e.idEmp and hc.idContract= c.idContract and c.idTypeCon = tc.idTypeCon and e.role = 0
            and e.name like '%<%= empName%>%' and tc.name like '%<%= typeCon%>%' and hc.status like '%<%= status%>%'
        </sql:query>
        <div style="margin: 0 16px; width: 100%">
            <div class="page-header">
                <div class="row">
                    <h3 class="page-title">History Contract</h3>
                    <div class="col-sm-12 list-employee__actions">                       
                        <div>
                            <ul class="breadcrumb">
                                <c:if test="${requestScope.idEmp eq null}">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    </c:if>
                                    <c:if test="${requestScope.idEmp ne null}">
                                    <li class="breadcrumb-item"><a href="mainController?action=passidemp&empid=${requestScope.idEmp}&type=detail">Employee</a></li>
                                    </c:if>
                                <li class="breadcrumb-item"><a href="mainController?action=showlist&type=con">Contract</a></li>
                                <li class="breadcrumb-item active">History contract</li>
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
                        <select class="form-select form-select-md-5 mb-1 list-options" name="typecon"> 
                            <option value="" >All Type</option>
                            <c:forEach var="listTyCon" items="${listTyCon.rows}">
                                <option value="${listTyCon.name}"
                                        <c:if test="${listTyCon.name eq sessionScope.typecon}">selected="${listTyCon.name}"</c:if>>${listTyCon.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-sm-6 col-md-3" style="margin-top: 15px">
                        <select class="form-select form-select-md-5 mb-1 list-options" name="statuscon"> 
                            <option value="" <c:if test="${null eq sessionScope.statuscon}">selected=""</c:if>>All Contract</option>
                            <option value="1" <c:if test="${'1' eq sessionScope.statuscon}">selected="1"</c:if>>Active</option>
                            <option value="0" <c:if test="${'0' eq sessionScope.statuscon}">selected="0"</c:if>>Expired</option> 
                            </select>
                        </div> 
                        <div class="col-sm-6 col-md-3 ">
                            <input type="submit" value="Search"  class="btn search-btn">
                            <input type="hidden" value="searchHisCon" name="action" >
                        </div>
                    </div>
                </form>
            <c:if test="${requestScope.listCon != null}">
                <c:if test="${not empty requestScope.listCon}">
                    <c:forEach var="Emp" items="${listEmp.rows}">
                        <div class="accordion accordion-flush" id="accordionFlush${Emp.idEmp}">
                            <div class="accordion-item">
                                <c:if test="${requestScope.idEmp ne null}">
                                    <c:if test="${requestScope.idEmp eq Emp.idEmp}">
                                        <h2 class="accordion-header" id="flush-headingOne">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${Emp.idEmp}" aria-expanded="false" aria-controls="flush-collapse${Emp.idEmp}">
                                                <div class="list-contract">
                                                    <span>Id ${Emp.idEmp} - </span> 
                                                    <p>${Emp.name}</p>
                                                </div>
                                            </button>
                                        </h2>
                                    </c:if>
                                </c:if>
                                <c:if test="${requestScope.idEmp eq null}">
                                    <h2 class="accordion-header" id="flush-headingOne">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${Emp.idEmp}" aria-expanded="false" aria-controls="flush-collapse${Emp.idEmp}">
                                            <div class="list-contract">
                                                <span>Id ${Emp.idEmp} - </span> 
                                                <p>${Emp.name}</p>
                                            </div>
                                        </button>
                                    </h2>
                                </c:if>
                                <div id="flush-collapse${Emp.idEmp}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlush${Emp.idEmp}">
                                    <div class="accordion-body">
                                        <table class="table table-bordered">
                                            <thead >
                                                <tr style="text-align: center">
                                                    <th scope="col">ID History</th>
                                                    <th scope="col">Employee</th>
                                                    <th scope="col">Type</th>
                                                    <th scope="col">Sign Date</th>
                                                    <th scope="col">Expired Date</th>
                                                    <th scope="col">Status</th>
                                                </tr>
                                            </thead>
                                            <c:forEach var="listHisCon" varStatus="counter" items="${requestScope.listCon}">
                                                <c:if test="${listHisCon.nameEmp eq Emp.name}">
                                                    <tbody>
                                                        <tr style="text-align: center">
                                                            <td>${listHisCon.idCon}</td>                            
                                                            <td>${listHisCon.nameEmp}</td>
                                                            <td>${listHisCon.typeCon}</td>
                                                            <td>${listHisCon.signDay}</td>
                                                            <td>${listHisCon.expDay}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${listHisCon.status eq 1}">
                                                                        <p style="color:green; margin-bottom: 0">Active</p>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <p style="color:red; margin-bottom: 0">Inactive</p>
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
                </div>
            </c:if>
        </c:if>
    </body>
</html>
