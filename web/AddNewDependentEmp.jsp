<%-- 
    Document   : AddNewDependent
    Created on : Jun 21, 2022, 7:20:37 AM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add new Dependent</title>
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
                background-color: #fff !important;
                padding-bottom: 0 !important
            }
            .page-title{
                text-align: initial !important;
                margin-top: 8px;
                margin-left: 30px
            }

            .modal-content{
                height: 100%
            }

            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 10px !important;
                font-size: 18px;
                font-weight: 600;
                min-width: 120px;
                padding: 2px 4px;
                margin-top: 16px
            }

            .btn-primary:hover{
                transform: scale(0.95)
            }
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="headerEmp.jsp"></c:import>
        <c:import url="sidebarEmp.jsp"></c:import> 
            <div style="margin: 2% 20%; width: 100%" class="modal-content">
                <div class="page-header">
                    <div class="row">
                        <h3 class="page-title">Add new dependent</h3>
                        <div class="col-sm-12 list-employee__actions">                       
                            <div>
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a></li>
                                    <li class="breadcrumb-item"><a href="mainController?action=listDependentEmp">Dependent</a></li>
                                    <li class="breadcrumb-item active">Add new dependent</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

            <c:if test="${filedBlank != null}">
                <p style="color: red" ><c:out value="${filedBlank}"/></p> 
            </c:if>
            
          
            <div class="modal-body">
                <form action="mainController" class="form-position">
                    <div class="form-group">
                        <span>Dependent name</span>
                        <input class="form-control" name="name" value="${param.name}">   
                        <c:if test="${nameInvalid != null}">
                            <p style="color: red" ><c:out value="${nameInvalid}"/></p> 
                        </c:if>
                    </div>
                    <div class="form-group">
                        <span>Gender</span>                        
                        <select name="gender" class="form-control">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>                                                                                     
                    </div>
                    <div class="form-group ">
                        <div style="margin-bottom: 4px">Date of birth</div>
                        <input class="form-control" name="dob" value="${param.dob}" type="date">
                        <c:if test="${requestScope.checkDob != null}" >
                            <p style="color: red" ><c:out value="${requestScope.checkDob}" /></p>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <span>Relationship</span>
                        <input class="form-control" name="relationship" value="${param.relationship}"> 
                        <c:if test="${checkRelationship != null}">
                            <p style="color: red" ><c:out value="${checkRelationship}"/></p> 
                        </c:if>
                    </div>
                    <div style="text-align: center">
                        <input class="btn btn-primary" type="submit" value="Save">
                        <input type="hidden" name="action" value="saveNewDependentEmp">
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>
