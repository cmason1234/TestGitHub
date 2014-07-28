USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRaypakPoolSpaTerritories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRaypakPoolSpaTerritories]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRaypakPoolSpaTerritories] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@OrganizationID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select o.OrganizationID, o.OrganizationName from MyOrganizations mo
	INNER JOIN Organization o on mo.OrganizationID = o.OrganizationID
	where 
	  mo.PersonID = @PersonID and
	  o.OrganizationType like 'PS Territory%' AND
	  o.OrganizationID NOT IN (Select op.ParentOrganizationID from OrganizationParent op where OrganizationID=@OrganizationID)
	order by o.organizationName 

END
GO
