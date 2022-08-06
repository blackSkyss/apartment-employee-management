<%-- 
    Document   : listDependent
    Created on : Jun 12, 2022, 8:26:09 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dependent</title>
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

            #sidebar{
                height: 100vh
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-left: -14px
            }

            .page-title{
                text-align: initial !important;
                margin-left: 6px !important;
                margin-top: 8px
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
        <%
            HttpSession ss = request.getSession();
        %>
        <c:import url="headerEmp.jsp"></c:import>
        <c:import url="sidebarEmp.jsp"></c:import>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:if test="${requestScope.updateFail != null}" >
            <c:out value="${requestScope.updateFail}" />
        </c:if>

        <div style="margin: 0 16px; width: 100%">
            <div class="page-header">
                <div class="row">
                    <h3 class="page-title">Dependent</h3>
                    <div class="col-sm-12 list-employee__actions">                       
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                <li class="breadcrumb-item active">Dependent</li>
                            </ul>
                        </div>
                        <div style="margin-right: 8px">          
                            <a class="add-btn" href="AddNewDependentEmp.jsp">
                                <i class="ri-add-fill list__employee-icon"></i>
                                Add new dependent
                            </a> 
                        </div>
                    </div>
                </div>
                <div style="text-align: center">
                    <p style="color:green">${requestScope.Success}</p>
                    <c:if test="${requestScope.updateSuccess != null}" >
                        <p style="color: green" ><c:out value="${requestScope.updateSuccess}" /></p>
                    </c:if>
                </div>
                    <div class="row justify-content-end" style="margin-bottom: -16px">
                    <div class="col-4" style="margin-top: 8px; ">
                        <div class="form-group mb-3 mt-3">
                            <input type="text" class="form-control" id="myInput" value="<%= (request.getParameter("empname") == null) ? "" : request.getParameter("empname")%>" placeholder="Enter..." name="empname">
                        </div>
                    </div>
                </div>
                <p style="color:green">${sessionScope.Success}</p>
                <% ss.removeAttribute("Success");%>
                <table class="table table-bordered" id="mydatatable">
                    <thead>
                        <tr>
                            <th>Dependent name</th>
                            <th>gender</th>
                            <th>Date of birth</th>
                            <th>Relationship</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody id="listEmp">                  
                        <c:forEach var="listDependent" items="${requestScope.listDependent}">
                            <tr>
                                <td>${listDependent.name}</td> 
                                <td>${listDependent.gender}</td> 
                                <td>${listDependent.dob}</td> 
                                <td>${listDependent.relationship}</td> 
                                <td>  
                                    <a href="mainController?action=updateDependentEmp&&idEmp=${listDependent.idEmp}&&idDepen=${listDependent.idDepen}"><i class="fas fa-edit"></i></a>
                                </td>

                            </tr>                           
                        </c:forEach>
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
