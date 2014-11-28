Imports System.Data.OleDb

Module ImportSpreadsheet

    Const COLUMN_A As Integer = 0
    Const COLUMN_B As Integer = 1
    Const COLUMN_C As Integer = 2
    Const COLUMN_D As Integer = 3
    Const COLUMN_E As Integer = 4
    Const COLUMN_F As Integer = 5
    Const COLUMN_G As Integer = 6
    Const COLUMN_H As Integer = 7
    Const COLUMN_I As Integer = 8
    Const COLUMN_J As Integer = 9
    Const COLUMN_K As Integer = 10
    Const COLUMN_L As Integer = 11
    Const COLUMN_M As Integer = 12
    Const COLUMN_N As Integer = 13
    Const COLUMN_O As Integer = 14
    Const COLUMN_P As Integer = 15
    Const COLUMN_Q As Integer = 16
    Const COLUMN_R As Integer = 17
    Const COLUMN_S As Integer = 18
    Const COLUMN_T As Integer = 19
    Const COLUMN_U As Integer = 20
    Const COLUMN_V As Integer = 21
    Const COLUMN_W As Integer = 22
    Const COLUMN_X As Integer = 23
    Const COLUMN_Y As Integer = 24
    Const COLUMN_Z As Integer = 25

    Dim LogFile As System.IO.StreamWriter
    Dim fileName As String = ""

    Sub Main()
        Try

            Dim codeTimer As New Stopwatch()
            codeTimer.Start()

            ' create a log file
            If System.IO.File.Exists(Environment.CurrentDirectory() & "\logs\ImportSpreadsheet.log") = False Then
                LogFile = System.IO.File.CreateText(Environment.CurrentDirectory() & "\logs\ImportSpreadsheet.log")
            Else
                LogFile = System.IO.File.AppendText(Environment.CurrentDirectory() & "\logs\ImportSpreadsheet.log")
            End If
            Log("Started at " & Now.ToShortDateString & " " & Now.ToShortTimeString)

            ImportBudget()

            codeTimer.Stop()
            Log("Elapsed Time To Process Data: " & (codeTimer.ElapsedMilliseconds * 0.001).ToString & " Sec")
            Log("End ...")

        Catch ex As Exception
            'Send a failure email
            Log("Exception Caught - " & ex.Message)
        End Try


        LogFile.Flush()
        LogFile.Close()

    End Sub

    Private Sub Log(ByVal text As String)
        System.Console.Write(text & vbCrLf)
        LogFile.WriteLine(text)
    End Sub

    Private Sub ImportBudget()
        Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

        Dim compRow = (From s In db.Competitions Where s.CompetitionName = "2014 Yearly Competition").FirstOrDefault

        Dim fileName As String = "2014 MVWS Wine Competition Entry Form.xlsx"

        Dim sConnectionString As String = "Provider=Microsoft.ACE.OLEDB.12.0;" &
            "Data Source=" & fileName &
            "; Extended Properties=""Excel 12.0; HDR=NO;"""
        Dim oleConn As New OleDbConnection(sConnectionString)
        oleConn.Open()

        'Dim dtSheets As DataTable =
        '  oleConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
        'Dim listSheet As New List(Of String)
        'Dim drSheet As DataRow

        'For Each drSheet In dtSheets.Rows
        '    listSheet.Add(drSheet("TABLE_NAME").ToString())
        'Next

        ''show sheetname in textbox where multiline is true
        'For Each sheet As String In listSheet
        '    Log(sheet)
        'Next

        Dim selectFrom As String = ""
        Dim fillName As String = ""

        selectFrom = "SELECT * FROM [Wine_Entry_Cat$]"
        fillName = "Input"

        Dim oleCmdSelect As New OleDbCommand(selectFrom, oleConn)
        Dim oleAdapter As New OleDbDataAdapter
        oleAdapter.SelectCommand = oleCmdSelect
        Dim ds As New DataSet
        oleAdapter.Fill(ds, fillName)

        Dim dt As DataTable = ds.Tables(fillName)
        Dim row As Integer = 0
        For Each dr As System.Data.DataRow In dt.Rows
            If row <> 0 Then
                Dim wineEntryRow As DBEntity.WineEntry = New DBEntity.WineEntry()
                With wineEntryRow
                    .EntryID = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_A)
                    .WineName = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_R)
                    .TableNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_N)
                    .FlightNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_O)
                    .SeqNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_P)
                    .CatNum = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_Q)
                    .CategoryName = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_S)
                    .AvgScore = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_L)
                    .MedalColor = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_M)
                End With
                compRow.WineEntries.Add(wineEntryRow)
                Dim wineScore As DBEntity.WineScoring
                For scoreNum As Integer = 1 To 5
                    Dim judgeNum As Integer
                    Dim judgeTotal As Double
                    Select Case scoreNum
                        Case 1
                            judgeNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_B)
                            judgeTotal = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_C)
                        Case 2
                            judgeNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_D)
                            judgeTotal = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_E)
                        Case 3
                            judgeNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_F)
                            judgeTotal = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_G)
                        Case 4
                            judgeNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_H)
                            judgeTotal = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_I)
                        Case 5
                            judgeNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_J)
                            judgeTotal = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_K)
                    End Select
                    If judgeNum <> 0 AndAlso judgeTotal <> 0 Then
                        wineScore = New DBEntity.WineScoring
                        wineScore.EnteredPersonID = 1
                        wineScore.JudgeNum = judgeNum
                        wineScore.JudgeTotal = judgeTotal
                        wineScore.Score = judgeTotal
                        wineEntryRow.WineScorings.Add(wineScore)
                    End If
                Next
                db.SaveChanges()
            End If
            row += 1
            Log("Row " & row.ToString & " complete")
        Next
        db.SaveChanges()
        'previousYearTCTextBox.Value = BudgetNullHelper(dt(tcCurrRow), 4)

        oleConn.Close()

    End Sub

End Module
