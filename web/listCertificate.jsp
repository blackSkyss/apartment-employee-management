<%-- 
    Document   : listCertificate
    Created on : Jun 6, 2022, 9:45:26 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Certificate</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/styles.css"/>
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
                display: flex;
                width: 268.6px;
                height: 38px;
                background-color: #55ce63;
                text-transform: uppercase;
                margin-top: -10px
            }

            .search-btn:hover{
                transform: scale(0.95);
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

        <sql:query dataSource = "${snapshot}" var = "listCer">
            select name
            from TypeCertificate
        </sql:query>
        <%
            String type = String.valueOf(request.getAttribute("typeCer"));
            if (type.equals("null")) {
                type = "";
            };
        %>
        <sql:query dataSource = "${snapshot}" var = "listEmp">
            select distinct(e.idEmp), e.name
            from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc,
            Certificate as cert, TypeCertificate as t
            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and
            e.idEmp = hp.idEmp and hp.idPos = p.idPos and
            hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and e.idEmp = cert.idEmp AND cert.idTypeCer = t.idTypeCer and
            statusLog = 1 and role = 0 and hc.status = 1 and t.name like '%<%= type%>%'
            order by idEmp ASC
        </sql:query>
        <div style="width: 100%; margin: 0 16px">

            <div class="page-header">
                <div class="row">
                    <h3 class="page-title">Certificate</h3>
                    <div class="col-sm-12 list-employee__actions">                       
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item active">Certificate</li>
                            </ul>
                        </div>
                        <div style="margin-right: 8px">          
                            <a class="add-btn" href="mainController?action=add new certificate">
                                <i class="ri-add-fill list__employee-icon"></i>
                                Add new Certificate</a>
                        </div>
                    </div>
                </div>
            </div>

            <form action="mainController" method="post" >
                <div class="row filter-row">
                    <div class="col-sm-6 col-md-3">
                        <div class="form-group mb-3 mt-3">
                            <input type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchIdemp") == null) ? "" : request.getParameter("txtSearchIdemp")%>" placeholder="Enter employee id..." name="txtSearchIdemp">
                        </div>
                    </div>  
                    <div class="col-sm-6 col-md-3">
                        <div class="form-group mb-3 mt-3">
                            <input type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchName") == null) ? "" : request.getParameter("txtSearchName")%>" placeholder="Enter name..." name="txtSearchName">
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3" style="margin-top: 15px">
                        <select class="form-select form-select-md-5 mb-1 list-option form-controls" name="typecer"> 
                            <option value="allCer" >All Type Certificate</option>
                            <c:forEach var="listCer" items="${listCer.rows}">
                                <option value="${listCer.name}"
                                        <c:if test="${listCer.name eq sessionScope.typecer}">selected="${listCer.name}"</c:if>>${listCer.name}</option>
                            </c:forEach>
                        </select>
                    </div> 
                    <div class="col-sm-6 col-md-3 ">
                        </br>
                        <input type="submit" value="Search" class="btn search-btn">
                        <input type="hidden" name="action" value="searchCer" >
                    </div>
                </div>
            </form>
            <h5>${requestScope.SearchRS}</h5>

            <c:if test="${sessionScope.Success != null}">
                <p style="color: green" ><c:out value="${sessionScope.Success}"/></p> 
            </c:if>
            <c:if test="${updateSuccess != null}" >
                <p style="color: green" ><c:out value="${updateSuccess}" /></p>
            </c:if>
            <c:if test="${updateFail != null}" >
                <p style="color: red" > <c:out value="${updateFail}" /></p>
            </c:if>


            <!--begin for each-->

            <c:forEach var="listEmp" items="${listEmp.rows}">
                <c:if test="${listEmp.idEmp ne null}">
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
                                                <th>Certificate ID</th>
                                                <th>Certificate name</th>
                                                <th>Date of issues</th>
                                                <th>Type certificate</th>
                                                <th>Update</th>
                                            </tr>
                                        </thead>
                                        <c:forEach var="listCer" items="${requestScope.listCer}">
                                            <c:if test="${listEmp.idEmp eq listCer.idEmp}">
                                                <tbody>
                                                    <tr>
                                                        <td>${listCer.cerId}</td>
                                                        <td class="list__employee-item">
                                                            <span>
                                                                <img class="list__employee-item-img" src='images/${listCer.imgPath}'>
                                                            </span>
                                                            <div class="list__employee-description">
                                                                <span class="list__employee-description-name">${listCer.cerName}</span>                 
                                                            </div>
                                                        </td>
                                                        <td>${listCer.doi}</td>
                                                        <td>${listCer.type}</td>
                                                        <td><a href="mainController?action=updateCertificate&&idEmp=${listCer.idEmp}&&cerId=${listCer.cerId}&&idTypeCer=${listCer.idTypeCer}"><i class="fas fa-edit"></i></a></td>
                                                    </tr>
                                                </tbody>
                                            </c:if>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <%
                HttpSession ss = request.getSession();
                ss.removeAttribute("Success");
            %>
            <!--End for each-->
        </div>
    </body>
</html>
