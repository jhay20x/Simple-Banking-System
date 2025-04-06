
Partial Class Teller_Withdraw
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub Teller_Withdraw_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)

            usernameLabel.Text = ticket.Name
        End If
    End Sub

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim userAccountNumber As String = WithdrawAccountNumber.Text
        Dim userAmount As Decimal = WithdrawAmount.Text

        If Not CheckAccountNumber(userAccountNumber) Then
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The account number seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If userAmount <= CDec("0.00") Then
            Dim errorScript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The amount entered is invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        If Not CheckFunds(userAccountNumber, userAmount) Then
            Dim errorScript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The client has insufficient funds. Transaction failed.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        TransactWithdraw(userAccountNumber, userAmount)
        TransactionLog(userAccountNumber, userAmount)
    End Sub

    Private Sub TransactionLog(ByVal userAccountNumber As String, ByVal userAmount As String)
        Dim query = "INSERT INTO Transactions (TransactionType, TransferFrom, TransferTo, Amount) VALUES (@TransactionType, 'DCSA Bank', @TransferTo, @Amount);"

        Connection.AddParam("@TransactionType", "Money Withdraw")
        Connection.AddParam("@TransferTo", userAccountNumber)
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

    Private Sub TransactWithdraw(userAccountNumber As String, userAmount As Decimal)
        Dim query = "UPDATE Accounts SET AvailableBalance = AvailableBalance - @AvailableBalance WHERE AccountsID = @AccountsID;"

        Connection.AddParam("@AvailableBalance", userAmount)
        Connection.AddParam("@AccountsID", userAccountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Withdraw successful!</div>');$('input').prop('disabled', true);setTimeout(function() { location.reload(true); }, 1500);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Withdraw failed. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
        End If
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
