Namespace Wine.Common

    Public Class SqlFunctions

        Public Shared Function SelectDistinct(ByVal tableName As String, _
                                       ByVal sourceTable As DataTable, _
                                       ByVal fieldName As String) As DataTable
            Dim dt As New DataTable(TableName)
            dt.Columns.Add(FieldName, SourceTable.Columns(FieldName).DataType)
            Dim dr As DataRow
            Dim lastValue As Object = Nothing
            For Each dr In SourceTable.Select("", FieldName)
                If LastValue Is Nothing OrElse Not ColumnEqual(LastValue, dr(FieldName)) Then
                    LastValue = dr(FieldName)
                    dt.Rows.Add(New Object() {LastValue})
                End If
            Next
            Return dt
        End Function

        Private Shared Function ColumnEqual(ByVal a As Object, ByVal b As Object) As Boolean
            '
            ' Compares two values to determine if they are equal. Also compares DBNULL.Value.
            '
            ' NOTE: If your DataTable contains object fields, you must extend this
            ' function to handle the fields in a meaningful way if you intend to group on them.
            '
            If A Is DBNull.Value And B Is DBNull.Value Then Return True ' Both are DBNull.Value.
            If A Is DBNull.Value Or B Is DBNull.Value Then Return False ' Only one is DBNull.Value.
            Return A = B                                                ' Value type standard comparison
        End Function

    End Class

End Namespace

