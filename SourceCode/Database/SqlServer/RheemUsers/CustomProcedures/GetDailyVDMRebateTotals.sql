USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDailyVDMRebateTotals]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDailyVDMRebateTotals]
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
CREATE PROCEDURE [dbo].[GetDailyVDMRebateTotals] 
    -- Add the parameters for the stored procedure here
    
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    CREATE TABLE #RebateTempTable (
        [TrueDate] [int] NOT NULL,
        [DailyTotal] [int] NOT NULL,
        PRIMARY KEY (TrueDate)
    )

    -- Insert statements for procedure here
    INSERT INTO #RebateTempTable 
    SELECT a.TheDay As TrueDate, DailyTotal  
    FROM (
        SELECT DATEDIFF(d,'1/1/1970',InvoiceDate) AS TheDay, 
               SUM(RebateAmount) DailyTotal 
        FROM rheemusers..VDMRebateProgram
        GROUP BY DATEDIFF(d,'1/1/1970',InvoiceDate)) AS a

    DECLARE @StartDate datetime
    SET @StartDate = (SELECT MIN(InvoiceDate) FROM rheemusers..VDMRebateProgram)

    SELECT DATEDIFF(d, @StartDate, DATEADD(d, a.TrueDate, '1/1/1970')) AS DayOfProgram, DATEADD(d, CAST(a.TrueDate AS int), '1/1/1970') AS TrueDate,
      (SELECT sum(b.DailyTotal) FROM #RebateTempTable b
       WHERE a.TrueDate >= b.TrueDate) AS 'CumulativeSum'
    FROM #RebateTempTable a
    order by a.TrueDate

    DROP TABLE #RebateTempTable

END
GO
