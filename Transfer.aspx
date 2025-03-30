<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Transfer.aspx.vb" Inherits="Transfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Transactions</title>    
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

            .bank-options h5 {
                font-size: 1rem;
            }

            .rounded:hover{
                transform: scale(1.1);
                transition: 0.3s;
            }

            .rounded{
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

            .bank-options h5 {
                font-size: 0.875rem;
            }

            .rounded:hover{
                transform: scale(1.1);
                transition: 0.3s;
            }

            .rounded{
                transform: scale(1);
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
            <a class="nav-link ms-3 ms-lg-0 active" href="./Transfer.aspx">Transfer</a>
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
            <h1 class="text-center">Transfer Money</h1>
            <div class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 me-3 me-md-5 bg-white">
                <div class="m-3 row d-flex justify-content-center">
                    <div class="col-12">
                        <img class="img-fluid" src="resources/img/person.png" alt="Logo" height="150px" width="150px" />
                    </div>
                    <div class="col-12 col-md-10 col-lg bank-options">
                        <h5>To another DCSA account</h5>
                    </div>
                </div>
            </div>
            
            <div class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 bg-white">
                <div class="m-3 row d-flex justify-content-center">
                    <div class="col-12">
                        <img class="img-fluid" src="resources/img/person-multiple.png" alt="Logo" height="150px" width="150px" />
                    </div>
                    <div class="col-12 col-md-8 col-lg bank-options">
                        <h5>To another bank</h5>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</asp:Content>

