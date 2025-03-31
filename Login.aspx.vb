
Partial Class _Default
    Inherits System.Web.UI.Page

    Dim mail As New SendEmail
    Dim Connection As New Connection

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

        Dim query = "SELECT us.Username, us.Password, us.UserType, ac.AccountsID FROM Users us " & _
        "LEFT OUTER JOIN UserInfo ui ON ui.UserID = us.UserID " & _
        "LEFT OUTER JOIN Accounts ac ON ui.UserInfoID = ac.UserInfoID " & _
        "WHERE us.Username = @Username"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Dim user = Connection.Data.Tables(0).Rows(0)

            If ComputeHash(password).SequenceEqual(DirectCast(user("Password"), Byte())) Then
                'FormsAuthentication.SetAuthCookie(username, False)

                Dim ticket As New FormsAuthenticationTicket(1, username, DateTime.Now, DateTime.Now.AddMinutes(30), False, user("AccountsID"))
                Dim encryptedTicket As String = FormsAuthentication.Encrypt(ticket)
                Dim authCookie As New HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
                Response.Cookies.Add(authCookie)
                Dim returnUrl As String = Request.QueryString("ReturnUrl")

                If Not String.IsNullOrEmpty(returnUrl) AndAlso returnUrl.ToLower() <> "login.aspx" Then
                    Response.Redirect(returnUrl)
                Else
                    Response.Redirect("MyAccounts.aspx")
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

    Private Function ComputeHash(ByVal input As String) As Byte()
        Dim sha256 As New System.Security.Cryptography.SHA256Managed()
        Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(input)
        Return sha256.ComputeHash(bytes)
    End Function
End Class
