<%-- 
    Document   : createNewEmp
    Created on : Jun 10, 2022, 4:17:53 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@page import="java.util.Date"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Employee</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            body{
                font-family: 'Poppins', sans-serif !important;
                background-color: #f7f7f7 !important;
            }

            .form__title{
                padding: 4px 0
            }

            .form__select{
                width: 278.3px !important;
                height: 38px !important;
                background-clip: padding-box;
                border: 1px solid #ced4da;
            }

            .breadcrumb{
                background-color: #fff !important;
                margin-left: -16px;
                margin-bottom: 0 !important;
                padding-bottom: 0 !important
            }

            .image{
                width: 100px;
                height: 100px;
                border-radius: 50%
            }

            .btn-primary{
                background-color: #00a8ef;
                border: 1px solid #01a3ed !important;
                border-radius: 20px !important;
                font-size: 18px;
                font-weight: 600;
                min-width: 150px;
                padding: 10px 20px;
                margin-top: 16px
            }

            .btn-primary:hover{
                transform: scale(0.95);
                opacity: 0.9
            }

            .modal-content{
                background-color: #fff;
                margin-bottom: 16px !important
                height: 100%;
            }
            #sidebar{
                height: 100vh;               
            }
            
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.USER_LOGGIN eq null}">
            <c:redirect url="Hall.jsp"/>
        </c:if>
        <c:import url="headerEmp.jsp"></c:import>
        <c:import url="sidebarEmp.jsp"></c:import> 

            <div class="modal-content" style="margin: 0 20%">

                <div class="modal-header">
                    <div>
                        <h5 class="modal-title">Update Employee</h5>
                        <div>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="EmployeeHome.jsp">Home</a> </li>
                                <li class="breadcrumb-item active">Update Employee</li>
                            </ul>
                        </div>
                    </div>
                </div>



                <div class="modal-body" style="padding-bottom: 0">
                    <form action="mainController" method="post" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label class="col-form-label">Name</label>
                                    <input class="form-control" type="text" name="empname"
                                    <c:choose>
                                        <c:when test="${param.empname eq null}">
                                            value="${sessionScope.USER_LOGGIN.name}"
                                        </c:when>
                                        <c:otherwise>
                                            value="${param.empname}"
                                        </c:otherwise>
                                    </c:choose>                                                  
                                    >
                                <p style="color: red">${requestScope.WARNINGNAME}</p>    
                            </div>                  
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Address</label>
                                <input class="form-control" type="text" name="empadd"
                                       <c:choose>
                                           <c:when test="${param.empadd eq null}">
                                               value="${sessionScope.USER_LOGGIN.address}"
                                           </c:when>
                                           <c:otherwise>
                                               value="${param.empadd}"
                                           </c:otherwise>  
                                       </c:choose> 
                                       >
                                <p style="color:red">${requestScope.WARNINGADD}</p>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Phone</label> 
                                <input class="form-control" type="text" name="empphone"
                                       <c:choose>
                                           <c:when test="${param.empphone eq null}">
                                               value="${sessionScope.USER_LOGGIN.phoneNum}"
                                           </c:when>
                                           <c:otherwise>
                                               value="${param.empphone}"
                                           </c:otherwise>
                                       </c:choose>                                                                                                                        
                                       >
                                <p style="color:red">${requestScope.WARNINGPHONE}</p>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-form-label form__title">Gender</div>  
                                <select name="empgen  " class="form-control">
                                    <option value="Male" 
                                            <c:choose>
                                                <c:when test="${param.empgen eq null}">
                                                    <c:if test="${sessionScope.USER_LOGGIN.gender == 'Male'}">selected=""</c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${param.empgen == 'Male'}">selected=""</c:if>
                                                </c:otherwise>
                                            </c:choose>                                    
                                            >
                                        Male
                                    </option>

                                    <option value="Female" 
                                            <c:choose>
                                                <c:when test="${param.empgen eq null}">
                                                    <c:if test="${sessionScope.USER_LOGGIN.gender == 'Female'}">selected=""</c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${param.empgen == 'Female'}">selected=""</c:if>
                                                </c:otherwise>
                                            </c:choose>                            
                                            >Female
                                    </option>

                                    <option value="Other" 
                                            <c:choose>
                                                <c:when test="${param.empgen eq null}">
                                                    <c:if test="${sessionScope.USER_LOGGIN.gender == 'Other'}">selected=""</c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:if test="${param.empgen == 'Other'}">selected=""</c:if>
                                                </c:otherwise>
                                            </c:choose>                                                                                                     
                                            >Other
                                    </option>

                                </select>
                            </div>
                        </div>
                    </div>



                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Day of birth</label>
                                <input class="form-control" type="date" name="empdob"
                                       <c:choose>
                                           <c:when test="${param.empdob eq null}">
                                               value="${sessionScope.USER_LOGGIN.dob}"
                                           </c:when>
                                           <c:otherwise>
                                               value="${param.empdob}"
                                           </c:otherwise>
                                       </c:choose>    
                                       >
                                <p style="color:red">${requestScope.WARNINGDOB}</p>
                            </div>
                        </div>

                    </div>


                    <div class="row">
                        <div class="col-sm-6" style="margin-top: 16px">
                            <div>
                                <label class="col-form-label">Current image</label>
                                <img class="align-self-center img-fluid image" 
                                     <c:choose>
                                         <c:when test="${not empty sessionScope.USER_LOGGIN.imgPath}">
                                             src='images/${sessionScope.USER_LOGGIN.imgPath}'
                                         </c:when> 
                                         <c:otherwise>
                                             src='images/${requestScope.imgreg}'
                                         </c:otherwise>
                                     </c:choose>           
                                     >
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-form-label">New Image</div>
                                <input class="form-control" type="file" name="empimg" value="" accept="image/*">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-form-label">Salary</label>
                                <input readonly="" class="form-control" type="text" name="empsalary"
                                       <c:choose>
                                           <c:when test="${param.empsalary eq null}">
                                               value="${sessionScope.USER_LOGGIN.baseSalary}"
                                           </c:when>
                                           <c:otherwise>
                                               value="${param.empsalary}"
                                           </c:otherwise>
                                       </c:choose>                                                  
                                       >
                                <p style="color: red">${requestScope.WARNINGSALARY}</p>    
                            </div>                  
                        </div>
                    </div>

                    <div>
                        <p style="color:red">${requestScope.WARNINGFIELD}</p>
                        <p style="color:green">${requestScope.COMPLETED}</p>
                        <p style="color: red">${requestScope.FAILINSERT}</p>
                    </div>

                    <div>
                        <input type="hidden" name="action" value="updateEmpInfo">
                        <input type="hidden" name="oldimg"
                               <c:choose>
                                   <c:when test="${not empty sessionScope.USER_LOGGIN.imgPath}">
                                       value="${sessionScope.USER_LOGGIN.imgPath}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.imgreg}"
                                   </c:otherwise>
                               </c:choose>    
                               >
                        <input type="hidden" name="idemp"
                               <c:choose>
                                   <c:when test="${not empty sessionScope.USER_LOGGIN.idEmp}">
                                       value="${sessionScope.USER_LOGGIN.idEmp}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${requestScope.idreg}"
                                   </c:otherwise>
                               </c:choose>   
                               >
                        <div style="text-align: center">
                            <input class="btn btn-primary" type="submit" value="Update">
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>
