
Partial Class accounts_ForgotUsername
    Inherits System.Web.UI.Page
    Dim mail As New SendEmail
    Dim Connection As New Connection

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim userEmail As String = Request.Form("userEmailAccount")

        If Not CheckEmail(userEmail) Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Email address not found. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        SendUsername(userEmail)

        Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Email has been sent.</div>');$(""#userEmailAccount, #submitBtn"").prop(""disabled"", true);"
        ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
    End Sub

    Private Sub SendUsername(userEmail As String)
        Dim subject As String = "Forgot Username"
        Dim content As String = "Your username is " & FetchUsername(userEmail) & "."

        mail.EmailSend(userEmail, subject, content)
    End Sub

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Function CheckEmail(userEmail As String) As Boolean
        Dim query = "SELECT EmailAddress FROM Users WHERE EmailAddress = @Email"

        Connection.AddParam("@Email", userEmail)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function FetchUsername(userEmail As String) As String
        Dim query = "SELECT Username FROM Users WHERE EmailAddress = @Email"

        Connection.AddParam("@Email", userEmail)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            Return row("Username")
        Else
            Return False
        End If
    End Function
End Class
