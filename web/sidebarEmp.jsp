<%-- 
    Document   : sidebar
    Created on : Jun 8, 2022, 9:34:29 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <title>Side Bar</title>

        <!-- Bootstrap CSS CDN -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <!-- Our Custom CSS -->
        <link rel="stylesheet" href="./css/sidebar.css">

        <!-- Font Awesome JS -->
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
        <style>
            .mt-20{
                margin-bottom: 20px
            }
        </style>
    </head>

    <body>

        <div class="wrapper">
            <!-- Sidebar  -->
            <nav id="sidebar">
                <nav class="navbar-expand-lg">
                    <div class="container-fluid">
                        <button type="button" id="sidebarCollapse" class="btn btn-info ">
                            <i class="fas fa-align-left"></i>
                        </button>
                        <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fas fa-align-justify"></i>
                        </button>
                    </div>
                </nav>
                <div class="sidebar-header">
                    <div style="border: 1px solid #fff; width: 100%"></div>
                    <strong>U</strong>
                </div>

                <ul class="list-unstyled components">
                    <li class="mt-20">
                        <a href="EmployeeHome.jsp">
                            <span style="width: 30px">
                                <i class="fas fa-calendar "></i>
                            </span>
                            Home
                        </a>
                    </li>
                    <li class="mt-20">
                        <a href="mainController?action=listDependentEmp">
                            <span style="width: 30px">
                                <i class="fas fa-user-friends"></i>
                            </span>
                            Dependent
                        </a>
                    </li>
                    <li class="mt-20">
                        <a  href="mainController?action=showDepartmentEmp">
                            <span style="width: 30px">
                                <i class="fas fa-building"></i>
                            </span>
                            Department
                        </a>
                    </li>


                    <li>
                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                            <span style="width: 30px">
                                <i class="fas fa-user"></i>
                            </span>
                            Account
                        </a>
                        <ul class="collapse list-unstyled" id="pageSubmenu">
                            <li>
                                <a href="mainController?action=listCertEmp">Certificate</a>
                            </li>
                            <li>
                                <a href="mainController?action=listRewPenEmp">Reward and Penalty</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a></a>
                    </li>
                </ul>

                <ul class="list-unstyled CTAs">
                    <div class="footer__body">
                        <div>
                            <div class="footer__content">
                                <div class="footer__header-left">
                                    <ul class="list-unstyled footer__list">
                                        <li>Privacy Policy</li>
                                        <li>Terms &amp; Conditions</li>
                                    </ul>
                                </div>
                            </div>
                            <div>
                                <p>&copy; 2022 Team6</p>
                            </div>
                        </div>
                    </div>                 
                </ul>

            </nav>

            <!-- Page Content  -->


            <!-- jQuery CDN - Slim version (=without AJAX) -->
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
            <!-- Popper.JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
            <!-- Bootstrap JS -->
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

            <script type="text/javascript">
                $(document).ready(function () {
                    $('#sidebarCollapse').on('click', function () {
                        $('#sidebar').toggleClass('active');
                    });
                });
            </script>
    </body>

</html>
