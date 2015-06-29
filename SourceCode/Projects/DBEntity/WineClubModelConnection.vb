Imports System.Data.Entity
Imports System.Data.Objects
Imports System.Data.Entity.Infrastructure


Partial Public Class MywinecompetitionEntities
    Inherits DbContext

    ' ReSharper disable once UnusedParameter.Local
    Public Sub New(connectionString As String)
        MyBase.New(nameOrConnectionString:=Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
    End Sub


End Class
