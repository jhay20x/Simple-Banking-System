<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Transfer.aspx.vb" Inherits="Transfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>DCSA - Transfer</title>    
    <script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>
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
    <script>
        function disableInputs() {
            $("input[name='optionsDCSA']").prop("checked", false).prop("disabled", true);
            $("input[name='optionsOther']").prop("checked", false).prop("disabled", true);
            $("#otherBanks").prop("disabled", true).val(1);
            $(".optionsDCSA, #<%= accountNumberDCSA.ClientID %>, #<%= accountNameDCSA.ClientID %>, #<%= amountDCSA.ClientID %>").prop("disabled", true);
            $(".optionsOther, #<%= accountNumberOther.ClientID %>, #<%= accountNameOther.ClientID %>, #<%= amountOther.ClientID %>").prop("disabled", true);
        }

        function limitFields() {
                $("#<%= accountNumberDCSA.ClientID %>, #<%= accountNumberOther.ClientID %>").on("input", function () {
                    if (this.value.length > 10) {
                        this.value = this.value.substring(0, 11);
                    }
                });
    
                $("#<%= amountDCSA.ClientID %>, #<%= amountOther.ClientID %>").on("input", function () {
                    if (this.value.length > 8) {
                        this.value = this.value.substring(0, 8);
                    }
                });
    
                $("#<%= amountDCSA.ClientID %>, #<%= amountOther.ClientID %>").on("blur", function () {                
                    let val = parseFloat(this.value);
                    if (!isNaN(val)) {
                        this.value = val.toFixed(2);
                    }
                });
            }

        $(document).ready(function () {
            disableInputs();   
            limitFields();

            $("#transferDCSA").on("click", function () {
                $("input[name='optionsDCSA']").prop("checked", false).prop("disabled", false);
                $(".optionsDCSA, #<%= accountNumberDCSA.ClientID %>, #<%= accountNameDCSA.ClientID %>, #<%= amountDCSA.ClientID %>").prop("disabled", false);

                $("input[name='optionsOther']").prop("checked", false).prop("disabled", true);
                $("#otherBanks").prop("disabled", true).val(1);
                $(".optionsOther, #<%= accountNumberOther.ClientID %>, #<%= accountNameOther.ClientID %>, #<%= amountOther.ClientID %>").prop("disabled", true).val("");
            });

            $("#transferDCSAModal").on("hidden.bs.modal", function () {
                $("#errorDCSAMessage").empty();
                $("input[name='optionsDCSA']").prop("checked", false).prop("disabled", true);;
                $(".optionsDCSA, #<%= accountNumberDCSA.ClientID %>, #<%= accountNameDCSA.ClientID %>, #<%= amountDCSA.ClientID %>").prop("disabled", true).val("");
            });

            $("#transferOther").on("click", function () {
                $("input[name='optionsOther']").prop("checked", false).prop("disabled", false);
                $("#otherBanks").prop("disabled", false).val(1);
                $(".optionsOther, #<%= accountNumberOther.ClientID %>, #<%= accountNameOther.ClientID %>, #<%= amountOther.ClientID %>").prop("disabled", false);

                $("input[name='optionsDCSA']").prop("checked", false).prop("disabled", true);
                $(".optionsDCSA, #<%= accountNumberDCSA.ClientID %>, #<%= accountNameDCSA.ClientID %>, #<%= amountDCSA.ClientID %>").prop("disabled", true).val("");
            });

            $("#transferOtherModal").on("hidden.bs.modal", function () {
                $("#errorOtherMessage").empty();
                $("input[name='optionsOther']").prop("checked", false).prop("disabled", true);
                $("#otherBanks").prop("disabled", true).val(1);
                $(".optionsOther, #<%= accountNumberOther.ClientID %>, #<%= accountNameOther.ClientID %>, #<%= amountOther.ClientID %>").prop("disabled", true).val("");
            });
        });
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
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Modal -->
    <div class="modal fade" id="transferDCSAModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="transferDCSALabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header d-flex align-items-center">
                    <h6 class="modal-title" id="transferDCSALabel">Transfer to another DCSA account</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" id="transferDCSAClose" aria-label="Close"></button>
                </div>                             
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                <div class="modal-body">
                    <div class="container-fluid">
                                       
                        <div class="col" id="errorDCSAMessage"></div>

                        <div class="row">
                            <h6 class="col-12 ps-0">Transfer from:</h6>

                            <div class='col-12'>
                                <input type='radio' required name='optionsDCSA' value="None" id='noneDCSA' required class='btn-check' autocomplete='off' />
                                <label class='btn btn-outline-danger col-12 my-1' for='noneDCSA'>
                                    <span class='col-12 fw-semibold'>None</span>
                                </label>
                            </div>

                            <asp:PlaceHolder ID="fundOptions" runat="server"></asp:PlaceHolder>
                        </div>
                        
                        <div class="row mt-3">
                            <h6 class="col-12 ps-0">Transfer To:</h6>

                            <div class="col-12">
                                <div class="form-floating">
                                    <asp:TextBox class="form-control optionsDCSA" required ID="accountNumberDCSA" placeholder="Account Number (Ex: 1234657890)" runat="server" type="number"></asp:TextBox>
                                    <label for="<%= accountNumberDCSA.ClientID %>">Account Number (Ex: 1234657890)</label>
                                </div>

                                <div class="form-floating mt-3">
                                    <asp:TextBox class="form-control optionsDCSA" required ID="accountNameDCSA" placeholder="Account Name (Ex: Juan Dela Cruz)" runat="server"></asp:TextBox>
                                    <label for="<%= accountNameDCSA.ClientID %>">Account Name (Ex: Juan Dela Cruz)</label>
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
                                    <asp:TextBox class="form-control optionsDCSA" required ID="amountDCSA" placeholder="0.00" runat="server" type="number"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row text-center mt-2">
                            <small>*Transfers with other DCSA accounts is free of charge.</small>
                        </div>
                    </div>
                </div>
                 <div class="modal-footer justify-content-center">
                    <div class="col-auto">
                        <asp:Button ID="transferDCSABtn" class="btn btn-danger btn-sm" runat="server" Text="Continue" />
                    </div>
                </div> 
                                
                </ContentTemplate>
                </asp:UpdatePanel>
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
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>

                <div class="modal-body">
                    <div class="container-fluid">

                        <div class="col" id="errorOtherMessage"></div>

                        <div class="row">
                            <h6 class="col-12 ps-0">Transfer from:</h6>                                       

                            <div class='col-12'>
                                <input type='radio' required name='optionsOther' value="None" id='noneOther' class='btn-check' autocomplete='off' />
                                <label class='btn btn-outline-danger col-12 my-1' for='noneOther'>
                                    <span class='col-12 fw-semibold'>None</span>
                                </label>
                            </div>

                            <asp:PlaceHolder ID="fundOptionsOther" runat="server"></asp:PlaceHolder>
                        </div>
                        
                        <div class="row mt-3">
                            <h6 class="col-12 ps-0">Transfer To:</h6>

                            <div class="col-12">
                                <div class="form-floating">
                                    <select required class="form-control optionsOther" name="otherBanks" id="otherBanks">
                                        <option value="1">Fake GCash</option>
                                    </select>
                                    <label for="otherBanks">Select Bank:</label>
                                </div>

                                <div class="form-floating mt-3">
                                    <asp:TextBox class="form-control optionsOther" required ID="accountNumberOther" placeholder="Account Name (Ex: Juan Dela Cruz)" runat="server" type="number"></asp:TextBox>
                                    <label for="<%= accountNumberOther.ClientID %>">Account Number (Ex: 1234657890)</label>
                                </div>

                                <div class="form-floating mt-3">
                                    <asp:TextBox class="form-control optionsOther" required ID="accountNameOther" placeholder="Account Name (Ex: Juan Dela Cruz)" runat="server"></asp:TextBox>
                                    <label for="<%= accountNameOther.ClientID %>">Account Name (Ex: Juan Dela Cruz)</label>
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
                                    <asp:TextBox class="form-control optionsOther" required ID="amountOther" placeholder="0.00" runat="server" type="number"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row text-center mt-2">
                            <small>*Transfers with other Banks have a transaction fee of Php 8.00.</small>
                        </div>
                    </div>
                </div>
                 <div class="modal-footer justify-content-center">
                    <div class="col-auto">
                        <asp:Button ID="transferOtherBtn" class="btn btn-danger btn-sm" runat="server" Text="Continue" />
                    </div>
                </div> 

                </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="row col d-flex justify-content-center align-items-center">
            <h1 class="text-center">Transfer Money</h1>
            <div id="transferDCSA" class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 me-3 me-md-5 bg-white" data-bs-toggle="modal" data-bs-target="#transferDCSAModal">
                <div class="m-3 row d-flex justify-content-center">
                    <div class="col-12">
                        <img class="img-fluid" src="resources/img/person.png" alt="Logo" height="150px" width="150px" />
                    </div>
                    <div class="col-12 col-md-10 col-lg bank-options">
                        <h5>To another DCSA account</h5>
                    </div>
                </div>
            </div>
            
            <div id="transferOther" class="col-5 col-md-4 col-lg-3 btn rounded shadow mt-3 bg-white" data-bs-toggle="modal" data-bs-target="#transferOtherModal">
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

