
Imports System.Data

Partial Class Teller_CustomerSearch
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub Teller_CustomerSearch_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)

            usernameLabel.Text = ticket.Name

            ViewTable()
            ScriptManager.RegisterStartupScript(UpdatePanel1, Me.GetType(), "ReloadScripts", "$('#myTable').DataTable().destroy().clear();loadTable();", True)
        End If
    End Sub

    Public Sub ViewTable()
        Dim query = "SELECT ac.AccountsID, ac.AccountType, ui.UserInfoID, " &
        "CONCAT(ui.FirstName , CASE WHEN ui.MiddleName = 'None' THEN ' ' ELSE CONCAT(' ' , ui.MiddleName , ' ') END , ui.LastName) AS ClientName " &
        "FROM Accounts ac " &
        "LEFT OUTER JOIN UserInfo ui ON ui.UserInfoID = ac.UserInfoID "

        Connection.Query(query)

        myTable.Rows.Clear()

        Dim headerRow As New TableHeaderRow()
        headerRow.TableSection = TableRowSection.TableHeader
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Account ID"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Name"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Account Type"})
        headerRow.Cells.Add(New TableHeaderCell() With {.Text = "Action"})

        myTable.Rows.Add(headerRow)

        For Each row As DataRow In Connection.Data.Tables(0).Rows
            Dim tablerow As New TableRow()

            tablerow.Cells.Add(New TableCell() With {.Text = row("AccountsID").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = row("ClientName").ToString()})
            tablerow.Cells.Add(New TableCell() With {.Text = row("AccountType").ToString()})

            Dim viewButton As New Button()
            viewButton.Text = "View"
            viewButton.CssClass = "btn btn-outline-danger btn-sm"
            viewButton.CommandArgument = row("UserInfoID").ToString()
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

    Private Sub LoadDetails(ByVal userInfoID As String)
        Dim query = "SELECT ui.*, us.EmailAddress, us.Username, ac.AccountsID, " &
        "CONCAT(ui.FirstName , CASE WHEN ui.MiddleName = 'None' THEN ' ' ELSE CONCAT(' ' , ui.MiddleName , ' ') END , ui.LastName) AS ClientName " &
        "FROM UserInfo ui " &
        "LEFT OUTER JOIN Users us ON us.UserID = ui.UserID " &
        "LEFT OUTER JOIN Accounts ac ON ac.UserInfoID = ui.UserInfoID " &
        "WHERE ui.UserInfoID = @UserInfoID;"

        Connection.AddParam("@UserInfoID", userInfoID)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            AccountIDLabel.Text = row("AccountsID").ToString
            AccountUsernameLabel.Text = row("Username").ToString
            AccountEmailLabel.Text = row("EmailAddress").ToString
            NameLabel.Text = row("ClientName").ToString
            GenderLabel.Text = row("Gender").ToString
            DOBLabel.Text = row("DOB").ToString
            CountryBirthLabel.Text = row("CountryBirth").ToString
            CityBirthLabel.Text = row("CityBirth").ToString
            ContactLabel.Text = row("ContactNumber").ToString
        End If

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showModal", "$('#profileViewModal').modal('show');$('#myTable').DataTable().destroy().clear();loadTable();", True)
    End Sub

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("../Login.aspx")
    End Sub
End Class
