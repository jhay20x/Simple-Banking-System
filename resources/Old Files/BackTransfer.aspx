<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BackTransfer.aspx.vb" Inherits="BackTransfer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="shortcut icon" type="image/x-icon" href="./img/LOGO_Only.png"/>
    <title>DCSA - Transfer Money</title>
    <link href="resources/style/bootstrap.css" rel="stylesheet" type="text/css" />

    <style>
        @media only screen and (min-width: 992px) and (max-width: 2500px) {
            #nav a {
                font-size: 1.25rem;
            }

            .bank-options h5 {
                font-size: 1rem;
            }
        }

        @media only screen and (min-width: 768px) and (max-width: 900px) {
            #nav a {
                font-size: 1.125rem;
            }

            .bank-options h5 {
                font-size: 1rem;
            }
        }        

        @media only screen and (max-width: 600px) {
            #nav a {
                font-size: 0.9375rem;
            }

            .bank-options h5 {
                font-size: 0.875rem;
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
                        <a href="#" class="text-white fs-2 fw-semibold text-decoration-none col-auto">DCSA</a>
                    </div>
                    <div id="nav" class="row mt-3 mt-md-0 col-auto d-flex justify-content-center">
                        <a href="MyAccounts.aspx" class="text-white fw-semibold text-decoration-none col-auto">My Accounts</a>
                        <a href="Transfer.aspx" class="text-white fw-semibold text-decoration-underline col-auto">Transfer</a>
                        <a href="Transactions.aspx" class="text-white fw-semibold text-decoration-none col-auto">Transactions</a>
                        <a href="#" class="text-white fw-semibold text-decoration-none col-auto">More</a>
                    </div>
                    <a href="Login.aspx" class="text-white mt-3 mt-md-0 fs-6 fw-semibold text-decoration-none col-auto">Logout</a>
                </div>
            </div>
        </div>

        <div class="container d-flex justify-content-center align-items-center" style="height: 80vh;">
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
    </form>
</body>
</html>
