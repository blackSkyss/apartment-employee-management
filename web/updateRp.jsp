<%-- 
    Document   : AssignRewardPenalty
    Created on : Jun 7, 2022, 1:00:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Reward - Penalty</title>
        <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                margin-top: 16px;
                width: 20%
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
            }

            .modal-content{
                background-color: #fff;
                margin-bottom: 16px !important;
                height: 100%
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="sidebar.jsp"></c:import> 
            <div style="margin: 0 20%" class="list-employee modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Update Reward - Penalty</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=rewardpenalty">Reward - Penalty</a></li>
                                <li class="breadcrumb-item active">Update Reward - Penalty</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div>
                    <div>
                        <p style="margin: 16px 16px 0 16px">ID Employee is being updated:  ${sessionScope.id}</p>
                    <p style="margin: 16px 16px 0 16px">Name is being updated: ${sessionScope.name}</p>
                </div>
            </div>
            <div class="modal-body">
                <form action="mainController" method="post">       
                    <div class="form-group">
                        <label>Reason</label>
                        <select id="updaterp" name="idReg" class="form-control">
                            <c:forEach var="list" items="${requestScope.list}">
                                <option value=${list.idReg} data-status="${list.status}" <c:if test="${sessionScope.idReg == list.idReg}" > selected="${list.name}" </c:if>>
                                    ${list.name} 
                                </option>
                                <p<c:if test="${sessionScope.idReg == list.idReg}" > selected="${list.name}" </c:if>>${list.name} </p>
                            </c:forEach>  
                        </select>
                    </div>
                    <div class="form-group" id="divResult"></div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea class="form-control" rows="4" cols="40" name="reasonrp" placeholder="Enter description here...">${sessionScope.reason}</textarea>
                    </div>
                    <div class="form-group">
                        <label >Time</label>
                        <input class="form-control" readonly="" name="timerp" value="${sessionScope.times}" >
                    </div>
                    <div class="form-group">
                        
                        <div style="text-align: center">
                            <input type="hidden" value="${sessionScope.id}" name="idemp">
                            <input type="hidden" value="${sessionScope.idRP}" name="idrp">
                            <input type="hidden" value="${sessionScope.times}" name="timerp">
                            <input type="hidden" name="action" value="UpdateRp"> 
                            <input class="btn btn-primary" type="submit" value="Update"> 
                        </div>
                        <c:if test="${requestScope.updateSuccess != null}">
                            <c:out value="${requestScope.updateSuccess}"/>
                        </c:if>
                </form>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#updaterp").change(function () {
                    var cntrol = $(this);
                    var times = cntrol.find(':selected').data('status');
                    if (times == 0) {
                        output = "Penalty";
                        $("#divResult").css("color", "red");
                    } else {
                        output = "Reward";
                        $("#divResult").css("color", "green");
                    }
                    $("#divResult").text(output);
                });
            });
        </script>                    
    </body>
</html>
