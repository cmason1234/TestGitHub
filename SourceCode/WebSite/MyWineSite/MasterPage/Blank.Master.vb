
Namespace Wine.Web

    Public Class Blank
        Inherits System.Web.UI.MasterPage

        Dim _appTitle As String

        ' ReSharper disable once ConvertToVbAutoProperty
        Public Property AppTitle() As String
            Get
                Return _appTitle
            End Get

            Set(ByVal value As String)
                _appTitle = value
            End Set
        End Property

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            '//Load Title in Application Title Bar
            litAppTitle.Text = "<b>" & AppTitle & "</b>"

        End Sub


        Function AssemblyLastWriteTime(ByVal a As Reflection.Assembly) As DateTime
            Try
                Return System.IO.File.GetLastWriteTime(a.Location)
            Catch ex As Exception
                Return DateTime.MaxValue
            End Try
        End Function

    End Class

End Namespace