﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated from a template.
'
'     Manual changes to this file may cause unexpected behavior in your application.
'     Manual changes to this file will be overwritten if the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Imports System
Imports System.Data.Entity
Imports System.Data.Entity.Infrastructure

Partial Public Class MywinecompetitionEntities
    Inherits DbContext

    Public Sub New()
        MyBase.New("name=mywinecompetitionEntities")
    End Sub

    Protected Overrides Sub OnModelCreating(modelBuilder As DbModelBuilder)
        Throw New UnintentionalCodeFirstException()
    End Sub

    Public Overridable Property EnvironmentTables() As DbSet(Of EnvironmentTable)
    Public Overridable Property MenuCategories() As DbSet(Of MenuCategory)
    Public Overridable Property MenuItems() As DbSet(Of MenuItem)
    Public Overridable Property Competitions() As DbSet(Of Competition)
    Public Overridable Property WineEntries() As DbSet(Of WineEntry)
    Public Overridable Property People() As DbSet(Of Person)
    Public Overridable Property WineScorings() As DbSet(Of WineScoring)

End Class
