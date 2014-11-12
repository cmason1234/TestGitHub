Namespace Wine.Common

    Public Class PasswordEncryption
        Public Sub New()
            MyBase.New()
        End Sub

        Private Function Crypt(key As String, src As String) As String
            Dim str1 As String = ""
            Dim startIndex1 As Integer = 0
            Dim num2 As Integer = src.Length - 1
            Dim startIndex2 As Integer = 0
            While startIndex2 <= num2
                Dim num3 As Integer = Strings.Asc(src.Substring(startIndex2, 1))
                Dim str2 As String = Conversion.Hex(num3 Xor Strings.Asc(key.Substring(startIndex1, 1)))
                str1 += str2
                If startIndex1 < key.Length - 1 Then
                    startIndex1 += 1
                Else
                    startIndex1 = 0
                End If
                startIndex2 += 1

            End While
            Return str1
        End Function

        Public Function CryptPassword(ByRef seed As String, ByVal pass As String) As String
            'Dim guid As Guid
            If (pass.Length = 0) Then
                Return "**BOGUS**"
            End If
            If (seed.Length = 0) Then
                seed = (Guid.NewGuid()).ToString()
            End If
            Dim str1 As String = Me.Crypt(Me.SystemSeed(), seed)
            Dim str2 As String = Me.Crypt(pass.Trim(), str1)
            If (str2.Length > 50) Then
                str2 = str2.Substring(0, 50)
            End If
            Return str2
        End Function

        Protected Overridable Function SystemSeed() As String
            Return "kitty92"
        End Function

        Public Function ValidatePassword(ByVal cleartxt As String, ByVal encrypted As String, ByVal key As String) As Boolean
            Dim brts As Boolean = False
            If Me.CryptPassword(key, cleartxt) = encrypted.Trim() Then
                brts = True
            End If
            Return brts
        End Function
    End Class


End Namespace