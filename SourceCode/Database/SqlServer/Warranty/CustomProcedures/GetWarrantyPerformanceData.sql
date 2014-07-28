USE [Warranty]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWarrantyPerformanceData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWarrantyPerformanceData]
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
CREATE PROCEDURE [dbo].[GetWarrantyPerformanceData] 
	-- Add the parameters for the stored procedure here
	@StartDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT AVG(isnull(DATEDIFF(millisecond, OracleSentTime,OracleReceivedTime), 0)) as avg_msec, 
		   floor(datediff(day, oraclereceivedtime, @StartDate) / 7) as weekNumber 
	FROM warranty..Homeowners 
	WHERE oracleStatus='Registered' and
		DATEDIFF(week, OracleReceivedTime, GETDATE()) < 10 
	GROUP BY floor(datediff(day, oraclereceivedtime, @StartDate) / 7)
	ORDER BY floor(datediff(day, oraclereceivedtime, @StartDate) / 7) desc

END
GO
