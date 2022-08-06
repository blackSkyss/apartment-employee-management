<%-- 
    Document   : listCertEmp
    Created on : Jun 21, 2022, 11:06:04 AM
    Author     : VyNT
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link rel="stylesheet" href="./css/styles.css"/>
        <title>Certificate</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            #sidebar{
                height: 100vh
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -16px
            }

            .page-title{
                margin-top: 8px;
                display: inline-block
            }

            .dataTables_length{
                display: flex;
                margin-top: -20px;
            }
            .dataTables_info{
                display: flex;
            }

            #sidebar{
                height: 100vh
            }

            .list-employee__actions{
                display: flex;
                align-items: center;
                justify-content: space-between;
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

            .add-btn:hover{
                opacity: 0.9;
                transform: scale(0.95)
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="headerEmp.jsp"></c:import>
        <c:import url="sidebarEmp.jsp"></c:import>
            <div style="margin: 0 16px; width: 100%" class="list__rp">
            <sql:setDataSource var = "snapshot" driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
                               url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement"
                               user = "sa"  password = "12345"/>

            
            <div>
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Certificate</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                    <li class="breadcrumb-item">Account</li>
                                    <li class="breadcrumb-item active"><a href="mainController?action=listCertEmp">Certificate</a></li>
                                </ul>
                            </div>
                            <div style="margin-right: 8px">          
                                <a class="add-btn" href="mainController?action=addNewCertPage">
                                    <i class="ri-add-fill list__employee-icon"></i>
                                    Add new certificate
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <form action="mainController" method="post" class="form-reward-penalty">
                        <div class="row justify-content-center" style=" margin-bottom: -16px">
                            <div class="col-md-auto"> 
                                <br>
                                <select class="form-select form-select-md-5 mb-1 list-options" name="month" id="month"> 
                                    <option value="all" >All Month</option>
                                    <option value="1" >January</option>
                                    <option value="2" >February</option>
                                    <option value="3" >March</option>
                                    <option value="4" >April</option>
                                    <option value="5" >May</option>
                                    <option value="6" >June</option>
                                    <option value="7" >July</option>
                                    <option value="8" >August</option>
                                    <option value="9" >September</option>
                                    <option value="10" >October</option>
                                    <option value="11" >November</option>
                                    <option value="12" >December</option>
                                </select>
                            </div> 
                        </div>  
                    </form>
                    <c:if test="${sessionScope.updateSuccess != null}" >
                        <p style="color: green" ><c:out value="${updateSuccess}" /></p>
                    </c:if>
                    <c:if test="${sessionScope.updateFail != null}" >
                        <p style="color: red" > <c:out value="${updateFail}" /></p>
                    </c:if>
                    <%
                        HttpSession ss = request.getSession();
                        ss.removeAttribute("updateSuccess");
                        ss.removeAttribute("updateFail");
                    %>
                    <table class="table table-bordered list__rp-table" id="mydatatable">
                        <thead>
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">Day of get</th>
                                <th scope="col">Type</th>
                                <th scope="col">Update</th>
                            </tr>
                        </thead>
                        <tbody id="listRp">
                            <c:forEach var = "rowcer" items = "${requestScope.listcer}">
                                <tr>
                                    <td class="list__employee-item">
                                        <span>
                                            <img class="list__employee-item-img" src='images/${rowcer.imgPath}'>
                                        </span>
                                        <div class="list__employee-description">
                                            <span class="list__employee-description-name">${rowcer.cerName}</span>                 
                                        </div>
                                    </td>
                                    <td>${rowcer.doi}</td>
                                    <td>${rowcer.type}</td>
                                    <td>
                                        <c:url var="update" value="mainController">
                                            <c:param name="action" value="updateCertPage"> </c:param>
                                            <c:param name="imgPath" value="${rowcer.imgPath}"> </c:param>
                                            <c:param name="cerID" value="${rowcer.cerId}"> </c:param>
                                            <c:param name="cerDoi" value="${rowcer.doi}"> </c:param>
                                            <c:param name="cerName" value="${rowcer.cerName}"> </c:param>
                                            <c:param name="cerType" value="${rowcer.type}"> </c:param>
                                        </c:url>
                                        <a href="${update}"><i class="fas fa-edit"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                    </table>
                </div>

                <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

                <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
                <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script> 
                <script>
                    $('.list__rp').on("change", 'select', function () {
                        var month = $('#month').val();
                        var table = $("#listRp");
                        var trs = table.find('tr');
                        trs.hide();

                        var filtered = trs.filter(function (index, elem) {
                            var tds = $(elem).find('td');
                            const d = new Date(tds.eq(1).text().trim().toLowerCase());
                            var mo = d.getMonth() + 1;
                            if (month == "all") {
                                return true;
                            }
                            if (mo == month) {
                                return true;
                            }
                        })
                        filtered.show();
                        if (filtered.length == 0) {
                            alert("No Records Found!!!");
                        }
                    });
                </script>
                <script>
                    $('#mydatatable').DataTable({
                        ordering: false,
                        lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                        searching: false
                    });
                </script>
                <script>
                    $(document).ready(function () {
                        var value = $("div.dataTables_length").closest("div");
                        value.closest("div").removeClass('col-sm-12 col-md-6').addClass('col-sm-12 col-md-1');
                    });
                </script>  
                </body>
                </html>
