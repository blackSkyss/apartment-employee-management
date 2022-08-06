<%-- 
    Document   : detailEmployee
    Created on : Jun 8, 2022, 9:14:55 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
        <%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
        <%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        
        <link rel="stylesheet" href="./css/profile.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"/>
        <title>Details Information Of Employee</title>
        <style>
            .list-contract__link{
                font-weight: 600;
                padding: 4px 8px;
                border: 1px solid #333;
                border-radius: 5px
            }

            .list-contract__link:hover{
                background-color: #000;
                color: #fff
            }
        </style>
    </head>

    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 

            <div class="content container-fluid">
                <div class="page-header">
                    <div class="row">
                        <div class="col-sm-12">
                            <h3 class="page-title">Employee Records</h3>
                            <ul class="breadcrumb ">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item"><a href="mainController?action=showlist&type=emp">Employee</a></li>
                                <li class="breadcrumb-item active">Employee Records</li>
                            </ul>
                        </div>
                    </div>
                </div>


                <div class="card mb-0">
                    <div class="card-body">
                        <div class="row employee__container">
                            <div class="col-md-12">
                                <div class="profile-view">
                                    <div class="profile-img-wrap">
                                        <div class="profile-img">
                                            <img alt="" src="images/${requestScope.Employee.imgPath}">
                                    </div>
                                </div>
                                <div class="profile-basic">
                                    <div class="row">
                                        <div class="col-md-5">
                                            <div class="profile-info-left mt-16">
                                                <h3 class="user-name m-t-0 mb-0">${requestScope.Employee.name}</h3>
                                                <h6 class="text-muted">${requestScope.Employee.posName}</h6>
                                                <div class="staff-id">Department: ${requestScope.Employee.depName}</div>
                                                <div class="small doj text-muted">Date of Join : ${requestScope.Employee.joinDate}</div>
                                                <div class="small doj text-muted">Exact date : ${requestScope.Employee.exactDate}</div>

                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <ul class="personal-info">
                                                <li>
                                                    <div class="title">Phone:</div>
                                                    <div class="text">${requestScope.Employee.phoneNum}</div>
                                                </li>
                                                <li>
                                                    <div class="title">Email:</div>
                                                    <div class="text">${requestScope.Employee.email}</div>
                                                </li>
                                                <li>
                                                    <div class="title">Birthday:</div>
                                                    <div class="text">${requestScope.Employee.dob}</div>
                                                </li>
                                                <li>
                                                    <div class="title">Address:</div>
                                                    <div class="text">${requestScope.Employee.address}</div>
                                                </li>
                                                <li>
                                                    <div class="title">Gender:</div>
                                                    <div class="text">${requestScope.Employee.gender}</div>
                                                </li>
                                                <li>
                                                    <div class="title">Salary:</div>
                                                    <div class="text">${requestScope.Employee.baseSalary}</div>  
                                                </li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${sessionScope.Success != null}">
                <p style="color: green" ><c:out value="${sessionScope.Success}"/></p> 
            </c:if>
            <%
                HttpSession ss = request.getSession();
                ss.removeAttribute("Success");
            %>
            <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                               url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                               user = "sa"  password = "12345"/>

            <div class="tab-content">
                <div class="row" style="margin-top: 16px">
                    <div class="col-md-6 d-flex">
                        <div class="card profile-box flex-fill">
                            <div class="card-body">
                                <h3 class="card-title">Contract informations</h3>

                                <sql:query dataSource = "${snapshot}" var = "listcontract">
                                    select c.idContract,  t.name, signDay, expDay, hc.status
                                    from Contract as c, TypeContract as t, HistoryContract hc, Employee e
                                    where c.idTypeCon = t.idTypeCon and c.idContract = hc.idContract and e.idEmp = hc.idEmp and hc.status = 1 and hc.idEmp = ${requestScope.Employee.idEmp}
                                </sql:query>

                                <ul class="personal-info">
                                    <c:forEach var = "rowcon" items = "${listcontract.rows}">
                                        <li>
                                            <div class="title">Contract ID</div>
                                            <div class="text">${rowcon.idContract}</div>
                                        </li>
                                        <li>
                                            <div class="title">Name</div>
                                            <div class="text">${rowcon.name}</div>
                                        </li>
                                        <li>
                                            <div class="title">Sign Day</div>
                                            <div class="text"><fmt:formatDate pattern="yyyy-MM-dd" value="${rowcon.signDay}" /></div>
                                        </li>
                                        <li>
                                            <div class="title">End Day</div>
                                            <div class="text"><fmt:formatDate pattern="yyyy-MM-dd" value="${rowcon.expDay}" /></div>
                                        </li>
                                        <li>
                                            <c:choose>
                                                <c:when test="${rowcon.status eq 1}">
                                                    <p style="color:green">Active</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p style="color:red">Expired</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <div>
                                    <a class="list-contract__link" href="mainController?action=showHisCon&idEmp=${requestScope.Employee.idEmp}">History Contract</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 d-flex">
                        <div class="card profile-box flex-fill">
                            <div class="card-body">
                                <h3 class="card-title">Dependent Informations </h3>
                                <a href="mainController?action=addNewDependent&EmpId=${requestScope.Employee.idEmp}"><i class="fas fa-plus-square"></i></a>
                                <div class="table-responsive">

                                    <sql:query dataSource = "${snapshot}" var = "listdepen">
                                        select idDepen, name, gender, dob, relationship
                                        from Dependent
                                        where idEmp = ${requestScope.Employee.idEmp}
                                    </sql:query>

                                    <table class="table table-nowrap">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Gender</th>
                                                <th>Date of Birth</th>
                                                <th>Relationship</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var = "rowdepen" items = "${listdepen.rows}">
                                                <tr>
                                                    <td>${rowdepen.name}</td>
                                                    <td>${rowdepen.gender}</td>
                                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${rowdepen.dob}" /></td>
                                                    <td>${rowdepen.relationship}</td>
                                                    <td class="text-right">

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row" style="margin-top: 16px">
                    <div class="col-md-6 d-flex">
                        <div class="card profile-box flex-fill">
                            <div class="card-body">
                                <h3 class="card-title">Certificate Informations </h3>
                                <a href=" mainController?action=add new certificate&EmpId=${requestScope.Employee.idEmp}"><i class="fas fa-plus-square"></i></a>
                                <div class="experience-box">
                                    <ul class="experience-list">
                                        <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                                           url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                                                           user = "sa"  password = "12345"/>

                                        <sql:query dataSource = "${snapshot}" var = "listcer">
                                            select cerID, cerName, doi, tc.name as type
                                            from Certificate as c, TypeCertificate tc
                                            where c.idTypeCer = tc.idTypeCer and c.idEmp = ${requestScope.Employee.idEmp}
                                        </sql:query>
                                        <c:forEach var = "rowcer" items = "${listcer.rows}">
                                            <li>
                                                <div class="experience-user">
                                                    <div class="before-circle"></div>
                                                </div>
                                                <div class="experience-content">
                                                    <div class="timeline-content">
                                                        <div class="name">${rowcer.cerName}</div>
                                                        <div>${rowcer.type}</div>
                                                        <span class="time"><fmt:formatDate pattern="yyyy-MM-dd" value="${rowcer.doi}" /></span>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 d-flex">
                        <div class="card profile-box flex-fill">
                            <div class="card-body">
                                <h3 class="card-title">Reward and Penalty</h3>
                                <c:url var="create" value="mainController">
                                    <c:param name="action" value="pushss"> </c:param>
                                    <c:param name="idemp" value="${requestScope.Employee.idEmp}"> </c:param>
                                    <c:param name="updatetype" value="createnewrp"> </c:param>
                                    <c:param name="flag" value="flag"> </c:param>
                                    <c:param name="nameemp" value="${requestScope.Employee.name}"> </c:param>
                                </c:url>
                                <a href="${create}"><i class="fas fa-plus-square"></i></a>
                                    <c:url var="detail" value="mainController">
                                        <c:param name="action" value="searchRP"> </c:param>
                                        <c:param name="txtSearchIdemp" value="${requestScope.Employee.idEmp}"> </c:param>
                                        <c:param name="txtSearchName" value="${requestScope.Employee.name}"> </c:param>
                                        <c:param name="depName" value="allDep"> </c:param>
                                        <c:param name="flag" value="flag"> </c:param>
                                    </c:url>
                                
                                <div class="table-responsive">

                                    <sql:query dataSource = "${snapshot}" var = "listdepen">
                                        select re.status , SUM(r.times) as times
                                        from Employee as e,RewardAndPenalty as r, Regulation as re
                                        where r.idReg = re.idReg and e.idEmp = r.idEmp and e.idEmp = ${requestScope.Employee.idEmp}
                                        group by re.status
                                    </sql:query>

                                    <table class="table table-nowrap">
                                        <thead>
                                            <tr>
                                                <th>Type</th>
                                                <th>Total Times</th>
                                                <th>Detail</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var = "rowdepen" items = "${listdepen.rows}">
                                                <tr>

                                                    <c:if test="${rowdepen.Status eq 0}">
                                                        <td>Penalty</td>
                                                    </c:if>
                                                    <c:if test="${rowdepen.Status eq 1}">
                                                        <td>Reward</td>
                                                    </c:if>
                                                    <td>${rowdepen.times}</td>
                                                    <td>
                                                        <a href="${detail}">
                                                            <i class="fa-solid fa-angles-right"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>            
                </div>
            </div>
            <div style="height: 20px; background-color: #fff"></div>
        </div>             

    </div>
</body>
</html>
