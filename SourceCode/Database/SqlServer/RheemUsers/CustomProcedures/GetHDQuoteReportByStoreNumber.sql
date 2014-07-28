USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDQuoteReportByStoreNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDQuoteReportByStoreNumber]
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
CREATE PROCEDURE [dbo].[GetHDQuoteReportByStoreNumber] 
    -- Add the parameters for the stored procedure here
    @StartDate datetime,
    @EndDate datetime

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT OptionCountByStore.StoreNumber, 
       OptionTotalByStore.AvgOptionPrice, 
       OptionTotalByStore.AvgDiscount, 
       OptionCountByStore.AvgOptionCount,
       ISNULL(AvgContractPriceTable.AvgContractPrice, 0) AS AverageContractPrice,
       ISNULL(ContractsByStore.TotalContracts, 0) AS TotalContracts,
       ISNULL(QuotesByStore.TotalQuotes, 0) AS TotalQuotes,
       ISNULL(AvgPercentDiffByStore.AvgPercentDiff, 0) AS AvgPercentDiff,
	   ISNULL(AvgDaysDiffByStore.AvgDaysDiff, 0) As AvgDaysDiff
-- Option Price,Discount by Store Query
FROM (SELECT AVG(a.OptionTotal) AS AvgOptionPrice, 
             AVG(a.Discount) AS AvgDiscount, 
             a.StoreNumber FROM             
             (SELECT opt.OptionTotal, opt.Discount, qt.StoreNumber 
              FROM rheemusers..HDOption opt, 
                   rheemusers..HDQuote qt 
              WHERE opt.HDQuoteID = qt.HDQuoteID and 
                    qt.ProposalDate between @StartDate and @EndDate) AS a
      GROUP BY a.StoreNumber) AS OptionTotalByStore
LEFT JOIN      
-- Option Count by Store Query
     (SELECT AVG(a.OptionCount) AS AvgOptionCount,a.StoreNumber 
      FROM (SELECT count(*) AS OptionCount, qt.StoreNumber 
            FROM rheemusers..HDOption opt, 
                 rheemusers..HDQuote qt 
            WHERE opt.HDQuoteID = qt.HDQuoteID and 
                  qt.ProposalDate between @StartDate and @EndDate
            GROUP BY opt.HDQuoteID, qt.StoreNumber) AS a
      GROUP BY a.StoreNumber) AS OptionCountByStore
ON OptionTotalByStore.StoreNumber=OptionCountByStore.StoreNumber
LEFT JOIN
-- AVG Contract Price
(SELECT AVG(a.OptionTotal) AS AvgContractPrice, 
             a.StoreNumber FROM             
             (SELECT opt.OptionTotal, opt.Discount, qt.StoreNumber, opt.IsContractOption
              FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDQuote qt ON opt.HDQuoteID = qt.HDQuoteID
              WHERE opt.IsContractOption <> 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS a
              GROUP BY a.StoreNumber) AS AvgContractPriceTable
ON OptionTotalByStore.StoreNumber=AvgContractPriceTable.StoreNumber 
LEFT JOIN       
-- Total number of contracts by store
(SELECT count(*) AS TotalContracts, qt.StoreNumber
              FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDQuote qt ON opt.HDQuoteID = qt.HDQuoteID
              WHERE opt.IsContractOption <> 0 and 
                    qt.ProposalDate between @StartDate and @EndDate
              GROUP BY qt.StoreNumber) AS ContractsByStore
ON OptionTotalByStore.StoreNumber=ContractsByStore.StoreNumber   
LEFT JOIN       
-- Total number of quotes by store
(SELECT count(*) AS TotalQuotes, StoreNumber
              FROM rheemusers..HDQuote                     
              WHERE ProposalDate between @StartDate and @EndDate
              GROUP BY StoreNumber) AS QuotesByStore
ON OptionTotalByStore.StoreNumber=QuotesByStore.StoreNumber   
LEFT JOIN                         
-- AVG % diff between contract and quote
    (SELECT AVG(PercentDiff) As AvgPercentDiff, StoreNumber FROM 
       (SELECT qt.StoreNumber,
               ABS(opt.OptionTotal-opt2.OptionTotal) / ((opt.OptionTotal+opt2.OptionTotal) / 2) As PercentDiff
        FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDOption opt2 ON opt.HDQuoteID = opt2.HDQuoteID
              LEFT JOIN rheemusers..HDQuote qt ON qt.HDQuoteID = opt.HDQuoteID
              WHERE opt.IsContractOption <> 0 and opt2.IsContractOption = 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS pctDiff 
    GROUP BY StoreNumber) AS AvgPercentDiffByStore
ON OptionTotalByStore.StoreNumber=AvgPercentDiffByStore.StoreNumber
LEFT JOIN
-- AVG days between Quote and Contract (needs schema additions for option dates)
    (SELECT AVG(DaysDiff) As AvgDaysDiff, StoreNumber FROM 
       (SELECT qt.StoreNumber,
               DATEDIFF(d,opt2.CreationDate,opt.CreationDate) As DaysDiff
        FROM rheemusers..HDOption opt                     
              LEFT JOIN rheemusers..HDOption opt2 ON opt.HDQuoteID = opt2.HDQuoteID
              LEFT JOIN rheemusers..HDQuote qt ON qt.HDQuoteID = opt.HDQuoteID
              WHERE opt.IsContractOption <> 0 and opt2.IsContractOption = 0 and 
                    qt.ProposalDate between @StartDate and @EndDate) AS pctDiff 
    GROUP BY StoreNumber) AS AvgDaysDiffByStore
ON OptionTotalByStore.StoreNumber=AvgDaysDiffByStore.StoreNumber

END
GO
