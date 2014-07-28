USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorOrgNameNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorOrgNameNumber]
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
CREATE PROCEDURE [dbo].[GetDistributorOrgNameNumber] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT o.OrganizationName + ' - ' + IsNull(do.DistributorNumber, '') as NameNumber, o.OrganizationID
	FROM rheemusers..MyOrganizations mo
       INNER JOIN rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
	      o.OrganizationType  = 'Distributor' and 
		  o.OrganizationName <> '' and o.OrganizationName is not null
	   INNER JOIN rheemusers..DistributorOrganization do ON   o.OrganizationID    = do.OrganizationId and  
          do.AC    = '1'
    WHERE 
          mo.personID         = @PersonID
    ORDER BY o.OrganizationName

END
GO
