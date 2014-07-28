USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGrandTotalBuilderProgramSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetGrandTotalBuilderProgramSales]
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
CREATE PROCEDURE [dbo].[GetGrandTotalBuilderProgramSales]
    -- Add the parameters for the stored procedure here
    @Year int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(Incentive) as Incentive, 
           SUM(MotorBearingUnits) as MotorBearingUnits, 
           Month, 
           'Grand Total' as ProgramType 
    FROM 
       (SELECT Incentive, 
               MotorBearingUnits, 
               Month 
        FROM rheemusers..BuilderProgramSales 
        WHERE ProgramYear=@Year
            UNION ALL
        SELECT Incentive, 
               MotorBearingUnits, 
               Month 
        FROM rheemusers..BuilderExternalUnitCount 
        WHERE Year=@Year
            UNION ALL
        SELECT SUM(a.TotalRebate) As Incentive, 
               SUM(a.MotorBearings) As MotorBearingUnits,
               MONTH(a.CompletedDate) As Month 
        FROM Builder..BuilderJobSites a, 
             Builder..Builder b 
        WHERE a.BuilderID=b.BuilderID and 
              YEAR(a.CompletedDate)=@Year
        GROUP BY MONTH(a.CompletedDate)) as tempTable 
    GROUP BY Month 
    ORDER BY Month 

END
GO
