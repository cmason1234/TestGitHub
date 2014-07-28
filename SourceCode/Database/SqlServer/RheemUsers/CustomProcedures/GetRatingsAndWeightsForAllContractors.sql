USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingsAndWeightsForAllContractors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingsAndWeightsForAllContractors]
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
CREATE PROCEDURE [dbo].[GetRatingsAndWeightsForAllContractors] 
    -- Add the parameters for the stored procedure here
    @OrganizationName varchar(100),
    @State varchar(50),
    @Country varchar(50),
    @RatingParentID uniqueidentifier,
    @PersonID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT a.WeightedRankingTankless,CONVERT(varchar(10),a.WeightedRankingTankless) + ' - ' + e.OrganizationName + ' - ' + f.AddressLine1 + ' ' + f.City + ', ' + f.State As Contractor,
           d.CategoryName, 
           c.CriteriaName, 
           c.Ranking, 
           d.Weight,
           c.Ranking*d.Weight As WeightedScore,
           a.ContractorWaterHeaterID
    FROM rheemusers..ContractorWaterHeater a
    INNER JOIN rheemusers..ContractorOrganizationRanking b ON a.ContractorWaterHeaterID=b.ContractorWaterHeaterID
    INNER JOIN rheemusers..RatingCriteria c ON b.RatingCriteriaID=c.RatingCriteriaID
    INNER JOIN rheemusers..RatingCategory d ON c.RatingCategoryID=d.RatingCategoryID
    INNER JOIN rheemusers..Organization e ON a.OrganizationID=e.OrganizationID
    LEFT OUTER JOIN rheemusers..Address f ON e.PrimaryAddressID=f.AddressID
    INNER JOIN rheemusers..MyOrganizations g ON g.OrganizationID = a.OrganizationID
    INNER JOIN rheemusers..ContractorOrganization co ON a.OrganizationID = co.OrganizationID
    WHERE (LEN(@OrganizationName) = 0 OR e.OrganizationName LIKE '%' + @OrganizationName + '%') and
          (LEN(@State) = 0 OR f.State = @State) and
          (LEN(@Country) = 0 OR f.Country = @Country) and
          d.RatingParentID=@RatingParentID and
          g.PersonID=@PersonID and
          a.RheemTankless=1 and
          (a.Disabled is NULL or a.Disabled=0) and
          (co.Disabled is NULL or co.Disabled=0) 

    ORDER BY a.WeightedRankingTankless desc,e.OrganizationName asc,d.DisplayOrder asc, c.DisplayOrder asc
END
GO
