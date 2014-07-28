USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorDSM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorDSM]
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
CREATE PROCEDURE [dbo].[GetDistributorDSM] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT p.FirstName + ' ' + p.LastName As PersonFullName, p.PersonId
		FROM rheemusers..Organization o 
		INNER JOIN rheemusers..DistributorOrganization do ON o.OrganizationID=do.OrganizationID
		INNER JOIN rheemusers..OrganizationParent op ON o.OrganizationID=op.OrganizationID
		INNER JOIN rheemusers..Organization o2 ON op.ParentOrganizationID=o2.OrganizationID AND
			   o2.OrganizationType LIKE 'Sales Territory%'
		LEFT OUTER JOIN rheemusers..Person p ON do.DSMPersonID=p.PersonID
	WHERE o.OrganizationID=@OrgID and PersonID IS NOT NULL

END
GO
