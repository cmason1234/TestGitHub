Imports System.Data.Entity
Imports System.Data.Objects
Imports System.Data.Entity.Infrastructure


Partial Public Class mywinecompetitionEntities
    Inherits DbContext

    Public Sub New(ConnectionString As String)
        MyBase.New(nameOrConnectionString:=Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
    End Sub


End Class
