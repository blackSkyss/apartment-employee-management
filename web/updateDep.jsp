<%-- 
    Document   : updateDep
    Created on : May 31, 2022, 9:21:10 AM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Department Page</title>
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
                width: 20%;
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
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

            <div class="modal-content" style="margin: 3% 20%">
                <div class="modal-header" >
                    <div>
                        <h5 class="modal-title">Update Department</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="listHallManagerController">Home</a> </li>
                                <li class="breadcrumb-item "><a href="mainController?action=showlist&type=dep">Department</a></li>
                                <li class="breadcrumb-item active">Update Department</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div>

                </div>
                <div class="modal-body">
                    <form action="mainController" method="POST" class="form-position">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput" name="depname" placeholder="Example input"

                            <c:choose>
                                <c:when test="${not empty requestScope.Dep.depName}">
                                    value="${requestScope.Dep.depName}"
                                </c:when>
                                <c:otherwise>
                                    value="${requestScope.namereg}"
                                </c:otherwise>
                            </c:choose>
                            >

                        <p style="color:red">${requestScope.messName}</p>
                        <p style="color:red">${requestScope.WARNINGEXIST}</p>
                    </div>


                    <div class="form-group">
                        <label for="formGroupExampleInput2">Description</label>
                        <input type="text" name="depdes" class="form-control" id="formGroupExampleInput2" placeholder="Another input"

                               <c:choose>
                                   <c:when test="${not empty requestScope.Dep.description}">
                                       value="${requestScope.Dep.description}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.desreg}"
                                   </c:otherwise>
                               </c:choose>
                               >

                        <p style="color:red">${requestScope.messDes}</p>
                    </div>


                    <div class="form-group">
                        <label for="formGroupExampleInput2">Location</label>
                        <input type="text" name="deploc" class="form-control" id="formGroupExampleInput2" placeholder="Another input"


                               <c:choose>
                                   <c:when test="${not empty requestScope.Dep.location}">
                                       value="${requestScope.Dep.location}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.locreg}"
                                   </c:otherwise>
                               </c:choose>
                               >

                        <p style="color:red"> ${requestScope.messLoc}</p>
                        <p style="color:red">${requestScope.WARNING}</p>
                    </div>


                    <div class="form-position__btn" style="text-align: center">
                        <input type="hidden" name="depnum"

                               <c:choose>
                                   <c:when test="${not empty requestScope.Dep.depNum}">
                                       value="${requestScope.Dep.depNum}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.idreg}"
                                   </c:otherwise>
                               </c:choose> 
                               >

                        <input type="hidden" name="depcheck"
                               <c:choose>
                                   <c:when test="${not empty requestScope.Dep.depName}">
                                       value="${requestScope.Dep.depName}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.nameregcheck}"
                                   </c:otherwise>
                               </c:choose>
                               >

                        <input type="submit" class="btn btn-primary " name="action" value="Update"/> 
                    </div>
                    <c:if test="${requestScope.updateSuccess != null}">
                        <c:out value="${requestScope.updateSuccess}"/>
                    </c:if>
                </form>
            </div>

        </div>
    </body>
</html>
