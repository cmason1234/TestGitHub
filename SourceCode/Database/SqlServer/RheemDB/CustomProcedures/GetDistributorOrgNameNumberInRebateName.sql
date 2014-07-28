USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorOrgNameNumberInRebateName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorOrgNameNumberInRebateName]
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
CREATE PROCEDURE [dbo].[GetDistributorOrgNameNumberInRebateName] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@CreditRebateNamesID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT LEFT(o.OrganizationName, 1) as FirstLetter, COUNT(*) as NumLetters
	FROM rheemusers..MyOrganizations mo
       INNER JOIN rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
	      o.OrganizationType  = 'Distributor' and 
		  o.OrganizationName <> '' and o.OrganizationName is not null
	   INNER JOIN rheemusers..DistributorOrganization do ON   o.OrganizationID    = do.OrganizationId and  
          do.COOPEligible    = '1'
    WHERE 
          mo.personID         = @PersonID
     GROUP BY LEFT(o.OrganizationName, 1)
    ORDER BY FirstLetter

    -- Insert statements for procedure here
    SELECT o.OrganizationName + ' - ' + IsNull(do.DistributorNumber, '') as NameNumber, o.OrganizationID,
	        CASE When cora.CreditOrgsWithRebateAmountID is not null Then 'TRUE'
	          ELSE 'FALSE'
	        END AS CHECKBOX,
	        LEFT(o.OrganizationName, 1) as FirstLetter
	FROM rheemusers..MyOrganizations mo
       INNER JOIN rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
	      o.OrganizationType  = 'Distributor' and 
		  o.OrganizationName <> '' and o.OrganizationName is not null
	   INNER JOIN rheemusers..DistributorOrganization do ON   o.OrganizationID    = do.OrganizationId and  
          do.COOPEligible    = '1'
	   LEFT OUTER JOIN rheemdb..EC_CreditOrgsWithRebateAmount cora ON o.OrganizationID=cora.OrganizationID AND
	          cora.CreditRebateNamesID = @CreditRebateNamesID
    WHERE 
          mo.personID         = @PersonID
    ORDER BY o.OrganizationName

END
GO
