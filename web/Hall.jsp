<%-- 
    Document   : Hall
    Created on : May 29, 2022, 1:33:53 PM
    Author     : AD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="./css/welcomepage.css"/>

    </head>
    <body>
        <div>
            <section class="body">
                <div class="container">
                    <div class="login-box">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="logo">
                                    <span class="logo-font">UniCorp</span>
                                </div>
                            </div>
                        </div>
                        <div class="row">             
                            <div class="col-sm-6">
                                <br>
                                <h3 class="header-title">LOGIN</h3>

                                <div class="form-group">
                                    <div class="carousel-item active">
                                        <div class="slider-feature-card card-custom">
                                            <img src="./images/avatar.svg" alt="">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:3030/apartment-employee-management/LoginGoogleController&response_type=code
                                               &client_id=981322887444-l8jbe7meq63lgooss90ks3o1en14nom3.apps.googleusercontent.com&approval_prompt=force" class="btn btn-primary btn-block">
                                                Login 
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="carousel-item active">
                                    <div class="slider-feature-card">
                                        <img class="logo-building" src="./images/logo.jpg" alt="">
                                        <h3 class="slider-title">UniCorp</h3>
                                        <p class="slider-description">Always listening always understanding!</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
</html>
