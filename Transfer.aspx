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

            .btn-outline-danger:hover {
                color: white !important;
                background-color: #dc3545 !important;
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

            .btn-outline-danger:hover {
                color: white !important;
                background-color: #dc3545 !important;
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
    <div class="modal fade" id="transferOwnModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="transferOwnLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header d-flex align-items-center">
                    <h6 class="modal-title" id="transferOwnLabel">Transfer to own account</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="transferOwnClose" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="col">
                            <h6>No eligible accounts found.</h6>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                    <input type="submit" class="btn btn-sm btn-primary btn-md mt-1" value="Submit" name="transferOwnSubmitBtn">
                </div> -->
            </div>
        </div>
    </div>
    
    <!-- Modal -->
    <div class="modal fade" id="transferOtherModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="transferOtherLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header d-flex align-items-center">
                    <h6 class="modal-title" id="transferOtherLabel">Transfer to another bank</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="transferOtherClose" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <h6 class="col-12 ps-0">Transfer from:</h6>

                            <div class="col-12">
                                <input type="radio" class="btn-check" name="options" id="btn1" autocomplete="off">
                                <label class="btn btn-outline-danger col-12" for="btn1">
                                    <h6 class="col-12">Savings Account</h6>
                                    <h6 class="col-12 fw-normal">0145965679</h6>
                                    <h6 class="col-12 fw-normal"><small>PHP</small> <span>1500.00</span></h6>
                                </label>
                            </div>

                            <div class="col-12">
                                <input type="radio" class="btn-check" name="options" id="btn2" autocomplete="off">
                                <label class="btn btn-outline-danger col-12 mt-3" for="btn2">
                                    <h6 class="col-12">Savings Account</h6>
                                    <h6 class="col-12 fw-normal">0145965679</h6>
                                    <h6 class="col-12 fw-normal"><small>PHP</small> <span>1500.00</span></h6>
                                </label>
                            </div>
                        </div>
                        
                        <div class="row mt-3">
                            <h6 class="col-12 ps-0">Transfer To:</h6>

                            <div class="col-12">
                                <div class="form-floating">
                                    <select class="form-control" name="otherBanks" id="otherBanks">
                                        <option value="">Fake GCash</option>
                                    </select>
                                    <label for="otherBanks">Select Bank:</label>
                                </div>

                                <div class="form-floating mt-3">
                                    <input type="text" class="form-control" placeholder="Account Number" name="acccountNumber" id="acccountNumber">
                                    <label for="acccountNumber">Account Number</label>
                                </div>

                                <div class="form-floating mt-3">
                                    <input type="text" class="form-control" placeholder="Account Name" name="acccountNumber" id="acccountNumber">
                                    <label for="acccountNumber">Account Name</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mt-3">
                            <h6 class="col-12 ps-0">Transfer Amount:</h6>

                            <div class="row col-auto align-items-center">
                                <h6>PHP</h6>
                            </div>
                            <div class="col">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="0.00" name="acccountNumber" id="acccountNumber">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row justify-content-center mt-3">
                            <div class="col-auto">
                                <button type="button" class="btn btn-danger" name="Continue" id="continueBtn">Continue</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                    <input type="submit" class="btn btn-sm btn-primary btn-md mt-1" value="Submit" name="transferOtherSubmitBtn">
                </div> -->
            </div>
        </div>
    </div>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="row col d-flex justify-content-center align-items-center">
            <h1 class="text-center">Transfer Money</h1>
            <div class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 me-3 me-md-5 bg-white">
                <div class="m-3 row d-flex justify-content-center" data-bs-toggle="modal" data-bs-target="#transferOwnModal">
                    <div class="col-12">
                        <img class="img-fluid" src="resources/img/person.png" alt="Logo" height="150px" width="150px" />
                    </div>
                    <div class="col-12 col-md-10 col-lg bank-options">
                        <h5>To another DCSA account</h5>
                    </div>
                </div>
            </div>
            
            <div class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 bg-white" data-bs-toggle="modal" data-bs-target="#transferOtherModal">
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

