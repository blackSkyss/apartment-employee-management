<%-- 
    Document   : updatePosition.jsp
    Created on : Jun 1, 2022, 1:00:36 PM
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

            .btn-primary{
                background-color: 00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                padding: 5px 10px;
                margin-top: 16px;
                width: 25%
            }

            .btn-primary:hover{
                transform: scale(0.99);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                display: inline-flex !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
            }

            .modal-content{
                margin: 5% 20%;
                margin-bottom: 16px !important;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import> 

            <div class="modal-content">      
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Update Position</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=listPosition">Position</a></li>
                                <li class="breadcrumb-item active">Update Position</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div>


                    <div class="modal-body">
                        <form action="mainController" method="POST" class="form-position">

                            <div class="form-group">
                                <p style="color:red">${requestScope.allFieldRequired}</p>
                            <label for="formGroupExampleInput"> Position name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput" name="posName" value="${requestScope.position.posName}">

                            <p style="color:red">${requestScope.errorMess}</p>
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Description</label>
                            <input type="text" name="posDescription" class="form-control" id="formGroupExampleInput2" value="${requestScope.position.description}">                        
                            <p style="color:red">${requestScope.errorMessDes}</p>
                        </div>

                        <div style="text-align: center">
                            <input class="btn btn-primary" type="hidden" name="idPos" value="${requestScope.position.idPos}"/>
                            <input class="btn btn-primary" type="submit" value="Save"/> 
                            <input class="btn btn-primary" type="hidden" name="action" value="updatePosition"/> 
                        </div>
                        <c:if test="${requestScope.updateSuccess != null}">
                            <c:out value="${requestScope.updateSuccess}"/>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
