<%-- 
    Document   : listEmp
    Created on : May 29, 2022, 8:06:21 PM
    Author     : lehon
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Department</title>
        <link rel="stylesheet" href="css/globalstyles.css"/>
        <style>
            .btn-primary{
                background-color: #55ce63 !important;
                border: 1px solid #55ce63 !important;
                border-radius: 5px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                margin-top: 14px;
                width: 100%
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -24px;
                margin-bottom: 0 !important
            }

            .actions{
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .history-btn{
                background-color: #00a8ef;
                border: 1px solid #00c5fb;
                border-radius: 5px;
                color: #fff;
                font-weight: 500;
                min-width: 140px;
                text-decoration: none;
                cursor: pointer;
                padding: 4px 10px;
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
        <sql:query dataSource = "${snapshot}" var = "listPos">
            select posName
            from Position
        </sql:query>
        <div style="margin: 0 16px; width: 100%" class="change-department">
            <div class="modal-header">
                <div style="width: 100%">
                    <h4 style="margin-left: -12px" class="page-title">Change department</h4>
                    <div class="actions">
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=dep">Department</a></li>
                                <li class="breadcrumb-item active">Change departmnet</li>
                            </ul>
                        </div>
                        <a class="history-btn" href="mainController?action=history&typehis=hisdep">History of change department</a>
                    </div>
                </div>
            </div>

            <c:if test="${requestScope.listEmp != null}">
                <form action="mainController" method="post" class="form-reward-penalty">
                    <div class="row filter-row">  
                        <div class="col-sm-6 col-md-3">
                            <div class="form-group mb-3 mt-3">
                                <input placeholder="Enter employee name..." type="text" class="form-control" id="email" value="<%= (request.getParameter("txtSearchName") == null) ? "" : request.getParameter("txtSearchName")%>"  name="txtSearchName">

                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3 mt-3"> 
                            <div class="form-group form-focus select-focus">
                                <select name="depName" class="form-select form-select-md-5 mb-1 list-options form-control" > 
                                    <option value="allDep">All</option>
                                    <c:forEach var="listDep" items="${listDep.rows}">
                                        <option value="${listDep.depName}" ><c:out value="${listDep.depName}"/></option>                       
                                    </c:forEach>
                                </select>
                            </div>
                        </div>     
                        <div class="col-sm-6 col-md-3 mt-3"> 
                            <div class="form-group form-focus select-focus">
                                <select name="posEmp" class="form-select form-select-md-5 mb-1 list-options form-control" > 
                                    <option value="allPos">
                                        All
                                    </option>
                                    <c:forEach var="listPos" items="${listPos.rows}">
                                        <option value="${listPos.posName}" ><c:out value="${listPos.posName}"/></option>                       
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3 ">
                            <input type="submit" value="Search" class="btn btn-primary">
                            <input type="hidden" name="action" value="filterChangeDep"/>
                        </div>
                    </div>  

                </form>

                <div class="changedep-btn">
                    <c:choose>
                        <c:when test="${not empty sessionScope.WARNINGCOMPLETED}">
                            <p style="color:green">${sessionScope.WARNINGCOMPLETED}</p>
                            <c:remove var="WARNINGCOMPLETED" scope="session" />
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty sessionScope.WARNINGFAILED}">
                                <p style="color: red">${sessionScope.WARNINGFAILED}</p>
                                <c:remove var="WARNINGFAILED" scope="session" />
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <h5>${requestScope.SearchRS}</h5>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">Employee ID</th>
                            <th scope="col">Image</th>
                            <th scope="col">Name</th>
                            <th scope="col">Gender</th>
                            <th scope="col">Department</th>
                            <th scope="col">Position</th>
                            <th scope="col">Exact Date</th>
                            <th scope="col">Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="listEmp" varStatus="counter" items="${requestScope.listEmp}">
                        <form action="mainController">
                            <tr>


                                <td>${listEmp.idEmp}</td>     
                                <td>
                                    <img class="align-self-center img-fluid" src='images/${listEmp.imgPath}' style="width: 80px;
                                         height: 80px; border-radius: 50%">
                                </td>

                                <td class="nameEmp">${listEmp.name}</td>
                                <td>${listEmp.gender}</td>
                                <td class="exception">Current department: ${listEmp.depName}</br>
                                    </br>

                                    <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                                       url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                                                       user = "sa"  password = "12345"/>

                                    <sql:query dataSource = "${snapshot}" var = "result">
                                        select DISTINCT d.depNum, d.depName
                                        from HistoryDep as hd, Department as d
                                        where hd.depNum <> d.depNum
                                        and hd.depNum = (
                                        select depNum
                                        from Department
                                        where depName = '${listEmp.depName}'
                                        );
                                    </sql:query>
                                    <label>New department:</label>
                                    <select name="iddep">
                                        <c:forEach var = "row" items = "${result.rows}">
                                            <option selected="" value="${row.depNum}">${row.depName}</option>
                                        </c:forEach>
                                    </select>
                                    </br>
                                    </br>
                                </td>
                                <td>${listEmp.posName}</td>
                                <td>
                                    <%   Date date = Calendar.getInstance().getTime();
                                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                        String strDate = dateFormat.format(date);%>
                                    <c:set var = "now" value = "<%= strDate%>" />
                                    <input type="date" name="exactDate" value = "${now}" required=""/>
                                </td>

                                <td>
                                    <input type="hidden" name="idemp" value="${listEmp.idEmp}">
                                    <input type="hidden" name="action" value="changeDep" >
                                    <input type="hidden" name="olddep" value="${listEmp.depName}">
                                    <input class="btn btn-secondary btn-sm" type="submit" value="Change">
                                </td>
                            </tr>

                        </form> 
                    </c:forEach>
                    </tbody>
                </table>

            </c:if>

        </div>
    </body>
</html>
