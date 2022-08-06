<%-- 
    Document   : error
    Created on : May 29, 2022, 10:11:52 PM
    Author     : lehon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <style>
            .login-fail{
            position: relative;
            text-align: center
            }
            
            .login-fail__img{
                height: 96vh
            }
            
            .login-fail__link{
                position: absolute;
                top: 0;
                left: 20px;
                font-size: 26px;
                text-decoration: none;
                color: #000;
                display: flex;
                align-items: center
            }
            
            .login-fail__link:hover{
                text-decoration: underline;
                opacity: 0.9
            }
            
            .login-fail__link-icon{
                color: #000;
                margin-right: 4px
            }
        </style>
    </head>
    <body>
        <div class="login-fail">
            <img class="login-fail__img" src="./images/loginFail.jpg" alt="Login Fail"/>
            <a class="login-fail__link" href="Hall.jsp">
                <i class="ri-arrow-left-circle-line login-fail__link-icon"></i>
                Try again
            </a>
        </div>
        
    </body>
</html>
