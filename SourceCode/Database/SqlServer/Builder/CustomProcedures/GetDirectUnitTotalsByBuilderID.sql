USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDirectUnitTotalsByBuilderID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDirectUnitTotalsByBuilderID]
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
CREATE PROCEDURE [dbo].[GetDirectUnitTotalsByBuilderID]
    -- Add the parameters for the stored procedure here
    @BuilderID uniqueidentifier,
    @Year int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(TotalRebate) AS Incentive, 
           SUM(MotorBearings) AS MotorBearingUnits, 
           MONTH(CompletedDate) As Month 
    FROM Builder..BuilderJobSites 
    WHERE BuilderID=@BuilderID and 
          YEAR(CompletedDate)=@Year
    GROUP BY MONTH(CompletedDate) 
    ORDER BY MONTH(CompletedDate) 

END
GO
