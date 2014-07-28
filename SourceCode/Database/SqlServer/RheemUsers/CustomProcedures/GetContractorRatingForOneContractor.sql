USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingForOneContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingForOneContractor]
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
CREATE PROCEDURE [dbo].[GetRatingForOneContractor] 
    -- Add the parameters for the stored procedure here
    @ContractorWaterHeaterID uniqueidentifier,
    @RatingParentID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT a.CategoryName,
           b.CriteriaName,
           b.RatingCriteriaID,
           CASE WHEN c.ContractorWaterHeaterID IS NULL THEN 0 ELSE 1 END As ThisContractorRated 
    FROM rheemusers..RatingCategory a
         LEFT JOIN rheemusers..RatingCriteria b 
         ON a.RatingCategoryID=b.RatingCategoryID
         LEFT OUTER JOIN rheemusers..ContractorOrganizationRanking c 
         ON b.RatingCriteriaID=c.RatingCriteriaID and 
            ContractorWaterHeaterID=@ContractorWaterHeaterID
    WHERE b.RatingCriteriaID is not null and
          a.RatingParentID=@RatingParentID
    order by a.DisplayOrder,b.DisplayOrder

END
GO
