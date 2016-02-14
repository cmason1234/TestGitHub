
Namespace Wine.Web

    Public Class LoginPub
        Inherits System.Web.UI.Page

        Dim _userMessage As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            'litMsg.Text = "<div class='msgInfo'>Forgot your password, <a href='AccountUtilities/ForgotPassword.aspx'>click here</a>.  Forgot your username, <a href='AccountUtilities/ForgotUsername.aspx'>click here</a>.</div>"

            'If Not IsNothing(Session("userMessage")) Then
            '    litMsg.Text = "<div class='msgErr'>" & Session("userMessage").ToString & "<br /><br />Forgot your password, <a href='AccountUtilities/ForgotPassword.aspx'>click here</a>.  Forgot your username, <a href='AccountUtilities/ForgotUsername.aspx'>click here</a>.</div>"
            'End If

        End Sub


        Protected Sub loginButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

            If IsNothing(Username.Text) Or IsNothing(Password.Text) Then
                litMsg.Text = "<div class='msgErr' style=""color:red;"">Both UserName and Password Must have a value</div>"
            Else
                If (Authenticate(Username.Text, Password.Text)) Then
                    RedirectToPage()
                Else
                    litMsg.Text = "<div class='msgErr' style=""color:red;"" >Invalid UserName/Password Combination</div>"
                End If
            End If

        End Sub

        Private Sub RedirectToPage()
            Dim returnUrlString As String = "Default.aspx"

            If Not Request.QueryString("returnUrl") Is Nothing Then
                If Not Request.QueryString("returnUrl").Contains("loginpub") Then
                    returnUrlString = Request.QueryString("returnUrl").ToString
                End If
            End If

            Response.Redirect(returnUrlString)

        End Sub


        Private Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
            msgContainer.Visible = False
            If _userMessage.Trim.Length > 0 Then
                litMsg.Visible = False
                msgContainer.Visible = True
                msgContainer.Attributes.Item("class") = "msgErr"
                messageLabel.Text = _userMessage
            End If
        End Sub


        Private Function Authenticate(ByVal uName As String, ByVal pWord As String) As Boolean

            Dim status As Boolean = False

            If uName.Trim.Length > 0 AndAlso pWord.Trim.Length > 0 Then
                Dim connstr As String = Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")
                Dim db As New DBEntity.MywinecompetitionEntities(connstr)

                Dim peopleList = (From s In db.People Where s.Username = uName).ToList

                If peopleList.Count > 0 Then
                    Dim objP = peopleList(0)

                    Dim pt As New Wine.Common.PasswordEncryption

                    status = pt.ValidatePassword(pWord, objP.EncryptedPassword, objP.PasswordSeed)
                    If status Then

                        Dim expDate As Date = Now.AddDays(1.0)
                        'set cookie for this user
                        Dim cookie As New HttpCookie("MyWineUser", objP.PersonID.ToString())
                        cookie.Expires = expDate
                        'To read, user Request.Cookies("MyWineUser")

                        Response.Cookies.Add(cookie)

                        Session("PersonID") = objP.PersonID.ToString()

                        Session.Timeout() = "240"

                    End If
                End If
            End If

            Return status

        End Function


    End Class

End Namespace