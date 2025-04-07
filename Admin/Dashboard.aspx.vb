
Imports System.Data

Partial Class Admin_Dashboard
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub Teller_Dashboard_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)

            usernameLabel.Text = ticket.Name
            LoadDashboard()
        End If
    End Sub

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Sub LoadDashboard()
        Dim query As String = "SELECT " &
            "COUNT(DISTINCT CASE " &
                "WHEN (tr.TransactionType = 'Money Deposit' OR tr.TransactionType = 'Money Withdraw') " &
                "AND CAST(tr.Date AS DATE) = CAST(GETDATE() AS DATE) " &
                "THEN tr.TransferTo " &
            "END) TotalClientsToday, " &
            "COUNT(CASE " &
                "WHEN CAST(tr.Date AS DATE) = CAST(GETDATE() AS DATE) " &
                "AND tr.TransactionType = 'Money Deposit' " &
                "THEN tr.TransferTo " &
            "END) AS TotalDepositsToday, " &
            "COUNT(CASE " &
                "WHEN CAST(tr.Date AS DATE) = CAST(GETDATE() AS DATE) " &
                "AND tr.TransactionType = 'Money Withdraw' " &
                "THEN tr.TransferFrom " &
            "END) AS TotalWithdrawToday " &
        "FROM Transactions tr;"

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            TotalClients.Text = row("TotalClientsToday")
            TotalDeposit.Text = row("TotalDepositsToday")
            TotalWithdraw.Text = row("TotalWithdrawToday")
        End If
    End Sub
End Class
