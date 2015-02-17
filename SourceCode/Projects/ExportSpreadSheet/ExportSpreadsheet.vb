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
    End Sub

    Private Sub ExportWineEntries()
        Throw New NotImplementedException
    End Sub

End Module
