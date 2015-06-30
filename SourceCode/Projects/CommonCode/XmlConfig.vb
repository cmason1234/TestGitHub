Imports System.IO
Imports System.Xml

Namespace Wine.Common

    ''' <summary>
    ''' This class handles all machine dependant configuration items
    ''' This class is a Singleton, therefore it will only exist ONCE for every thread that is using it.
    ''' This design pattern will avoid the disk I/O of reading the XML file every time data is needed.
    ''' XmlConfig requires a file named WineConfig.xml to reside in %SystemDrive%/WineConfiguration/WineConfig.xml
    ''' </summary>
    ''' <remarks></remarks>
    Public NotInheritable Class XmlConfig

        Private Shared _instance As XmlConfig
        Private Shared _configHash As Hashtable
        Private Shared _configError As String
        Public Const ConfigErrStr As String = "CONFIGURATION ERROR: "

        Private Sub New()
            ' This prevents .Net from creating a default Public constructor and also prevents any caller from creating their
            ' own instance of the object. 
        End Sub

        Private Shared Sub InitSingleton()
            '
            ' initialize object if it hasn't already been done
            '
            If _instance Is Nothing Then
                _instance = New XmlConfig
                _configHash = New Hashtable
                Dim systemDrive As String = Environment.GetEnvironmentVariable("SystemDrive")
                Dim configFileLoc As String = systemDrive + "/WineConfiguration/WineConfig.xml"
                If File.Exists(configFileLoc) Then
                    FillConfigHash(configFileLoc)
                Else
                    _configError = ConfigErrStr + "File not found at required config file location of: " + configFileLoc
                End If
            End If
            '
            ' return the initialized instance
            '
            Return
        End Sub

        Private Shared Sub FillConfigHash(configFileLoc As String)
            Using reader As XmlReader = XmlReader.Create(configFileLoc)
                While reader.Read()
                    ' Check for start elements.
                    If reader.IsStartElement() Then
                        If Not reader.Name.Equals("configuration") Then
                            If _configHash.ContainsKey(reader.Name) Then
                                _configError = ConfigErrStr + "Duplicate Key found in WineConfig.xml file. Key Name = " + reader.Name
                            Else
                                Dim key As String = reader.Name
                                reader.Read()
                                _configHash.Add(key, reader.Value)
                            End If
                        End If
                    End If
                End While
            End Using
        End Sub

        Public Shared Function ConfigVal(key As String) As String
            Dim result As String = ""
            initSingleton()
            If Not IsNothing(_configError) Then
                result = _configError
            Else
                If _configHash.ContainsKey(key) Then
                    result = _configHash(key)
                Else
                    result = ConfigErrStr + "ConfigVal for key " + key + " not found in WineConfig.xml file."
                End If
            End If
            Return result
        End Function

        Public Shared Function SetConfigVal(key As String, value As String) As String
            Dim result As String = ""
            initSingleton()
            If Not IsNothing(_configError) Then
                result = _configError
            Else
                If _configHash.ContainsKey(key) Then
                    result = ConfigErrStr + "ConfigVal for key " + key + " already exists in WineConfig.xml file."
                Else
                    _configHash.Add(key, value)
                    result = value
                End If
            End If
            Return result
        End Function

        Public Shared Function SaveExistingKey(key As String, value As String) As String
            Dim result As String = ""
            Dim myXml As New XmlDocument
            Dim systemDrive As String = Environment.GetEnvironmentVariable("SystemDrive")
            Dim configFileLoc As String = systemDrive + "/WineConfiguration/WineConfig.xml"

            myXml.Load(configFileLoc)
            Dim myNode As XmlNode = myXml.SelectSingleNode("/configuration/" + key)
            If Not IsNothing(myNode) Then
                myNode.InnerText = value
                myXml.Save(configFileLoc)
                result = "Success"
            Else
                result = ConfigErrStr + "ConfigVal for key " + key + " not found in WineConfig.xml file."
            End If

            Return result
        End Function

    End Class

End Namespace

