<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        If HttpContext.Current.User IsNot Nothing AndAlso HttpContext.Current.Request.IsAuthenticated Then
            Dim authCookie As HttpCookie = Context.Request.Cookies(FormsAuthentication.FormsCookieName)
            If authCookie IsNot Nothing Then
                Dim ticket As FormsAuthenticationTicket = FormsAuthentication.Decrypt(authCookie.Value)
                If ticket IsNot Nothing Then
                    Dim userDataParts = ticket.UserData.Split(","c)
                    If userDataParts.Length >= 3 Then
                        Dim roles() As String = {userDataParts(2)} ' third value is role
                        HttpContext.Current.User = New System.Security.Principal.GenericPrincipal(New FormsIdentity(ticket), roles)
                    End If
                End If
            End If
        End If
    End Sub

</script>