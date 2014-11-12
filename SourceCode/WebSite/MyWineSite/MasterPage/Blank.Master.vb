
Namespace Rheem.Web.Partners

    Public Class Blank
        Inherits System.Web.UI.MasterPage


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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