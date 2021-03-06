﻿Imports Telerik.Web.UI

Namespace Wine.Web
    Public Class CompAddEdit
        Inherits WebMaster

        Dim _userMessage As String = ""

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            Master.AppTitle = "Competition Add/Edit"
            If Not IsPostBack Then
                Dim sCompId As String = Request.Params("CompetitionID")
                Dim competitionId As Integer = 0
                divMontlyList.Visible = False
                divYearlyList.Visible = False
                If Request.Params("CompetitionID") IsNot Nothing Then
                    If Integer.TryParse(sCompID, competitionID) AndAlso competitionID > 0 Then
                        LoadFromDB(competitionID)
                    End If
                End If
                hfCompetitionID.Value = competitionID.ToString
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

        Private Sub LoadFromDb(competitionId As Integer)
            divMontlyList.Visible = False
            divYearlyList.Visible = False

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim comp As DBEntity.Competition = db.Competitions.Find(competitionID)
            tbCompNameTextBox.Text = comp.CompetitionName
            If comp.MonthlyCompetition Then
                ddlCompType.SelectedValue = "Monthly"
            Else
                ddlCompType.SelectedValue = "Yearly"
            End If
            If Wine.Common.HTML.CanSetDropDownValue(ddlYear, comp.Year.ToString) Then
                If IsNothing(comp.Year) Then
                    ddlYear.SelectedValue = ""
                Else
                    ddlYear.SelectedValue = comp.Year.ToString
                End If
            End If
            If Wine.Common.HTML.CanSetDropDownValue(ddlMonth, comp.Month) Then
                If IsNothing(comp.Month) Then
                    ddlMonth.SelectedValue = ""
                Else
                    ddlMonth.SelectedValue = comp.Month.ToString
                End If
            End If

            ShowMonthlyCompResults(competitionID, True)
            If Not comp.MonthlyCompetition Then
                ShowYearlyCompResults(competitionID, True)
            End If
        End Sub

        Private Sub ShowMonthlyCompResults(competitionId As Integer, bind As Boolean)
            divMontlyList.Visible = True

            Dim sql As String
            sql = "select WineEntryID, CompetitionID, EntryID, WineName, EntrantName, TableNum, " &
                "FlightNum, SeqNum, AvgScore, MedalColor " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & "   order by  AvgScore desc, EntryID asc"

            Dim pds As New System.Data.DataSet
            Wine.Common.Sql.FillDataSet(pds, sql, "WineEntry")
            If pds.Tables(0).Rows.Count > 0 Then
                litMontlyCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
            End If
            dgGridMonthlyComp.DataSource = pds
            If bind Then
                dgGridMonthlyComp.DataBind()
            End If
        End Sub

        Private Sub dgGridMonthlyComp_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles dgGridMonthlyComp.NeedDataSource
            Dim compId As Integer = 0
            Integer.TryParse(hfCompetitionID.Value, compId)
            ShowMonthlyCompResults(compId, False)
        End Sub


        Private Sub ShowYearlyCompResults(competitionId As Integer, bind As Boolean)
            divYearlyList.Visible = True

            Dim sql As String
            sql = "select 1 as MedalOrder, 'Double Gold' as medalColor, COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor='double gold' " &
                "union " &
                "select 2, 'Gold', COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor='gold' " &
                "union " &
                "select 3, 'Silver', COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor='Silver' " &
                "UNION " &
                "select 4, 'Bronze', COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor='bronze' " &
                "UNION " &
                "select 5, '', COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor='' " &
                "UNION " &
                "select 6, 'Not Scored', COUNT(*) as NumMedals " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & " and medalcolor is null " &
                "order by MedalOrder"
            Dim mds As New System.Data.DataSet
            Wine.Common.Sql.FillDataSet(mds, sql, "WineColors")

            sql = "select WineEntryID, CompetitionID, EntryID, WineName, " &
                     "TableNum, FlightNum, SeqNum, AvgScore, CatNum, " &
                     "isnull(MedalColor, 'Not Scored') as MedalColor, " &
                     "case medalcolor " &
                     "when 'double gold' then 1 " &
                     "when 'gold' then 2 " &
                     "when 'silver' then 3 " &
                     "when 'bronze' then 4 " &
                     "when '' then 5 " &
                     "else 6 end as MedalOrder " &
                "from WineEntry where CompetitionID = " & competitionID.ToString &
                " order by  MedalOrder, catnum, AvgScore desc"

            Dim pds As New System.Data.DataSet
            Wine.Common.Sql.FillDataSet(pds, sql, "WineEntry")
            If pds.Tables(0).Rows.Count > 0 Then
                litYearlyCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
            End If

            Dim dt As System.Data.DataTable = mds.Tables(0).Copy
            pds.Tables.Add(dt)

            dgGridYearlyComp.DataSource = pds
            If bind Then
                dgGridYearlyComp.DataBind()
            End If


        End Sub

        Private Sub dgGridYearlyComp_DetailTableDataBind(sender As Object, e As Telerik.Web.UI.GridDetailTableDataBindEventArgs) Handles dgGridYearlyComp.DetailTableDataBind
            Dim parentItem As GridDataItem = e.DetailTableView.ParentItem
            If parentItem.Edit Then
                Return
            End If
            If (e.DetailTableView.DataMember = "WineEntry") Then
                Dim ds As DataSet = CType(e.DetailTableView.DataSource, DataSet)
                e.DetailTableView.DataSource = ds.Tables("WineEntry").Select("MedalColor = '" + parentItem("MedalColor").Text + "'")
            End If
        End Sub


        Private Sub dgGridYearlyComp_NeedDataSource(sender As Object, e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles dgGridYearlyComp.NeedDataSource
            Dim compId As Integer = 0
            Integer.TryParse(hfCompetitionID.Value, compId)
            ShowYearlyCompResults(compId, False)
        End Sub


        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            SaveCompetition()
        End Sub

        Private Sub SaveCompetition()
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim competition As DBEntity.Competition = Nothing
            If Integer.TryParse(sCompID, competitionID) AndAlso competitionID > 0 Then
                competition = db.Competitions.Find(competitionID)
            Else
                competition = New DBEntity.Competition
            End If
            With competition
                .CompetitionName = tbCompNameTextBox.Text
                If IsNothing(ddlCompType.SelectedItem) OrElse ddlCompType.SelectedValue.Trim.ToLower.Equals("monthly") Then
                    .MonthlyCompetition = True
                Else
                    .MonthlyCompetition = False
                End If
                If IsNothing(ddlMonth.SelectedItem) OrElse ddlMonth.SelectedValue.Trim.Length = 0 Then
                    .Month = Nothing
                Else
                    .Month = ddlMonth.SelectedValue.Trim
                End If
                If IsNothing(ddlYear.SelectedItem) OrElse ddlYear.SelectedValue.Trim.Length = 0 Then
                    .Year = Nothing
                Else
                    .Year = ddlYear.SelectedValue
                End If

            End With
            If competitionID = 0 Then
                db.Competitions.Add(competition)
            End If
            db.SaveChanges()
            hfCompetitionID.Value = competition.CompetitionId.ToString
            LoadFromDB(competition.CompetitionId)
            delArea.Visible = True
            _userMessage = "Competition successfully saved"
        End Sub


        Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            Response.Redirect("/Competition/CompSearch.aspx")
        End Sub

        Private Sub btnDel_Click(sender As Object, e As EventArgs) Handles btnDel.Click
            DeleteCompetition()
        End Sub

        Private Sub DeleteCompetition()
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0

            Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            Dim competition As DBEntity.Competition = Nothing
            If Integer.TryParse(sCompID, competitionID) AndAlso competitionID > 0 Then
                competition = db.Competitions.Find(competitionID)
                db.Competitions.Remove(competition)
                db.SaveChanges()
                Response.Redirect("/Competition/CompSearch.aspx")
            End If
        End Sub

        Protected Sub btnNewWine_Click(sender As Object, e As EventArgs)
            Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=0")
        End Sub

        Private Sub btnSwitch_Click(sender As Object, e As EventArgs) Handles btnSwitch.Click
            Dim sWineNum As String = ""

            Dim wineNum As Integer = 0
            Dim sCompId As String = hfCompetitionID.Value
            Dim competitionId As Integer = 0

            If sender.ID = "btnSwitch1" Then
                sWineNum = tbWineSwitch1.Value
            ElseIf sender.ID.Equals("btnSwitch") Then
                sWineNum = tbWineSwitch.Value
            End If

            If sWineNum.Length > 0 Then
                Integer.TryParse(sCompID, competitionID)

                If Integer.TryParse(sWineNum, wineNum) AndAlso wineNum > 0 Then
                    Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                    Dim wineScoringList = (From s In db.WineEntries Where s.EntryID = wineNum And s.CompetitionID = competitionID).ToList
                    If wineScoringList.Count > 0 Then
                        Dim wineEntryId As Integer = wineScoringList.FirstOrDefault.WineEntryID
                        Response.Redirect("/Competition/WineEntryAddEdit.aspx?CompetitionID=" & hfCompetitionID.Value & "&WineEntryID=" & wineEntryID.ToString)
                    Else
                        ucErrorMessages.MessageClass() = "msgErr"
                        _userMessage = "Unable to find Wine Entry # " + sWineNum + " in this competition"
                    End If
                End If
            Else
                _userMessage = "Unable to figure out where to find the wine Number - This should never happen"
            End If
        End Sub

        Private Sub btnSwitch1_Click(sender As Object, e As EventArgs) Handles btnSwitch1.Click
            btnSwitch_Click(sender, e)
        End Sub


    End Class
End Namespace
