USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ComputeContractorRanking]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ComputeContractorRanking]
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
CREATE PROCEDURE [dbo].[ComputeContractorRanking] 
    -- Add the parameters for the stored procedure here
    @ContractorWaterHeaterID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT SUM(Total.RawRankings) As TotalRanking,
       SUM(Total.WeightedRankings) As TotalWeightedRanking 
FROM (SELECT SUM(b.Ranking * c.Weight) As WeightedRankings, SUM(b.Ranking) As RawRankings 
      FROM rheemusers..ContractorOrganizationRanking a
      LEFT JOIN rheemusers..RatingCriteria b ON a.RatingCriteriaID=b.RatingCriteriaID
      LEFT JOIN rheemusers..RatingCategory c ON b.RatingCategoryID=c.RatingCategoryID
      WHERE ContractorWaterHeaterID=@ContractorWaterHeaterID
      GROUP BY c.RatingCategoryID) AS Total

END
GO
