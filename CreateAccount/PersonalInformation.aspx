<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PersonalInformation.aspx.vb" Inherits="CreateAccount_PersonalInformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">   
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" type="image/x-icon" href="../resources/img/LOGO_Only.png"/>
    <title>DCSA - Create Account</title>
    <link href="../resources/style/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="../resources/script/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="../resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <style>        
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        
        input[type="date"]::-webkit-calendar-picker-indicator {
            background: transparent;
            bottom: 0;
            color: transparent;
            cursor: pointer;
            height: auto;
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            width: auto;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#NoMiddle, #NoSuffix").click(function () {
                let id = "";

                if ((this.id) == "NoMiddle") {
                    id = "#" + $(this).attr('id').substring(2) + "Name";
                } else {
                    id = "#" + $(this).attr('id').substring(2);
                }

                if ($(this).is(":checked")) {
                    $(id).prop("readonly", true);
                    $(id).val("None");
                } else {
                    $(id).prop("readonly", false);
                    $(id).val("");
                }
            });
        });
    </script>
</head>
<body class="bg-danger d-flex justify-content-center align-items-center" style="min-height:100vh;">
    <form id="myForm" class="col-11 container" runat="server">
        <div class="p-3 p-md-4 p-lg-5 bg-white rounded shadow justify-content-center align-items-center row">

            <div class="row justify-content-center">
                <div class="col-auto">
                    <img src="../resources/img/LOGO Initials.png" alt="Logo" width="250" height="90">
                </div>
            </div>

            <div class="row justify-content-center text-center my-1">
                <div class="col">
                    <h6>Create Account</h6>
                    <h6><span class="fw-normal">Please fill up all the neccessary fields.</span></h6>
                </div>
            </div>
            
            <div class="row">
                <div class="col" id="errorMessage"></div>
            </div>

            <div class="row justify-content-center mb-3">         
                <div class="col">
                    <div class="input-group-text">
                        <input id="ConfirmationCheck" required name="ConfirmationCheck" value="Confirmed" type="checkbox" />
                        <label for="ConfirmationCheck" class="ms-1">Is a Filipino Resident and Above 18.</label>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="FirstName" placeholder="First Name" runat="server"></asp:TextBox>
                        <label for="FirstName">First Name</label>
                    </div>
                </div>

                <div class="col-12 col-md-6 col-lg-3">                    
                    <div class="input-group mb-3">
                        <div class="form-floating">
                            <asp:TextBox class="form-control" required ID="MiddleName" placeholder="Middle Name" runat="server"></asp:TextBox>
                            <label for="MiddleName">Middle Name</label>
                        </div>
                        <div class="input-group-text">                            
                            <asp:CheckBox ID="NoMiddle" runat="server" />
                            <label class="ms-1" for="NoMiddle">N/A</label>
                        </div>
                    </div>
                </div>               

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="LastName" placeholder="Last Name" runat="server"></asp:TextBox>
                        <label for="LastName">Last Name</label>
                    </div>
                </div>           

                <div class="col-12 col-md-6 col-lg-3">
                    <div class="input-group mb-3">
                        <div class="form-floating">
                            <asp:TextBox class="form-control" required ID="Suffix" placeholder="Suffix" runat="server"></asp:TextBox>
                            <label for="Suffix">Suffix</label>
                        </div>
                        <div class="input-group-text">                            
                            <asp:CheckBox ID="NoSuffix" runat="server" />
                            <label class="ms-1" for="NoSuffix">N/A</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="DOB" placeholder="Date of Birth" type="date" runat="server"></asp:TextBox>
                        <label for="userEmailAccount">Date of Birth</label>
                    </div>
                </div>
                
                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <select required class="form-control" name="Gender" id="Gender">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                        <label for="Gender">Gender</label>
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="userContactNumber" placeholder="Contact Number" type="number" runat="server"></asp:TextBox>
                        <label for="userContactNumber">Contact Number</label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="CountryBirth" placeholder="Country of Birth" runat="server"></asp:TextBox>
                        <label for="CountryBirth">Country of Birth</label>
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="CityBirth" placeholder="City of Birth" runat="server"></asp:TextBox>
                        <label for="CityBirth">City of Birth</label>
                    </div>
                </div>

                <div class="col-12 col-md-4">
                    <div class="mb-3 form-floating">
                        <asp:TextBox class="form-control" required ID="Address" placeholder="Address" runat="server"></asp:TextBox>
                        <label for="Address">Address</label>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-12 col-md-4 col-lg-3 order-0 order-sm-1">
                    <asp:Button ID="submitBtn" class="btn p-2 mb-3 col-12 btn-danger" runat="server" Text="Submit" />
                </div>
                <div class="col-12 col-md-4 col-lg-3 order-1 order-sm-0">
                    <asp:LinkButton ID="backBtn" runat="server" CssClass="btn p-2 mb-2 col-12 btn-outline-danger">
                        <i class="bi bi-arrow-left"></i> Back to Login
                    </asp:LinkButton>
                </div>
            </div>         
        </div>
    </form>
</body>
</html>
