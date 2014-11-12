﻿Namespace Wine.Web
    Public Class CompSearch
        Inherits WebMaster

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not IsPostBack Then
                UpdateGrid(True)
            End If
        End Sub

        Private Sub UpdateGrid(bind As Boolean)

            dgGridComp.DataSource = GetCompDataSet()
            If bind Then
                dgGridComp.DataBind()
            End If
            dgGridComp.Visible = True

        End Sub

        Private Function GetCompDataSet() As Object

            Dim addSQL As String = ""

            If tbName.Text.Trim.Length > 0 Then
                addSQL = addSQL & " and CompetitionName like " & Wine.Common.SQL.Quote(tbName.Text.Trim & "%") & " "
            End If

            If Not IsNothing(ddlYear.SelectedItem) AndAlso ddlYear.SelectedItem.Value.Trim.Length > 0 Then
                addSQL = addSQL & " AND Year = " & Wine.Common.SQL.Quote(ddlYear.SelectedItem.Value.Trim)
            End If

            If Not IsNothing(ddlMonth.SelectedItem) AndAlso ddlMonth.SelectedItem.Value.Trim.Length > 0 Then
                addSQL = addSQL & " AND Month = " & Wine.Common.SQL.Quote(ddlMonth.SelectedItem.Value.Trim)
            End If


            Dim sql As String
            sql = "select CompetitionId, CompetitionName, Year, Month, " &
                " CASE MonthlyCompetition When 1 then 'Monthly' Else 'Yearly' END as CompType " &
                "from competition where 1=1 " & addSQL & "   order by  CompetitionName, Year, Month"

            Dim pds As New System.Data.DataSet
            Wine.Common.SQL.FillDataSet(pds, sql, "Competition")
            If pds.Tables(0).Rows.Count > 0 Then
                litCompetitionCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
            Else
                litCompetitionCount.Text = "No Competitions found ..."
            End If

            Return pds


        End Function

        Protected Sub findButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFind.Click
            UpdateGrid(bind:=True)
        End Sub


        Private Sub btnCreateNew_Click(sender As Object, e As EventArgs) Handles btnCreateNew.Click
            Response.Redirect("/Competition/CompAddEdit.aspx?CompetitionID=0")
        End Sub

    End Class
End Namespace