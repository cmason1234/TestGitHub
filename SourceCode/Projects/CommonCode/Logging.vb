
Namespace Wine.Common

    Public Class Logging

        Public Sub WriteToEventLog(ByVal entry As String)

            '//go to registry editor (regedit), 
            '//locate key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application
            '//and create a new key with the source name "Wine Competition V1"

            Dim appName As String = "Wine Competition V1"
            Dim eventType As EventLogEntryType = EventLogEntryType.Error
            Dim logName = "Application"

            Dim objEventLog As New EventLog()

            Try
                'Register the App as an Event Source
                If Not EventLog.SourceExists(appName) Then
                    EventLog.CreateEventSource(appName, logName)
                End If

                objEventLog.Source = appName

                'WriteEntry is overloaded; this is one
                'of 10 ways to call it
                objEventLog.WriteEntry(Entry, eventType)

                '//Use it like so:
                'Dim objLog As New Rheem.Common.Logging
                'objLog.WriteToEventLog("text you want added to event viewer")



            Catch ex As Exception
                '//Do Nothing
            End Try


        End Sub

    End Class

End Namespace