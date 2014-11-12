Namespace Rheem.Web.Partners

    Public Class Logout
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            Dim cookie As HttpCookie = Request.Cookies("MyWineUser")
            If Not IsNothing(cookie) Then
                cookie.Expires = DateTime.Now.AddYears(-30)
                Response.AppendCookie(cookie)
            End If
            Session().Clear()
            Session().Abandon()
            Response.Redirect("loginpub.aspx")

        End Sub

    End Class

End Namespace
