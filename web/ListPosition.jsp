<%-- 
    Document   : ListPosition
    Created on : Jun 1, 2022, 12:18:29 AM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Position Page</title>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .breadcrumb{
                background-color: #f7f7f7 !important;
                display: inline-flex !important;
                margin-left: -16px;
            }

            .list-position__actions{
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 8px
            }

            .page-title{
                text-align: initial !important;
                margin-left: 12px !important;
                margin-top: 8px
            }

            .position-link{
                background-color: #00a8ef;
                border: 1px solid #00c5fb;
                border-radius: 5px;
                color: #fff;
                font-weight: 500;
                min-width: 140px;
                text-decoration: none;
                cursor: pointer;
                padding: 4px 10px;
            }

            .add-link{
                display: inline-flex;
                align-items: center;
                background-color: #00a8ef;
                padding: 5px 10px;
                color: #fff
            }

            .add-link:hover{
                background-color: #dee2e6
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import>

        <c:if test="${requestScope.listPosition != null}">

            <div style="margin: 0 16px; width: 100%">

                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Position</h3>
                        <div class="col-sm-12 list-position__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    <li class="breadcrumb-item active">Position</li>
                                </ul>
                            </div>
                            <div>
                                <a class="position-link" href="mainController?action=searchPro">Promote/demote</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <a class="add-link" href="addNewPosition.jsp">
                        <i class="ri-add-fill"></i>
                        Add new position</a>
                </div>
                <p style="color: green" > ${requestScope.addSuccess} </p>
                <c:if test="${requestScope.updateSuccess != null}">
                    <p style="color: green" > ${requestScope.updateSuccess} </p>
                </c:if>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">Position name</th>                           
                            <th scope="col">Description</th>                                                  
                            <th scope="col">Creator</th>
                            <th scope="col">Date Create</th>                                                      
                            <th scope="col">Update</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="listPosition" items="${requestScope.listPosition}">
                            <tr>
                                <td>${listPosition.posName}</td>                            
                                <td>${listPosition.description}</td>
                                <td>${listPosition.creator}</td>
                                <td>${listPosition.dateCreated}</td>       
                                <td >  
                                    <a href="mainController?action=ssPosition&&idPos=${listPosition.idPos}&&posName=${listPosition.posName}&&posDes=${listPosition.description}"><i class="fas fa-edit"></i></a>
                                </td>                    
                            </tr>                           
                        </c:forEach>
                    </tbody>
                </table>       
            </div>
        </c:if>
    </body>
</html>
