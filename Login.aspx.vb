
Partial Class _Default
    Inherits System.Web.UI.Page

    Dim mail As New SendEmail

    Protected Sub loginBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles loginBtn.Click
        Response.Redirect("MyAccounts.aspx")
        'mail.btnSendEmail_Click()
    End Sub
End Class
