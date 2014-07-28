USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProStockBudget]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProStockBudget]
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
CREATE PROCEDURE [dbo].[GetProStockBudget] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select '0' Budget, '0' YearToDateCredits, * 
	FROM rheemusers..MyOrganizations mo, rheemusers..organization o, rheemusers..DistributorOrganization do 
    WHERE mo.OrganizationID = o.OrganizationId and 
          mo.personID = @PersonID and
		  o.OrganizationType  = 'Distributor' and 
		  o.OrganizationID    = do.OrganizationId and 
		  do.ProStockStores   = '1' and 
		  o.OrganizationName <> '' and 
		  o.OrganizationName is not null 
    ORDER BY o.OrganizationName

END
GO
