Imports System.Data

Partial Class Transfer
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Protected Sub Logout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)
            Dim accountNumber = userData(0)
            Dim UserInfoID As String = userData(1)

            usernameLabel.Text = ticket.Name

            GenerateFundOptions(UserInfoID, accountNumber)
        End If
    End Sub

    Private Sub AddRadioButton(ByVal accountNumber As String, ByVal AccountType As String, ByVal balance As String)
        Dim radioButtonHTML As String = "<div class='col-12'>" &
                                        "<input type='radio' name='optionsDCSA' value=" & accountNumber & " required id='btnView_" & accountNumber & "' class='btn-check optionsDCSA' autocomplete='off' />" &
                                        "<label class='btn btn-outline-danger col-12 my-1' for='btnView_" & accountNumber & "'>" &
                                        "<h6 class='col-12'>" & AccountType & " Account</h6>" &
                                        "<h6 class='col-12 fw-normal'>" & accountNumber & "</h6>" &
                                        "<h6 class='col-12 fw-normal'><small>PHP</small> <span>" & balance & "</span></h6>" &
                                        "</label>" &
                                        "</div>"

        Dim literal As New LiteralControl(radioButtonHTML)
        fundOptions.Controls.Add(literal)

        Dim radioButtonHTMLOther As String = "<div class='col-12'>" &
                                        "<input type='radio' name='optionsOther' value=" & accountNumber & " required id='btnViewOther_" & accountNumber & "' class='btn-check optionsOther' autocomplete='off' />" &
                                        "<label class='btn btn-outline-danger col-12 my-1' for='btnViewOther_" & accountNumber & "'>" &
                                        "<h6 class='col-12'>" & AccountType & " Account</h6>" &
                                        "<h6 class='col-12 fw-normal'>" & accountNumber & "</h6>" &
                                        "<h6 class='col-12 fw-normal'><small>PHP</small> <span>" & balance & "</span></h6>" &
                                        "</label>" &
                                        "</div>"

        Dim literalOther As New LiteralControl(radioButtonHTMLOther)
        fundOptionsOther.Controls.Add(literalOther)
    End Sub

    Private Sub GenerateFundOptions(ByVal UserInfoID As String, ByVal accountNumber As String)
        Dim query = "SELECT * FROM Accounts WHERE UserInfoID = @UserInfoID;"

        Connection.AddParam("@UserInfoID", UserInfoID)

        Dim result = Connection.Query(query)

        For Each row As DataRow In Connection.Data.Tables(0).Rows
            AddRadioButton(row("AccountsID").ToString(), row("AccountType").ToString(), row("AvailableBalance").ToString())
        Next
    End Sub

    Protected Sub transferDCSABtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles transferDCSABtn.Click
        Dim selectedOption As String = Request.Form("optionsDCSA")
        Dim accountNumber As String = accountNumberDCSA.Text
        Dim amount As Decimal = amountDCSA.Text

        If selectedOption = "None" Then
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">No funds selected." & selectedOption & "</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorFundsMesssage", errorScript, True)

            ReinitializeInputsDCSA()

            Dim restoreScript As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", restoreScript, True)
            Exit Sub
        End If

        If accountNumber = selectedOption Then
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">You cannot transfer funds to your selected account.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsDCSA()

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not CheckAccountNumberDCSA(accountNumber) Then
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">The account number provided seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsDCSA()

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If amount <= CDec("0.00") Then
            'Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">" & selectedOption & "</div>');"
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">The amount entered is invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsDCSA()

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not CheckFunds(selectedOption, amount) Then
            'Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">" & selectedOption & "</div>');"
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">You have insufficient funds. Please choose another account and try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsDCSA()

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not Page.ClientScript.IsStartupScriptRegistered("RestoreRadio") Then
            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
        End If

        TransactTransferDCSA(selectedOption, accountNumber, amount)
    End Sub

    Private Sub ReinitializeInputsDCSA()
        If Not Page.ClientScript.IsStartupScriptRegistered("ReinitializeDCSA") Then
            Dim script As String = "disableInputs();$('input[name=""optionsDCSA""]').prop('disabled', false);$('.optionsDCSA').prop('disabled', false);limitFields();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Reinitialize", script, True)
        End If
    End Sub

    Private Sub ReinitializeInputsOther()
        If Not Page.ClientScript.IsStartupScriptRegistered("ReinitializeOther") Then
            Dim script As String = "disableInputs();$('input[name=""optionsOther""]').prop('disabled', false);$('.optionsOther').prop('disabled', false);limitFields();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Reinitialize", script, True)
        End If
    End Sub

    Private Function CheckFunds(ByVal accountNumber As String, ByVal amount As Decimal) As Boolean
        Dim query = "SELECT AvailableBalance FROM Accounts WHERE AccountsID = @AccountsID"

        Connection.AddParam("@AccountsID", accountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            If amount <= CDec(row("AvailableBalance")) Then
                Return True
            Else
                Return False
            End If
        Else
            Return False
        End If
    End Function

    Private Function CheckAccountNumberDCSA(ByVal accountNumber As String) As Boolean
        Dim query = "SELECT AccountsID FROM Accounts WHERE AccountsID = @AccountsID"

        Connection.AddParam("@AccountsID", accountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function CheckAccountNumberOther(ByVal accountNumber As String) As Boolean
        Dim query = "SELECT AccountsID FROM FakeGCashAccounts WHERE AccountsID = @AccountsID"

        Connection.AddParam("@AccountsID", accountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub TransactTransferDCSA(ByVal userAccountNumber As String, ByVal accountNumber As String, ByVal amount As String)
        Dim query1 = "UPDATE Accounts SET AvailableBalance = AvailableBalance - @Amount WHERE AccountsID = @UserAccountID"

        Connection.AddParam("@Amount", amount)
        Connection.AddParam("@UserAccountID", userAccountNumber)

        Dim result1 = Connection.Query(query1)

        Dim query2 = "UPDATE Accounts SET AvailableBalance = AvailableBalance + @Amount WHERE AccountsID = @AccountsID"

        Connection.AddParam("@Amount", amount)
        Connection.AddParam("@AccountsID", accountNumber)

        Dim result2 = Connection.Query(query2)

        Dim query3 = "INSERT INTO Transactions (TransactionType, TransferFrom, TransferTo, Amount) VALUES (@TransactionType, @TransferFrom, @TransferTo, @Amount);"

        Connection.AddParam("@TransactionType", "Money Transfer")
        Connection.AddParam("@TransferFrom", userAccountNumber)
        Connection.AddParam("@TransferTo", accountNumber)
        Connection.AddParam("@Amount", amount)

        Dim result3 = Connection.Query(query3)

        If result1 And result2 And result3 Then
            Dim errorScript As String = "disableInputs();$(""#errorDCSAMessage"").append('<div class=""alert alert-success"" role=""alert"">Transfer success.</div>');setTimeout(function() {location.reload();}, 1000);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + accountNumber + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        Else
            Dim errorScript As String = "$(""#errorDCSAMessage"").append('<div class=""alert alert-danger"" role=""alert"">Error in transferring. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            Dim script As String = "$('input[name=""optionsDCSA""][value=""" + accountNumber + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If
    End Sub

    Private Sub TransactTransferOther(ByVal userAccountNumber As String, ByVal accountNumber As String, ByVal amount As Decimal)
        Dim query1 = "UPDATE Accounts SET AvailableBalance = AvailableBalance - @Amount WHERE AccountsID = @UserAccountID"

        Connection.AddParam("@Amount", amount + 8)
        Connection.AddParam("@UserAccountID", userAccountNumber)

        Dim result1 = Connection.Query(query1)

        Dim query2 = "UPDATE FakeGCashAccounts SET AvailableBalance = AvailableBalance + @Amount WHERE AccountsID = @AccountsID"

        Connection.AddParam("@Amount", amount)
        Connection.AddParam("@AccountsID", accountNumber)

        Dim result2 = Connection.Query(query2)

        Dim query3 = "INSERT INTO Transactions (TransactionType, TransferFrom, TransferTo, Amount) VALUES (@TransactionType, @TransferFrom, @TransferTo, @Amount);"

        Connection.AddParam("@TransactionType", "DCSA Bank Money Transfer")
        Connection.AddParam("@TransferFrom", userAccountNumber)
        Connection.AddParam("@TransferTo", accountNumber)
        Connection.AddParam("@Amount", amount + 8)

        Dim result3 = Connection.Query(query3)

        Dim query4 = "INSERT INTO FakeGCashTransactions (TransactionType, TransferFrom, TransferTo, Amount) VALUES (@TransactionType, @TransferFrom, @TransferTo, @Amount);"

        Connection.AddParam("@TransactionType", "DCSA Bank Money Transfer")
        Connection.AddParam("@TransferFrom", userAccountNumber)
        Connection.AddParam("@TransferTo", accountNumber)
        Connection.AddParam("@Amount", amount)

        Dim result4 = Connection.Query(query4)

        If result1 And result2 And result3 And result4 Then
            Dim errorScript As String = "disableInputs();$(""#errorOtherMessage"").append('<div class=""alert alert-success"" role=""alert"">Transfer success.</div>');setTimeout(function() {location.reload();}, 1000);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            Dim script As String = "$('input[name=""optionsOther""][value=""" + accountNumber + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        Else
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">Error in transferring. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            Dim script As String = "$('input[name=""optionsOther""][value=""" + accountNumber + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If
    End Sub

    Protected Sub transferOtherBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles transferOtherBtn.Click
        Dim selectedOption As String = Request.Form("optionsOther")
        Dim accountNumber As String = accountNumberOther.Text
        Dim amount As Decimal = amountOther.Text

        If selectedOption = "None" Then
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">No funds selected.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorFundsMesssage", errorScript, True)


            ReinitializeInputsOther()

            Dim restoreScript As String = "$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel2, Me.GetType(), "RestoreRadio", restoreScript, True)
            Exit Sub
        End If

        If accountNumber = selectedOption Then
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">You cannot transfer funds to your selected account.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsOther()

            Dim script As String = "$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not CheckAccountNumberOther(accountNumber) Then
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">The account number provided seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsOther()

            Dim script As String = "$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel2, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If amount <= CDec("0.00") Then
            'Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">" & selectedOption & "</div>');"
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">The amount entered is invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsOther()

            Dim script As String = "$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel2, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not CheckFunds(selectedOption, amount) Then
            'Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">" & selectedOption & "</div>');"
            Dim errorScript As String = "$(""#errorOtherMessage"").append('<div class=""alert alert-danger"" role=""alert"">You have insufficient funds. Please choose another account and try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAccountMesssage", errorScript, True)

            ReinitializeInputsOther()

            Dim script As String = "$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true);"
            ScriptManager.RegisterStartupScript(UpdatePanel2, Me.GetType(), "RestoreRadio", script, True)
            Exit Sub
        End If

        If Not Page.ClientScript.IsStartupScriptRegistered("RestoreRadio") Then
            Dim script As String = "disableInputs();$('input[name=""optionsOther""][value=""" + selectedOption + """]').prop('checked', true).prop('disabled', false);"
            ScriptManager.RegisterStartupScript(UpdatePanel2, Me.GetType(), "RestoreRadio", script, True)
        End If

        TransactTransferOther(selectedOption, accountNumber, amount)
    End Sub
End Class