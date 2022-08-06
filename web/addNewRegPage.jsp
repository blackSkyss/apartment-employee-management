<%-- 
    Document   : addNewRegPage.jsp
    Created on : Jun 7, 2022, 3:55:47 AM
    Author     : VyNT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Regulation Page</title>
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
                width: 28%
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;   
                margin-bottom: 0 !important
            }
            .modal-content{
                height: 100%
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 
            <div class="modal-content" style="margin: 5% 20%">

                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Create Regulation</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item"><a href="mainController?action=showlist&type=reg">Regulation</a></li>
                                <li class="breadcrumb-item active">Create Regulation</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div>
                    <div>
                        <p style="margin: 16px 16px 0 16px">Regulation is being created by: ${sessionScope.USER_LOGGIN.name}</p>
                </div>

                <div class="modal-body">
                    <form action="mainController" method="POST" class="form-position" >

                        <div class="form-group">
                            <label for="formGroupExampleInput">Regulation Name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput" name="regName" placeholder="Example Input" value="${sessionScope.regName}">
                            <% session.removeAttribute("regName"); %>
                            <p style="color:red">${sessionScope.WARNING}</p>
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Regulation Type</label>
                            <select name="regType" class="form-control">
                                <option value="0" selected>Penalty</option>
                                <option value="1">Reward</option>
                            </select>            </div>

                        <div style="text-align: center">
                            <input class="btn btn-primary" type="submit" value="Create"/>
                            <input class="btn btn-primary" type="hidden" name="action" value="Create Regulation"/>
                        </div>

                    </form>
                </div>
            </div>
            <%
                session.removeAttribute("WARNING");
            %>

    </body>
</html>
