
Partial Class CreateAccount_PersonalInformation
    Inherits System.Web.UI.Page
    Dim Connection As New Connection

    Private Sub backBtn_Click(sender As Object, e As EventArgs) Handles backBtn.Click
        Session.Abandon()
        Response.Redirect("../Login.aspx")
    End Sub

    Private Sub submitBtn_Click(sender As Object, e As EventArgs) Handles submitBtn.Click
        Dim selectedOption As String = Request.Form("ConfirmationCheck")

        If selectedOption <> "Confirmed" Then
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Please confirm your citizenship and age.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
            Exit Sub
        End If

        If Not Page.ClientScript.IsStartupScriptRegistered("RestoreCheck") Then
            Dim script As String = "$('input[name=""ConfirmationCheck""][value=""" + selectedOption + """]').prop('checked', true);"
            ClientScript.RegisterStartupScript(Me.GetType(), "RestoreCheck", script, True)
        End If

        InsertUserInfo()
        CreateAccount()
    End Sub

    Private Sub InsertUserInfo()
        Dim gender = Request.Form("Gender")
        Dim userID = FetchUserID(Session("EmailAddress"))
        Dim query = "INSERT INTO UserInfo (UserID, FirstName, MiddleName, LastName, Suffix, Gender, DOB, Address, ContactNumber, CountryBirth, CityBirth) " &
        "VALUES (@UserID, @FirstName, @MiddleName, @LastName, @Suffix, @Gender, @DOB, @Address, @ContactNumber, @CountryBirth, @CityBirth);"

        Connection.AddParam("@UserID", userID)
        Connection.AddParam("@FirstName", FirstName.Text)
        Connection.AddParam("@MiddleName", MiddleName.Text)
        Connection.AddParam("@LastName", LastName.Text)
        Connection.AddParam("@Suffix", Suffix.Text)
        Connection.AddParam("@Gender", gender)
        Connection.AddParam("@DOB", DOB.Text)
        Connection.AddParam("@Address", Address.Text)
        Connection.AddParam("@ContactNumber", userContactNumber.Text)
        Connection.AddParam("@CountryBirth", CountryBirth.Text)
        Connection.AddParam("@CityBirth", CityBirth.Text)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Your personal information has been saved. Please login to continue.</div>');$(""input, #submitBtn"").prop(""disabled"", true);setTimeout(() => location.href = ""../Login.aspx"", 1500);"
            ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your personal information failed to be saved. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Sub CreateAccount()
        Dim userID = FetchUserInfoID(Session("EmailAddress"))
        Dim query = "INSERT INTO Accounts (UserInfoID, AccountType, AvailableBalance) VALUES (@UserInfoID, 'Savings', 0.00);"

        Connection.AddParam("@UserInfoID", userID)

        Dim result = Connection.Query(query)

        If result Then
            Dim donescript As String = "$(""#errorMessage"").empty();$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Your personal information has been saved. Please login to continue.</div>');$(""input, #submitBtn"").prop(""disabled"", true);setTimeout(() => location.href = ""../Login.aspx"", 1500);"
            ClientScript.RegisterStartupScript(Me.GetType(), "SuccessMesssage", donescript, True)
        Else
            Dim script As String = "$(""#errorMessage"").append('<div class=""alert alert-danger"" role=""alert"">Your personal information failed to be saved. Please try again.</div>');"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", script, True)
        End If
    End Sub

    Private Sub CreateAccount_PersonalInformation_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("OTPCode") Is Nothing OrElse String.IsNullOrEmpty(Session("OTPCode").ToString()) OrElse Session("EmailAddress") Is Nothing OrElse String.IsNullOrEmpty(Session("EmailAddress").ToString()) Then
            Session.Abandon()
            Response.Redirect("../Login.aspx")
            Exit Sub
        End If
    End Sub

    Private Function FetchUserID(useremail As String) As Integer
        Dim query = "SELECT UserID FROM Users WHERE EmailAddress = @Email;"

        Connection.AddParam("@Email", useremail)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            Return row("UserID")
        Else
            Return Nothing
        End If
    End Function

    Private Function FetchUserInfoID(useremail As String) As Integer
        Dim query = "SELECT ui.UserInfoID FROM UserInfo ui " &
        "LEFT OUTER JOIN Users us ON us.UserID = ui.UserID " &
        "WHERE us.EmailAddress = @Email;"

        Connection.AddParam("@Email", useremail)

        Dim result = Connection.Query(query)

        If result Then
            Dim row = Connection.Data.Tables(0).Rows(0)

            Return row("UserInfoID")
        Else
            Return Nothing
        End If
    End Function
End Class
