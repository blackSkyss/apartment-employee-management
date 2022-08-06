<%-- 
    Document   : rewardpenalty
    Created on : May 31, 2022, 1:34:28 PM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="management.dto.RewardPenaltyDTO"%>
<%@page import="management.dao.RewardPenaltyDAO"%>
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
        <title>Reward And Penalty</title>
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
                margin-left: 4px !important;
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
        <header>
            <%@include file="headerEmp.jsp" %>
        </header>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="sidebarEmp.jsp"></c:import>
            <div class="list__employee" style="margin: 0 16px; width: 100%">
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Reward and penalty</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                    <li class="breadcrumb-item">Account</li>
                                    <li class="breadcrumb-item active">Reward and penalty</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                <div class="col-3"  style="margin-bottom: 10px"> 
                    <br>
                    <select class="form-select form-select-md-5 mb-1 list-options" name="depname" id="depname"> 
                        <option value="all" >All Type</option>
                        <option value="Reward" >Reward</option>
                        <option value="Penalty" >Penalty</option>
                    </select>
                </div>
                    
            </div>
                <table class="table table-bordered" id="mydatatable">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Name</th>
                            <th>Times</th>
                            <th>Date</th>
                            <th>Reason </th>
                        </tr>
                    </thead>
                    <tbody id="listEmp">
                    <c:forEach var="listRpEmp" varStatus="counter" items="${requestScope.listRpEmp}">
                        <tr>
                            <td><c:choose>
                                    <c:when test="${listRpEmp.status eq  1}">Reward</c:when>
                                    <c:otherwise>Penalty</c:otherwise>
                                </c:choose></td>
                            <td>${listRpEmp.namere}</td> 
                            <td>${listRpEmp.times}</td>
                            <td>${listRpEmp.applicableDate}</td>
                            <td>${listRpEmp.reason}</td> 
                        </tr>
                    </c:forEach>
                </tbody>
            </table> 
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
                var table = $("#listEmp");
                var trs = table.find('tr');
                trs.hide();
                var filtered = trs.filter(function (index, elem) {
                    var tds = $(elem).find('td');
                    if (depname == "all") {
                        return true;
                    }
                    if (tds.eq(0).text().trim().toLowerCase().indexOf(depname) != -1 ) {
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
                var value = $("div.dataTables_length").closest("div");
                value.closest("div").removeClass('col-sm-12 col-md-6').addClass('col-sm-12 col-md-1');
            });
        </script>    
    </body>
</html>
