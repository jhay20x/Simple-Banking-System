Imports System.Data

Partial Class Transactions
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

            usernameLabel.Text = ticket.Name
            ViewTable(accountNumber)
        End If
    End Sub

    Public Sub ViewTable(ByVal accountNumber As String)
        Dim query = "SELECT * FROM Transactions WHERE TransferFrom = @TransferFrom OR TransferTo = @TransferFrom"

        Connection.AddParam("@TransferFrom", accountNumber)

        Connection.Query(query)

        myTable.Rows.Clear()

        Dim headerRow As New TableHeaderRow()
        headerRow.TableSection = TableRowSection.TableHeader
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Transaction ID"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Transaction Type"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Transfer To"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Date"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Action"})

        myTable.Rows.Add(headerRow)

        For Each row As DataRow In Connection.Data.Tables(0).Rows
            Dim tablerow As New TableRow()

            tablerow.Cells.Add(New TableCell() With {.Text = row("TransactionID").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = row("TransactionType").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = row("TransferTo").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = CDate(row("Date").ToString()).ToString("yyyy-MM-dd")})

            Dim viewButton As New Button()
            viewButton.Text = "View"
            viewButton.CssClass = "btn btn-outline-danger btn-sm"
            viewButton.CommandArgument = row("TransactionID").ToString()
            AddHandler viewButton.Click,
                Sub(sender As Object, e As EventArgs)
                    LoadDetails(viewButton.CommandArgument, accountNumber)
                End Sub

            Dim buttonCell As New TableCell()
            buttonCell.Controls.Add(viewButton)
            tablerow.Cells.Add(buttonCell)

            myTable.Rows.Add(tablerow)
        Next
    End Sub

    Private Sub LoadDetails(ByVal transID As String, ByVal accountNumber As String)
        Dim query = "SELECT * FROM Transactions WHERE (TransferFrom = @TransferFrom OR TransferTo = @TransferFrom) AND TransactionID = @TransactionID;"

        Connection.AddParam("@TransferFrom", accountNumber)
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
End Class
