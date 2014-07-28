USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorQuarterlySales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorQuarterlySales]
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
CREATE PROCEDURE [dbo].[GetContractorQuarterlySales] 
	-- Add the parameters for the stored procedure here
	@DistributorSelected uniqueidentifier,
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT * 
	FROM rheemdb..EC_ContractorQuarterlySales cqs, rheemusers..Organization o, rheemusers..ContractorAC cac, rheemdb..brand b
    WHERE cqs.DistributorOrganizationID = @DistributorSelected and
          cqs.ReportingYear= @Year and
          cqs.ContractorOrganizationID = o.OrganizationID and
          cqs.BrandOfSales = 'Rheem/Ruud' and
          o.OrganizationID = cac.OrganizationID and
          (cac.Disabled is null or cac.disabled = '0') and
          cac.brandid = b.brandid and
          (b.brandname = 'Ruud Reliable' or b.brandname='RheemTeam')
     order by o.OrganizationName
END
GO
