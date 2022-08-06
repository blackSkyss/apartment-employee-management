<%-- 
    Document   : addNewCertificate
    Created on : Jun 7, 2022, 4:53:38 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add new Certificate</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .breadcrumb{
                background-color: #fff !important;
                display: inline-flex !important;
                float: left !important;
            }

            .page-title{
                text-align: initial !important;
                margin-left: 32px !important;
                margin-top: 8px
            }

            #sidebar{
                height: 100vh
            }

            .certificate-select{
                padding: 0.375rem 0.75rem;
                font-size: 1rem;
                line-height: 1.5;
                color: #495057;
                background-color: #fff;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                width: 100%;
                height: 42px
            }

            .modal-content{
                height: 100%
            }

            .save-btn{
                background-color: #00a8ef;
                border: 1px solid #00c5fb;
                border-radius: 10px;
                color: #fff;
                font-weight: 500;
                min-width: 100px;
                text-decoration: none;
                cursor: pointer;
                padding: 4px 0;
            }

            .save-btn:hover{
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
        <c:import url="sidebarEmp.jsp"></c:import> 



            <div style="width: 100%; margin: 3% 20%" class="modal-content">
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Certificate</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                    <li class="breadcrumb-item">Account</li>
                                    <li class="breadcrumb-item"><a href="mainController?action=listCertEmp">Certificate</a></li>
                                    <li class="breadcrumb-item active">Add new certificate</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            <c:if test="${filedBlank != null}">
                <p style="color: red" ><c:out value="${filedBlank}"/></p> 
            </c:if>
            <c:if test="${Success != null}">
                <p style="color: green" ><c:out value="${Success}"/></p> 
            </c:if>
            <c:if test="${Fail != null}">
                <c:out value="${Fail}"/>
            </c:if>
            <div class="modal-body">
                <form action="mainController" class="form-position" enctype="multipart/form-data" method="POST">            

                    <div class="form-group">
                        <span> Name certificate</span>
                        <input class="form-control" name="cerName" value="${param.cerName}"> 
                        <c:if test="${nameInvalid != null}">
                            <p style="color: red" ><c:out value="${nameInvalid}"/></p> 
                        </c:if>
                    </div>
                    <div class="form-group">
                        <span>Date of isuess</span>
                        <input class="form-control" name="cerDoi" type="date" value="${param.cerDoi}"> 
                        <c:if test="${requestScope.checkDoi != null}" >
                            <p style="color: red" ><c:out value="${requestScope.checkDoi}" /></p>
                        </c:if>
                    </div>
                    <div class="form-group ">
                        <div style="margin-bottom: 4px">Type</div>

                        <select name="idTypeCer" class="certificate-select">
                            <c:forEach var="listTypeCer" items="${requestScope.listTypeCer}">
                                <option value="${listTypeCer.idTypeCer}" ><c:out value="${listTypeCer.type}"/></option>                        
                            </c:forEach>
                        </select> 

                    </div>
                    <div class="form-group" style="margin-top: 16px">
                        <span> Image</span>
                        <input class="form-control" name="imgPath" type="file" accept="image/*">   
                    </div>
                    <div style="margin-top: 20px; text-align: center">
                        <input type="hidden" name="action" value="addNewCertEmp"/>
                        <input type="hidden" name="empID" value="${sessionScope.USER_LOGGIN.idEmp}"/>
                        <input class="save-btn" type="submit" value="Save">
                    </div>

                </form>
            </div>
        </div>
    </body>
</html>
