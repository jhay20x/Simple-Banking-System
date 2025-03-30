
Partial Class MyAccounts
    Inherits System.Web.UI.Page

    Protected Sub Logout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("Login.aspx")
    End Sub
End Class
