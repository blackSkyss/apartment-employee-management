<%-- 
    Document   : header
    Created on : Feb 2, 2022, 5:37:31 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Header Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width= device-width, initial-scale = 1.0">
        <link rel="stylesheet" href="./css/header.css"/>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap');
            
            body{
                font-family: 'Poppins', sans-serif !important;
            }
            
            .header__container{
                height: 58px;
                width: 100%;
                background: linear-gradient(to right, #00c0f9, #0255cd);
                margin-bottom: 16px
            }

            .header__logo{
                display: flex;
                align-items: center
            }

            .header__logo h3{
                margin: 0 ;
                font-size: 20px ;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="header__container">
            <div class="header__navbar">
                <div class="header__logo">
                    <a  href="EmployeeHome.jsp">
                        <img src="images/logo.jpg" class="header__logo-img">
                    </a>
                    <h3>UniCorp</h3>
                </div>

                <div class="header__user">
                    <img 
                        src="images/${sessionScope.USER_LOGGIN.imgPath}" 
                        alt="" 
                        class="header__user-img"
                        >
                    <span class="header__user-name"><c:out value="${sessionScope.USER_LOGGIN.name}"/></span>

                    <ul class="header__user-menu">

                        <li class="header__user-item">
                            <a href="logoutController?action=logout">Logout</a>
                        </li>
                    </ul>


                </div>
            </div>
        </div>
    </body>
</html>
