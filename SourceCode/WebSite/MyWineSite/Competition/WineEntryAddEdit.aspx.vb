Namespace Wine.Web
    Public Class WineEntryAddEdit
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Master.AppTitle = "Wine Entries Add/Edit"
            If Not IsPostBack Then
                LoadFromDB()
            End If
        End Sub

        Private Sub LoadFromDB()
            Dim sCompID As String = Request.Params("CompetitionID")
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = Request.Params("WineEntryId")
            Dim wineEntryID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

            If Not IsNothing(Request.Params("CompetitionID")) AndAlso
                Integer.TryParse(sCompID, competitionID) AndAlso
                competitionID > 0 Then

                Dim comp As DBEntity.Competition = db.Competitions.Find(competitionID)
                tbCompNameTextBox.Text = comp.CompetitionName

                If Not IsNothing(Request.Params("WineEntryID")) AndAlso
                   Integer.TryParse(sWineEntryID, wineEntryID) AndAlso
                   wineEntryID > 0 Then

                    Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)
                    With wineEntry
                        tbEntryNumTextBox.Text = .EntryID.ToString
                        tbWineName.Text = .WineName
                        tbEntrantName.Text = .EntrantName
                        tbCategoryName.Text = .CategoryName
                        tbTableNum.Text = .TableNum.ToString
                        tbFlightNum.Text = .FlightNum.ToString
                        tbSeqNum.Text = .SeqNum.ToString
                        tbAvgScore.Text = .AvgScore.ToString
                        tbMedalColor.Text = .MedalColor
                    End With
                    GetScoringEntries(wineEntryID, competitionID, True)
                Else
                    divScoreList.Visible = False
                End If
            End If
            hfCompetitionID.Value = competitionID.ToString
            hfWineEntryId.Value = wineEntryID.ToString
        End Sub

        Private Sub GetScoringEntries(wineEntryID As Integer, competitionID As Integer, bind As Boolean)

            Dim sql As String
            sql = "select WineScoringID, wineEntryID, EnteredPersonID, " &
                "JudgeNum, JudgeInitials, Clarity, Color, Aroma, Ta, Texture, " &
                "Flavor, Bitterness, Finish, Quality, JudgeTotal, Score, p.Username, " &
                "'' as JudgeID, " & competitionID.ToString & " as CompetitionID " &
                "from WineScoring ws " &
                "INNER JOIN Person p on p.PersonID=ws.EnteredPersonID " &
                "where wineEntryID = " & wineEntryID.ToString & " Order by Score"

            Dim pds As New System.Data.DataSet
            Wine.Common.SQL.FillDataSet(pds, sql, "WineEntry")
            If pds.Tables(0).Rows.Count > 0 Then
                dgGridScoreComp.Visible = True
                litScoreCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
                For Each dr As System.Data.DataRow In pds.Tables(0).Rows
                    Dim judgeNum As String = Wine.Common.Validation.NullHelperInteger(dr, "JudgeNum").ToString
                    Dim judgeInitials As String = Wine.Common.Validation.NullHelper(dr, "JudgeInitials")
                    If judgeInitials.Trim.Length <> 0 Then
                        dr("JudgeID") = judgeInitials
                    Else
                        dr("JudgeID") = judgeNum
                    End If
                Next
            Else
                dgGridScoreComp.Visible = False
            End If
            dgGridScoreComp.DataSource = pds
            If bind Then
                dgGridScoreComp.DataBind()
            End If
        End Sub

        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            SaveWineEntry()
            divScoreList.Visible = True
        End Sub

        Private Sub SaveWineEntry()
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Integer.TryParse(sCompID, competitionID)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

            Dim wineEntry As DBEntity.WineEntry = Nothing

            If Integer.TryParse(sWineEntryID, wineEntryID) AndAlso wineEntryID > 0 Then
                wineEntry = db.WineEntries.Find(wineEntryID)
            Else
                wineEntry = New DBEntity.WineEntry
            End If
            With wineEntry
                .CompetitionID = competitionID
                .EntryID = Convert.ToInt64(tbEntryNumTextBox.Text)
                .WineName = tbWineName.Text
                .EntrantName = tbEntrantName.Text
                .CategoryName = tbCategoryName.Text
                If tbTableNum.Text.Length > 0 Then
                    .TableNum = Convert.ToInt64(tbTableNum.Text)
                End If
                If tbFlightNum.Text.Length > 0 Then
                    .FlightNum = Convert.ToInt64(tbFlightNum.Text)
                End If
                If tbSeqNum.Text.Length > 0 Then
                    .SeqNum = Convert.ToInt64(tbSeqNum.Text)
                End If
                If tbAvgScore.Text.Length > 0 Then
                    .AvgScore = Convert.ToDouble(tbAvgScore.Text)
                End If
                If tbMedalColor.Text.Length > 0 Then
                    .MedalColor = tbMedalColor.Text
                End If
            End With
            If wineEntryID = 0 Then
                db.WineEntries.Add(wineEntry)
            End If
            db.SaveChanges()
            hfWineEntryId.Value = wineEntry.WineEntryID.ToString
            GetScoringEntries(wineEntry.WineEntryID, wineEntry.CompetitionID, True)
        End Sub

        Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            Response.Redirect("/Competition/CompAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value)
        End Sub


        Private Sub btnDel_Click(sender As Object, e As EventArgs) Handles btnDel.Click
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            If Integer.TryParse(sWineEntryID, wineEntryID) AndAlso wineEntryID > 0 Then
                Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)
                db.WineEntries.Remove(wineEntry)
                db.SaveChanges()
                Response.Redirect("/Competition/CompAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value)
            End If
        End Sub

        Public Sub btnNewScore_Click(sender As Object, e As EventArgs)
            Response.Redirect("/Competition/WineScoreAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & hfWineEntryId.Value & "&WineScoringID=0")
        End Sub

        Private Sub btnCreateNewWineEntry_Click(sender As Object, e As EventArgs) Handles btnCreateNewWineEntry.Click
            Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=0")
        End Sub

        Private Sub dgGridScoreComp_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles dgGridScoreComp.NeedDataSource
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            GetScoringEntries(wineEntryID:=wineEntryID, competitionID:=competitionID, bind:=False)
        End Sub
    End Class
End Namespace
