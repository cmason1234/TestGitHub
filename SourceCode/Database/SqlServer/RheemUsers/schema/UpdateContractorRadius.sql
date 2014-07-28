USE [RheemUsers]
GO

Update contractorOrganization SET Radius=0 where Radius IS NULL
