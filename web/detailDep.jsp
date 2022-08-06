<%-- 
    Document   : detailDep
    Created on : Jul 5, 2022, 1:11:32 PM
    Author     : VyNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Department Detail</title>
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
                margin-left: -28px;
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
                text-transform: uppercase
            }

            .search-btn:hover{
                transform: scale(0.9)
            }

            .list__employee{
                margin: 0 16px
            }

            .dep-infor{
                text-align: initial;
                border: 1px solid #000;
                padding: 8px 16px;
                border-radius: 6px
            }

            .dep-infor p{
                margin-bottom: 0
            }

            .dataTables_length{
                display: flex;
                margin-top: -50px;
                margin-left: -10px
            }
            .dataTables_info{
                display: flex;
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

        <div class="list__employee">

            <div class="page-header">
                <div class="row" style="margin-bottom: 16px">
                    <div class="col-sm-6">
                        <h3 class="page-title">Department</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    <li class="breadcrumb-item"><a href="mainController?action=showlist&type=dep">Department</a></li>
                                    <li class="breadcrumb-item active">Detail</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="dep-infor">
                            <h4 style="text-align: center">${requestScope.dep.depName}</h4>
                            <p>${requestScope.dep.description}</p>
                            <p>Location: ${requestScope.dep.location}</p>
                            <p>Date of Create: ${requestScope.dep.dateCreate}</p>
                            <p>Creator: ${requestScope.dep.creator}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-end">
                <div class="col-4" style="margin-top: 8px">
                    <div class="form-group mb-3 mt-3">
                        <input type="text" class="form-control" id="myInput" value="<%= (request.getParameter("empname") == null) ? "" : request.getParameter("empname")%>" placeholder="Enter..." name="empname">
                    </div>
                </div>
                    <div class="col-3" style="display: none"> 
                    </br>
                    <select class="form-select form-select-md-5 mb-1 list-options" name="depname" id="depname"> 
                        <option value="all" >All Department</option>
                        <c:forEach var="listDep" items="${listDep.rows}">
                            <option value="${listDep.depName}">${listDep.depName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-3" >
                    </br>
                    <select class="form-select form-select-md-5 mb-1 list-options" name="posname" id="posname"> 
                        <option value="all" >All Position</option>
                        <c:forEach var="listPos" items="${listPos.rows}">
                            <option value="${listPos.posName}">${listPos.posName}</option>
                        </c:forEach>
                    </select>
                </div> 
            </div>
            <c:if test="${requestScope.listEmp != null}">
                <c:if test="${not empty requestScope.listEmp}">

                    <table style="font-size: 14px" class="table table-striped list__employee-table" id="mydatatable">
                        <thead>
                            <tr class="list__employee-header" style="font-size: 13px">
                                <th scope="col">Employee ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Gender</th>
                                <th scope="col 3">DOB</th>
                                <th scope="col">Email</th>
                                <th scope="col">Employee Records</th>
                            </tr>
                        </thead>
                        <tbody id="listEmp">
                            <c:forEach var="listEmp" varStatus="counter" items="${requestScope.listEmp}">
                            <form action="mainController">
                                <tr class="list__employee-body">
                                    <td scope="row">${listEmp.idEmp}</td>     
                                    <td class="list__employee-item">
                                        <span>
                                            <img class="list__employee-item-img" src='images/${listEmp.imgPath}'>
                                        </span>
                                        <div class="list__employee-description">
                                            <span class="list__employee-description-name">${listEmp.name}</span>                   
                                            <span class="list__employee-description-pos">${listEmp.posName}</span>
                                        </div>
                                    </td>

                                    <td>${listEmp.gender}</td>
                                    <td>${listEmp.dob}</td>
                                    <td>${listEmp.email}</td>
                                    <td>
                                        <a href="mainController?action=passidemp&empid=${listEmp.idEmp}&type=detail">
                                            <i class="fas fa-address-card"></i></a>
                                    </td>

                                </tr>
                            </form> 
                        </c:forEach>
                        </tbody>
                    </table>

                </c:if>
            </c:if>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script> 
        <script>
            $('#mydatatable').DataTable({
                ordering: false,
                lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
                searching: false
            });
        </script>
        <script>
            $('.list__employee').on("change", 'select', function () {
                var depname = $('#depname').val().toLowerCase();
                var posname = $('#posname').val().toLowerCase();
                var table = $("#listEmp");
                var trs = table.find('tr');
                trs.hide();

                var filtered = trs.filter(function (index, elem) {
                    var tds = $(elem).find('td');
                    if (depname == "all" && posname == "all") {
                        return true;
                    }
                    if (tds.eq(5).text().trim().toLowerCase().indexOf(depname) != -1 && posname == "all") {
                        return true;
                    }

                    if (tds.eq(1).text().trim().toLowerCase().indexOf(posname) != -1 && depname == "all") {
                        return true;
                    }

                    if (tds.eq(5).text().trim().toLowerCase().indexOf(depname) != -1 &&
                            tds.eq(1).text().trim().toLowerCase().indexOf(posname) != -1) {
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
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#listEmp tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
                var value = $("div.dataTables_length").closest("div");
                value.closest("div").removeClass('col-sm-12 col-md-6').addClass('col-sm-12 col-md-1');
            });
        </script>
    </body>
</html>
