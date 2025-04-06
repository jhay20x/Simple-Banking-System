
Imports System.Net.WebRequestMethods

Partial Class CreateAccounts_ResetPassword
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim userOTP As Integer = Request.Form("OTPCode")
        Dim savedOTP As Integer = Session("OTPCode")
        Dim useremail = Session("EmailAddress")

        If userOTP <> savedOTP Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your OTP Code is invalid. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        UpdateEmailVerification(useremail)
    End Sub

    Private Sub UpdateEmailVerification(useremail As String)
        Dim query = "UPDATE Users SET EmailVerified = 1 WHERE EmailAddress = @Email;"

        Connection.AddParam("@Email", useremail)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">OTP Code verified.</div>');$(""#userEmailAccount, #submitBtn"").prop(""disabled"", true);setTimeout(() => location.href = ""PersonalInformation.aspx"", 1000);"
            ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Email failed to be verified. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Sub Accounts_ResetPassword_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("OTPCode") Is Nothing OrElse String.IsNullOrEmpty(Session("OTPCode").ToString()) OrElse Session("EmailAddress") Is Nothing OrElse String.IsNullOrEmpty(Session("EmailAddress").ToString()) Then
            Session.Abandon()
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub
End Class
