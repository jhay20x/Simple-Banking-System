Imports System.Net
Imports System.Net.Mail

Public Class SendEmail

    Public Sub btnSendEmail_Click()
        Try
            ' Create a new email message
            Dim mail As New MailMessage()
            mail.From = New MailAddress("jhay20x@gmail.com") ' Sender's email
            mail.To.Add("jhay20x@gmail.com") ' Recipient's email
            mail.Subject = "Test Email from ASP.NET VB"
            mail.Body = "Hello, this is a test email from an ASP.NET VB application."

            ' SMTP Client Configuration
            Dim smtp As New SmtpClient("smtp.gmail.com") ' Replace with your SMTP server
            smtp.Port = 587 ' Common SMTP ports: 25, 465, 587
            smtp.Credentials = New NetworkCredential("jhay20x@gmail.com", "grvf jkur pyxw pdqs") ' Your email credentials
            smtp.EnableSsl = True ' Enable SSL for security

            ' Send the email
            smtp.Send(mail)

            MsgBox("Email sent successfully!") ' Update UI
        Catch ex As Exception
            MsgBox("Error: " & ex.Message)
        End Try
    End Sub
End Class
