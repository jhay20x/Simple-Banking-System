<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ResetPassword.aspx.vb" Inherits="Accounts_ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">   
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" type="image/x-icon" href="../resources/img/LOGO_Only.png"/>
    <title>DCSA - Forgot Password</title>
    <link href="../resources/style/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="../resources/script/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="../resources/script/jquery-3.7.1.js" type="text/javascript"></script>
    <script>
        function toggleButtons() {
            $("#OldPasswordTextToggle, #NewPasswordTextToggle, #ConfirmNewPasswordTextToggle").on("click", function () {
                let id = "#" + $(this).attr('id').replace("Toggle", "");
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
            $("#OldPasswordText, #NewPasswordText, #ConfirmNewPasswordText").prop("disabled", true);
        }

        $(document).ready(function () {
            toggleButtons();
        })
    </script>
</head>
<body class="bg-danger d-flex justify-content-center align-items-center" style="min-height:100vh;">
    <form id="myForm" class="col-10 col-sm-6 col-md-6 col-lg-5 col-xl-3" runat="server">
        <div class="p-5 flex-column bg-white rounded shadow d-flex align-items-center row">
            <div class="d-flex flex-column align-items-center mb-1">
                <a href="#">
                    <img src="../resources/img/LOGO Initials.png" alt="Logo" width="250" height="90">
                </a>
            </div>

            <div class="col text-center my-1">
                <h6>Forgot Password</h6>
                <h6><span class="fw-normal">Please enter your new password.</span></h6>
            </div>
            
            <div class="col" id="errorMessage"></div>                   
                        
            <div class="input-group mb-3">
                <div class="form-floating">
                    <asp:TextBox class="form-control" required ID="NewPasswordText" placeholder="Enter your New Password" runat="server" type="password"></asp:TextBox>
                    <label for="NewPasswordText">Enter your New Password</label>
                </div>
                <button class="btn btn-outline-secondary" id="NewPasswordTextToggle" type="button"><i id="" class="bi bi-eye"></i></button>
            </div>                        
                        
            <div class="input-group mb-3">
                <div class="form-floating">
                    <asp:TextBox class="form-control" required ID="ConfirmNewPasswordText" placeholder="Confirm your New Password" runat="server" type="password"></asp:TextBox>
                    <label for="ConfirmNewPasswordText">Confirm your New Password</label>
                </div>
                <button class="btn btn-outline-secondary" id="ConfirmNewPasswordTextToggle" type="button"><i id="" class="bi bi-eye"></i></button>
            </div>
                
            <div class="d-flex flex-column align-items-center">
                <asp:Button ID="submitBtn" class="btn p-2 mb-3 col-12 btn-danger" runat="server" Text="Submit" />
                <asp:LinkButton ID="backBtn" runat="server" CssClass="btn p-2 mb-2 col-12 btn-outline-danger">
                    <i class="bi bi-arrow-left"></i> Back to Login
                </asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>
