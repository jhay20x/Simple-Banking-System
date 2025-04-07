
Partial Class _Default
    Inherits System.Web.UI.Page

    Dim mail As New SendEmail
    Dim Connection As New Connection
    Public OTP, EmailVerified As Integer
    Public EmailAddress As String

    Protected Sub loginBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles loginBtn.Click
        Dim username As String = loginUsername.Text.Trim()
        Dim password As String = loginPassword.Text.Trim()

        If String.IsNullOrWhiteSpace(username) Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Username is empty!</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If String.IsNullOrWhiteSpace(password) Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Password is empty!</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        Dim query = "SELECT us.Username, us.Password, us.UserType, ac.AccountsID, ac.UserInfoID FROM Users us " &
        "LEFT OUTER JOIN UserInfo ui ON ui.UserID = us.UserID " &
        "LEFT OUTER JOIN Accounts ac ON ui.UserInfoID = ac.UserInfoID " &
        "WHERE us.Username = @Username"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Dim user = Connection.Data.Tables(0).Rows(0)

            If ComputeHash(password) = user("Password").ToString Then
                FetchOTPEmail(username)

                If EmailVerified Then
                    If CheckInfo(username) Then
                        Dim ticket As New FormsAuthenticationTicket(1, username, DateTime.Now, DateTime.Now.AddMinutes(30), False, user("AccountsID") & "," & user("UserInfoID") & "," & user("UserType"))
                        Dim encryptedTicket As String = FormsAuthentication.Encrypt(ticket)
                        Dim authCookie As New HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
                        Response.Cookies.Add(authCookie)
                        Dim returnUrl As String = Request.QueryString("ReturnUrl")

                        If Not String.IsNullOrEmpty(returnUrl) AndAlso returnUrl.ToLower() <> "login.aspx" Then
                            Response.Redirect(returnUrl)
                        Else
                            If user("UserType") = "Client" Then
                                Response.Redirect("./Client/MyAccounts.aspx")
                            ElseIf user("UserType") = "Teller" Then
                                Response.Redirect("./Teller/Dashboard.aspx")
                            Else
                                Response.Redirect("./Admin/Dashboard.aspx")
                            End If
                        End If
                    Else
                        Session("OTPCode") = OTP
                        Session("EmailAddress") = EmailAddress
                        Response.Redirect("./CreateAccount/PersonalInformation.aspx")
                    End If
                Else
                    Session("OTPCode") = OTP
                    Session("EmailAddress") = EmailAddress
                    Response.Redirect("./CreateAccount/VerifyOTP.aspx")

                    Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">" & OTP & "</div>');"
                    ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
                End If
            Else
                Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Password is incorrect. Please try again.</div>');"
                ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            End If
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">User not found!</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Function ComputeHash(ByVal input As String) As String
        Dim sha256 As New System.Security.Cryptography.SHA256Managed()
        Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(input)
        Dim hashBytes As Byte() = sha256.ComputeHash(bytes)

        Return BitConverter.ToString(hashBytes).Replace("-", "").ToLower()
    End Function

    Private Function CheckInfo(username As String)
        Dim query = "SELECT ui.UserID FROM UserInfo ui " &
        "LEFT OUTER JOIN Users us ON us.UserID = ui.UserID " &
        "WHERE us.Username = @Username;"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub FetchOTPEmail(username As String)
        Dim query = "SELECT OTP, EmailAddress, EmailVerified FROM Users WHERE Username = @Username"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            OTP = row("OTP")
            EmailAddress = row("EmailAddress")
            EmailVerified = row("EmailVerified")
        End If
    End Sub
End Class
