
Imports System.Data

Partial Class Teller_Transactions
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub

    Public Sub ViewTable(accountNumber As String)
        Dim query = "SELECT * FROM Transactions WHERE TransferFrom = @TransferFrom OR TransferTo = @TransferFrom ORDER BY TransactionID DESC"

        Connection.AddParam("@TransferFrom", accountNumber)

        Connection.Query(query)

        myTable.Rows.Clear()

        Dim headerRow As New TableHeaderRow()
        headerRow.TableSection = TableRowSection.TableHeader
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Transaction ID"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Transaction Type"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Date"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Action"})

        myTable.Rows.Add(headerRow)

        For Each row As DataRow In Connection.Data.Tables(0).Rows
            Dim tablerow As New TableRow()

            tablerow.Cells.Add(New TableCell() With {.Text = row("TransactionID").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = row("TransactionType").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = CDate(row("Date").ToString()).ToString("yyyy-MM-dd")})

            Dim viewButton As New Button()
            viewButton.Text = "View"
            viewButton.CssClass = "btn btn-outline-danger btn-sm"
            viewButton.CommandArgument = row("TransactionID").ToString()
            AddHandler viewButton.Click,
                Sub(sender As Object, e As EventArgs)
                    LoadDetails(viewButton.CommandArgument)
                End Sub

            Dim buttonCell As New TableCell()
            buttonCell.Controls.Add(viewButton)
            tablerow.Cells.Add(buttonCell)

            myTable.Rows.Add(tablerow)
        Next
    End Sub

    Private Sub LoadDetails(ByVal transID As String)
        Dim query = "SELECT * FROM Transactions WHERE TransactionID = @TransactionID;"

        Connection.AddParam("@TransactionID", transID)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            DateLabel.Text = row("Date").ToString
            TransactionIDLabel.Text = row("TransactionID").ToString
            TransactionTypeLabel.Text = row("TransactionType").ToString
            TransferFromLabel.Text = row("TransferFrom").ToString
            TransferToLabel.Text = row("TransferTo").ToString
            AmountLabel.Text = row("Amount").ToString
        End If

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showModal", "$('#transactionsModal').modal('show');$('#myTable').DataTable().destroy().clear();loadTable();", True)
    End Sub

    Private Sub Teller_Transactions_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)

            usernameLabel.Text = ticket.Name
            Dim accountNumber = ClientAccountNumber.Text

            ViewTable(accountNumber)
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ReloadScripts", "$('#myTable').DataTable().destroy().clear();loadTable();", True)
        End If
    End Sub

    Private Sub SearchBtn_Click(sender As Object, e As EventArgs) Handles SearchBtn.Click
        Dim accountNumber = ClientAccountNumber.Text

        If Not CheckAccountNumber(accountNumber) Then
            Dim script As String = "limitInputs();$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">The account number seems to be invalid. Please try again.</div>');"
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If
    End Sub

    Private Function CheckAccountNumber(userAccountNumber As String) As Boolean
        Dim query = "SELECT AccountsID FROM Accounts WHERE AccountsID = @AccountsID;"

        Connection.AddParam("@AccountsID", userAccountNumber)

        Dim result = Connection.Query(query)

        If result Then
            Return True
        Else
            Return False
        End If
    End Function
End Class
