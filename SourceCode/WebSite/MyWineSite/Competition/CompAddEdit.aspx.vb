Namespace Wine.Web
    Public Class CompAddEdit
        Inherits System.Web.UI.Page

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                LoadFromDB()
            End If
        End Sub

        Private Sub LoadFromDB()
            Dim sCompID As String = Request.Params("CompetitionID")
            Dim competitionID As Integer = 0
            divMontlyList.Visible = False
            divYearlyList.Visible = False

            If Request.Params("CompetitionID") IsNot Nothing Then
                If Integer.TryParse(sCompID, competitionID) AndAlso competitionID > 0 Then
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
                    If comp.MonthlyCompetition Then
                        ShowMonthlyCompResults(competitionID, True)
                    Else
                        ShowYearlyCompResults(db, comp)
                    End If
                End If
            End If
            hfCompetitionID.Value = competitionID.ToString
        End Sub

        Private Sub ShowMonthlyCompResults(competitionID As Integer, bind As Boolean)
            divMontlyList.Visible = True

            Dim sql As String
            sql = "select WineEntryID, CompetitionID, EntryID, WineName, EntrantName, TableNum, " &
                "FlightNum, SeqNum, AvgScore, MedalColor " &
                "from WineEntry where CompetitionID = " & competitionID.ToString & "   order by  AvgScore desc, EntryID asc"

            Dim pds As New System.Data.DataSet
            Wine.Common.SQL.FillDataSet(pds, sql, "WineEntry")
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


        Private Sub ShowYearlyCompResults(db As DBEntity.mywinecompetitionEntities, comp As DBEntity.Competition)
            Throw New NotImplementedException
        End Sub

        Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            SaveCompetition()
            LoadFromDB()
        End Sub

        Private Sub SaveCompetition()
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0

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
            delArea.Visible = True
        End Sub


        Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            Response.Redirect("/Competition/CompSearch.aspx")
        End Sub

        Private Sub btnDel_Click(sender As Object, e As EventArgs) Handles btnDel.Click
            DeleteCompetition()
        End Sub

        Private Sub DeleteCompetition()
            Dim sCompID As String = hfCompetitionID.Value
            Dim competitionID As Integer = 0

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


    End Class
End Namespace
