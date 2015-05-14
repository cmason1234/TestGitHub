Imports System.Text.RegularExpressions

Namespace Wine.Common

    Public Class Validation

        Public Sub New()
        End Sub

        Public Shared Function ValidZipCode(ByVal zipCode As String) As Boolean
            Dim result As Boolean = False
            Dim pattern As String = "(^\d{5}$)|(^\d{5}-\d{4}$)"

            Dim zipCodeMatch As Match = Regex.Match(zipCode, pattern)
            If zipCodeMatch.Success Then
                result = True
            End If

            Return result
        End Function

        Public Shared Function ValidPhoneNumber(ByVal phoneNumber As String) As Boolean
            Dim result As Boolean = False
            Dim pattern As String = "^(1?(-?\d{3})-?)?(\d{3})(-?\d{4})$"

            Dim phoneNumberMatch As Match = Regex.Match(phoneNumber, pattern)
            If phoneNumberMatch.Success Then
                result = True
            End If

            Return result
        End Function

        Public Shared Function ValidEmailAddress(ByVal emailAddress As String) As Boolean

            'Dim pattern As String = "^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*\.[a-zA-Z0-9][a-zA-Z\.]*[a-zA-Z]$"
            Dim pattern As String = "^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$"

            Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
            If emailAddressMatch.Success Then
                ValidEmailAddress = True
            Else
                ValidEmailAddress = False
            End If

        End Function

        Public Shared Function ValidState(ByVal state As String, ByVal country As String) As Boolean
            Dim result = False
            Dim trimmedState As String = state.Trim.ToUpper
            Dim trimmedCountry As String = country.Trim.ToUpper

            If trimmedCountry = "USA" Then
                Select Case trimmedState
                    Case "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN"
                        result = True
                    Case "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM"
                        result = True
                    Case "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"
                        result = True
                End Select
            ElseIf trimmedCountry = "CANADA" Then
                Select Case trimmedState
                    Case "AB", "BC", "MB", "NB", "NL", "NS", "ON", "PE", "QC", "SK"
                        result = True
                End Select
            End If

            Return result
        End Function

        Public Shared Function ReturnDate(ByVal thisDate As DateTime) As Object
            If thisDate.ToString = "1/1/0001 12:00:00 AM" Then
                Return DBNull.Value
            Else
                Return thisDate
            End If
        End Function

        Public Shared Function NothingCheck(ByVal test As Object) As String
            If IsNothing(test) Then
                Return ("")
            Else
                Return test.ToString()
            End If
        End Function

        Public Shared Function NullCheck(ByVal test As Object) As String
            If IsDBNull(test) Then
                Return ("")
            Else
                Return CStr(test)
            End If
        End Function

        Public Shared Function NullDoubleCheck(ByVal test As Double) As Double
            If IsNothing(test) Then
                Return (0.0)
            Else
                Return CStr(test)
            End If
        End Function

        Public Shared Function NullCheckObj(ByVal test As Object) As Object
            If IsDBNull(test) Then
                Return Nothing
            Else
                Return test
            End If
        End Function

        Public Shared Function NullHelper(ByVal dr As Data.DataRow, ByVal colName As String) As String
            Dim s As String = " "
            If Not IsDBNull(dr(colName)) Then
                s = dr(colName)
            End If
            NullHelper = s
        End Function


        Public Shared Function NullGuidHelper(ByVal dr As Data.DataRow, ByVal colName As String) As Guid
            Dim g As Guid = Guid.Empty
            If Not IsDBNull(dr(colName)) Then
                g = dr(colName)
            End If
            NullGuidHelper = g
        End Function


        Public Shared Function NullHelperInteger(ByVal dr As Data.DataRow, ByVal colName As String) As Integer
            Dim r As Integer = 0
            If Not IsDBNull(dr(colName)) Then
                r = dr(colName)
            End If
            NullHelperInteger = r
        End Function

        Public Shared Function NullHelperBit(ByVal dr As Data.DataRow, ByVal colName As String) As Boolean
            Dim b As Boolean = False
            If Not IsDBNull(dr(colName)) Then
                b = dr(colName)
            End If
            Return b
        End Function

        Public Shared Function NullHelperDouble(ByVal dr As Data.DataRow, ByVal colName As String) As Double
            Dim d As Double = 0
            If Not IsDBNull(dr(colName)) Then
                d = dr(colName)
            End If
            NullHelperDouble = d
        End Function

        Public Shared Function NullStringHelper(ByVal s As String) As Boolean
            Dim bNull As Boolean = False
            If s Is Nothing Then
                bNull = True
            Else
                If s.Trim.Length = 0 Then
                    bNull = True
                End If
            End If
            NullStringHelper = bNull
        End Function

        Public Shared Function NullBooleanHelper(ByVal s As String) As Boolean
            Dim bNull As Boolean = False
            If s Is Nothing Then
                bNull = False
            Else
                If Not Boolean.TryParse(s, bNull) Then
                    bNull = False
                End If
            End If
            Return bNull
        End Function

        Public Shared Function ToGuid(ByVal val As String) As Guid
            Dim result As Guid = Nothing
            If Not Guid.TryParse(val, result) Then
                result = Guid.Empty
            End If
            Return result
        End Function


        Public Shared Function GetByteArray(ByVal obj As Object) As Byte()
            Dim result() As Byte = New Byte(0) {}
            If Not IsNothing(obj) AndAlso TypeOf obj Is System.Byte() Then
                result = obj
            End If
            Return result
        End Function

        Public Shared Function RemoveTrailingString(ByVal inString As String, ByVal trailingString As String) As String
            Dim result As String = ""
            If inString.Length = 0 Then
                result = ""
            Else
                result = inString.Substring(0, inString.LastIndexOf(trailingString))
            End If
            Return result
        End Function

        ''' <summary>
        ''' This function should be used for all nullable columns of type "bit" retrieved from the database.
        ''' It will return False for null or 0, otherwise True
        ''' </summary>
        ''' <param name="bitIn">Object of type Integer? usually a database column of type bit</param>
        ''' <returns>False for Nothing or 0, otherwise True</returns>
        ''' <remarks></remarks>
        Public Shared Function NullBitCheck(ByVal bitIn As Integer?) As Boolean
            Dim result As Boolean = False
            If IsNothing(bitIn) Then
                result = False
            Else
                If bitIn = 0 Then
                    result = False
                Else
                    result = True
                End If
            End If

            Return result

        End Function

        ''' <summary>
        ''' This function should be used for all nullable columns of type "Interger" retrieved from the database.
        ''' It will return the value, if the passed in value is not nothing, otherwise it will return
        ''' the default value, which is optional and -1
        ''' </summary>
        ''' <param name="intIn">Object of type Integer? usually a database column of type integer</param>
        ''' <param name="defaultValue">An optional default value to return</param>
        ''' <returns>Value or default value</returns>
        ''' <remarks></remarks>
        Public Shared Function NullIntegerCheck(ByVal intIn As Integer?, Optional ByVal defaultValue As Integer = -1) As Integer
            Dim result As Integer = False
            If IsNothing(intIn) Then
                result = defaultValue
            Else
                result = intIn
            End If

            Return result
        End Function




        ''' <summary>
        ''' This function should be used when a formatted date string is required from a nullable column of type "datetime".
        ''' It will return a zero length string for null, otherwise a date formatted using the formatString argument.
        ''' </summary>
        ''' <param name="dateIn">Object of type Date? usually a database column of type datetime</param>
        ''' <param name="formatString">A date format string</param>
        ''' <returns>"" for null dates, otherwise a formated date string</returns>
        ''' <remarks></remarks>
        Public Shared Function NullDateCheck(ByVal dateIn As Date?, ByVal formatString As String) As String
            Dim result As String = ""
            If IsDate(dateIn) Then
                result = Format(dateIn, formatString)
            End If

            Return result

        End Function

        Public Shared Function DblOrNothing(ByVal textIn As String) As Double?
            Dim result As Double?
            Dim dummy As Double = 0
            If Not Double.TryParse(textIn, dummy) Then
                result = Nothing
            Else
                result = dummy
            End If
            Return result
        End Function

        Public Shared Function IntOrNothing(ByVal textIn As String) As Integer?
            Dim result As Integer?
            Dim dummy As Int64 = 0
            If Not Long.TryParse(textIn, dummy) Then
                result = Nothing
            Else
                result = dummy
            End If
            Return result
        End Function

        Public Shared Function BoolOrFalse(ByVal textIn As String) As Boolean
            Dim result As Boolean
            Dim dummy As Int64 = 0
            If IsNothing(textIn) Then
                result = False
            ElseIf textIn.ToUpper.Equals("T") OrElse textIn.ToUpper.Equals("TRUE") Then
                result = True
            ElseIf Not Long.TryParse(textIn, dummy) Then
                result = False
            ElseIf dummy = 0 Then
                result = False
            Else
                ' non-zero integers will be treated as True
                result = True
            End If

            Return result
        End Function

        Public Shared Function SingleOrNothing(ByVal textIn As String) As Single?
            Dim result As Single?
            Dim dummy As Single
            If Not Single.TryParse(textIn, dummy) Then
                result = Nothing
            Else
                result = dummy
            End If
            Return result
        End Function

        Public Shared Function DateorNothing(ByVal textIn As String) As Date?
            Dim result As Date?
            Dim dummy As Date
            If Not Date.TryParse(textIn, dummy) Then
                result = Nothing
            Else
                result = dummy
            End If
            Return result
        End Function

        Public Shared Function BlankIntZero(ByVal obj As Object) As Int32
            Dim result As Int32 = 0
            If obj.ToString = "" Then
                result = 0
            Else
                If Not Int32.TryParse(obj.ToString, result) Then
                    result = 0
                End If
            End If
            Return result
        End Function

        Public Shared Function ValidPostalCode(ByVal tstPostalCode As String) As Boolean
            Dim rts As Boolean = False

            If (Wine.Common.Sql.GetSingleValue("SELECT COUNT(1) from rheemdb..PostalCode WHERE PostalCode=" & Wine.Common.Sql.Quote(tstPostalCode)) <> 0) Then
                rts = True
            End If
            Return rts
        End Function


        Public Shared Function IsValidGuid(ByVal inpGuid As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            Dim tstGuid As Guid
            outStr = ""
            If Not Guid.TryParse(inpGuid, tstGuid) Then
                rts = False
                outStr = paramName & " is not a valid Guid"
            End If

            Return rts
        End Function


        Public Shared Function IsValidInteger(ByVal inpInt As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            Dim tstint As Int64 = Nothing
            outStr = ""
            If Not Long.TryParse(inpInt, tstint) Then
                rts = False
                outStr = paramName & " is not a valid Integer"
            End If

            Return rts
        End Function

        Public Shared Function IsValidBoolean(ByVal inpBool As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            Dim tstBool As Boolean = Nothing
            outStr = ""
            If Not Boolean.TryParse(inpBool, tstBool) Then
                rts = False
                outStr = paramName & " is not a valid Boolean"
            End If

            Return rts
        End Function

        Public Shared Function IsValidDouble(ByVal inpDouble As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            Dim tstDouble As Double = Nothing
            outStr = ""
            If Not Double.TryParse(inpDouble, tstDouble) Then
                rts = False
                outStr = paramName & " is not a valid Double"
            End If

            Return rts
        End Function

        Public Shared Function IsValidDate(ByVal inpDate As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            Dim tstDate As DateTime = Nothing
            outStr = ""
            If Not DateTime.TryParse(inpDate, tstDate) Then
                rts = False
                outStr = paramName & " is not a valid DateTime"
            End If

            Return rts
        End Function

        Public Shared Function IsValidString(ByVal inpString As String, ByVal paramName As String, ByRef outStr As String) As Boolean
            Dim rts As Boolean = True  '  Assume success
            outStr = ""
            If inpString.Length = 0 Then
                rts = False
                outStr = paramName & " is not a valid String"
            End If

            Return rts

        End Function

        Public Shared Function RemoveLastCharacter(ByVal inStr As String) As String
            Dim result = inStr
            If inStr.Length > 0 Then
                result = inStr.Substring(0, inStr.Length - 1)
            End If
            Return result
        End Function

        Public Shared Function PadIntStringWithZeros(numIn As Integer, desiredLength As Int16) As String
            Dim result As String = numIn.ToString

            While result.Length < desiredLength
                result = "0" + result
            End While

            Return result
        End Function


        Public Shared Function ExcelNullHelper(ByVal dr As System.Data.DataRow, ByVal colNumber As Integer) As String
            Dim s As String = ""
            If Not IsDBNull(dr.Item(colNumber)) Then
                s = dr.Item(colNumber)
                s = s.Trim
                If s.StartsWith("$") Then
                    s = s.Remove(0, 1)
                End If
                If s.EndsWith("%") Then
                    s = s.Remove(s.Length - 1)
                End If
            End If
            Return s
        End Function

        Public Shared Function ExcelNullHelperInteger(ByVal dr As System.Data.DataRow, ByVal colNumber As Integer) As String
            Dim i As Int64 = 0
            If Not IsDBNull(dr.Item(colNumber)) Then
                Dim s As String = dr.Item(colNumber)
                If s.StartsWith("$") Then
                    s = s.Remove(0, 1)
                End If
                If s.EndsWith("%") Then
                    s = s.Remove(s.Length - 1)
                End If
                s = s.Replace(",", "")
                Long.TryParse(s, i)
            End If
            Return i.ToString()
        End Function


        Public Shared Function ExcelNullHelperDouble(ByVal dr As System.Data.DataRow, ByVal colNumber As Integer) As String
            Dim d As Double = 0
            If Not IsDBNull(dr.Item(colNumber)) Then
                Dim s As String = dr.Item(colNumber)
                If s.StartsWith("$") Then
                    s = s.Remove(0, 1)
                End If
                If s.EndsWith("%") Then
                    s = s.Remove(s.Length - 1)
                End If
                s = s.Replace(",", "")
                Double.TryParse(s, d)
            End If
            Return d.ToString()
        End Function

        Public Shared Function IntQuestionToString(ByVal intQin As Integer?) As String
            Dim rts As String = ""
            If intQin Is Nothing Then
                rts = ""
            Else
                rts = intQin.ToString
            End If

            Return rts
        End Function


    End Class


    Public Class UnitConverstions

        Public Shared Function PixelsToPoints(ByVal pixels As Integer) As Integer
            'There are 72 points per inch; if it is sufficient to assume 96 pixels per inch
            PixelsToPoints = CInt(pixels * 72 / 96)
        End Function

        Public Shared Function BtuPerHrToKw(ByVal btuPerHour As Integer) As Double
            BTUPerHrToKw = btuPerHour * 2.931 * 10 ^ -4
        End Function

        Public Shared Function PoundsToKilograms(ByVal pounds As Integer) As Double
            PoundsToKilograms = pounds * 0.45359237
        End Function

        Public Shared Function InchesAsStringToMilliMetters(ByVal inches As String) As Integer
            ' this routine takes in a string in the format of 
            ' 32 - 1/4 and returns millimeters
            'x = InchesAsStringToMilliMetters("33 - 1/4")
            'x = InchesAsStringToMilliMetters("33-1/4")
            'x = InchesAsStringToMilliMetters("33")
            'x = InchesAsStringToMilliMetters("33 1/4")
            'x = InchesAsStringToMilliMetters("1/4")


            inches = inches.Trim
            Dim firstSpace As Integer = inches.IndexOf(" ")
            Dim dashLocation As Integer = inches.IndexOf("-")
            Dim slashLocation As Integer = inches.IndexOf("/")
            Dim wholenumber As Integer = 0

            Dim inchesAsDouble As Double = 0
            Dim numerator As Integer = 0
            Dim denominator As Integer = 0

            ' Is there a dash
            If dashLocation > 0 And slashLocation > dashLocation Then
                ' handle "33 - 1/4" and "33-1/4"
                wholenumber = CInt(inches.Substring(0, dashLocation - 1))
                numerator = inches.Substring(dashLocation + 1, slashLocation - dashLocation - 1)
                denominator = inches.Substring(slashLocation + 1)
                inchesAsDouble = wholenumber + (numerator / denominator)

            ElseIf firstSpace > 0 And slashLocation > 0 Then
                ' handle "33 1/4"
                wholenumber = CInt(inches.Substring(0, firstSpace))
                numerator = inches.Substring(firstSpace + 1, slashLocation - firstSpace - 1)
                denominator = inches.Substring(slashLocation + 1)
                inchesAsDouble = wholenumber + (numerator / denominator)

            ElseIf firstSpace <= 0 And slashLocation <= 0 Then
                ' handle "33"
                wholenumber = CInt(inches)
                inchesAsDouble = wholenumber
            ElseIf firstSpace <= 0 And slashLocation > 0 Then
                ' handle "3/4"
                wholenumber = 0
                numerator = inches.Substring(0, slashLocation)
                denominator = inches.Substring(slashLocation + 1)
                inchesAsDouble = wholenumber + (numerator / denominator)
            ElseIf dashLocation > 0 And slashLocation < 0 Then
                ' handle "34 -"
                wholenumber = CInt(inches.Replace("-", ""))
                inchesAsDouble = wholenumber

            End If

            Return CInt(inchesAsDouble * 25.4)

        End Function

    End Class

    Public Class Sorting

        Public Shared Function SortHashtable(ByVal oHash As Hashtable) As DataView
            Dim oTable As New System.Data.DataTable
            oTable.Columns.Add(New System.Data.DataColumn("key"))
            oTable.Columns.Add(New System.Data.DataColumn("value"))

            For Each oEntry As Collections.DictionaryEntry In oHash
                Dim oDataRow As DataRow = oTable.NewRow()
                oDataRow("key") = oEntry.Key
                oDataRow("value") = oEntry.Value
                oTable.Rows.Add(oDataRow)
            Next

            Dim oDataView As DataView = New DataView(oTable)
            oDataView.Sort = "key aSC"

            Return oDataView
        End Function

    End Class

    Public Class Files

        Private Shared Function LoadValidFileExtensions() As Hashtable

            Dim validFileExtensions As New Hashtable()
            validFileExtensions.Add("doc", "application/msword")
            validFileExtensions.Add("pdf", "application/pdf")
            validFileExtensions.Add("xls", "application/vnd.ms-excel")
            validFileExtensions.Add("xlsx", "application/vnd.ms-excel")
            validFileExtensions.Add("ppt", "application/vnd.ms-powerpoint")
            validFileExtensions.Add("bmp", "image/bmp")
            validFileExtensions.Add("gif", "image/gif")
            validFileExtensions.Add("jpeg", "image/jpeg")
            validFileExtensions.Add("jpg", "image/jpeg")
            validFileExtensions.Add("pjpeg", "image/pjpeg")
            validFileExtensions.Add("png", "image/x-png")
            validFileExtensions.Add("tif", "image/tiff")
            validFileExtensions.Add("tiff", "image/tiff")
            validFileExtensions.Add("txt", "text/plain")

            Return validFileExtensions
        End Function

        Public Shared Function MimeType(ByVal fileExtension As String) As String

            Dim mt As String = ""
            Dim validFileExtensions As New Hashtable()
            validFileExtensions = LoadValidFileExtensions()

            If validFileExtensions.Contains(fileExtension) Then
                mt = validFileExtensions.Item(fileExtension)
            End If
            Return mt
        End Function

        Public Shared Function ValidFileExtension(ByVal fileExtension As String) As Boolean

            Dim bValid As Boolean = False
            Dim validFileExtensions As New Hashtable()
            validFileExtensions = LoadValidFileExtensions()

            If validFileExtensions.Contains(fileExtension) Then
                bValid = True
            End If
            Return bValid
        End Function

    End Class


End Namespace