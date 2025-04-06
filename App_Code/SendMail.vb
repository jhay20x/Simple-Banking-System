Imports System.Net
Imports System.Net.Mail

Public Class SendEmail
    Inherits System.Web.UI.Page

    Public Sub EmailSend(userEmail As String, subject As String, content As String)
        Try
            Dim mail As New MailMessage()
            mail.From = New MailAddress("jhay20x@gmail.com")
            mail.To.Add(userEmail)
            mail.Subject = subject
            mail.Body = content

            Dim smtp As New SmtpClient("smtp.gmail.com")
            smtp.Port = 587
            smtp.Credentials = New NetworkCredential("jhay20x@gmail.com", "grvf jkur pyxw pdqs")
            smtp.EnableSsl = True

            smtp.Send(mail)
        Catch ex As Exception

            Dim errorscript As String = "$(""#errorMessage"").append('<div class=""alert alert-success"" role=""alert"">Error: " & ex.Message & "</div>');$(""#userEmailAccount"").prop(""disabled"", false);"
            ClientScript.RegisterStartupScript(Me.GetType(), "ErrorMesssage", errorscript, True)
            MsgBox("Error: " & ex.Message)
        End Try
    End Sub
End Class
