<%-- 
    Document   : showDepartmentEmp
    Created on : Jun 26, 2022, 6:48:37 PM
    Author     : VyNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -14px
            }

            .page-title{
                margin-top: 8px;
                margin-left: 16px;
                display: inline-block
            }

            #sidebar{
                height: 100vh
            }

            .list-department{
                margin: 0 16px
            }

            .icon{
                text-align: center; 
                font-size: 20px;
            }

            .icon:hover{
                opacity: 0.8;  
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
        <title>Department Page</title>
    </head>
    <body>

        <%@include file="headerEmp.jsp" %>
    <c:import url="sidebarEmp.jsp"></c:import>
    <c:if test="${sessionScope.USER_LOGGIN eq null}">
        <c:redirect url="Hall.jsp"/>
    </c:if>
    <div style="width: 100%">
        <div class="page-header">
            <div>
                <h3 class="page-title">Department</h3>
                <div class="col-sm-12 list-employee__actions">                       
                    <div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                            <li class="breadcrumb-item active">Department</li>
                        </ul>
                    </div>  
                </div>
            </div>
        </div>
        
        <div class="row justify-content-center">
                <div class="col-4" style="margin-top: 8px">
                    <div class="form-group mb-3 mt-3">
                        <input type="text" class="form-control" id="myInput" value="<%= (request.getParameter("empname") == null) ? "" : request.getParameter("empname")%>" placeholder="Enter..." name="empname">
                    </div>
                </div>
        </div>
                    
        <div class="list-department">
            <table class="table table-bordered" style="font-size: 14px" id="mydatatable">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Description</th>
                        <th scope="col">Location</th>
                        <th scope="col">Date Create</th>
                        <th scope="col">Creator</th>
                        <th style="text-align: center" scope="col">History department</th>
                        <th style="text-align: center" scope="col">History position</th>
                    </tr>
                </thead>
                <tbody id="listEmp">
                    <tr>
                        <td>${requestScope.department.depName}</td>                            
                        <td>${requestScope.department.description}</td>
                        <td>${requestScope.department.location}</td>
                        <td >${requestScope.department.dateCreate}</td>
                        <td>${requestScope.department.creator}</td>
                        <td class="icon">
                            <a href="mainController?action=showHisDepEmp">
                                <i class="fas fa-pen-square"></i>
                            </a>
                        </td>
                        <td class="icon" >
                            <a href="mainController?action=showHisPosEmp">
                                <i class="fas fa-pen-square"></i>
                            </a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
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
