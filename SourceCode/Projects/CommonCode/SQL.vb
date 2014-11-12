Imports System.Data.SqlClient
Imports System.Data.OleDb

Namespace Wine.Common

    Public Class SQL

        Public Shared Function ConnStrFromEDMXConnStr(edmxConnStr As String) As String

            Dim connStr As String = ""

            Dim quoteStart As Integer = edmxConnStr.IndexOf("""")
            Dim quoteEnd As Integer = edmxConnStr.IndexOf("""", quoteStart + 1)

            Dim dsConnStr As String = edmxConnStr.Substring(quoteStart + 1, quoteEnd - quoteStart - 1)
            dsConnStr = dsConnStr.Replace(";user id", ";uid").Replace(";password", ";pwd")

            Return dsConnStr

        End Function

        Private Shared Function SQLSafe(ByVal instr As String) As String
            SQLSafe = instr.Replace("'", "''")
        End Function

        Public Shared Function Quote(ByVal inStr As String, Optional ByVal commaAfter As Boolean = False) As String
            Dim strBack As String = ""
            If IsNothing(inStr) Then
                If commaAfter Then
                    strBack = " null, "
                Else
                    strBack = " null "
                End If
            ElseIf commaAfter Then
                strBack = "'" & SQLSafe(inStr).Trim & "',"
            Else
                strBack = "'" & SQLSafe(inStr).Trim & "'"
            End If

            Return strBack
        End Function

        Public Shared Function Quote(ByVal inGuid As Guid, Optional ByVal commaAfter As Boolean = False) As String
            Quote = Quote(inGuid.ToString, commaAfter)
        End Function

        Public Shared Function Quote(ByVal inGuid As Guid?, Optional ByVal commaAfter As Boolean = False) As String
            Dim strBack As String = ""

            If IsNothing(inGuid) OrElse inGuid.Equals(Guid.Empty) Then
                If commaAfter Then
                    strBack = " null, "
                Else
                    strBack = " null "
                End If
            Else
                strBack = Quote(inGuid.ToString, commaAfter)
            End If

            Return strBack
        End Function

        Public Shared Function Quote(ByVal inInt As Integer, Optional ByVal commaAfter As Boolean = False) As String
            Return Quote(inInt.ToString, commaAfter)
        End Function

        Public Shared Function Quote(ByVal indouble As Double, Optional ByVal commaAfter As Boolean = False) As String
            Return Quote(indouble.ToString, commaAfter)
        End Function

        Public Shared Function Quote(ByVal inBool As Boolean, Optional ByVal commaAfter As Boolean = False) As String
            Dim strBack = ""
            If inBool Then
                strBack = Quote("1", commaAfter)
            Else
                strBack = Quote("0", commaAfter)
            End If

            Return strBack
        End Function

        Public Shared Function QuoteDate(ByVal inStr As String, Optional ByVal commaAfter As Boolean = False) As String
            Dim strBack = ""
            If inStr.Trim.Length = 0 Then
                If commaAfter Then
                    strBack = " null, "
                Else
                    strBack = " null "
                End If
            Else
                strBack = Quote(inStr, commaAfter)
            End If

            Return strBack
        End Function

        Public Shared Sub FillDataSet(ByRef ds As System.Data.DataSet, ByVal inSql As String, Optional ByVal tableName As String = "temp")
            ds.Tables.Add(New DataTable(tableName))

            Dim myConnection As New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))
            Dim sqlCmd As New SqlCommand(inSql, myConnection)
            sqlCmd.CommandTimeout = 0
            sqlCmd.Connection.Open()
            Dim sda As New SqlDataAdapter(sqlCmd)
            sda.Fill(ds.Tables(tableName))
            sqlCmd.Connection.Close()

            'ds.Tables(0).TableName = tableName
        End Sub

        ' Migrate to this as this uses sql params
        Public Shared Sub FillDataSet(ByRef ds As System.Data.DataSet, ByVal inSql As String, ByVal tableName As String, ByRef params As ArrayList)

            Dim myConnection As New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))
            Dim sqlCmd As New SqlCommand(inSql, myConnection)
            For Each sqlParam As SqlParameter In params
                sqlCmd.Parameters.Add(sqlParam)
            Next
            sqlCmd.CommandTimeout = 0
            sqlCmd.Connection.Open()
            Dim sda As New SqlDataAdapter(sqlCmd)
            sda.Fill(ds)
            sqlCmd.Parameters.Clear()
            sqlCmd.Connection.Close()

            ds.Tables(0).TableName = tableName
        End Sub


        Public Shared Sub ExecuteSQLCommand(ByVal inSql As String, Optional logException As Boolean = True)
            Try
                Dim myConnection As New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))
                Dim myCommand As New SqlCommand(inSql, myConnection)
                myCommand.CommandTimeout = 0
                myCommand.CommandType = Data.CommandType.Text
                myCommand.Connection.Open()
                myCommand.ExecuteNonQuery()
                myCommand.Connection.Close()
            Catch ex As Exception
                ' put a row into the exception log
                If logException Then
                    Dim sqlStr As String = "INSERT INTO ExceptionLog (ExceptionLogID, PersonID, ErrDateTime, FatalBit, ErrPage, ErrFirstLineNumber, ErrMessage) values (NEWID(), 'D02FE02A-AADD-40DC-8C43-76F772A712D8', GETDATE(), 1, 'SEE DETAILS', 'SEE DETAILS',"
                    inSql = "ERROR ExecuteSQLCommand where inSql = " + inSql
                    sqlStr += Wine.Common.SQL.Quote(inSql) + ")"
                    ExecuteSQLCommand(inSql:=sqlStr, logException:=False)
                    Throw ex
                End If
            End Try

        End Sub

        Public Shared Function GetSingleValue(ByVal inSql As String) As String
            Dim v As String = ""
            Dim ds As New System.Data.DataSet

            FillDataSet(ds, inSql, "temp")
            Try
                If ds.Tables(0).Rows.Count = 0 Then
                    v = ""
                ElseIf Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = CStr(ds.Tables(0).Rows(0)(0))
                Else
                    v = ""
                End If
            Catch ex As Exception
                v = ""
            End Try

            GetSingleValue = v
        End Function

        Public Shared Function GetSingleIntegerValue(ByVal inSql As String) As Integer
            Dim v As Integer = 0
            Dim ds As New System.Data.DataSet

            FillDataSet(ds, inSql, "temp")

            If ds.Tables(0).Rows.Count > 0 Then

                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = CInt(ds.Tables(0).Rows(0)(0))
                End If

            End If
            GetSingleIntegerValue = v
        End Function

        Public Shared Function GetSingleGUIDValue(ByVal inSql As String) As Guid
            Dim v As Guid = Guid.Empty
            Dim ds As New System.Data.DataSet

            FillDataSet(ds, inSql, "temp")
            If ds.Tables(0).Rows.Count > 0 Then

                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = ds.Tables(0).Rows(0)(0)
                End If
            End If
            GetSingleGUIDValue = v
        End Function

        Public Shared Function GetSingleBooleanValue(ByVal inSql As String) As Boolean
            Dim v As Boolean = False
            Dim ds As New System.Data.DataSet

            FillDataSet(ds, inSql, "temp")
            If ds.Tables(0).Rows.Count > 0 Then

                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = ds.Tables(0).Rows(0)(0)
                End If
            End If
            GetSingleBooleanValue = v
        End Function

        Public Shared Function GetSingleFloatValue(ByVal inSql As String) As Double
            Dim v As Double = 0.0
            Dim ds As New System.Data.DataSet

            Wine.Common.SQL.FillDataSet(ds, inSql, "temp")
            If ds.Tables(0).Rows.Count > 0 Then
                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = ds.Tables(0).Rows(0)(0)
                End If
            End If
            GetSingleFloatValue = v
        End Function

        Public Shared Function GetSingleFloatValue(ByVal inSql As String, ByRef params As ArrayList) As Double
            Dim v As Double = 0.0
            Dim ds As New System.Data.DataSet

            Wine.Common.SQL.FillDataSet(ds, inSql, "temp", params)
            If ds.Tables(0).Rows.Count > 0 Then
                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = ds.Tables(0).Rows(0)(0)
                End If
            End If
            GetSingleFloatValue = v
        End Function

        Public Shared Function UniqueField(ByVal dbColumn As String, ByVal dbValue As String, ByVal dbName As String, ByVal tableName As String, Optional ByVal additionalWhereClause As String = "") As Boolean
            Dim bUnique As Boolean = False
            Dim SQL As String = "select  count ( distinct " & dbColumn & " ) c from " & dbName & ".." & tableName & " where " & dbColumn & "=" & Quote(dbValue) & additionalWhereClause
            If GetSingleIntegerValue(SQL) = 0 Then
                bUnique = True
            End If
            Return bUnique
        End Function


#Region "AddParameter"

        Public Shared Function AddParameter(ByRef cmd As SqlCommand, ByVal name As String, ByVal value As Object, Optional ByVal addComma As Boolean = False) As String
            If Not cmd.Parameters.Contains(name) Then
                Dim param As SqlParameter = New SqlParameter
                param.ParameterName = name
                param.Value = value
                cmd.Parameters.Add(param)
            End If

            If addComma Then
                Return "@" & name & ", "
            Else
                Return "@" & name
            End If
        End Function

#End Region

#Region "GetSingleValue"

        Public Shared Function GetSingleValue(ByVal cmd As SqlCommand) As String
            Dim v As String = String.Empty
            Dim ds As System.Data.DataSet = FillDataSet(cmd)

            Try
                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = CStr(ds.Tables(0).Rows(0)(0))
                End If
            Catch ex As Exception
            End Try

            GetSingleValue = v
        End Function

#End Region

#Region "FillDataSet"

        Public Shared Function FillDataSet(ByVal inSql As String, Optional ByVal tableName As String = "temp") As DataSet
            Dim ds As DataSet = New DataSet(tableName)

            Dim myConnection As New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))
            Dim sqlCmd As New SqlCommand(inSql, myConnection)
            sqlCmd.CommandTimeout = 0
            sqlCmd.Connection.Open()
            Dim sda As New SqlDataAdapter(sqlCmd)
            sda.Fill(ds)
            sqlCmd.Connection.Close()

            ds.Tables(0).TableName = tableName

            Return ds
        End Function

        Public Shared Function FillDataSet(ByRef sqlCommand As SqlCommand, Optional ByVal tableName As String = "temp") As DataSet
            Dim ds As DataSet = New DataSet(tableName)

            sqlCommand.Connection = New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))
            sqlCommand.CommandTimeout = 0
            sqlCommand.Connection.Open()

            Dim sda As New SqlDataAdapter(sqlCommand)
            sda.Fill(ds)
            sqlCommand.Connection.Close()

            Return ds
        End Function

        Public Shared Function FillDataSetWithConnection(ByVal inSql As String, Optional ByVal tableName As String = "temp", Optional ByVal connection As String = Nothing) As DataSet
            Dim ds As DataSet = New DataSet(tableName)

            If IsNothing(connection) Then
                connection = ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
            End If

            Dim myConnection As New SqlConnection(connection)
            Dim sqlCmd As New SqlCommand(inSql, myConnection)
            sqlCmd.CommandTimeout = 0
            sqlCmd.Connection.Open()
            Dim sda As New SqlDataAdapter(sqlCmd)
            sda.Fill(ds)
            sqlCmd.Connection.Close()

            ds.Tables(0).TableName = tableName

            Return ds
        End Function



        Public Shared Sub ExecuteSQLCommandWithConnection(ByVal inSql As String, Optional ByVal connection As String = Nothing, Optional logException As Boolean = True)
            Try
                If IsNothing(connection) Then
                    connection = ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString"))
                End If
                Dim myConnection As New SqlConnection(connection)
                Dim myCommand As New SqlCommand(inSql, myConnection)
                myCommand.CommandTimeout = 0
                myCommand.CommandType = Data.CommandType.Text
                myCommand.Connection.Open()
                myCommand.ExecuteNonQuery()
                myCommand.Connection.Close()
            Catch ex As Exception
                ' put a row into the exception log
                If logException Then
                    Dim sqlStr As String = "INSERT INTO ExceptionLog (ExceptionLogID, PersonID, ErrDateTime, FatalBit, ErrPage, ErrFirstLineNumber, ErrMessage) values (NEWID(), 'D02FE02A-AADD-40DC-8C43-76F772A712D8', GETDATE(), 1, 'SEE DETAILS', 'SEE DETAILS',"
                    inSql = "ERROR ExecuteSQLCommand where inSql = " + inSql
                    sqlStr += Wine.Common.SQL.Quote(inSql) + ")"
                    ExecuteSQLCommand(inSql:=sqlStr, logException:=False)
                    Throw ex
                End If
            End Try

        End Sub


        Public Shared Function GetSingleIntegerValueWithConnection(ByVal inSql As String, Optional ByVal connection As String = Nothing) As Integer
            Dim v As Integer = 0
            Dim ds As System.Data.DataSet

            ds = FillDataSetWithConnection(inSql, "temp", connection)

            If ds.Tables(0).Rows.Count > 0 Then

                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    v = CInt(ds.Tables(0).Rows(0)(0))
                End If

            End If
            Return v
        End Function



#End Region

#Region "ExecuteSQLCommand"

        Public Shared Sub ExecuteSQLCommand(ByVal inSql As SqlCommand)
            Dim myConnection As New SqlConnection(ConnStrFromEDMXConnStr(Wine.Common.XmlConfig.ConfigVal("WineCompetition_ConnectionString")))

            inSql.Connection = myConnection
            inSql.CommandTimeout = 0
            inSql.CommandType = CommandType.Text
            inSql.Connection.Open()
            inSql.ExecuteNonQuery()
            inSql.Connection.Close()
        End Sub

#End Region

#Region "GetBooleanValue"

        Public Shared Function GetSingleBooleanValue(ByVal inSql As SqlCommand) As Boolean
            GetSingleBooleanValue = False

            Dim ds As System.Data.DataSet
            ds = FillDataSet(inSql)

            If ds.Tables(0).Rows.Count > 0 Then
                If Not IsDBNull(ds.Tables(0).Rows(0)(0)) Then
                    GetSingleBooleanValue = CBool(ds.Tables(0).Rows(0)(0))
                End If
            End If
        End Function

#End Region

        Public Shared Function FillDataSetFromFile(ByVal fname As String) As DataSet
            Dim sConnectionString As String = "Provider=Microsoft.Jet.OLEDB.4.0;Extended Properties=Text;Data Source=c:\"
            Dim cn As New OleDbConnection(sConnectionString)

            cn.Open()

            Dim objCmdSelect As New OleDbCommand("SELECT * FROM " + fname, cn)
            Dim objAdapter1 As New OleDbDataAdapter
            objAdapter1.SelectCommand = objCmdSelect
            Dim ds1 As New DataSet
            objAdapter1.Fill(ds1, "HomeDepotImport")
            cn.Close()

            Return ds1
        End Function


    End Class

End Namespace

