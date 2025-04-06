
Partial Class Teller_Transfer
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub Teller_Transfer_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)

            usernameLabel.Text = ticket.Name
        End If
    End Sub

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim senderAccountNumber As String = TransferAccountNumberSender.Text
        Dim receiverAccountNumber As String = TransferAccountNumberReceiver.Text
        Dim userAmount As Decimal = TransferAmount.Text

        If Not CheckAccountNumber(senderAccountNumber) Then
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The sender\'s account number seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If Not CheckAccountNumber(receiverAccountNumber) Then
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The receiver\'s account number seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If senderAccountNumber = receiverAccountNumber Then
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The sender and receiver\'s account number is the same. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If userAmount <= CDec("0.00") Then
            Dim errorScript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The amount entered is invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        If Not CheckFunds(senderAccountNumber, userAmount) Then
            Dim errorScript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The client has insufficient funds. Transaction failed.</div>');"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        TransactTransfer(senderAccountNumber, userAmount)
        TransactionLog(senderAccountNumber, receiverAccountNumber, userAmount)
    End Sub

    Private Sub TransactionLog(ByVal senderAccountNumber As String, receiverAccountNumber As String, ByVal userAmount As String)
        Dim query = "INSERT INTO Transactions (TransactionType, TransferFrom, TransferTo, Amount) VALUES (@TransactionType, @TransferFrom, @TransferTo, @Amount);"

        Connection.AddParam("@TransactionType", "Money Transfer")
        Connection.AddParam("@TransferFrom", senderAccountNumber)
        Connection.AddParam("@TransferTo", receiverAccountNumber)
        Connection.AddParam("@Amount", userAmount)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Deposit successful!</div>');$('input').prop('disabled', true);setTimeout(function() { location.reload(true); }, 1500);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Deposit failed. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Sub TransactTransfer(senderAccountNumber As String, userAmount As Decimal)
        Dim query = "UPDATE Accounts SET AvailableBalance = AvailableBalance - @AvailableBalance WHERE AccountsID = @AccountsID;"

        Connection.AddParam("@AvailableBalance", userAmount)
        Connection.AddParam("@AccountsID", senderAccountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Transfer successful!</div>');$('input').prop('disabled', true);setTimeout(function() { location.reload(true); }, 1500);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Transfer failed. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Function CheckAccountNumber(userAccountNumber As String) As Boolean
        Dim query = "SELECT AccountsID FROM Accounts WHERE AccountsID = @AccountsID;"

        Connection.AddParam("@AccountsID", userAccountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function CheckFunds(ByVal userAccountNumber As String, ByVal userAmount As Decimal) As Boolean
        Dim query = "SELECT AvailableBalance FROM Accounts WHERE AccountsID = @AccountsID"

        Connection.AddParam("@AccountsID", userAccountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            If userAmount <= CDec(row("AvailableBalance")) Then
                Return True
            Else
                Return False
            End If
        Else
            Return False
        End If
    End Function
End Class
