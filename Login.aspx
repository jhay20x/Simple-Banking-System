<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" type="image/x-icon" href="resources/img/LOGO_Only.png"/>
    <title>DCSA - Login</title>
    <link href="resources/style/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="resources/script/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>
</head>
<body class="bg-danger d-flex justify-content-center align-items-center" style="min-height:100vh;">
    <form id="myForm" runat="server">
        <div class="p-5 flex-column bg-white rounded shadow d-flex align-items-center row">
            <div class="d-flex flex-column align-items-center mb-3">
                <a href="#">
                    <img src="resources/img/LOGO Initials.png" alt="Logo" width="250" height="90">
                </a>
            </div>
            
            <div class="col" id="errorMessage"></div>

            <div class="col">
                <div class="mb-3 form-floating">
                    <asp:TextBox class="form-control" ID="loginUsername" placeholder="Username" runat="server"></asp:TextBox>
                    <label for="loginUsername">Username</label>
                </div>
            </div>

            <div class="col">
                <div class="input-group mb-3">
                    <div class="form-floating">
                        <asp:TextBox class="form-control" ID="loginPassword" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                        <label for="loginPassword">Password</label>
                    </div>
                    <button class="btn btn-outline-secondary" type="button" id="togglePassword"><i id="toggleIcon" class="bi bi-eye"></i></button>
                </div>
            </div>
                
            <div class="d-flex flex-column align-items-center">
                <asp:Button ID="loginBtn" class="btn p-2 mb-3 col-12 btn-danger" runat="server" Text="Log in" />
                <h6>
                    Forgot <a href="#">username</a> or <a href="#">password</a>
                </h6>
            </div>
        </div>
    </form>
</body>
</html>

<script type="text/javascript">
    $("#togglePassword").on("click", function() {
        if ($("#loginPassword").attr("type") == "password") {
            $("#loginPassword").attr("type", "text");
            $("#toggleIcon").removeClass(['bi', 'bi-eye']);
            $("#toggleIcon").addClass(['bi', 'bi-eye-slash']);

        } else {
            $("#loginPassword").attr("type", "password");
            $("#toggleIcon").removeClass(['bi', 'bi-eye-slash']);
            $("#toggleIcon").addClass(['bi', 'bi-eye']);
        }
    });
</script>