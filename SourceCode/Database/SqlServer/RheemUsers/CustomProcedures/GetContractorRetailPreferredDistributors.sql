USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorRetailPreferredDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorRetailPreferredDistributors]
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
CREATE PROCEDURE [dbo].[GetContractorRetailPreferredDistributors] 
	-- Add the parameters for the stored procedure here
	@contractorOrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT crpd.ContractorRetailPreferredDistributorID, crpd.OrganizationIDDistributor, o.OrganizationName, a.City, a.State
	FROM rheemusers..ContractorRetailPreferredDistributor crpd
	    INNER JOIN Organization o ON crpd.OrganizationIDDistributor=o.OrganizationID
	    LEFT OUTER JOIN rheemusers..Address a ON a.AddressID = o.PrimaryAddressID
	WHERE crpd.OrganizationIDContractor = @contractorOrgID
		order by o.OrganizationName

END
GO
