USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllOtherProgramSalesByProgramType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAllOtherProgramSalesByProgramType]
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
CREATE PROCEDURE [dbo].[GetAllOtherProgramSalesByProgramType]
    -- Add the parameters for the stored procedure here
    @Year int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(a.Incentive) as Incentive, 
           SUM(a.MotorBearingUnits) as MotorBearingUnits, 
           a.Month As Month, 
           b.ProgramName As OrganizationName 
    FROM rheemusers..BuilderProgramSales a, 
         rheemusers..BuilderProgram b 
    WHERE a.BuilderProgramID=b.BuilderProgramID and 
          a.ProgramYear=@Year
    GROUP BY b.ProgramName,
             a.Month 
    ORDER BY b.ProgramName,
             a.Month     

END
GO
