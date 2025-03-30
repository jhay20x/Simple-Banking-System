<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BackTransactions.aspx.vb" Inherits="BackTransactions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<link rel="shortcut icon" type="image/x-icon" href="./img/LOGO_Only.png"/>
    <title>DCSA - Transactions</title>
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
                        <a href="#" class="text-white fs-2 fw-semibold text-decoration-none col-auto">DCSA</a>
                    </div>
                    <div id="nav" class="row mt-3 mt-md-0 col-auto d-flex justify-content-center">
                        <a href="MyAccounts.aspx" class="text-white fw-semibold text-decoration-none col-auto">My Accounts</a>
                        <a href="Transfer.aspx" class="text-white fw-semibold text-decoration-none col-auto">Transfer</a>
                        <a href="Transactions.aspx" class="text-white fw-semibold text-decoration-underline col-auto">Transactions</a>
                        <a href="#" class="text-white fw-semibold text-decoration-none col-auto">More</a>
                    </div>
                    <a href="Login.aspx" class="text-white mt-3 mt-md-0 fs-6 fw-semibold text-decoration-none col-auto">Logout</a>
                </div>
            </div>
        </div>

        <div class="container d-flex justify-content-center align-items-center" style="height: 80vh;">
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
    </form>
</body>
</html>

<script src="resources/script/bootstrap.bundle.js" type="text/javascript"></script>
<script src="resources/script/jquery-3.7.1.js" type="text/javascript"></script>

<script type="text/javascript">
    
</script>
