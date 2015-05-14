Imports System.Web.UI.WebControls
Imports System.Text

Namespace Wine.Common

    Public Class Html

        Public Shared Function CleanUrl(ByVal thisStr As String, Optional ByVal keepUrlPath As Boolean = False) As String

            Dim str As New System.Text.StringBuilder

            str.Append(thisStr)
            str.Replace(" ", "-")
            str.Replace("#", "")
            str.Replace("'", "")
            str.Replace("""", "")
            str.Replace(".", "")
            str.Replace(",", "")
            str.Replace("\", "")

            If Not KeepURLPath Then
                str.Replace("/", "")
            Else
                str.Replace("&", "and")
            End If

            str.Replace("@", "")
            str.Replace("~", "")
            str.Replace("^", "")
            str.Replace("&", "")
            str.Replace("%", "")
            str.Replace("$", "")
            str.Replace("?", "")
            str.Replace("*", "")
            str.Replace("!", "")

            str.Replace("(", "-")
            str.Replace(")", "-")
            str.Replace("[", "-")
            str.Replace("]", "-")
            str.Replace("<", "-")
            str.Replace(">", "-")

            Return str.ToString

        End Function


        Public Shared Function ChangeMimeType(ByVal mimeType As String)

            Dim fileNameString As String
            Dim newFileNameString As String
            newFileNameString = ""
            fileNameString = MimeType.Replace("application", "")
            fileNameString = fileNameString.Replace("image", "")
            fileNameString = fileNameString.Replace("text", "")
            fileNameString = fileNameString.Replace("video", "")
            fileNameString = fileNameString.Replace("/", "")
            fileNameString = fileNameString.Replace("pjpeg", "jpeg")
            fileNameString = fileNameString.Replace("msword", "doc")
            fileNameString = fileNameString.Replace("audiompeg", "mp3")
            fileNameString = fileNameString.Replace("x-ms-wmv", "wmv")
            fileNameString = fileNameString.ToLower
            If fileNameString = "html" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "jpeg" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "tiff" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "pdf" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "gif" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "doc" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "mp3" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "wmv" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "quicktime" Then
                newFileNameString = "icon_" + fileNameString + ".gif"
            End If
            If fileNameString = "png" Then
                newFileNameString = "icon_png.gif"
            End If
            If fileNameString = "postscript" Then
                newFileNameString = "icon_eps.gif"
            End If
            If newFileNameString = "" Then
                newFileNameString = "icon_unknown.gif"
            End If
            Return newFileNameString
        End Function


        Public Shared Function StripHtml(ByVal strHtml)
            'Strips the HTML tags from strHTML using split and join

            'Ensure that strHTML contains something
            If Len(strHTML) = 0 Then
                stripHTML = strHTML
                Exit Function
            End If

            Dim arysplit, i, j, strOutput

            arysplit = Split(strHTML, "<")

            'Assuming strHTML is nonempty, we want to start iterating
            'from the 2nd array postition
            If Len(arysplit(0)) > 0 Then j = 1 Else j = 0

            'Loop through each instance of the array
            For i = j To UBound(arysplit)
                'Do we find a matching > sign?
                If InStr(arysplit(i), ">") Then
                    'If so, snip out all the text between the start of the string
                    'and the > sign
                    arysplit(i) = Mid(arysplit(i), InStr(arysplit(i), ">") + 1)
                Else
                    'Ah, the < was was nonmatching
                    arysplit(i) = " "
                End If
            Next

            'Rejoin the array into a single string
            strOutput = Join(arysplit, "")

            'Snip out the first <
            strOutput = Mid(strOutput, 2 - j)

            'Convert < and > to &lt; and &gt;
            strOutput = Replace(strOutput, ">", "&gt;")
            strOutput = Replace(strOutput, "<", "&lt;")

            stripHTML = strOutput
        End Function


        Public Shared Function ConvertBytes(ByVal byteCount)
            Dim convertedBytes As String
            convertedBytes = byteCount
            If Not byteCount Is Nothing Then
                convertedBytes = (Math.Round((byteCount / 1024), 2)).ToString
            End If
            Return convertedBytes
        End Function


        Public Shared Function ConvertBytesMb(ByVal byteCount)
            Dim convertedBytes As String
            convertedBytes = byteCount
            If Not byteCount Is Nothing Then
                convertedBytes = (Math.Round(((byteCount / 1024) / 1024), 2)).ToString
            End If
            Return convertedBytes
        End Function

        Public Shared Sub SetCheckBox(ByRef cb As CheckBox, ByVal invalue As Object)
            If Not IsDBNull(invalue) Then
                If invalue Then
                    cb.Checked = True
                End If
            End If
        End Sub


        Public Shared Function CanSetDropDownValue(ByVal ddl As DropDownList, ByVal guidValue As Guid?) As Boolean
            Dim status As Boolean = False
            If Not IsNothing(guidValue) Then
                For Each item As ListItem In ddl.Items
                    If item.Value = guidValue.ToString Then status = True
                Next
            End If
            Return status
        End Function


        Public Shared Function CanSetDropDownValue(ByVal ddl As DropDownList, ByVal stringValue As String) As Boolean
            Dim status As Boolean = False

            For Each item As ListItem In ddl.Items
                If item.Value = stringValue Then status = True
            Next

            Return status

        End Function


        Public Shared Function CanSetDropDownValue(ByVal ddl As DropDownList, ByVal integerValue As Integer) As Boolean
            Dim status As Boolean = False

            For Each item As ListItem In ddl.Items
                If item.Value = integerValue Then status = True
            Next

            Return status

        End Function


        Public Shared Function CanSetDropDownText(ByVal ddl As DropDownList, ByVal textValue As String) As Boolean
            Dim status As Boolean = False

            For Each item As ListItem In ddl.Items
                If item.Text = textValue Then
                    status = True
                    Exit For
                End If
            Next

            Return status

        End Function

        Public Shared Sub FillCheckBoxList(ByVal cbl As CheckBoxList, _
                            ByVal ds As System.Data.DataSet, _
                            ByVal tf As String, _
                            ByVal vf As String)

            If ds.Tables(0).Rows.Count = 0 Then
                cbl.Visible = False
            Else
                cbl.DataSource = ds
                cbl.DataTextField = tf
                cbl.DataValueField = vf
                cbl.DataBind()
            End If

        End Sub


        Public Shared Sub FillCheckBoxList(ByVal cbl As CheckBoxList, _
                            ByVal dv As System.Data.DataView, _
                            ByVal tf As String, _
                            ByVal vf As String)

            If dv.Table.Rows.Count = 0 Then
                cbl.Visible = False
            Else
                cbl.DataSource = dv
                cbl.DataTextField = tf
                cbl.DataValueField = vf
                cbl.DataBind()
            End If

        End Sub


        Public Shared Sub FillRadioButtonList(ByVal rbl As RadioButtonList, _
                            ByVal ds As System.Data.DataSet, _
                            ByVal tf As String, _
                            ByVal vf As String)

            If ds.Tables(0).Rows.Count = 0 Then
                rbl.Visible = False
            Else
                rbl.DataSource = ds
                rbl.DataTextField = tf
                rbl.DataValueField = vf
                rbl.DataBind()
            End If

        End Sub


        Public Shared Sub FillDropDownList(ByVal ddl As DropDownList, ByVal dt As System.Data.DataTable, ByVal textFieldColumn As String,
                                           ByVal valueFieldColumn As String, Optional ByVal emptyRow As Boolean = False, Optional ByVal addValueText As Boolean = False)
            If dt.Rows.Count = 0 Then
                ddl.Visible = False
            Else
                Dim vt As String = "System.String"
                If Not IsNothing(dt.Rows(0)(valueFieldColumn)) Then
                    vt = dt.Rows(0)(valueFieldColumn).GetType.ToString()
                End If

                If emptyRow Then
                    Dim r As System.Data.DataRow
                    r = dt.NewRow()
                    dt.Rows.InsertAt(r, 0)
                    dt.Rows(0)(textFieldColumn) = "** Choose"
                    If Not textFieldColumn.Equals(valueFieldColumn) Then
                        Select Case vt
                            Case "System.Guid"
                                dt.Rows(0)(valueFieldColumn) = Guid.Empty
                            Case "System.Integer", "System.Int32", "System.Int16", "System.Int64"
                                dt.Rows(0)(valueFieldColumn) = 0
                            Case "System.String", "System.DBNull"
                                dt.Rows(0)(valueFieldColumn) = ""
                            Case Else
                        End Select
                    End If
                End If

                ddl.DataSource = dt
                ddl.DataTextField = textFieldColumn
                ddl.DataValueField = valueFieldColumn
                ddl.DataBind()

                If addValueText Then
                    For Each item As ListItem In ddl.Items
                        Select Case vt
                            Case "System.Guid"
                                If Not item.Value.Equals(Guid.Empty) Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                            Case "System.Integer"
                                If Not item.Value.Equals("0") Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                            Case "System.String"
                                If Not item.Value.Equals("") Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                        End Select
                    Next
                End If
            End If


        End Sub

        ' TODO - This function should be removed and all calls to it replaced by calling the DataTable version, which needs to have the logic of this function
        Public Shared Sub FillDropDownList(ByVal ddl As DropDownList, _
                                ByVal ds As System.Data.DataSet, _
                                ByVal tf As String, _
                                ByVal vf As String, _
                                Optional ByVal emptyRow As Boolean = False, _
                                Optional ByVal addValueText As Boolean = False)

            FillDropDownList(ddl, ds.Tables(0), tf, vf, emptyRow)

        End Sub


        'Public Shared Sub FillDropDownList(ByVal ddl As DropDownList, ByVal ds As System.Data.DataSet, ByVal tf As String, ByVal vf As String)
        '    ddl.DataSource = ds
        '    ddl.DataTextField = tf
        '    ddl.DataValueField = vf
        '    ddl.DataBind()
        'End Sub

        ' TODO - Find all places this is used and should be replaced by doing the concatination in the SQL call.
        Public Shared Sub FillDropDownList(ByVal ddl As DropDownList, ByVal ds As Data.DataSet, ByVal tf As List(Of String), ByVal vf As String, Optional ByVal emptyRow As Boolean = False)
            If ds.Tables(0).Rows.Count = 0 Then
                ddl.Visible = False
            Else
                ddl.Visible = True
                ddl.Items.Clear()

                If emptyRow Then
                    ddl.Items.Add(New ListItem("** Choose", ""))
                End If

                For Each row As Data.DataRow In ds.Tables(0).Rows
                    Dim textField As String = ""
                    For Each field As String In tf
                        textField += row.Item(field) & " - "
                    Next
                    textField = textField.Substring(0, textField.Length - 3)
                    ddl.Items.Add(New ListItem(textField, row.Item(vf).ToString))
                Next
            End If
        End Sub


        Public Shared Sub FillDropDownListV2(ByVal ddl As DropDownList, ByVal ds As Data.DataSet, ByVal tf As List(Of String), ByVal vf As String, Optional ByVal emptyRow As Boolean = False)
            ddl.Visible = True
            ddl.Items.Clear()

            If emptyRow Then
                ddl.Items.Add(New ListItem("** Choose", ""))
            End If

            For Each row As Data.DataRow In ds.Tables(0).Rows
                Dim textField As String = ""
                For Each field As String In tf
                    textField += row.Item(field) & " - "
                Next
                textField = textField.Substring(0, textField.Length - 3)
                ddl.Items.Add(New ListItem(textField, row.Item(vf).ToString))
            Next
        End Sub

        Public Shared Sub FillDropDownListV2(ByVal ddl As DropDownList, ByVal dt As System.Data.DataTable, ByVal textFieldColumn As String,
                                           ByVal valueFieldColumn As String, Optional ByVal emptyRow As Boolean = False, Optional ByVal addValueText As Boolean = False)
            If dt.Rows.Count <> 0 Then
                Dim vt As String = "System.String"
                If Not IsNothing(dt.Rows(0)(valueFieldColumn)) Then
                    vt = dt.Rows(0)(valueFieldColumn).GetType.ToString()
                End If

                If emptyRow Then
                    Dim r As System.Data.DataRow
                    r = dt.NewRow()
                    dt.Rows.InsertAt(r, 0)
                    dt.Rows(0)(textFieldColumn) = "** Choose"
                    If Not textFieldColumn.Equals(valueFieldColumn) Then
                        Select Case vt
                            Case "System.Guid"
                                dt.Rows(0)(valueFieldColumn) = Guid.Empty
                            Case "System.Integer", "System.Int32", "System.Int16", "System.Int64"
                                dt.Rows(0)(valueFieldColumn) = 0
                            Case "System.String", "System.DBNull"
                                dt.Rows(0)(valueFieldColumn) = ""
                            Case Else
                        End Select
                    End If
                End If

                ddl.DataSource = dt
                ddl.DataTextField = textFieldColumn
                ddl.DataValueField = valueFieldColumn
                ddl.DataBind()

                If addValueText Then
                    For Each item As ListItem In ddl.Items
                        Select Case vt
                            Case "System.Guid"
                                If Not item.Value.Equals(Guid.Empty) Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                            Case "System.Integer"
                                If Not item.Value.Equals("0") Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                            Case "System.String"
                                If Not item.Value.Equals("") Then
                                    item.Text = item.Text & " (" & item.Value & ")"
                                End If
                        End Select
                    Next
                End If
            Else
                If emptyRow Then
                    ddl.Items.Add(New ListItem("** Choose", ""))
                End If
            End If
        End Sub

        Public Shared Sub FillDropDownListV2(ByVal ddl As DropDownList, _
                                ByVal ds As System.Data.DataSet, _
                                ByVal tf As String, _
                                ByVal vf As String, _
                                Optional ByVal emptyRow As Boolean = False, _
                                Optional ByVal addValueText As Boolean = False)

            FillDropDownListV2(ddl, ds.Tables(0), tf, vf, emptyRow, addValueText)

        End Sub



        Public Shared Function GetColumnIndexByHeaderText(gridView As GridView, ByVal headerText As String) As Integer
            Dim result As Integer = -1

            For Each column As DataControlField In gridView.Columns
                If column.HeaderText = headerText Then
                    result = gridView.Columns.IndexOf(column)
                    Exit For
                End If
            Next

            Return result
        End Function

    End Class

End Namespace


