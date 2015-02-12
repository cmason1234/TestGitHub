Namespace Wine.Web

    Public Class WineScoreAddEdit
        Inherits WebMaster

        Dim userMessage As String = ""

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
            If userMessage.Trim.Length > 0 Then
                ucErrorMessages.Visible = True
                ucErrorMessages.SetDescription(userMessage)
            End If
        End Sub

        Private Sub LoadFromDB()
            Dim sCompID As String = Request.Params("CompetitionID")
            Dim competitionID As Integer = 0

            Dim sWineEntryID As String = Request.Params("WineEntryId")
            Dim wineEntryID As Integer = 0

            Dim sWineScoringID As String = Request.Params("WineScoringID")
            Dim wineScoringID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

            If Not IsNothing(Request.Params("CompetitionID")) AndAlso
                Integer.TryParse(sCompID, competitionID) AndAlso competitionID > 0 Then
                Dim comp As DBEntity.Competition = db.Competitions.Find(competitionID)
                tbCompNameTextBox.Text = comp.CompetitionName

                If Not IsNothing(Request.Params("WineEntryId")) AndAlso
                    Integer.TryParse(sWineEntryID, wineEntryID) AndAlso wineEntryID > 0 Then
                    Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)

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
                        Integer.TryParse(sWineScoringID, wineScoringID) AndAlso wineScoringID > 0 Then
                        Dim wineScore As DBEntity.WineScoring = db.WineScorings.Find(wineScoringID)

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
            hfCompetitionID.Value = competitionID.ToString
            hfWineEntryId.Value = wineEntryID.ToString
            hfWineScoringID.Value = wineScoringID.ToString
        End Sub

        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0
            Dim sWineScoringID As String = hfWineScoringID.Value
            Dim wineScoringID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing

            If Integer.TryParse(sWineScoringID, wineScoringID) AndAlso wineScoringID > 0 Then
                wineScoring = db.WineScorings.Find(wineScoringID)
            Else
                wineScoring = New DBEntity.WineScoring
            End If
            With wineScoring
                .WineEntryId = wineEntryID
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
            If wineScoringID = 0 Then
                db.WineScorings.Add(wineScoring)
            End If
            db.SaveChanges()
            hfWineScoringID.Value = wineScoring.WineScoringID.ToString

            UpdateAvgScore(wineEntryID, db)
            btnValidate.Visible = True
            lblEnteredBy.Visible = True
            lblEnteredByText.Visible = True
            lblEnteredBy.Text = currentPerson.Username
            userMessage = "Wine Score successfully saved"
        End Sub


        Private Sub btnSave2_Click(sender As Object, e As EventArgs) Handles btnSave2.Click
            btnSave_Click(sender, e)
        End Sub

        Private Sub UpdateAvgScore(wineEntryID As Integer, db As DBEntity.mywinecompetitionEntities)
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
            Dim sWineScoringID As String = hfWineScoringID.Value
            Dim wineScoringID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            If Integer.TryParse(sWineScoringID, wineScoringID) AndAlso wineScoringID > 0 Then
                Dim wineScoring As DBEntity.WineScoring = db.WineScorings.Find(wineScoringID)
                Dim wineEntryID As Integer = wineScoring.WineEntryId
                db.WineScorings.Remove(wineScoring)
                db.SaveChanges()
                UpdateAvgScore(wineEntryID:=wineEntryID, db:=db)
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
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0

            Integer.TryParse(sCompID, competitionID)

            If Integer.TryParse(sWineNum, wineNum) AndAlso wineNum > 0 Then
                Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                Dim wineScoringList = (From s In db.WineEntries Where s.EntryID = wineNum And s.CompetitionID = competitionID).ToList
                If wineScoringList.Count > 0 Then
                    Dim wineEntryID As Integer = wineScoringList.FirstOrDefault.WineEntryID
                    Response.Redirect("/Competition/WineScoreAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & wineEntryID.ToString & "&WineScoringID=0")
                Else
                    ucErrorMessages.MessageClass() = "msgErr"
                    userMessage = "Unable to find Wine Entry # " + sWineNum + " in this competition"
                End If
            End If

        End Sub

        Private Sub btnValidate_Click(sender As Object, e As EventArgs) Handles btnValidate.Click
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0
            Dim sWineScoringID As String = hfWineScoringID.Value
            Dim wineScoringID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing

            ' Not a lot of checking here, since we have to have a saved item to even get the button to click.
            Integer.TryParse(sWineScoringID, wineScoringID)
            wineScoring = db.WineScorings.Find(wineScoringID)

            With wineScoring
                .WineEntryId = wineEntryID
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

            UpdateAvgScore(wineEntryID, db)
            btnValidate.Visible = False
            lblValidatedBy.Visible = True
            lblValidText.Visible = True
            lblValidatedBy.Text = currentPerson.PersonID
            userMessage = "Wine Score successfully validated"
        End Sub
    End Class
End Namespace
