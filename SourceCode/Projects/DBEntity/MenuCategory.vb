'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Collections.Generic

Partial Public Class MenuCategory
    Public Property MenuCategoryId As Integer
    Public Property MenuCategoryName As String
    Public Property MenuCategoryDisplayOrder As Integer

    Public Overridable Property MenuItems As ICollection(Of MenuItem) = New HashSet(Of MenuItem)

End Class