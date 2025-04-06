<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Deposit.aspx.vb" Inherits="Teller_Deposit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Deposit</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">    
    <script src="/resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <style>
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

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
    <script>
        function limitInputs() {
            $("#<%= DepositAccountNumber.ClientID %>").on("input", function () {
                if (this.value.length > 10) {
                    this.value = this.value.substring(0, 10);
                }
            });

            $("#<%= DepositAmount.ClientID %>").on("input", function () {
                    if (this.value.length > 8) {
                        this.value = this.value.substring(0, 8);
                    }
                });

            $("#<%= DepositAmount.ClientID %>").on("blur", function () {
                let val = parseFloat(this.value);
                if (!isNaN(val)) {
                    this.value = val.toFixed(2);
                }
            });
        }

        $(document).ready(function () {
            limitInputs();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navbar" Runat="Server">
    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
        <li id="welcomeLabel" class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 fw-semibold">Welcome <asp:Label class="ms-1" ID="usernameLabel" runat="server"></asp:Label>!</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" aria-current="page" href="./Dashboard.aspx">Dashboard</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 active" href="./Deposit.aspx">Deposit</a>
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
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col">
                <div class="row justify-content-center">
                    <h1 class="col-auto">Deposit</h1>
                </div>
                  
                <div class="col p-3 rounded shadow mt-3 bg-white">                                       
                    <div class="col" id="errorMessage"></div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                    <asp:Panel ID="Panel1" DefaultButton="submitBtn" runat="server">

                    <div class="row justify-content-center">
                        <div class="col-12 col-sm-6 mb-3 mb-sm-0">
                            <div class="form-floating">
                                <asp:TextBox class="form-control" required placeholder="Account Number (Ex: 7810250000)" type="number" ID="DepositAccountNumber" runat="server"></asp:TextBox>
                                <label for="<%= DepositAccountNumber.ClientID %>">Account Number (Ex: 7810250000)</label>
                            </div>
                        </div>

                        <div class="col-12 col-sm-6">
                            <div class="form-floating">
                                <asp:TextBox class="form-control" required placeholder="Amount (Ex: 100.00)" type="number" ID="DepositAmount" runat="server"></asp:TextBox>
                                <label for="<%= DepositAmount.ClientID %>">Amount (Ex: 100.00)</label>
                            </div>
                        </div>
                    </div>

                    <div class="row justify-content-center mt-3">
                        <asp:Button ID="submitBtn" class="btn col-6 col-sm-3 btn-outline-danger" runat="server" Text="Proceed" />
                    </div>

                    </asp:Panel>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

