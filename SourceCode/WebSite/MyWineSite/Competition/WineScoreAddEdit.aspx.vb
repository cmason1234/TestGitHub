Namespace Wine.Web

    Public Class WineScoreAddEdit
        Inherits WebMaster

        Dim _userMessage As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Master.AppTitle = "Wine Score Add/Edit"
            If Not IsPostBack Then
                btnValidate.Visible = False
                LoadFromDB()
                If currentPerson.Username.ToLower <> "cmason" Then
                    btnDel.Visible = False
                End If
            End If
        End Sub

        Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
            ucErrorMessages.Visible = False
            If _userMessage.Trim.Length > 0 Then
                ucErrorMessages.Visible = True
                ucErrorMessages.SetDescription(_userMessage)
            End If
        End Sub

        Private Sub LoadFromDb()
            Dim sCompId As String = Request.Params("CompetitionID")
            Dim competitionId As Integer = 0

            Dim sWineEntryId As String = Request.Params("WineEntryId")
            Dim wineEntryId As Integer = 0

            Dim sWineScoringId As String = Request.Params("WineScoringID")
            Dim wineScoringId As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

            If Not IsNothing(Request.Params("CompetitionID")) AndAlso
                Integer.TryParse(sCompId, competitionId) AndAlso competitionId > 0 Then
                Dim comp As DBEntity.Competition = db.Competitions.Find(competitionId)
                tbCompNameTextBox.Text = comp.CompetitionName

                If Not IsNothing(Request.Params("WineEntryId")) AndAlso
                    Integer.TryParse(sWineEntryId, wineEntryId) AndAlso wineEntryId > 0 Then
                    Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryId)

                    tbWineNum.Value = wineEntry.EntryID.ToString
                    tbWineName.Text = wineEntry.WineName

                    tbAvgScore.Text = wineEntry.AvgScore.ToString
                    tbMedalColor.Text = wineEntry.MedalColor

                    If wineEntry.AvgScore >= 18.5 Then
                        tbAvgScore.BackColor = Drawing.Color.Gold
                        tbMedalColor.BackColor = Drawing.Color.Gold
                    ElseIf wineEntry.AvgScore >= 17 Then
                        tbAvgScore.BackColor = Drawing.Color.Yellow
                        tbMedalColor.BackColor = Drawing.Color.Yellow
                    ElseIf wineEntry.AvgScore >= 15 Then
                        tbAvgScore.BackColor = Drawing.Color.Silver
                        tbMedalColor.BackColor = Drawing.Color.Silver
                    ElseIf wineEntry.AvgScore >= 13 Then
                        tbAvgScore.BackColor = Drawing.Color.Peru
                        tbMedalColor.BackColor = Drawing.Color.Peru
                    Else
                        tbAvgScore.BackColor = Drawing.Color.LightGray
                        tbMedalColor.BackColor = Drawing.Color.LightGray
                    End If

                    If Not IsNothing(wineEntry.TableNum) Then
                        tbTableNum.Text = wineEntry.TableNum
                    End If
                    If Not IsNothing(wineEntry.SeqNum) Then
                        tbSeqNum.Text = wineEntry.SeqNum
                    End If
                    If Not IsNothing(wineEntry.CatNum) Then
                        tbCategoryNumber.Text = wineEntry.CatNum
                    End If
                    If Not IsNothing(wineEntry.Vintage) Then
                        tbVintage.Text = wineEntry.Vintage
                    End If

                    If Not IsNothing(wineEntry.FlightNum) Then
                        tbFlightNum.Text = wineEntry.FlightNum
                    End If

                    If Not IsNothing(Request.Params("WineScoringID")) AndAlso
                        Integer.TryParse(sWineScoringId, wineScoringId) AndAlso wineScoringId > 0 Then
                        Dim wineScore As DBEntity.WineScoring = db.WineScorings.Find(wineScoringId)

                        Dim enteredby As String = ""

                        If Not IsNothing(wineScore.EnteredPersonID) Then
                            enteredby = wineScore.Person.Username
                        End If
                        Dim validatedby As String = ""
                        If wineScore.ValidatedPersonID Then
                            validatedby = wineScore.Person1.Username
                        End If

                        With wineScore
                            tbClarity.Value = .Clarity
                            tbColor.Value = .Color
                            tbAroma.Value = .Aroma
                            tbAcidity.Value = .Ta
                            tbBody.Value = .Texture
                            tbFlavor.Value = .Flavor
                            tbBitterness.Value = .Bitterness
                            tbFinish.Value = .Finish
                            tbQuality.Value = .Quality
                            tbJudgeNum.Value = .JudgeNum
                            tbJudgeName.Text = .JudgeInitials
                            tbJudgeScore.Value = .JudgeTotal
                            tbCalcScore.Value = .Score
                        End With
                        If enteredby.Length = 0 Then
                            lblEnteredBy.Visible = False
                            lblEnteredByText.Visible = False
                        Else
                            lblEnteredBy.Visible = True
                            lblEnteredByText.Visible = True
                            lblEnteredBy.Text = enteredby
                        End If
                        If validatedby.Length = 0 Then
                            btnValidate.Visible = True
                        Else
                            btnValidate.Visible = False
                            lblValidatedBy.Visible = True
                            lblValidText.Visible = True
                            lblValidatedBy.Text = validatedby
                        End If
                    Else
                        tbClarity.Value = 0
                        tbColor.Value = 0
                        tbAroma.Value = 0
                        tbAcidity.Value = 0
                        tbBody.Value = 0
                        tbFlavor.Value = 0
                        tbBitterness.Value = 0
                        tbFinish.Value = 0
                        tbQuality.Value = 0
                        tbJudgeScore.Value = 0
                        tbCalcScore.Value = 0
                    End If
                End If
            End If
            hfCompetitionID.Value = competitionId.ToString
            hfWineEntryId.Value = wineEntryId.ToString
            hfWineScoringID.Value = wineScoringId.ToString
        End Sub

        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0
            Dim sWineEntryId As String = hfWineEntryId.Value
            Dim wineEntryId As Integer = 0
            Dim sWineScoringId As String = hfWineScoringID.Value
            Dim wineScoringId As Integer = 0

            Integer.TryParse(sCompId, competitionId)
            Integer.TryParse(sWineEntryId, wineEntryId)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing

            If Integer.TryParse(sWineScoringId, wineScoringId) AndAlso wineScoringId > 0 Then
                wineScoring = db.WineScorings.Find(wineScoringId)
            Else
                wineScoring = New DBEntity.WineScoring
            End If
            With wineScoring
                .WineEntryId = wineEntryId
                .EnteredPersonID = currentPerson.PersonID
                .JudgeNum = tbJudgeNum.Value
                .JudgeInitials = tbJudgeName.Text
                .Clarity = tbClarity.Value
                .Color = tbColor.Value
                .Aroma = tbAroma.Value
                .Ta = tbAcidity.Value
                .Texture = tbBody.Value
                .Flavor = tbFlavor.Value
                .Bitterness = tbBitterness.Value
                .Finish = tbFinish.Value
                .Quality = tbQuality.Value
                .JudgeTotal = tbJudgeScore.Value
                .Score = tbCalcScore.Value
                .ValidatedPersonID = Nothing
            End With
            If wineScoringId = 0 Then
                db.WineScorings.Add(wineScoring)
            End If
            db.SaveChanges()
            hfWineScoringID.Value = wineScoring.WineScoringID.ToString

            UpdateAvgScore(wineEntryId, db)
            btnValidate.Visible = True
            lblEnteredBy.Visible = True
            lblEnteredByText.Visible = True
            lblEnteredBy.Text = currentPerson.Username
            _userMessage = "Wine Score successfully saved"
        End Sub


        Private Sub btnSave2_Click(sender As Object, e As EventArgs) Handles btnSave2.Click
            btnSave_Click(sender, e)
        End Sub

        Private Sub UpdateAvgScore(wineEntryId As Integer, db As DBEntity.mywinecompetitionEntities)
            Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)
            Dim wineScoringList = wineEntry.WineScorings

            If wineScoringList.Count > 0 Then
                Dim total As Double = 0
                For Each winescoring As DBEntity.WineScoring In wineScoringList
                    total += winescoring.Score
                Next
                Dim avg As Double = total / wineScoringList.Count
                wineEntry.AvgScore = avg
                Dim medalColor As String = Nothing
                If avg >= 18.5 Then
                    medalColor = "Double Gold"
                    tbAvgScore.BackColor = Drawing.Color.Gold
                    tbMedalColor.BackColor = Drawing.Color.Gold
                ElseIf avg >= 17 Then
                    medalColor = "Gold"
                    tbAvgScore.BackColor = Drawing.Color.Yellow
                    tbMedalColor.BackColor = Drawing.Color.Yellow
                ElseIf avg >= 15 Then
                    medalColor = "Silver"
                    tbAvgScore.BackColor = Drawing.Color.Silver
                    tbMedalColor.BackColor = Drawing.Color.Silver
                ElseIf avg >= 13 Then
                    medalColor = "Bronze"
                    tbAvgScore.BackColor = Drawing.Color.Peru
                    tbMedalColor.BackColor = Drawing.Color.Peru
                Else
                    medalColor = ""
                    tbAvgScore.BackColor = Drawing.Color.LightGray
                    tbMedalColor.BackColor = Drawing.Color.LightGray
                End If
                wineEntry.MedalColor = medalColor
                db.SaveChanges()
                tbAvgScore.Text = wineEntry.AvgScore.ToString
                tbMedalColor.Text = wineEntry.MedalColor
            End If

        End Sub

        Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value)
        End Sub


        Private Sub btnDel_Click(sender As Object, e As EventArgs) Handles btnDel.Click
            Dim sWineScoringId As String = hfWineScoringID.Value
            Dim wineScoringId As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            If Integer.TryParse(sWineScoringId, wineScoringId) AndAlso wineScoringId > 0 Then
                Dim wineScoring As DBEntity.WineScoring = db.WineScorings.Find(wineScoringId)
                Dim wineEntryId As Integer = wineScoring.WineEntryId
                db.WineScorings.Remove(wineScoring)
                db.SaveChanges()
                UpdateAvgScore(wineEntryID:=wineEntryId, db:=db)
            End If
            Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value)
        End Sub

        Private Sub btnCreateNew_Click(sender As Object, e As EventArgs) Handles btnCreateNew.Click
            Response.Redirect("/Competition/WineScoreAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value & "&WineScoringID=0")
        End Sub


        Private Sub btnCreateNew2_Click(sender As Object, e As EventArgs) Handles btnCreateNew2.Click
            btnCreateNew_Click(sender, e)
        End Sub

        Private Sub btnSwitch_Click(sender As Object, e As EventArgs) Handles btnSwitch.Click
            Dim sWineNum As String = tbWineSwitch.Value
            Dim wineNum As Integer = 0
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0

            Integer.TryParse(sCompId, competitionId)

            If Integer.TryParse(sWineNum, wineNum) AndAlso wineNum > 0 Then
                Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                Dim wineScoringList = (From s In db.WineEntries Where s.EntryID = wineNum And s.CompetitionID = competitionId).ToList
                If wineScoringList.Count > 0 Then
                    Dim wineEntryId As Integer = wineScoringList.FirstOrDefault.WineEntryID
                    Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & wineEntryId.ToString)
                Else
                    ucErrorMessages.MessageClass() = "msgErr"
                    _userMessage = "Unable to find Wine Entry # " + sWineNum + " in this competition"
                End If
            End If

        End Sub

        Private Sub btnValidate_Click(sender As Object, e As EventArgs) Handles btnValidate.Click
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0
            Dim sWineEntryId As String = hfWineEntryId.Value
            Dim wineEntryId As Integer = 0
            Dim sWineScoringId As String = hfWineScoringID.Value
            Dim wineScoringId As Integer = 0

            Integer.TryParse(sCompId, competitionId)
            Integer.TryParse(sWineEntryId, wineEntryId)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing

            ' Not a lot of checking here, since we have to have a saved item to even get the button to click.
            Integer.TryParse(sWineScoringId, wineScoringId)
            wineScoring = db.WineScorings.Find(wineScoringId)

            With wineScoring
                .WineEntryId = wineEntryId
                .JudgeNum = tbJudgeNum.Value
                .JudgeInitials = tbJudgeName.Text
                .Clarity = tbClarity.Value
                .Color = tbColor.Value
                .Aroma = tbAroma.Value
                .Ta = tbAcidity.Value
                .Texture = tbBody.Value
                .Flavor = tbFlavor.Value
                .Bitterness = tbBitterness.Value
                .Finish = tbFinish.Value
                .Quality = tbQuality.Value
                .JudgeTotal = tbJudgeScore.Value
                .Score = tbCalcScore.Value
                .ValidatedPersonID = currentPerson.PersonID
            End With
            db.SaveChanges()

            UpdateAvgScore(wineEntryId, db)
            btnValidate.Visible = False
            lblValidatedBy.Visible = True
            lblValidText.Visible = True
            lblValidatedBy.Text = currentPerson.PersonID
            _userMessage = "Wine Score successfully validated"
        End Sub
    End Class
End Namespace
