
Partial Class Accounts_ForgotPassword
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

        Dim OTP = GenerateOTP()
        Session("OTPCode") = OTP
        Session("EmailAddress") = userEmail

        SendOTP(userEmail, OTP)

        Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Email has been sent.</div>');$(""#userEmailAccount, #submitBtn"").prop(""disabled"", true);setTimeout(() => location.href = ""VerifyOTP.aspx"", 1000);"
        ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
    End Sub

    Private Function GenerateOTP() As Integer
        Dim rng As New Random()
        Return rng.Next(100000, 999999)
    End Function

    Private Sub SendOTP(userEmail As String, OTP As Integer)
        Dim subject As String = "Forgot Password"
        Dim content As String = "Your OTP Code is " & OTP & "."

        mail.EmailSend(userEmail, subject, content)
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

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub
End Class
