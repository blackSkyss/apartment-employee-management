<%-- 
    Document   : updateCertificate
    Created on : Jun 8, 2022, 10:07:38 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Certificate</title>
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

            .page-title{
                text-align: initial !important;
                margin-left: 16px !important;
                margin-top: 8px
            }
            .breadcrumb{
                background-color: #f7f7f7 !important;
                margin-bottom: 0 !important
            }

        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="header.jsp"></c:import>
        <c:import url="sidebar.jsp"></c:import>



        <c:if test="${requestScope.listCerObject != null}">

            <div style="margin: 0 16px; width: 100%" >
                <div class="page-header">
                    <div class="row" style="margin-bottom: 16px">
                        <h4 class="page-title">Update certificate</h4>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                <li class="breadcrumb-item"><a href="mainController?action=listCertificate">Certificate</a></li>
                                <li class="breadcrumb-item active">Update Certificate</li>
                            </ul>
                        </div>
                    </div>
                </div>


                <table class="table table-striped list-certificate">
                    <thead>
                        <tr>
                            <th scope="col">Employee name</th>                      
                            <th scope="col">Image</th>
                            <th scope="col">Certificate name</th>
                            <th scope="col">Date of issue</th>
                            <th scope="col">Type certificate</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <form action="mainController" method="POST" enctype="multipart/form-data">
                        <c:forEach var="listCerObject" items="${requestScope.listCerObject}">    
                            <tr>
                                <td>${listCerObject.empName}</td>                            
                                <td>
                                    <span>
                                        <img class="list__employee-item-img" src='images/${listCerObject.imgPath}'>
                                    </span>
                                    <input name="imgPath" type="file" accept="image/*">
                                </td>
                                <td><input name="cerName" value="${listCerObject.cerName}"></td>
                                <td><input name="doi" type="date" value="${listCerObject.doi}" required=""></td>
                                <td>
                                    <select name="idTypeCer" >
                                        <c:forEach var="listTypeCer" items="${requestScope.listTypeCer}">                                       
                                            <option value="${listTypeCer.idTypeCer}"  <c:if test="${listCerObject.idTypeCer == listTypeCer.idTypeCer}" > selected="${listTypeCer.type}" </c:if>>
                                                ${listTypeCer.type}
                                            </option>

                                        </c:forEach>  
                                    </select>
                                </td>
                                <td>
                                    <input type="hidden" name="cerID" value="${listCerObject.cerId}">
                                    <input type="hidden" name="idEmp" value="${listCerObject.idEmp}">
                                    <input type="hidden" name="oldImg" value="${listCerObject.imgPath}">
                                    <input type="hidden" name="action" value="SaveChange">
                                    <input class="btn btn-secondary btn-sm" type="submit" value="Save">
                                </td>
                            </tr>                        
                        </c:forEach>
                        <c:if test="${requestScope.filedBlank != null}" >
                            <p style="color: red" ><c:out value="${requestScope.filedBlank}" /></p>
                        </c:if>
                        <c:if test="${nameInvalid != null}">
                            <p style="color: red" ><c:out value="${nameInvalid}"/></p> 
                        </c:if>
                        <c:if test="${requestScope.checkDoi != null}" >
                            <p style="color: red" ><c:out value="${requestScope.checkDoi}" /></p>
                        </c:if>
                    </form>
                    </tbody>
                </table>
            </div>
        </c:if>
    </body>
</html>
