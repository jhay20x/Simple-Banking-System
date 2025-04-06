<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" Inherits="ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Update Password</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="../resources/script/jquery-3.7.1.js" type="text/javascript"></script>
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

            .dropdown-item.active {
                background-color: maroon !important;
                font-weight: bolder;
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

            .dropdown-item.active {
                background-color: maroon !important;
                font-weight: bolder;
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
    <script>
        function toggleButtons() {
            $("#OldPasswordTextToggle, #NewPasswordTextToggle, #ConfirmNewPasswordTextToggle").on("click", function () {
                let id = "#ContentPlaceHolder1_" + $(this).attr('id').replace("Toggle", "");
                let icon = $(this).find("i");

                if ($(id).attr("type") == "password") {
                    $(id).attr("type", "text");
                    $(icon).removeClass(['bi bi-eye']);
                    $(icon).addClass(['bi bi-eye-slash']);

                } else {
                    $(id).attr("type", "password");
                    $(icon).removeClass(['bi bi-eye-slash']);
                    $(icon).addClass(['bi bi-eye']);
                }
            });
        }

        function disableInputs() {
            $("#<%= OldPasswordText.ClientID%>, #<%= NewPasswordText.ClientID%>, #<%= ConfirmNewPasswordText.ClientID%>").prop("disabled", true);
        }

        $(document).ready(function () {
            toggleButtons();
        })
    </script>
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
                <li><a class="dropdown-item active" href="./ChangePassword.aspx">Change Password</a></li>
                <li>
                    <hr class="dropdown-divider">
                </li>
                <li>
                    <asp:Button ID="Logout" class="dropdown-item" runat="server" Text="Logout" CausesValidation="False" UseSubmitBehavior="False" />
                    <%--<a class="dropdown-item" href="Login.aspx">Logout</a>--%>
                </li>
            </ul>
        </li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col">
                <div class="row justify-content-center">
                    <h1 class="col-auto">Update Password</h1>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <asp:Panel ID="UpdatePassword" runat="server" DefaultButton="UpdatePasswordBtn">

                    <div class="row justify-content-center">
                        <div class="col-11 col-md-10 col-lg-8 col-xl-6 p-3 rounded shadow mt-3 bg-white">
                            
                            <div class="col" id="errorMessage"></div>

                            <div class="input-group mb-3">
                                <div class="form-floating">
                                    <asp:TextBox class="form-control" required ID="OldPasswordText" placeholder="Enter your Old Password" runat="server" type="password"></asp:TextBox>
                                    <label for="<%= OldPasswordText.ClientID %>">Enter your Old Password</label>
                                </div>
                                <button class="btn btn-outline-secondary" id="OldPasswordTextToggle" type="button"><i id="" class="bi bi-eye"></i></button>
                            </div>                        
                        
                            <div class="input-group mb-3">
                                <div class="form-floating">
                                    <asp:TextBox class="form-control" required ID="NewPasswordText" placeholder="Enter your New Password" runat="server" type="password"></asp:TextBox>
                                    <label for="<%= NewPasswordText.ClientID %>">Enter your New Password</label>
                                </div>
                                <button class="btn btn-outline-secondary" id="NewPasswordTextToggle" type="button"><i id="" class="bi bi-eye"></i></button>
                            </div>                        
                        
                            <div class="input-group mb-3">
                                <div class="form-floating">
                                    <asp:TextBox class="form-control" required ID="ConfirmNewPasswordText" placeholder="Confirm your New Password" runat="server" type="password"></asp:TextBox>
                                    <label for="<%= ConfirmNewPasswordText.ClientID %>">Confirm your New Password</label>
                                </div>
                                <button class="btn btn-outline-secondary" id="ConfirmNewPasswordTextToggle" type="button"><i id="" class="bi bi-eye"></i></button>
                            </div>

                            <div class="row justify-content-center">
                                <div class="col-auto">
                                    <asp:Button class="btn btn-sm btn-outline-danger" ID="UpdatePasswordBtn" runat="server" Text="Submit" />
                                </div>
                            </div>

                        </div>
                    </div>

                </asp:Panel>
                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>

