Namespace Wine.Web

    Public Class PersonSearch
        Inherits WebMaster

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not IsPostBack Then
                UpdateGrid(True)
            End If
        End Sub

        Private Sub UpdateGrid(bind As Boolean)

            dgGridPerson.DataSource = GetPersonDataSet()
            If bind Then
                dgGridPerson.DataBind()
            End If
            dgGridPerson.Visible = True

        End Sub

        Private Function GetPersonDataSet() As System.Data.DataSet

            Dim addSQL As String = ""

            If tbName.Text.Trim.Length > 0 Then
                Dim lName As String
                If tbName.Text.Trim.IndexOf(" -") > 3 Then
                    lName = tbName.Text.Trim.Substring(0, tbName.Text.Trim.IndexOf(" -"))
                Else
                    lName = tbName.Text.Trim
                End If
                addSQL = addSQL & " and pm.LastName + ', ' + pm.FirstName like " & Wine.Common.SQL.Quote(lName & "%") & " "
            End If

            If tbUserName.Text.Trim.Length > 0 Then
                addSQL = addSQL & " and pm.username like " & Wine.Common.SQL.Quote("%" & tbUserName.Text.Trim & "%") & " "
            End If

            Dim sql As String
            sql = "select  FirstName + ' ' + LastName as FullName, PersonID, UserName  from person pm where 1=1 " &
                        addSQL & "   order by  LastName, FirstName"
            '   

            Dim pds As New System.Data.DataSet
            Wine.Common.SQL.FillDataSet(pds, sql, "Person")
            If pds.Tables(0).Rows.Count > 0 Then

                litPersonCount.Text = "(" & pds.Tables(0).Rows.Count & ")"
            Else
                litPersonCount.Text = "No users found ..."
            End If

            pds.AcceptChanges()

            Return pds

        End Function


        Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
            UpdateGrid(bind:=True)
        End Sub

        Private Sub btnCreateNew_Click(sender As Object, e As EventArgs) Handles btnCreateNew.Click
            Response.Redirect("/AdminTools/PersonAddEdit.aspx?PersonID=0")
        End Sub

    End Class
End Namespace
