<%-- 
    Document   : addNewPosition
    Created on : Jul 22, 2022, 10:55:41 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
            }

            .page-title{
                text-align: initial !important;
                margin-left: 12px !important;
                margin-top: 8px
            }

            .modal-content{
                height: 100%
            }

            .create-btn{
                background-color: #00a8ef;
                border: 1px solid #00c5fb;
                border-radius: 5px;
                color: #fff;
                font-weight: 500;
                min-width: 100px;
                text-decoration: none;
                cursor: pointer;
                padding: 4px 10px;
            }

            .create-btn:hover{
                opacity: 0.9;
                transform: scale(0.95)
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 

            <div class="modal-content" style="margin: 4% 20%">

                <div style="margin: 0 16px">
                    <div class="page-header">
                        <div class="row">
                            <h3 class="page-title">Add new position</h3>
                            <div class="col-sm-12">                       
                                <div>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                        <li class="breadcrumb-item"><a href="mainController?action=listPosition">Position</a></li>
                                        <li class="breadcrumb-item active">Add new position</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-body">
                        <form action="mainController" method="POST" class="form-position">
                            <div class="form-group">
                                <p style="color: red" >${allField}</p>
                            <label>
                                Position name
                            </label>
                            <input class="form-control" name="posName" value="${requestScope.posName}">
                            <p style="color: red" >${messPosName}</p>
                            <p style="color: red" >${duplicateName}</p>
                        </div>

                        <div class="form-group">
                            <label>
                                Description
                            </label>
                            <input class="form-control" name="posDes" value="${requestScope.posDes}">
                            <p style="color: red" >${messDes}</p>

                        </div>
                        <div class="form-group">
                            <label>
                                Creator
                            </label>
                            <input class="form-control" name="creator" value="${sessionScope.USER_LOGGIN.name}" readonly="">
                        </div>
                        <div style="text-align: center">
                            <input type="hidden" name="action" value="addNewPosition">
                            <input class="create-btn" type="submit" value="Create">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
