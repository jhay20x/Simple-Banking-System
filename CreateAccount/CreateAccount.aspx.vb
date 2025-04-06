
Imports System.Net.WebRequestMethods

Partial Class CreateAccount_CreateAccount
    Inherits System.Web.UI.Page
    Dim Connection As New Connection
    Dim mail As New SendEmail

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim selectedOption As String = Request.Form("ConfirmationCheck")
        Dim username = usernameAccount.Text
        Dim useremail = userEmailAccount.Text
        Dim newPassword = NewPasswordText.Text
        Dim confirmNewPassword = ConfirmNewPasswordText.Text
        Dim hashPassword = ComputeHash(confirmNewPassword)

        If selectedOption <> "Confirmed" Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Please confirm your citizenship and age.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)

            Dim radioscript As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true);"
            ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", radioscript, True)
            Exit Sub
        End If

        If CheckUsername(username) Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Username already exist. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)

            Dim radioscript As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true);"
            ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", radioscript, True)
            Exit Sub
        End If

        If newPassword <> confirmNewPassword Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Passwords mismatch. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)

            Dim radioscript As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true);"
            ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", radioscript, True)
            Exit Sub
        End If

        If CheckEmail(useremail) Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Email addreass already exist. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)

            Dim radioscript As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true);"
            ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", radioscript, True)
            Exit Sub
        End If

        SendOTP(useremail, username)

        InsertUser(username, hashPassword, useremail, Session("OTPCode"))

        Dim radioscriptcheck As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true).prop('disabled', true);$(""#submitBtn, #usernameAccount, #userEmailAccount, #NewPasswordText, #ConfirmNewPasswordText, .btn-outline-secondary"").prop('disabled', true);setTimeout(() => location.href = ""VerifyOTP.aspx"", 1000);"
        ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", radioscriptcheck, True)
    End Sub

    Private Sub InsertUser(username As String, password As String, useremail As String, OTP As Integer)
        Dim query = "INSERT INTO Users (Username, Password, UserType, EmailAddress, OTP, EmailVerified) VALUES (@Username, @Password, 'Client', @EmailAddress, @OTP, 0);"

        Connection.AddParam("@Username", username)
        Connection.AddParam("@Password", password)
        Connection.AddParam("@EmailAddress", useremail)
        Connection.AddParam("@OTP", OTP)

        Dim result = Connection.Query(query)

        If result Then
            Dim debugscript As String = "$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Account created. OTP has been sent to your email.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", debugscript, True)
        End If
    End Sub

    Private Function ComputeHash(ByVal input As String) As String
        Dim sha256 As New System.Security.Cryptography.SHA256Managed()
        Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(input)
        Dim hashBytes As Byte() = sha256.ComputeHash(bytes)

        Return BitConverter.ToString(hashBytes).Replace("-", "").ToLower()
    End Function

    Private Function GenerateOTP() As Integer
        Dim rng As New Random()
        Return rng.Next(100000, 999999)
    End Function

    Private Sub SendOTP(userEmail As String, username As String)
        Dim OTP = GenerateOTP()

        Dim subject As String = "Account Creation: Email Verification"
        Dim content As String = "Good Day " & username & "! Your OTP Code is " & OTP & "."

        Session("OTPCode") = OTP
        Session("EmailAddress") = userEmail

        mail.EmailSend(userEmail, subject, content)
    End Sub

    Private Function CheckUsername(username As String) As Boolean
        Dim query = "SELECT Username FROM Users WHERE Username = @Username"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function CheckEmail(useremail As String) As Boolean
        Dim query = "SELECT EmailAddress FROM Users WHERE EmailAddress = @Email"

        Connection.AddParam("@Email", useremail)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function
End Class
