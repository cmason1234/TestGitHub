Namespace Wine.Web
    Public Class PersonAddEdit
        Inherits webmaster

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Master.AppTitle = "Person Add/Edit"
            If Not IsPostBack Then
                LoadFromDB()
            End If
        End Sub

        Private Sub LoadFromDB()
            Dim sPersID As String = Request.Params("PersonID")
            Dim personID As Integer = 0
            If Request.Params("PersonID") IsNot Nothing Then
                If Integer.TryParse(sPersID, personID) AndAlso personID > 0 Then
                    Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                    Dim person As DBEntity.Person = db.People.Find(personID)
                    tbFirstNameTextBox.Text = person.FirstName
                    tbMiddleNameTextBox.Text = person.MiddleName
                    tbLastNameTextBox.Text = person.LastName
                    tbEmailTextBox.Text = person.EmailAddress
                    tbUserNameTextBox.Text = person.Username
                End If
            End If
            If Not personID > 0 Then
                delArea.Visible = False
                tdChgPassword.Visible = False
            End If
            hfPersonID.Value = personID.ToString
        End Sub



        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            Dim sPersID As String = hfPersonID.Value
            Dim personID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim person As DBEntity.Person = Nothing
            If Integer.TryParse(sPersID, personID) AndAlso personID > 0 Then
                person = db.People.Find(personID)
            Else
                person = New DBEntity.Person
            End If
            person.FirstName = tbFirstNameTextBox.Text
            person.MiddleName = tbMiddleNameTextBox.Text
            person.LastName = tbLastNameTextBox.Text
            person.EmailAddress = tbEmailTextBox.Text
            person.Username = tbUserNameTextBox.Text
            If tbPasswordTextBox.Text.Length <> 0 Then
                ' Encryopt password
                Dim pt As New Wine.Common.PasswordEncryption
                Dim newSeed As String = ""
                Dim EncryptedPassword As String = pt.CryptPassword(newSeed, tbPasswordTextBox.Text.Trim)

                person.PasswordSeed = newSeed
                person.EncryptedPassword = EncryptedPassword
                person.PasswordDate = DateTime.Now
            End If
            If personID = 0 Then
                db.People.Add(person)
            End If
            db.SaveChanges()
            hfPersonID.Value = person.PersonID.ToString
            delArea.Visible = True
            tdChgPassword.Visible = True
        End Sub

        Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            Response.Redirect("/AdminTools/PersonSearch.aspx")
        End Sub

        Private Sub btnDel_Click(sender As Object, e As EventArgs) Handles btnDel.Click
            Dim sPersID As String = hfPersonID.Value
            Dim personID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim person As DBEntity.Person = Nothing
            If Integer.TryParse(sPersID, personID) AndAlso personID > 0 Then
                person = db.People.Find(personID)
                db.People.Remove(person)
                db.SaveChanges()
                Response.Redirect("/AdminTools/PersonSearch.aspx")
            End If
        End Sub



        Private Sub btnChangePassword_Click(sender As Object, e As EventArgs) Handles btnChangePassword.Click
            Dim sPersID As String = hfPersonID.Value
            Dim personID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim person As DBEntity.Person = Nothing
            If Integer.TryParse(sPersID, personID) AndAlso personID > 0 Then
                person = db.People.Find(personID)

                ' Encryopt password
                Dim pt As New Wine.Common.PasswordEncryption
                Dim newSeed As String = ""
                Dim EncryptedPassword As String = pt.CryptPassword(newSeed, tbPasswordTextBox.Text.Trim)

                person.PasswordSeed = newSeed
                person.EncryptedPassword = EncryptedPassword
                person.PasswordDate = DateTime.Now

                db.SaveChanges()
            End If

        End Sub
    End Class
End Namespace
