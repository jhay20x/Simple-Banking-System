Imports System.Data

Partial Class MyAccounts
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Protected Sub Logout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("Login.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)
            Dim accountNumber As String = userData(0)
            Dim balance As DataRow = GetBalance(accountNumber)

            usernameLabel.Text = ticket.Name
            accountNumberLabel.Text = accountNumber
            accountNumberModalLabel.Text = accountNumber

            accountTypeLabel.Text = balance("AccountType")
            accountTypeTitleModalLabel.Text = balance("AccountType")
            accountTypeDetailsModalLabel.Text = balance("AccountType")

            availableBalanceLabel.Text = balance("AvailableBalance").ToString
            availableBalanceModalLabel.Text = balance("AvailableBalance").ToString
            totalBalanceModalLabel.Text = balance("TotalBalance").ToString
        End If
    End Sub

    Private Function GetBalance(ByVal accountNumber As String) As DataRow
        Dim query = "SELECT AccountType, AvailableBalance, TotalBalance FROM Accounts WHERE AccountsID = @AccountsID;"

        Connection.AddParam("@AccountsID", accountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Return Connection.Data.Tables(0).Rows(0)
        Else
            Return Nothing
        End If
    End Function
End Class
