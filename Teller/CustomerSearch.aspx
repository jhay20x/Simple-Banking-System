<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="CustomerSearch.aspx.vb" Inherits="Teller_CustomerSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Customer Search</title>
    <link rel="stylesheet" href="../resources/style/dataTables.bootstrap5.css">
    <link href="../resources/style/dataTables.dateTime.css" rel="stylesheet" type="text/css" />
    <link href="../resources/style/searchBuilder.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="../resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <script src="../resources/script/dataTables.js" type="text/javascript"></script>
    <script src="../resources/script/dataTables.bootstrap5.js" type="text/javascript"></script>
    <script src="../resources/script/searchBuilder.dataTables.js" type="text/javascript"></script>
    <script src="../resources/script/dataTables.searchBuilder.js" type="text/javascript"></script>
    <script src="../resources/script/dataTables.dateTime.js" type="text/javascript"></script>
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

            .nav-link:hover, .nav-link.show {
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
        <%--function limitInputs() {
            $("#<%= ClientAccountNumber.ClientID %>").on("input", function () {
                if (this.value.length > 10) {
                    this.value = this.value.substring(0, 10);
                }
            });
        }--%>

        $(document).ready(function () {
            //limitInputs();
        });

        function loadTable(){
            let table = new DataTable('#myTable', {        
                language: {
                    searchBuilder: {
                        title: {
                            0: 'Filters',
                            _: 'Filters (%d)'
                        },
                    }
                },
                select: false,
                lengthMenu: [
                    [15, 25, 50, -1],
                    [15, 25, 50, 'All'],
                ],
                layout: {
                    topStart:{
                    },
                    topEnd: {
                        search: true
                    },
                    top1: {
                        searchBuilder: true
                    },
                    bottomStart: {
                        pageLength: true
                    }
                },
                columnDefs: [
                    {
                        targets: [0,1,2,3],
                        className: 'dt-body-center dt-head-center'
                    }
                ],
                paging: true,
                autoSize: true,
                scrollCollapse: true,
                scrollY: '30vh',
            });
        }

        function LoadDetails(TransactionID, TransactionType, DateLabel){
            $("#ContentPlaceHolder1_DateLabel").text = DateLabel;
            $("#ContentPlaceHolder1_TransactionID").text = DateLabel;
            $("#ContentPlaceHolder1_TransactionType").text = DateLabel;

            $('#profileViewModal').modal('show');
        };
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
            <a class="nav-link ms-3 ms-lg-0" href="./Deposit.aspx">Deposit</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Withdraw.aspx">Withdraw</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transfer.aspx">Transfer</a>
        </li>
        <li class="nav-item me-0 me-lg-3 dropdown">
            <a class="nav-link ms-3 ms-lg-0 dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                More
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
                <li><a class="dropdown-item" href="./Transactions.aspx">Transactions</a></li>
                <li><a class="dropdown-item active" href="./CustomerSearch.aspx">Customer Search</a></li>
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
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="profileViewModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="profileViewLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header d-flex align-items-center">
                            <h6 class="modal-title" id="profileViewLabel">Transactions</h6>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" id="profileViewClose" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <h6>Account ID: <span class="fw-normal"><asp:Label ID="AccountIDLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Account Username: <span class="fw-normal"><asp:Label ID="AccountUsernameLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Account Email: <span class="fw-normal"><asp:Label ID="AccountEmailLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Name: <span class="fw-normal"><asp:Label ID="NameLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Gender: <span class="fw-normal"><asp:Label ID="GenderLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Date of Birth: <span class="fw-normal"><asp:Label ID="DOBLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Country of Birth: <span class="fw-normal"><asp:Label ID="CountryBirthLabel" runat="server"></asp:Label></span></h6>
                                            <h6>City of Birth: <span class="fw-normal"><asp:Label ID="CityBirthLabel" runat="server"></asp:Label></span></h6>
                                            <h6>Contact Number: <span class="fw-normal"><asp:Label ID="ContactLabel" runat="server"></asp:Label></span></h6>
                                        </div>
                                    </div>
                        </div>
                        <!-- <div class="modal-footer">
                            <input type="submit" class="btn btn-sm  data-bs-toggle="modal" data-bs-target="#profileViewModal"btn-primary btn-md mt-1" value="Submit" name="profileViewSubmitBtn">
                        </div> -->
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row justify-content-center align-items-center" style="height: 100vh;">
                    <div class="col">
                        <div class="row justify-content-center">
                            <h1 class="col-auto">Customer Search</h1>
                        </div>

                        <div class="col-auto p-3 rounded shadow mt-3 bg-white">                            
                            <div class="row justify-content-center">
                                <div class="col-12" id="errorMessage"></div>

                                <div class="col-12">
                                    <asp:Table ID="myTable" class="table table-hover table-striped" runat="server" ClientIDMode="Static"></asp:Table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>    
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

