USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrganizationAddress_Organization]') AND type in (N'F'))
ALTER TABLE [dbo].[OrganizationAddress] DROP CONSTRAINT FK_OrganizationAddress_Organization
GO
SET ANSI_NULLS ON
ALTER TABLE [dbo].[OrganizationAddress]  WITH CHECK ADD  CONSTRAINT [FK_OrganizationAddress_Organization] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
ON DELETE CASCADE
GO

