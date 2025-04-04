<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="MyProfile.aspx.vb" Inherits="MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - My Profile</title>
    <script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>
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
            <a class="nav-link ms-3 ms-lg-0" aria-current="page" href="./MyAccounts.aspx">My Accounts</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transfer.aspx">Transfer</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transactions.aspx">Transactions</a>
        </li>
        <li class="nav-item me-0 me-lg-3 dropdown">
            <a class="nav-link ms-3 ms-lg-0 dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                More
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="./MyProfile.aspx">My Profile</a></li>
                <li><a class="dropdown-item" href="#">Change Password</a></li>
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
                    <h1 class="col-auto">My Profile</h1>
                </div>

                <div class="row justify-content-center">
                    <div class="col-11 col-md-10 col-lg-8 col-xl-6 p-3 rounded shadow mt-3 bg-white">                    
                        <h6 class="fw-normal">Name: <span class="h6"><asp:Label ID="NameLabel" runat="server"></asp:Label></span></h6>
                        <h6 class="fw-normal">Gender: <span class="h6"><asp:Label ID="GenderLabel" runat="server"></asp:Label></span></h6>
                        <h6 class="fw-normal">Date of Birth: <span class="h6"><asp:Label ID="DOBLabel" runat="server"></asp:Label></span></h6>
                        <h6 class="fw-normal">Address: <span class="h6"><asp:Label ID="AddressLabel" runat="server"></asp:Label></span></h6>
                        <h6 class="fw-normal">Contact Number: <span class="h6"><asp:Label ID="ContactLabel" runat="server"></asp:Label></span></h6>
                        <h6 class="fw-normal">Email Address: <span class="h6"><asp:Label ID="EmailLabel" runat="server"></asp:Label></span></h6>
                    </div>

                    <div class="row text-center mt-3">
                        <small>*To update your profile details, please visit the bank and ask for assistance.</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

