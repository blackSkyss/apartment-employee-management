<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dependent</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link rel="stylesheet" href="css/globalstyles.css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }
            .list-employee__actions{
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .breadcrumb{
                background-color: #f7f7f7 !important;
                display: inline-flex !important;
                float: left !important;
                margin-left: -16px;
            }
            .page-title{
                text-align: initial !important;
                margin-left: 2px !important;
                margin-top: 8px
            }
            .search-btn{
                border: 1px solid #00c5fb;
                border-radius: 5px;
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
            .search-btn:hover{
                transform: scale(0.98);
                opacity: 0.9
            }
            .add-btn{
                background-color: #00a8ef;
                border: 1px solid #00c5fb;
                border-radius: 50px;
                color: #fff;
                font-weight: 500;
                min-width: 140px;
                text-decoration: none;
                cursor: pointer;
                padding: 4px 10px;
                display: flex;
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

        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                           user = "sa"  password = "12345"/>

        <sql:query dataSource = "${snapshot}" var = "listEmp">
            select e.idEmp, name
            from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc
            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and
            e.idEmp = hp.idEmp and hp.idPos = p.idPos and
            hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and
            statusLog = 1 and role = 0 and hc.status = 1
            and e.idEmp in(
            select idEmp from Dependent)
            order by idEmp ASC
        </sql:query>

        <c:if test="${requestScope.listDependent != null}">

            <div style="margin: 0 16px; width: 100%">
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Dependent</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    <li class="breadcrumb-item active">Dependent</li>
                                </ul>
                            </div>
                            <div style="margin-right: 8px">          
                                <a class="add-btn" href="mainController?action=addNewDependent" >
                                    <i class="ri-add-fill list__employee-icon"></i>
                                    Add new dependent</a>

                            </div>
                        </div>
                    </div>
                </div>
                <c:if test="${requestScope.updateFail != null}" >
                    <p style="color: red" ><c:out value="${requestScope.updateFail}" /></p> 
                </c:if>
                <c:if test="${requestScope.updateSuccess != null}" >
                    <p style="color: green" ><c:out value="${requestScope.updateSuccess}" /></p>
                </c:if>
                <c:if test="${sessionScope.addDepenSuccess != null}">
                    <p style="color: green" ><c:out value="${sessionScope.addDepenSuccess}"/></p> 
                </c:if>

                <c:if test="${requestScope.Fail != null}" >
                    <p style="color: red" ><c:out value="${requestScope.Fail}" /></p>
                </c:if>
                <form action="mainController" method="post" class="form-reward-penalty">
                    <div class="row filter-row">
                        <div class="col-sm-6 col-md-4">
                            <div class="form-group mb-3 mt-3">
                                <input type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchIdemp") == null) ? "" : request.getParameter("txtSearchIdemp")%>" placeholder="Enter employee id..." name="txtSearchIdemp">                               
                            </div>
                        </div>  
                        <div class="col-sm-6 col-md-4">
                            <div class="form-group mb-3 mt-3">
                                <input type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchName") == null) ? "" : request.getParameter("txtSearchName")%>" placeholder="Enter employee name..." name="txtSearchName">                               
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-4 ">
                            <input type="hidden" name="action" value="searchDependent"/>
                            <input type="submit" value="Search"  class="btn search-btn">
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
                                                <th>Dependent ID</th>
                                                <th>Dependent name</th>
                                                <th>Gender</th>
                                                <th>Date of birth</th>
                                                <th>Relationship</th>
                                                <th>Update</th>
                                            </tr>
                                        </thead>
                                        <c:forEach var="listDependent" items="${requestScope.listDependent}">
                                            <c:if test="${listEmp.idEmp eq listDependent.idEmp}">
                                                <tbody>
                                                    <tr>
                                                        <td>${listDependent.idDepen}</td>
                                                        <td>${listDependent.name}</td>
                                                        <td>${listDependent.gender}</td>
                                                        <td>${listDependent.dob}</td>
                                                        <td>${listDependent.relationship}</td>
                                                        <td>
                                                            <a href="mainController?action=updateDependent&&idEmp=${listDependent.idEmp}&&idDepen=${listDependent.idDepen}">
                                                                <i class="fas fa-edit"></i>
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
                <%
                    HttpSession ss = request.getSession();
                    ss.removeAttribute("addDepenSuccess");
                    ss.removeAttribute("updateFail");
                %>

            </div>
        </c:if>
    </body>
</html>