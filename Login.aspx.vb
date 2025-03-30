
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

        Dim query = "SELECT * FROM Users WHERE Username = @Username"

        Connection.AddParam("@Username", username)

        Dim result = Connection.Query(query)

        If result Then
            Dim user = Connection.Data.Tables(0).Rows(0)

            If ComputeHash(password).SequenceEqual(DirectCast(user("Password"), Byte())) Then
                FormsAuthentication.SetAuthCookie(username, False)
                Response.Redirect("MyAccounts.aspx")
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
