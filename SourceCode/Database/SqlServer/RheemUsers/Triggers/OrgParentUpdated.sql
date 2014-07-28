USE [RheemUsers]

GO
/****** Object:  Trigger [dbo].[trg_OrgParentUpdated]    Script Date: 04/12/2013 12:08:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trg_OrgParentUpdated]
ON [dbo].[OrganizationParent]
FOR INSERT, UPDATE, DELETE
AS 

update rheemdb..env set Timestamp=getdate() where envName='OrganizationParentUpdated'

