<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="Teller_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">    
    <script src="/resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <style>
        @media only screen and (min-width: 992px) and (max-width: 2500px) {
            .nav-link {
                color: white !important;
            }

            .nav-link.active {
                font-weight: bolder;
            }
        
            #welcomeLabel:hover {            
                background-color: #dc3545 !important;
            }
            
            .nav-link:hover{
                color: white !important;
            }

            .nav-item:hover {
                background-color: maroon !important;
                transition: 0.3s;
            }

            .nav-item {
                border-radius: 0.5rem;
            }

            .dropdown-item:hover {                
                background-color: maroon !important;
                color: white !important;
                transition: 0.3s;
            }

            #accountDetails .accordion-item .accordion-header .accordion-button:not(.collapsed) {
                color: #198754 !important;
                background-color: white !important;
                box-shadow: 0 0 0 0 !important;
            }

            #accountDetails .accordion-item .accordion-header .accordion-button:focus {
                box-shadow: 0 0 0 0;
            }

            #accountDetails.accordion {
                --bs-accordion-btn-active-icon: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='none' stroke='%23212529' stroke-linecap='round' stroke-linejoin='round'%3e%3cpath d='M2 5L8 11L14 5'/%3e%3c/svg%3e");
            }

            .card:hover {
                transform: scale(1.1);
                transition: 0.3s
            }

            .card {
                transform: scale(1);
                transition: 0.3s;
            }
        }

        @media only screen and (max-width: 992px) {
            .nav-link {
                color: black !important;
            }

            .nav-link.active {
                font-weight: bolder;
            }
            
            .nav-link:hover, .nav-link.show{
                color: white !important;
            }
        
            #welcomeLabel, #welcomeLabel a:hover {            
                color: black !important;
                background-color: white !important;
            }

            .nav-item:hover {
                background-color: maroon !important;
                transition: 0.3s;
            }

            .nav-item {
                border-radius: 0.5rem;
            }

            .dropdown-item:hover {                
                background-color: maroon !important;
                color: white !important;
                transition: 0.3s;
            }

            #accountDetails .accordion-item .accordion-header .accordion-button:not(.collapsed) {
                color: #198754 !important;
                background-color: white !important;
                box-shadow: 0 0 0 0 !important;
            }

            #accountDetails .accordion-item .accordion-header .accordion-button:focus {
                box-shadow: 0 0 0 0;
            }

            #accountDetails.accordion {
                --bs-accordion-btn-active-icon: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='none' stroke='%23212529' stroke-linecap='round' stroke-linejoin='round'%3e%3cpath d='M2 5L8 11L14 5'/%3e%3c/svg%3e");
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navbar" Runat="Server">
    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
        <li id="welcomeLabel" class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 fw-semibold">Welcome <asp:Label class="ms-1" ID="usernameLabel" runat="server"></asp:Label>!</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 active" aria-current="page" href="./Dashboard.aspx">Dashboard</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Deposit.aspx">Deposit</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Withdraw.aspx">Withdraw</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transfer.aspx">Transfer</a>
        </li>
        <li class="nav-item me-0 me-lg-3 dropdown">
            <a class="nav-link ms-3 ms-lg-0 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                More
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="./MyProfile.aspx">Transactions</a></li>
                <li><a class="dropdown-item" href="./MyProfile.aspx">Customer Search</a></li>
                <li><a class="dropdown-item" href="./MyProfile.aspx">Account Inquiry</a></li>
                <li>
                    <hr class="dropdown-divider">
                </li>
                <li>
                    <asp:Button ID="Logout" class="dropdown-item" runat="server" Text="Logout" />
                    <%--<a class="dropdown-item" href="Login.aspx">Logout</a>--%>
                </li>
            </ul>
        </li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col">
                <div class="row justify-content-center">
                    <h1 class="col-auto">Dashboard</h1>
                </div>    

                <div class="row justify-content-center">
                    <div class="col-12 col-sm-4 col-lg-3 mb-3 mb-sm-0">
                        <div class="card">
                            <div class="card-body text-center">
                                <h6 class="card-title">Total Clients Today</h6>                                
                                <h3 class="card-text">12</h3>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-12 col-sm-4 col-lg-3 mb-3 mb-sm-0">
                        <div class="card">
                            <div class="card-body text-center">
                                <h6 class="card-title">Total Deposits Today</h6>
                                <h3 class="card-text">12</h3>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-12 col-sm-4 col-lg-3 mb-3 mb-sm-0">
                        <div class="card">
                            <div class="card-body text-center">
                                <h6 class="card-title">Total Withdraws Today</h6>
                                <h3 class="card-text">12</h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>   
</asp:Content>

