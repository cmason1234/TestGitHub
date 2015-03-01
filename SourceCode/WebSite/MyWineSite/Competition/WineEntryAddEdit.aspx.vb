Imports Telerik.Web.UI

Namespace Wine.Web
    Public Class WineEntryAddEdit
        Inherits WebMaster

        Dim userMessage As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Master.AppTitle = "Wine Entries Add/Edit"
            If Not IsPostBack Then
                LoadFromDB()
                If currentPerson.Username.ToLower <> "cmason" Then
                    btnDel.Visible = False
                End If
            End If
            btnNewScore.Attributes.Add("onclick", "WINE.EntryAddEdit.openPopup();")
            btnNewScore2.Attributes.Add("onclick", "WINE.EntryAddEdit.openPopup();")
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
                        tbCategoryNumber.Text = .CatNum
                        tbVintage.Text = .Vintage
                        If .AvgScore >= 18.5 Then
                            tbAvgScore.BackColor = Drawing.Color.Gold
                            tbMedalColor.BackColor = Drawing.Color.Gold
                        ElseIf .AvgScore >= 17 Then
                            tbAvgScore.BackColor = Drawing.Color.Yellow
                            tbMedalColor.BackColor = Drawing.Color.Yellow
                        ElseIf .AvgScore >= 15 Then
                            tbAvgScore.BackColor = Drawing.Color.Silver
                            tbMedalColor.BackColor = Drawing.Color.Silver
                        ElseIf .AvgScore >= 13 Then
                            tbAvgScore.BackColor = Drawing.Color.Peru
                            tbMedalColor.BackColor = Drawing.Color.Peru
                        Else
                            tbAvgScore.BackColor = Drawing.Color.LightGray
                            tbMedalColor.BackColor = Drawing.Color.LightGray
                        End If
                    End With

                    btnLock.Visible = Not wineEntry.Locked
                    btnLock2.Visible = Not wineEntry.Locked
                    btnUnlock.Visible = wineEntry.Locked
                    btnUnLock2.Visible = wineEntry.Locked
                    btnNewScore.Enabled = Not wineEntry.Locked
                    btnNewScore2.Enabled = Not wineEntry.Locked
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
                "JudgeNum, Clarity, Color, Aroma, Ta, Texture, " &
                "Flavor, Bitterness, Finish, Quality, JudgeTotal, Score, p.Username as EnteredBy, " &
                 competitionID.ToString & " as CompetitionID, " &
                "ISNULL( p1.Username, '') as ValidatedBy  " &
                "from WineScoring ws " &
                "INNER JOIN Person p on p.PersonID=ws.EnteredPersonID " &
                "LEFT OUTER JOIN Person P1 on ws.ValidatedPersonID=p1.PersonID " &
                "where wineEntryID = " & wineEntryID.ToString & " Order by Score"

            Dim pds As New System.Data.DataSet
            Wine.Common.SQL.FillDataSet(pds, sql, "WineEntry")
            If pds.Tables(0).Rows.Count > 0 Then
                dgGridScoreComp.Visible = True
                btnValidate.Visible = True
                btnValidate2.Visible = True
                litScoreCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
            Else
                dgGridScoreComp.Visible = False
                btnValidate.Visible = False
                btnValidate2.Visible = False
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
                .CatNum = tbCategoryNumber.Text
                .Vintage = tbVintage.Text
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
            userMessage = "Wine successfully saved"
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

        Private Sub btnAddScore_Click(sender As Object, e As EventArgs) Handles btnAddScore.Click
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing

            wineScoring = New DBEntity.WineScoring
            With wineScoring
                .WineEntryId = wineEntryID
                .EnteredPersonID = currentPerson.PersonID
                .JudgeNum = tbJudgeNum2.Text
                '.JudgeInitials = tbJudgeName.Text
                .Clarity = tbClarity2.Value
                .Color = tbColor2.Value
                .Aroma = tbAroma2.Value
                .Ta = tbAcidity2.Value
                .Texture = tbBody2.Value
                .Flavor = tbFlavor2.Value
                .Bitterness = tbBitterness2.Value
                .Finish = tbFinish2.Value
                .Quality = tbQuality2.Value
                .JudgeTotal = tbJudgeScore2.Value
                .Score = tbCalcScore2.Value
                .ValidatedPersonID = Nothing
            End With
            db.WineScorings.Add(wineScoring)

            db.SaveChanges()

            UpdateAvgScore(wineEntryID, db)
            btnValidate.Visible = True
            userMessage = "Wine Score successfully saved"
            LoadFromDB()
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


        Private Sub dgGridScoreComp_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles dgGridScoreComp.NeedDataSource
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            GetScoringEntries(wineEntryID:=wineEntryID, competitionID:=competitionID, bind:=False)
        End Sub


        Public Sub btnValidate_Click(sender As Object, e As EventArgs)
            Dim selectedItems As Telerik.Web.UI.GridItemCollection = dgGridScoreComp.SelectedItems
            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim wineScoring As DBEntity.WineScoring = Nothing
            For Each item As GridDataItem In selectedItems
                ' Get the checkbox value for the row 
                Dim sWineScoringID = item("WineScoringID").Text.ToString()
                Dim intWineScoringID As Integer = 0
                Integer.TryParse(sWineScoringID, intWineScoringID)

                wineScoring = db.WineScorings.Find(intWineScoringID)
                wineScoring.ValidatedPersonID = currentPerson.PersonID
            Next
            db.SaveChanges()

            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0
            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            Integer.TryParse(sCompID, competitionID)
            Integer.TryParse(sWineEntryID, wineEntryID)

            GetScoringEntries(wineEntryID:=wineEntryID, competitionID:=competitionID, bind:=True)
            userMessage = "Scores successfully validated"
        End Sub

        Public Sub btnChangeLock_Click(sender As Object, e As EventArgs)
            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

            Dim sWineEntryID As String = hfWineEntryId.Value
            Dim wineEntryID As Integer = 0

            If Integer.TryParse(sWineEntryID, wineEntryID) AndAlso wineEntryID > 0 Then

                Dim wineEntry As DBEntity.WineEntry = db.WineEntries.Find(wineEntryID)
                wineEntry.Locked = Not wineEntry.Locked

                btnLock.Visible = Not wineEntry.Locked
                btnLock2.Visible = Not wineEntry.Locked
                btnUnlock.Visible = wineEntry.Locked
                btnUnLock2.Visible = wineEntry.Locked
                btnNewScore.Enabled = Not wineEntry.Locked
                btnNewScore2.Enabled = Not wineEntry.Locked

                db.SaveChanges()
            End If
        End Sub

    End Class
End Namespace
