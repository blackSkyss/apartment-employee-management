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
                transform: scale(0.99);
                opacity: 0.9
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-bottom: 0 !important;
                margin-left: -14px
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

        <c:if test="${requestScope.listEmp != null}">          
            <div style="width: 100%; margin: 0 20%" class="modal-content">            
                <div class="modal-header" style="margin-bottom: 16px">
                    <div>
                        <h5 class="modal-title">Create new dependent</h5>
                        <div>
                            <ul class="breadcrumb">
                                <c:if test="${requestScope.EmpId ne null}">
                                    <li class="breadcrumb-item"><a href="mainController?action=passidemp&empid=${requestScope.EmpId}&type=detail">Employee Records</a></li>
                                    </c:if>
                                    <c:if test="${requestScope.EmpId eq null}">
                                    <li class="breadcrumb-item"><a href="listHallManagerController">Home</a></li>
                                    </c:if>
                                <li class="breadcrumb-item"><a href="mainController?action=listDependent">Dependent</a></li>
                                <li class="breadcrumb-item active">Create new dependent</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <c:if test="${filedBlank != null}">
                    <p style="color: red" ><c:out value="${filedBlank}"/></p> 
                </c:if>
                <div class="modal-body">
                    <form action="mainController" class="form-position">
                        <c:if test="${requestScope.EmpId eq null}">
                            <div class="form-group">
                                <div style="margin-bottom: 4px">Select employee</div>                                      
                                <select name="empId" class="certificate-select">
                                    <c:forEach var="listEmp" items="${requestScope.listEmp}">
                                        <option value="${listEmp.idEmp}"> id:<c:out value="${listEmp.idEmp}"/> - name:<c:out value="${listEmp.name}"/></option>                        
                                    </c:forEach>
                                </select> 
                            </div>
                        </c:if>
                        <div class="form-group">
                            <span>Dependent name</span>
                            <input class="form-control" name="name" value="${param.name}">   
                            <c:if test="${nameInvalid != null}">
                                <p style="color: red" >${nameInvalid}</p> 
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
                            <input class="form-control" name="dob" value="${param.dob}" type="date" required="" >
                            <c:if test="${requestScope.checkDob != null}" >
                                <p style="color: red" >${requestScope.checkDob}</p>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <span>Relationship</span>
                            <input class="form-control" name="relationship" value="${param.relationship}"> 
                            <c:if test="${checkRelationship != null}">
                                <p style="color: red" ><c:out value="${checkRelationship}"/></p> 
                            </c:if>
                        </div>

                        <div style="margin-top: 20px; text-align: center">
                            <c:if test="${requestScope.EmpId ne null}">
                                <input type="hidden" name="empId" value="${requestScope.EmpId}">
                                <input type="hidden" name="flag" value="flag">
                            </c:if>
                            <input class="btn btn-primary" type="submit" value="Save">
                            <input type="hidden" name="action" value="saveNewDependent">               
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
    </body>
</html>
