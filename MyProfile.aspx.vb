Imports System.Data
Imports System.ServiceModel.PeerResolvers

Partial Class MyProfile
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub MyProfile_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim authCookie As HttpCookie = Request.Cookies(FormsAuthentication.FormsCookieName)

        If authCookie IsNot Nothing Then
            Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)

            Dim userData As String() = ticket.UserData.Split(","c)
            Dim accountNumber As String = userData(0)
            Dim userInfoID As Integer = userData(1)

            usernameLabel.Text = ticket.Name
            LoadProfile(userInfoID)
        End If
    End Sub

    Private Sub LoadProfile(userInfoID As Integer)
        Dim query = "SELECT ui.*, us.EmailAddress FROM UserInfo ui " &
        "LEFT OUTER JOIN Users us On us.UserID = ui.UserID " &
        "WHERE UserInfoID = @UserInfoID"

        Connection.AddParam("@UserInfoID", userInfoID)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)
            Dim middleName, suffix As String

            If row("MiddleName") = "None" Then
                middleName = " "
            Else
                middleName = " " & row("MiddleName") & " "
            End If

            If row("Suffix") = "None" Then
                suffix = ""
            Else
                suffix = " " & row("Suffix")
            End If

            NameLabel.Text = row("FirstName") + middleName + row("LastName") + suffix
            GenderLabel.Text = row("Gender")
            DOBLabel.Text = CDate(row("DOB")).ToString("MMMM dd, yyyy")
            AddressLabel.Text = row("Address")
            CountryBirth.Text = row("CountryBirth")
            CityBirth.Text = row("CityBirth")
            ContactLabel.Text = row("ContactNumber")
            EmailLabel.Text = row("EmailAddress")
        End If
    End Sub

    Private Sub Logout_Click(sender As Object, e As EventArgs) Handles Logout.Click
        FormsAuthentication.SignOut()
        Response.Redirect("Login.aspx")
    End Sub
End Class
