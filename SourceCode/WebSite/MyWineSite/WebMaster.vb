Namespace Wine.Web
    Public Class WebMaster
        Inherits System.Web.UI.Page

        Public currentPerson As DBEntity.Person

        Public Overloads Sub Page_PreInit(ByVal sender As Object, ByVal e As EventArgs) Handles Me.PreInit

            Dim cookie As HttpCookie = Request.Cookies.Get("MyWineUser")

            If IsNothing(cookie) Then
                Response.Redirect(Page.ResolveUrl("~/LoginPub.aspx?returnUrl=" + HttpUtility.UrlEncode(Page.Request.Url.ToString)))
            Else
                ResetCookie(HttpContext.Current.Response, cookie.Value)
            End If

            '//Have Cookie, but no Session, then Create Session
            '//PostLogin will check for validity of this UserID
            If IsNothing(Session("PersonID")) Then
                Session("PersonID") = cookie.Value
            End If

        End Sub


        Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
            Dim sPersonID As String = Session("PersonID").ToString    ' We check the Session value, not the cookie for impersonation
            Dim intPersonId As Integer

            If sPersonID.Trim.Length <> 0 AndAlso Integer.TryParse(sPersonID, intPersonId) Then
                Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                currentPerson = db.People.Find(intPersonId)

                'Add check that the person we just loaded up, is the person the cookie points at.
                If currentPerson.PersonID <> intPersonId Then
                    ' If we get here, we weren't able to find the guid of person in the db, so logout
                    Response.Redirect("~/Logout.aspx")
                End If
            Else
                Response.Redirect("~/LoginPub.aspx")
            End If
        End Sub


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        End Sub

        Sub ResetCookie(httpResponse As HttpResponse, personId As String)
            Dim myWineCookie = New HttpCookie("MyWineUser", personId)
            myWineCookie.Expires = Now.AddDays(1)
            httpResponse.Cookies.Add(myWineCookie)
        End Sub

    End Class
End Namespace
