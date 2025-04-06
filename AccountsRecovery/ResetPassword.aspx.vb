
Partial Class Accounts_ResetPassword
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim newPassword = NewPasswordText.Text
        Dim confirmNewPassword = ConfirmNewPasswordText.Text
        Dim userEmail = Session("EmailAddress")

        If newPassword <> confirmNewPassword Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Passwords mismatch. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        ChangePassword(confirmNewPassword, userEmail)
    End Sub

    Private Sub ChangePassword(password As String, userEmail As String)
        Dim query = "UPDATE Users SET Password = @Password " &
        "WHERE EmailAddress = @Email"

        Connection.AddParam("@Password", ComputeHash(password))
        Connection.AddParam("@Email", userEmail)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Password has been updated successfully.</div>');$(""#userEmailAccount, #submitBtn"").prop(""disabled"", true);setTimeout(() => location.href = ""../Login.aspx"", 1500);"
            ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Password has not been updated. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
        End If

        Session.Abandon()
    End Sub

    Private Sub Accounts_ResetPassword_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("OTPCode") Is Nothing OrElse String.IsNullOrEmpty(Session("OTPCode").ToString()) OrElse Session("EmailAddress") Is Nothing OrElse String.IsNullOrEmpty(Session("EmailAddress").ToString()) Then
            Session.Abandon()
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub

    Private Function ComputeHash(ByVal input As String) As String
        Dim sha256 As New System.Security.Cryptography.SHA256Managed()
        Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(input)
        Dim hashBytes As Byte() = sha256.ComputeHash(bytes)

        Return BitConverter.ToString(hashBytes).Replace("-", "").ToLower()
    End Function
End Class
