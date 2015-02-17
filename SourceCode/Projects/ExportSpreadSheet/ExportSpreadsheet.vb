Imports System.Data.OleDb

Module ExportSpreadsheet

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

    '   I decided to just use sql to pull the data into sql server and copy/paste that into the spreadsheet provided.
    '    select EntryID, ws1.JudgeNum, ws1.Score, ws2.JudgeNum, ws2.Score, ws3.JudgeNum, ws3.Score, AvgScore, MedalColor, WineName
    '  from WineEntry we
    '  inner join WineScoring ws1 on we.WineEntryID=ws1.WineEntryId
    '  inner join WineScoring ws2 on we.WineEntryID=ws2.WineEntryId and ws1.JudgeNum < ws2.JudgeNum
    '  inner join WineScoring ws3 on we.WineEntryID=ws3.WineEntryId and ws2.JudgeNum < ws3.JudgeNum
    'where CompetitionID=8 order by EntryID asc

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

            ExportWineEntries()

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

    Private Sub ExportWineEntries()
        Dim db As New DBEntity.mywinecompetitionEntities(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))

        Dim compRow = (From s In db.Competitions Where s.CompetitionName = "2015 Yearly Competition").FirstOrDefault

        Dim fileName As String = "Wine_Entry-2015.xlsx"

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

        selectFrom = "SELECT * FROM [Wine_Entries$]"
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
                    .WineName = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_P)     ' This is the ingredient column
                    .TableNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_L)
                    .FlightNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_M)
                    .SeqNum = Wine.Common.Validation.ExcelNullHelperInteger(dr, COLUMN_N)
                    .CatNum = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_O)
                    .CategoryName = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_Q)
                    .Vintage = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_R)
                    '.AvgScore = Wine.Common.Validation.ExcelNullHelperDouble(dr, COLUMN_J)   
                    '.MedalColor = Wine.Common.Validation.ExcelNullHelper(dr, COLUMN_K)
                End With
            End If
            row += 1
            Log("Row " & row.ToString & " complete")
        Next

        oleConn.Close()



    End Sub

End Module
