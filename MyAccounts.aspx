<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="MyAccounts.aspx.vb" Inherits="MyAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - My Accounts</title>    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">    
    <script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <style>
        @media only screen and (min-width: 992px) and (max-width: 2500px) {
            .nav-link {
                color: white !important;
            }

            .nav-link.active {
                font-weight: bolder;
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
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 active" aria-current="page" href="./MyAccounts.aspx">My Accounts</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transfer.aspx">Transfer</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transactions.aspx">Transactions</a>
        </li>
        <li class="nav-item me-0 me-lg-3 dropdown">
            <a class="nav-link ms-3 ms-lg-0 dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                More
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="#">My Profile</a></li>
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

    <!-- Modal -->
    <div class="modal fade" id="accountDetailsModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="accountDetailsLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header d-flex align-items-center">
                    <h6 class="modal-title" id="accountDetailsLabel">Savings Account</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="accountDetailsClose" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="col">
                            <h6>Available Balance</h6>
                            <span><small>PHP</small> 1500.00</span>
                        </div>
                        <div class="col mt-3">
                            <h6>Total Balance</h6>
                            <span><small>PHP</small> 1500.00</span>
                        </div>                        
                        <div class="accordion accordion-flush mt-3" id="accountDetails">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button text-success fw-semibold p-0 collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#otherDetails" aria-expanded="false" aria-controls="otherDetails">
                                        Other Details 
                                    </button>
                                </h2>
                                <div id="otherDetails" class="accordion-collapse collapse" data-bs-parent="#accountDetails">
                                    <div class="row">
                                        <div class="accordion-body col-6">
                                            <h6 class="fw-normal">Account Number</h6 class="fw-normal">
                                            <h6>0145965679</h6>
                                        </div>

                                        <div class="accordion-body col-6">
                                            <h6 class="fw-normal">Account Type</h6 class="fw-normal">
                                            <h6>Checking Account</h6>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="accordion-body pb-0 col">
                                            <h6 class="fw-normal">Branch</h6 class="fw-normal">
                                            <h6>DCSA - Valenzuela</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="col">
                            <a href="#" class="text-decoration-none h6"><span><i class="bi bi-arrow-left-right"></i></span> Transfer To</a>
                        </div>

                        <div class="col mt-3">                            
                            <a href="#" class="text-decoration-none h6"><span><i class="bi bi-file-earmark-medical"></i></span> My Statements</a>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                    <input type="submit" class="btn btn-sm btn-primary btn-md mt-1" value="Submit" name="accountDetailsSubmitBtn">
                </div> -->
            </div>
        </div>
    </div>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="row col d-flex justify-content-center align-items-center">
            <h1 class="text-center">Deposit Accounts</h1>

            <div class="rounded shadow mt-3 bg-white col-11 col-md-10 col-lg-8">
                <div class="my-3 mx-1">
                    <div class="accordion" id="myAccounts">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#accountOne" aria-expanded="true" aria-controls="accountOne">
                                    Savings Account: 0145965679
                                </button>
                            </h2>
                            <div id="accountOne" class="accordion-collapse collapse show" data-bs-parent="#myAccounts">
                                <div class="accordion-body row align-items-center">
                                    <div class="col row">
                                        <div class="col-auto">
                                            <a href="#" class="text-decoration-none h5" data-bs-toggle="modal" data-bs-target="#accountDetailsModal">Available Balance: <small class="small fw-semibold">PHP</small> <span id="balance" class="h5">1500.00</span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
    </div>
    
    <script type="text/javascript">
        // $("#togglePassword").on("click", function() {
        //     if ($("#toggleIcon").hasClass("bi-eye")) {
        //         $("#toggleIcon").removeClass(['bi', 'bi-eye']);
        //         $("#toggleIcon").addClass(['bi', 'bi-eye-slash']);
        //     } else {
        //         $("#toggleIcon").removeClass(['bi', 'bi-eye-slash']);
        //         $("#toggleIcon").addClass(['bi', 'bi-eye']);
        //     }
        // });
    </script>
</asp:Content>


