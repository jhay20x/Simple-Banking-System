<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Transactions.aspx.vb" Inherits="Transactions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Transactions</title>
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
                <li><a class="dropdown-item" href="#">Action</a></li>
                <li><a class="dropdown-item" href="#">Another action</a></li>
                <li>
                    <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item" href="Login.aspx">Logout</a></li>
            </ul>
        </li>
    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="row col d-flex justify-content-center align-items-center">
            <h1 class="text-center">Transactions</h1>

            <div class="rounded shadow mt-3 bg-white">
                <div class="my-3 mx-1">
                    <table id="myTable" class="table text-center table-bordered table-hover table-striped">
                        <thead>
                            <tr>
                                <th class="col">Transaction ID</th>
                                <th class="col">Transaction</th>
                                <th class="col">Transfer From</th>
                                <th class="col">Transfer To</th>
                                <th class="col">Amount</th>
                                <th class="col">Date</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>0145965679</td>
                                <td>0154874577</td>
                                <td>-1500.00</td>
                                <td>03/06/2024</td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>0145965679</td>
                                <td>0154874577</td>
                                <td>-1500.00</td>
                                <td>03/06/2024</td>
                            </tr>
                            <tr>
                                <td>123456</td>
                                <td>Send Money</td>
                                <td>0145965679</td>
                                <td>0154874577</td>
                                <td>-1500.00</td>
                                <td>03/06/2024</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>    
        </div>
    </div>
</asp:Content>

