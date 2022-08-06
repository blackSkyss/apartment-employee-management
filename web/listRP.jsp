
<%@page import="java.util.ArrayList"%>
<%@page import="management.dto.RewardPenaltyDTO"%>
<%@page import="management.dao.RewardPenaltyDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reward And Penalty</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="css/globalstyles.css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -16px;
            }

            .search-btn{
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
                text-transform: uppercase
            }

            .search-btn:hover{
                transform: scale(0.9)
            }

            .list__regulation-item{
                display: flex;
                align-items: center
            }

            .list__regulation-item-img{
                width: 38px;
                height: 38px;
                border-radius: 50%
            }

            .list__regulation-description{
                display: flex;
                flex-direction: column;
                text-align: initial;
                font-size: 14px;
                margin-left: 8px
            }

            .list__regulation-description-name{
                font-weight: 600;
                margin-bottom: 2px
            }

            .list__regulation-description-dep{
                font-size: 13px;
                opacity: 0.9
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
        <header>
            <%@include file="header.jsp" %>
        </header>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="sidebar.jsp"></c:import>
        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                           user = "sa"  password = "12345"/>

        <sql:query dataSource = "${snapshot}" var = "listDep">
            select depName
            from Department
        </sql:query>
        <%
            String type = String.valueOf(request.getAttribute("nameDep"));
            if (type.equals("null")) {
                type = "";
            };
        %>
        <sql:query dataSource = "${snapshot}" var = "listEmp">
            select distinct(e.idEmp), e.name
            from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc, RewardAndPenalty as r, Regulation as re
            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and
            e.idEmp = hp.idEmp and hp.idPos = p.idPos and r.idReg = re.idReg and e.idEmp = r.idEmp and
            hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and
            statusLog = 1 and role = 0 and hc.status = 1 and d.depName like '%<%= type%>%'
            order by idEmp ASC
        </sql:query>
        <div style="margin: 0 16px" class="list-employee">

            <div class="page-header">
                <div class="row">
                    <h3 class="page-title">Reward - Penalty</h3>
                    <div class="col-sm-12 list-employee__actions">                       
                        <div>
                            <ul class="breadcrumb">
                                <c:if test="${requestScope.idEmp ne ''}">
                                    <li class="breadcrumb-item"><a href="mainController?action=passidemp&empid=${requestScope.idEmp}&type=detail">Employee Records</a></li>
                                    </c:if>
                                    <c:if test="${requestScope.idEmp eq ''}">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    </c:if>
                                <li class="breadcrumb-item active">Reward-Penalty</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <form action="mainController" method="post" class="form-reward-penalty">
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
                    <div class="col-sm-6 col-md-3" style="margin-top: 16px"> 
                        <div class="form-group form-focus select-focus">
                            <select name="depName" class="form-select form-select-md-5 mb-1 list-options" > 
                                <option value="allDep">All Department</option>
                                <c:forEach var="listDep" items="${listDep.rows}">
                                    <option value="${listDep.depName}"
                                            <c:if test="${listDep.depName eq sessionScope.depName}">selected="${listDep.depName}"</c:if>>${listDep.depName}</option>                       
                                </c:forEach>
                            </select>
                        </div>
                    </div>        
                    <div class="col-sm-6 col-md-3 " style="margin-top: 15px">
                        <input type="submit" value="Search"  class="btn search-btn">
                        <input type="hidden" name="action" value="searchRP"/>
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
                                            <th>Type</th>
                                            <th>Times</th>
                                            <th>Date</th>
                                            <th>Reason</th>
                                            <th>Description</th>
                                            <th>Edit</th>
                                        </tr>
                                    </thead>
                                    <c:forEach var="listrp" varStatus="counter" items="${requestScope.listrp}">
                                        <c:if test="${listEmp.idEmp eq listrp.idEmp}">
                                            <tbody>
                                                <tr>
                                                    <td><c:choose>
                                                            <c:when test="${listrp.status eq  1}">Reward</c:when>
                                                            <c:otherwise>Penalty</c:otherwise>
                                                        </c:choose></td>
                                                    <td>${listrp.times}</td>
                                                    <td>${listrp.applicableDate}</td>
                                                    <td>${listrp.namere}</td>
                                                    <td>${listrp.reason}</td>
                                                    <td>
                                                        <c:url var="update" value="mainController">
                                                            <c:param name="action" value="pushss"> </c:param>
                                                            <c:param name="updatetype" value="updaterp"> </c:param>
                                                            <c:param name="idrp" value="${listrp.idRP}"> </c:param>
                                                            <c:param name="idreg" value="${listrp.idReg}"> </c:param>
                                                            <c:param name="nameemp" value="${listrp.name}"> </c:param>
                                                            <c:param name="idemp" value="${listrp.idEmp}"> </c:param>
                                                            <c:param name="times" value="${listrp.times}"> </c:param> 
                                                            <c:param name="reason" value="${listrp.reason}"> </c:param> 
                                                        </c:url>
                                                        <a href="${update}"><i class="fas fa-edit"></i></a>
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
            <%
                HttpSession ss = request.getSession();
                ss.removeAttribute("Success");
            %>
        </div>
    </body>
</html>
