USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDQuoteReportByContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDQuoteReportByContractor]
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
CREATE PROCEDURE [dbo].[GetHDQuoteReportByContractor] 
    -- Add the parameters for the stored procedure here
    @StartDate datetime,
    @EndDate datetime

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT OptionCountByOrg.OrganizationName, 
       OptionTotalByOrg.AvgOptionPrice, 
       OptionTotalByOrg.AvgDiscount, 
       OptionCountByOrg.AvgOptionCount,
       ISNULL(AvgContractPriceTable.AvgContractPrice, 0) AS AverageContractPrice,
       ISNULL(ContractsByOrg.TotalContracts, 0) AS TotalContracts,
       ISNULL(QuotesByOrg.TotalQuotes, 0) AS TotalQuotes,
       ISNULL(AvgPercentDiffByOrg.AvgPercentDiff, 0) AS AvgPercentDiff,
       ISNULL(AvgDaysDiffByOrg.AvgDaysDiff, 0) As AvgDaysDiff
-- Option Price,Discount by Org Query
FROM (SELECT AVG(a.OptionTotal) AS AvgOptionPrice, 
             AVG(a.Discount) AS AvgDiscount, 
             a.OrganizationName FROM             
             (SELECT opt.OptionTotal, opt.Discount, org.OrganizationName 
              FROM rheemusers..HDOption opt, 
                   rheemusers..HDQuote qt,
                   rheemusers..Organization org
              WHERE opt.HDQuoteID = qt.HDQuoteID and 
                    qt.OrganizationID = org.OrganizationID and
                    qt.ProposalDate between @StartDate and @EndDate) AS a
      GROUP BY a.OrganizationName) AS OptionTotalByOrg
LEFT JOIN      
-- Option Count by Org Query
     (SELECT AVG(a.OptionCount) AS AvgOptionCount,a.OrganizationName 
      FROM (SELECT count(*) AS OptionCount, org.OrganizationName 
            FROM rheemusers..HDOption opt, 
                 rheemusers..HDQuote qt,
                 rheemusers..Organization org
            WHERE opt.HDQuoteID = qt.HDQuoteID and 
                  qt.ProposalDate between @StartDate and @EndDate
            GROUP BY opt.HDQuoteID, org.OrganizationName) AS a
      GROUP BY a.OrganizationName) AS OptionCountByOrg
ON OptionTotalByOrg.OrganizationName=OptionCountByOrg.OrganizationName
LEFT JOIN
-- AVG Contract Price
(SELECT AVG(a.OptionTotal) AS AvgContractPrice, 
             a.OrganizationName FROM             
             (SELECT opt.OptionTotal, opt.Discount, org.OrganizationName, opt.IsContractOption
              FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDQuote qt ON opt.HDQuoteID = qt.HDQuoteID
              LEFT JOIN rheemusers..Organization org ON qt.OrganizationID = org.OrganizationID
              WHERE opt.IsContractOption <> 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS a
              GROUP BY a.OrganizationName) AS AvgContractPriceTable
ON OptionTotalByOrg.OrganizationName=AvgContractPriceTable.OrganizationName 
LEFT JOIN       
-- Total number of contracts by Org
(SELECT count(*) AS TotalContracts, org.OrganizationName
              FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDQuote qt ON opt.HDQuoteID = qt.HDQuoteID
              LEFT JOIN rheemusers..Organization org ON qt.OrganizationID = org.OrganizationID
              WHERE opt.IsContractOption <> 0 and 
                    qt.ProposalDate between @StartDate and @EndDate
              GROUP BY org.OrganizationName) AS ContractsByOrg
ON OptionTotalByOrg.OrganizationName=ContractsByOrg.OrganizationName   
LEFT JOIN       
-- Total number of quotes by Org
(SELECT count(*) AS TotalQuotes, OrganizationName
              FROM rheemusers..HDQuote qt
              LEFT JOIN rheemusers..Organization org ON qt.OrganizationID = org.OrganizationID                    
              WHERE ProposalDate between @StartDate and @EndDate
              GROUP BY OrganizationName) AS QuotesByOrg
ON OptionTotalByOrg.OrganizationName=QuotesByOrg.OrganizationName   
LEFT JOIN                         
-- AVG % diff between contract and quote
    (SELECT AVG(PercentDiff) As AvgPercentDiff, OrganizationName FROM 
       (SELECT org.OrganizationName,
               ABS(opt.OptionTotal-opt2.OptionTotal) / ((opt.OptionTotal+opt2.OptionTotal) / 2) As PercentDiff
        FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDOption opt2 ON opt.HDQuoteID = opt2.HDQuoteID
              LEFT JOIN rheemusers..HDQuote qt ON qt.HDQuoteID = opt.HDQuoteID
              LEFT JOIN rheemusers..Organization org ON qt.OrganizationID = org.OrganizationID 
              WHERE opt.IsContractOption <> 0 and opt2.IsContractOption = 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS pctDiff 
    GROUP BY OrganizationName) AS AvgPercentDiffByOrg
ON OptionTotalByOrg.OrganizationName=AvgPercentDiffByOrg.OrganizationName
LEFT JOIN
-- AVG days between Quote and Contract (needs schema additions for option dates)
    (SELECT AVG(DaysDiff) As AvgDaysDiff, OrganizationName FROM 
       (SELECT org.OrganizationName,
               DATEDIFF(d,opt2.CreationDate,opt.CreationDate) As DaysDiff
        FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDOption opt2 ON opt.HDQuoteID = opt2.HDQuoteID
              LEFT JOIN rheemusers..HDQuote qt ON qt.HDQuoteID = opt.HDQuoteID
              LEFT JOIN rheemusers..Organization org ON qt.OrganizationID = org.OrganizationID 
              WHERE opt.IsContractOption <> 0 and opt2.IsContractOption = 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS pctDiff 
    GROUP BY OrganizationName) AS AvgDaysDiffByOrg
ON OptionTotalByOrg.OrganizationName=AvgDaysDiffByOrg.OrganizationName

END
GO
