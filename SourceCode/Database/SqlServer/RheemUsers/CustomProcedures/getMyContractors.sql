USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getMyContractors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[getMyContractors]
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
CREATE PROCEDURE [dbo].[getMyContractors] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueIdentifier
	,@BrandID uniqueIdentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT o.OrganizationName, o.OrganizationID, o.OrganizationType, co.WebSite FROM MyOrganizations mo
	  INNER JOIN Organization o ON mo.OrganizationID = o.OrganizationID AND
		 o.OrganizationType IN ('Dealer', 'Contractor')
	  INNER JOIN ContractorOrganization co ON o.OrganizationID=co.OrganizationID AND
			   (co.Disabled IS NULL OR co.Disabled ='0')
	  INNER JOIN ContractorAC cac ON cac.OrganizationID=co.OrganizationID AND
				cac.BrandID=@BrandID AND
			   (cac.Disabled IS NULL OR cac.Disabled='0')
	  WHERE mo.PersonID=@PersonID
	  ORDER by o.OrganizationName

END
GO
