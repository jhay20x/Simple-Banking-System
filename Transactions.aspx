<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Transactions.aspx.vb" Inherits="Transactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Transactions</title>
    <link rel="stylesheet" href="resources/style/dataTables.bootstrap5.css">
    <script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <script src="resources/script/dataTables.js" type="text/javascript"></script>
    <script src="resources/script/dataTables.bootstrap5.js" type="text/javascript"></script>
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
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navbar" Runat="Server">
    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" aria-current="page" href="./MyAccounts.aspx">My Accounts</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0" href="./Transfer.aspx">Transfer</a>
        </li>
        <li class="nav-item me-0 me-lg-3">
            <a class="nav-link ms-3 ms-lg-0 active" href="./Transactions.aspx">Transactions</a>
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
    <div class="modal fade" id="transactionsModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="transactionsLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header d-flex align-items-center">
                    <h6 class="modal-title" id="transactionsLabel">Transactions</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="transactionsClose" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <h6>Date: <span class="fw-normal">03/06/2024</span></h6>
                            <h6>Transaction ID: <span class="fw-normal">123456</span></h6>
                            <h6>Transaction Type: <span class="fw-normal">Send Money</span></h6>
                            <h6>Transfer From: <span class="fw-normal">0145965679</span></h6>
                            <h6>Transfer To: <span class="fw-normal">0154874577</span></h6>
                            <h6>Amount: <span class="fw-normal">-1500.00</span></h6>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                    <input type="submit" class="btn btn-sm  data-bs-toggle="modal" data-bs-target="#transactionsModal"btn-primary btn-md mt-1" value="Submit" name="transactionsSubmitBtn">
                </div> -->
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row justify-content-center align-items-center" style="height: 100vh;">
            <div class="col">
                <div class="row justify-content-center">
                    <h1 class="col-auto">Transactions</h1>
                </div>    
                <div class="col-auto p-3 rounded shadow mt-3 bg-white">
                    <table id="myTable" class="table table-hover table-striped">
                        <thead>
                            <tr>
                                <th class="col">Transaction ID</th>
                                <th class="col">Transaction Type</th>
                                <th class="col">Date</th>
                                <th class="col">Action</th>
                            </tr>
                        </thead>
    
                        <tbody>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>03/06/2024</td>
                                <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#transactionsModal">View</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

    <script>        
        let table = new DataTable('#myTable', {
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
            order: [
                [0, "desc"]
            ]
        });
    </script>
</asp:Content>

