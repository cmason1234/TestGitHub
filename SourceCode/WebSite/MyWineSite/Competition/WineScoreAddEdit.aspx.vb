Namespace Wine.Web

    Public Class WineScoreAddEdit
        Inherits WebMaster

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                LoadFromDB()
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

                If Not IsNothing(Request.Params("WineEntryId")) AndAlso
                    Integer.TryParse(sWineEntryID, wineEntryID) AndAlso wineEntryID > 0 Then
                    Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)
                    tbWineNum.Value = wineEntry.EntryID.ToString
                    tbWineName.Text = wineEntry.WineName

                    If Not IsNothing(Request.Params("WineScoringID")) AndAlso
                        Integer.TryParse(sWineScoringID, wineScoringID) AndAlso wineScoringID > 0 Then
                        Dim wineScore As DBEntity.WineScoring = db.WineScorings.Find(wineScoringID)

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
            End With
            If wineScoringID = 0 Then
                db.WineScorings.Add(wineScoring)
            End If
            hfWineScoringID.Value = wineScoring.WineScoringID.ToString
            db.SaveChanges()

            UpdateAvgScore(wineEntryID, db)
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
                If avg >= 19 Then
                    medalColor = "Double Gold"
                ElseIf avg >= 17 Then
                    medalColor = "Gold"
                ElseIf avg >= 15 Then
                    medalColor = "Silver"
                ElseIf avg >= 13 Then
                    medalColor = "Bronze"
                End If
                wineEntry.MedalColor = medalColor
                db.SaveChanges()
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
                db.WineScorings.Remove(wineScoring)
                db.SaveChanges()
                Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value)
            End If
        End Sub

        Private Sub btnCreateNew_Click(sender As Object, e As EventArgs) Handles btnCreateNew.Click
            Response.Redirect("/Competition/WineScoreAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value & "&WineScoringID=0")
        End Sub
    End Class
End Namespace
