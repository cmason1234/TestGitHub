USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingsAndWeightsForOneContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingsAndWeightsForOneContractor]
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
CREATE PROCEDURE [dbo].[GetRatingsAndWeightsForOneContractor] 
	-- Add the parameters for the stored procedure here
	@ContractorWaterHeaterID uniqueidentifier,
	@RatingParentID uniqueidentifier

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT d.CategoryName, c.CriteriaName, c.Ranking, d.Weight,c.Ranking*d.Weight As WeightedScore,a.ContractorWaterHeaterID
	FROM rheemusers..ContractorWaterHeater a
	INNER JOIN rheemusers..ContractorOrganizationRanking b ON a.ContractorWaterHeaterID=b.ContractorWaterHeaterID
	INNER JOIN rheemusers..RatingCriteria c ON b.RatingCriteriaID=c.RatingCriteriaID
	INNER JOIN rheemusers..RatingCategory d ON c.RatingCategoryID=d.RatingCategoryID
	where b.ContractorWaterHeaterID=@ContractorWaterHeaterID and
		  d.RatingParentID=@RatingParentID
	ORDER BY d.DisplayOrder, c.DisplayOrder

END
GO
