
Partial Class ChangePassword
    Inherits System.Web.UI.Page
    Dim Connection As New Connection
    Private UserInfoID As Integer

    Private Sub ChangePassword_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)
            Dim accountNumber As String = userData(0)
            UserInfoID = userData(1)

            usernameLabel.Text = ticket.Name
        End If
    End Sub

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Sub UpdatePasswordBtn_Click(sender As Object, e As EventArgs) Handles UpdatePasswordBtn.Click
        Dim oldPassword = OldPasswordText.Text
        Dim newPassword = NewPasswordText.Text
        Dim confirmNewPassword = ConfirmNewPasswordText.Text

        If Not FetchUserPassword(UserInfoID, oldPassword) Then
            Dim errorScript As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your old password is not valid. Please try again.</div>');toggleButtons();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        If oldPassword = newPassword Or oldPassword = confirmNewPassword Then
            Dim errorScript As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your old password is the same as your new password. Please try again.</div>');toggleButtons();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        If newPassword <> confirmNewPassword Then
            Dim errorScript As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your new and confirmation password is invalid. Please try again.</div>');toggleButtons();"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", errorScript, True)
            Exit Sub
        End If

        ChangePassword(confirmNewPassword)

        'Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Good.</div>');toggleButtons();"
        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
    End Sub

    Private Sub ChangePassword(password As String)
        Dim query = "UPDATE us SET us.Password = @Password FROM Users us " &
        "LEFT OUTER JOIN UserInfo ui ON ui.UserID = us.UserID " &
        "WHERE ui.UserInfoID = @UserInfoID"

        Connection.AddParam("@Password", ComputeHash(password))
        Connection.AddParam("@UserInfoID", UserInfoID)

        Dim result = Connection.Query(query)

        If result Then
            Dim script As String = "disableInputs();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Your password has been successfully updated.</div>');setTimeout(function() {location.reload();}, 1000);"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your password has not been updated. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Function FetchUserPassword(userID As Integer, password As String) As Boolean
        Dim query = "SELECT us.Password FROM Users us " &
        "LEFT OUTER JOIN UserInfo ui ON ui.UserID = us.UserID " &
        "WHERE ui.UserInfoID = @UserInfoID"

        Connection.AddParam("@UserInfoID", userID)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            If ComputeHash(password) = row("Password") Then
                Return True
            Else
                Return False
            End If
        Else
            Return False
        End If
    End Function

    Private Function ComputeHash(ByVal input As String) As String
        Dim sha256 As New System.Security.Cryptography.SHA256Managed()
        Dim bytes As Byte() = System.Text.Encoding.UTF8.GetBytes(input)
        Dim hashBytes As Byte() = sha256.ComputeHash(bytes)

        Return BitConverter.ToString(hashBytes).Replace("-", "").ToLower()
    End Function
End Class
