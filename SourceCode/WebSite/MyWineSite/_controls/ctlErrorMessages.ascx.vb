
Namespace Wine.Web

    Public Class CtlErrorMessages
        Inherits System.Web.UI.UserControl

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        End Sub

        Public Property Text As String
            Get
                Return messageLabel.Text
            End Get
            Set(ByVal value As String)
                messageLabel.Text = value
            End Set
        End Property

        Public Property MessageClass As String
            Get
                Return msgContainer.Attributes.Item("class")
            End Get
            Set(ByVal value As String)
                msgContainer.Attributes.Item("class") = value
            End Set
        End Property

        Public Sub SetDescription(ByVal description As String)
            messageLabel.Text = description
        End Sub

    End Class

End Namespace