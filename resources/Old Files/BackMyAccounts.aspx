<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BackMyAccounts.aspx.vb" Inherits="BackMyAccounts" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="shortcut icon" type="image/x-icon" href="./img/LOGO_Only.png"/>
    <title>DCSA - My Accounts</title>
    <link href="resources/style/bootstrap.css" rel="stylesheet" type="text/css" />

    <style>
        @media only screen and (min-width: 992px) and (max-width: 2500px) {
            #nav a {
                font-size: 1.25rem;
            }
        }

        @media only screen and (min-width: 768px) and (max-width: 900px) {
            #nav a {
                font-size: 1.125rem;
            }
        }        

        @media only screen and (max-width: 600px) {
            #nav a {
                font-size: 0.9375rem;
            }
        }
    </style>
</head>
<body class="bg-body-secondary overflow-hidden">
    <form id="myForm" runat="server">
        <div class="bg-danger p-3">
            <div class="container">
                <div class="row d-flex align-items-center justify-content-md-between justify-content-center">
                    <div class="row col-auto">
                        <img class="col-auto" src="resources/img/LOGO_Only.png" alt="Logo" height="50px" width="90px" />
                        <a href="#" class="text-white fs-2 fw-semibold text-decoration-none col-auto">DCSA Bank</a>
                    </div>
                    <div id="nav" class="row mt-3 mt-md-0 col-auto d-flex justify-content-center">
                        <a href="MyAccounts.aspx" class="text-white fw-semibold text-decoration-underline col-auto">My Accounts</a>
                        <a href="Transfer.aspx" class="text-white fw-semibold text-decoration-none col-auto">Transfer</a>
                        <a href="Transactions.aspx" class="text-white fw-semibold text-decoration-none col-auto">Transactions</a>
                        <!-- <a href="#" class="text-white fw-semibold text-decoration-none col-auto">More</a> -->
                    </div>
                    <a href="Login.aspx" class="text-white mt-3 mt-md-0 fs-6 fw-semibold text-decoration-none col-auto">Logout</a>
                </div>
            </div>
        </div>

        <div class="container d-flex justify-content-center align-items-center" style="height: 80vh;">
            <div class="row col d-flex justify-content-center align-items-center">
                <h1 class="text-center">My Accounts</h1>

                <div class="rounded shadow mt-3 bg-white">
                    <div class="my-3 mx-1">
                        <div class="accordion" id="myAccounts">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#accountOne" aria-expanded="true" aria-controls="accountOne">
                                        Savings Account: 0145965679
                                    </button>
                                </h2>
                                <div id="accountOne" class="accordion-collapse collapse show" data-bs-parent="#myAccounts">
                                    <div class="accordion-body">
                                        <div class="col">
                                            <span class="h5">Available Balance:</span> <small class="small fw-semibold">PHP</small> <span class="h5">1500.00</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </div>
        </div>
    </form>
</body>
</html>

<script src="resources/script/bootstrap.bundle.js" type="text/javascript"></script>
<script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>

<script type="text/javascript">
    
</script>
