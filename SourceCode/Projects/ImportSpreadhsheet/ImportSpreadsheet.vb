Imports System.Data.OleDb

Module ImportSpreadsheet

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

        Dim fileName As String = ""

        Dim sConnectionString As String = "Provider=Microsoft.ACE.OLEDB.12.0;" &
            "Data Source=" & fileName &
            "; Extended Properties=""Excel 12.0; HDR=NO;"""
        Dim oleConn As New OleDbConnection(sConnectionString)
        oleConn.Open()

        Dim selectFrom As String = ""
        Dim fillName As String = ""

        selectFrom = "SELECT * FROM [GDP Budget$A1:F43]"
        fillName = "GDP Budget"

        Dim oleCmdSelect As New OleDbCommand(selectFrom, oleConn)
        Dim oleAdapter As New OleDbDataAdapter
        oleAdapter.SelectCommand = oleCmdSelect
        Dim ds As New DataSet
        oleAdapter.Fill(ds, fillName)

        Dim dt As DataTable = ds.Tables(fillName)

        previousYearTCTextBox.Value = BudgetNullHelper(dt(tcCurrRow), 4)

        oleConn.Close()

    End Sub


    Private Function BudgetNullHelper(ByVal dr As System.Data.DataRow, ByVal colNumber As Integer, Optional returnZero As Boolean = False) As String
        Dim s As String = ""
        If Not IsDBNull(dr.Item(colNumber)) Then
            s = dr.Item(colNumber)
            s = s.Trim
            If s.StartsWith("$") Then
                s = s.Remove(0, 1)
            End If
            If s.EndsWith("%") Then
                s = s.Remove(s.Length - 1)
            End If
        End If
        If returnZero = True AndAlso s.Length = 0 Then
            s = "0"
        End If
        If IsNumeric(s) Then
            Dim d As Decimal
            Decimal.TryParse(s, d)
            s = String.Format("{0:#,###,##0}", Math.Round(d))
        End If
        Return s
    End Function


End Module
