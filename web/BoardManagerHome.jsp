<%-- 
    Document   : BoardManagerHome
    Created on : May 29, 2022, 1:11:25 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Management Hall Page</title>   
        <style>
            .statistics{
                margin-left: -17px;
                flex: 0 0 32.8% !important;
            }

            .statistics-department{
                padding-left: 0 !important;
                flex: 0 0 31.5% !important;
                margin-right: 6px
            }

            .stats-info p {
                display: flex;
                font-size: 12px;
                justify-content: space-between;
                margin-bottom: 2px;
                color: #000;
                font-weight: 500
            }

            .stats-info {
                background-color: #fff;
                border: 1px solid #e5e5e5;
                border-radius: 4px;
                margin-bottom: 20px;
                padding: 10px;
                text-align: center;
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import>

        <c:if test="${sessionScope.USER_LOGGIN == null or sessionScope.USER_LOGGIN.role ne 1}">
            <c:redirect url="Hall.jsp">
            </c:redirect>
        </c:if>
        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                           user = "sa"  password = "12345"/>
        <sql:query dataSource = "${snapshot}" var = "listRP">
            select re.status,sum(r.times) as count
            from Employee as e,HistoryDep as hd, Department as d,  RewardAndPenalty as r, Regulation as re
            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and r.idReg = re.idReg and e.idEmp = r.idEmp
            and hd.status = 1
            group by re.status
        </sql:query>
        <sql:query dataSource="${snapshot}" var="dep">
            select d.depName,count(e.idEmp) employee
            from Employee as e, HistoryDep as hd, Department as d, HistoryPos as hp, Position as p, Contract as c, HistoryContract as hc
            where e.idEmp = hd.idEmp and hd.depNum = d.depNum and
            e.idEmp = hp.idEmp and hp.idPos = p.idPos and 
            hd.status = 1 and hp.status = 1 and c.idContract=hc.idContract and hc.idEmp=e.idEmp and
            statusLog = 1 and role = 0 and hc.status = 1
            group by d.depName
        </sql:query>
        <div style="width: 100%; margin-left: 40px; overflow: hidden">
            <div>
                <div class="container">
                    <div class="row">

                        <div style="max-width: 30%" class="card-item col-xl-4 col-sm-6 col-12 ">
                            <div class="card-item_employee">
                                <i style="color: #00c5fb" class="fas fa-building"></i>
                            </div>

                            <div>
                                <p class="card-item_number">
                                    ${requestScope.lengthDep}
                                </p>
                                <a 
                                    class="card-item_link"
                                    href="mainController?action=showlist&type=dep">Department</a>
                            </div>

                        </div>
                        <div style="width: 20px"></div>

                        <div style="max-width: 30%" class="card-item col-xl-4 col-sm-6 col-12">
                            <div class="card-item_employee">
                                <i style="color: #00c5fb" class="fas fa-user"></i>
                            </div>

                            <div>
                                <p class="card-item_number">
                                    ${requestScope.lengthEmp}
                                </p>
                                <a 
                                    class="card-item_link"
                                    href="mainController?action=showlist&type=emp">Employee</a>
                            </div>    
                        </div>
                        <div style="width: 20px"></div>
                        <div style="max-width: 30%" class="card-item col-xl-4 col-sm-6 col-12">
                            <div class="card-item_employee">
                                <i style="color: #00c5fb" class="fas fa-book-open"></i>
                            </div>

                            <div>
                                <p class="card-item_number">${requestScope.lengthReg}</p>
                                <a                         
                                    class="card-item_link"
                                    href="mainController?action=showlist&type=reg">
                                    Regulation
                                </a>
                            </div>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" >
                <div class="row" style="margin-top: 32px">
                    <div class="col-md-12 col-lg-12 col-xl-4 d-flex statistics-department">
                        <div class="card flex-fill dash-statistics" >
                            <div class="card-body" >
                                <h5 class="card-title">Department Statistics</h5>
                                <div class="stats-list">
                                    <c:forEach var="emp" items="${dep.rows}">
                                    <div class="stats-info">
                                        <p>${emp.depName} <strong>${emp.employee}</strong></p>
                                    </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-12 col-lg-6 col-xl-4 d-flex statistics" style="height: 100%">
                        <div class="card flex-fill">
                            <div class="card-body">
                                <h4 class="card-title" style="font-size: 20px">Reward & Penalty Statistics</h4>
                                <div class="statistics">
                                    <div class="row">
                                        <c:forEach var="RP" items="${listRP.rows}">
                                            <c:if test="${RP.status eq '1'}">
                                                <div class="col-md-6 col-6 text-center">
                                                    <div class="stats-box mb-4">
                                                        <p style="color: #007bff">Reward</p>
                                                        <c:if test="${RP.count eq null}"><h3>0</h3></c:if>
                                                        <c:if test="${RP.count ne null}"><h3>${RP.count}</h3></c:if>
                                                    </div>
                                                </div>
                                                <c:set var="reward" value="${RP.count}"></c:set>
                                            </c:if>
                                        </c:forEach>
                                        <c:forEach var="RP" items="${listRP.rows}">
                                            <c:if test="${RP.status eq '0'}">
                                                <div class="col-md-6 col-6 text-center">
                                                    <div class="stats-box mb-4">
                                                        <p style="color: #f10e1d">Penalty</p>
                                                        <c:if test="${RP.count eq null}"><h3>0</h3></c:if>
                                                        <c:if test="${RP.count ne null}"><h3>${RP.count}</h3></c:if>
                                                    </div>
                                                </div>
                                                <c:set var="penalty"  value="${RP.count}"> </c:set>

                                            </c:if>
                                        </c:forEach>
                                        <fmt:parseNumber var = "p" type = "number" value = "${penalty}" ></fmt:parseNumber>
                                        <fmt:parseNumber var = "r" type = "number" value = "${reward}" ></fmt:parseNumber>
                                        </div>
                                    </div>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-purple" role="progressbar" style="width: ${(r div (r+p))*100}%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"><fmt:formatNumber type="number" pattern="###" maxIntegerDigits="3" value="${(r div (r+p))*100}" />%</div>                            
                                    <div class="progress-bar bg-danger" role="progressbar" style="width: ${100-(r div (r+p))*100}%" aria-valuenow="14" aria-valuemin="0" aria-valuemax="100"><fmt:formatNumber type="number" pattern="###" maxIntegerDigits="3" value="${100-(r div (r+p))*100}" />%</div>                                   
                                </div>                           
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
