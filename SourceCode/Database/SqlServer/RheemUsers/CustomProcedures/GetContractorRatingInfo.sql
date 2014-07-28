USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingInfo]
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
CREATE PROCEDURE [dbo].[GetRatingInfo]
    -- Add the parameters for the stored procedure here
    @RatingParentID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT a.RatingCategoryID,a.CategoryName,a.Weight,a.RatingParentID,b.RatingParentName,a.DisplayOrder
    FROM rheemusers..RatingCategory a
    LEFT JOIN rheemusers..RatingParent b ON a.RatingParentID = b.RatingParentID  
    WHERE b.RatingParentID=@RatingParentID
    ORDER BY a.DisplayOrder

    SELECT RatingCriteriaID,CriteriaName,Ranking,a.RatingCategoryID,a.DisplayOrder
    FROM rheemusers..RatingCriteria a
    INNER JOIN rheemusers..RatingCategory b ON a.RatingCategoryID=b.RatingCategoryID
    INNER JOIN rheemusers..RatingParent c ON b.RatingParentID=c.RatingParentID
    WHERE c.RatingParentID=@RatingParentID
    ORDER BY a.DisplayOrder

    SELECT b.DivisionName, 
           c.BusinessUnitName, 
           d.BrandName,
           a.RankType
    FROM rheemusers..RatingParent a
         INNER JOIN rheemusers..Division b ON a.DivisionID=b.DivisionID
         INNER JOIN rheemusers..BusinessUnit c ON c.BusinessUnitID=a.BusinessUnitID
         INNER JOIN rheemdb..Brand d ON d.BrandID=a.BrandID
    WHERE a.RatingParentID=@RatingParentID

END
GO
