<%-- 
    Document   : createNewRp
    Created on : Jun 11, 2022, 3:12:04 PM
    Author     : Admin
--%>

<%@page import="management.dto.EmployeeDTO"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Reward - Penalty</title>
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
                border-radius: 5px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                width: 25%;
                margin-top: 10px
            }

            .btn-primary:hover{
                transform: scale(0.99);
                cursor: pointer;
                opacity: 0.9
            }

            .title{
                margin: 8px 0
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
            }

            .model-content{
                background-color: #fff;
                margin-bottom: 16px !important
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
            <div 
                style="margin: 0 20%;
                width: 100%;
                border: 1px solid #d9d9d9;
                border-radius: 10px"

                class="model-content">
            <div class="modal-header">
                <div>
                    <h5 class="modal-title">Create Reward - Penalty</h5>
                    <div>
                        <ul class="breadcrumb">
                            <c:if test="${requestScope.idEmp ne null}">
                                <li class="breadcrumb-item"><a href="mainController?action=passidemp&empid=${requestScope.idEmp}&type=detail">Employee Records</a></li>
                                </c:if>
                                <c:if test="${requestScope.idEmp eq null}">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=emp">Employee</a></li>
                                </c:if>
                            <li class="breadcrumb-item active">Create Reward - Penalty</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div style="margin-left: 16px">
                <div>
                    <p style="margin-top: 8px; margin-bottom: 8px">ID Employee:  ${sessionScope.id}</p>               
                    <p>Name: ${sessionScope.name}</p>
                </div>
            </div>

            <div class="modal-body" style="padding-top: 0; margin-bottom: 0"> 

                <div class="list-employee">
                    <form action="mainController" method="post" class="form-position">
                        <div class="form-group">
                            <!--                            <div style="margin-bottom: 6px">Reason</div> -->
                            <div style="margin-bottom: 6px">Reason</div> 
                            <select id="updaterp" name="idReg" class="form-control">
                                <!--                                <option value="" disabled selected>Choose Reason</option>-->
                                <c:forEach var="list" items="${requestScope.list}">
                                    <option value="${list.idReg}" data-status="${list.status}" <c:if test="${sessionScope.idReg == list.idReg}" > selected="${list.name}" </c:if>>
                                        ${list.name}
                                    </option>
                                </c:forEach>  
                            </select>
                            <p style="color:red">${requestScope.WARNING}</p>
                        </div>
                        <div class="form-group" id="divResult"></div>
                        <%Date d = new Date();%>

                        <div class="form-group">
                            <div style="margin-bottom: 6px">Date Create</div> 
                            <input class="form-control" type="text" name="daterp" value="<%=d%>" readonly=""/>
                        </div>
                        <div class="form-group">
                            <div style="margin-bottom: 6px">Description</div>
                            <textarea class="form-control" rows="3" cols="40" name="reasonrp" placeholder="Enter description here...(30 letters only)" maxlength="30"></textarea>
                        </div>
                        <div class="form-group">
                            <div style="margin-bottom: 6px">Time</div> 
                            <input class="form-control" type="number" name="timerp" value="1" min="1" max="10" readonly/>
                        </div>
                        <div style="text-align: center">
                            <input type="hidden" value="${sessionScope.id}" name="idemp">
                            <c:set var="flag" value="${requestScope.flag}"></c:set>
                            <c:if test="${param.flag eq 'flag'}">
                                <input type="hidden" name="flag" value="${param.flag}">
                            </c:if>
                            <input class="btn-primary" type="submit" value="Create"> 
                            <input class="btn-primary" type="hidden" name="action" value="CreateNewRp"> 
                        </div>
                        <c:if test="${requestScope.updateSuccess != null}">
                            <c:out value="${requestScope.updateSuccess}"/>
                        </c:if>
                    </form>
                </div>
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
                    } else if (times == 1) {
                        output = "Reward";
                        $("#divResult").css("color", "green");
                    } else {
                        output = "You must choose reason ";
                        $("#divResult").css("color", "red");
                    }
                    $("#divResult").text(output);
                });
            });
        </script>     
    </body>
</html>
