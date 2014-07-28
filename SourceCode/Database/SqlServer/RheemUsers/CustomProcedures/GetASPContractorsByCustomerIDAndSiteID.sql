USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetASPContractorsByCustomerIDAndSiteID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetASPContractorsByCustomerIDAndSiteID]
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
CREATE PROCEDURE [dbo].[GetASPContractorsByCustomerIDAndSiteID] 
    -- Add the parameters for the stored procedure here
     @CustomerAccountID varchar(50),
	@SiteUSeID varchar(50)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT * FROM ContractorWaterHeater CWH
	  LEFT OUTER JOIN Organization O on CWH.OrganizationID=O.OrganizationID
	  LEFT OUTER JOIN ContractorOrganization CO on CWH.OrganizationID=CO.OrganizationID
	  LEFT OUTER JOIN ContractorRates CR on O.OrganizationID=CR.OrganizationID and RateType='CURRENT'
	  LEFT OUTER JOIN Address A on CO.PrimaryAddressID=A.AddressID
	WHERE CWH.ServiceContractor = 1 and
	CO.CustomerAccountID = @CustomerAccountID 
	ORDER BY O.OrganizationName

	--and	CO.SiteUSeID = @SiteUSeID
	
END
GO
