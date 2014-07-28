USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTopContractorPurchases]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTopContractorPurchases]
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
CREATE PROCEDURE [dbo].[GetTopContractorPurchases] 
	-- Add the parameters for the stored procedure here
	@Brand varchar(256),
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select disO.OrganizationName DistributorName, conO.OrganizationName ContractorName, 
	       cqs.FirstQuarter , cqs.SecondQuarter , cqs.ThirdQuarter , cqs.FourthQuarter , 
		   (cqs.FirstQuarter + cqs.SecondQuarter + cqs.ThirdQuarter + cqs.FourthQuarter ) TotalSales 
    FROM rheemdb..EC_ContractorQuarterlySales cqs, rheemusers..Organization conO, rheemusers..Organization disO, 
	     rheemusers..ContractorAC cac, rheemdb..Brand b 
    WHERE cqs.ReportingYear=@Year and 
	      cqs.BrandOfSales ='Rheem/Ruud' and 
		  cqs.ContractorOrganizationID  = cono.OrganizationID and 
		  cqs.DistributorOrganizationID = disO.organizationID and 
		  conO.OrganizationID = cac.organizationid and 
		  (cac.disabled is null or cac.disabled = '0') and 
		  cac.BrandID  = b.brandId and 
		  b.BrandName = @Brand
    ORDER BY DistributorName, ContractorName

END
GO
