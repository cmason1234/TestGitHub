USE [Warranty]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWarrantyDailyDataForCharts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWarrantyDailyDataForCharts]
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
CREATE PROCEDURE [dbo].[GetWarrantyDailyDataForCharts] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@Month int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT DAY(RegistrationDate) As TheDay,
	       b.BrandName, 
	       COUNT(*) As Units 
	FROM warranty..Units u
	INNER JOIN rheemdb..Brand b ON b.BrandID=u.UnitBrand
	WHERE YEAR(RegistrationDate) = @Year and MONTH(RegistrationDate) = @Month
	GROUP BY DAY(RegistrationDate),BrandName ORDER BY BrandName, DAY(RegistrationDate)

END
GO
