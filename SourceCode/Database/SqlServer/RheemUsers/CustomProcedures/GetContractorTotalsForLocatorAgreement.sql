USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorTotalsForLocatorAgreement]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorTotalsForLocatorAgreement]
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
CREATE PROCEDURE [dbo].[GetContractorTotalsForLocatorAgreement] 
    -- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT 
        (SELECT COUNT(*) AS TotalContractors FROM 
			(SELECT DISTINCT op.OrganizationID FROM rheemusers..OrganizationParent op
            INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=op.OrganizationID
            WHERE op.ParentOrganizationID in (SELECT DISTINCT dlp.OrganizationID FROM rheemusers..DistributorLocatorProcess dlp) 
            and innerO.OrganizationType in ('Dealer', 'Contractor')) innerTable) As TotalContractors,
        (SELECT COUNT(*) 
         FROM rheemusers..ContractorLocatorAgreement 
         WHERE Historical=0 AND ApprovedDate IS NOT NULL) As UnderContract,
        (SELECT COUNT(*) 
         FROM rheemusers..ContractorLocatorAgreement 
         WHERE Historical=0 AND ApprovedDate IS NULL AND DeniedDate IS NULL) As PendingApproval,
        (SELECT COUNT(*) 
         FROM rheemusers..ContractorLocatorAgreement 
         WHERE Historical=0 AND DeniedDate IS NOT NULL) As Denied
         
END
GO
