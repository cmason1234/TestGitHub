USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWHContractorsByRanking]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWHContractorsByRanking]
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
CREATE PROCEDURE [dbo].[GetWHContractorsByRanking] 
    -- Add the parameters for the stored procedure here
    @OrganizationName varchar(100),
    @State varchar(50),
	@Country varchar(50),
    @IncludeUnranked bit,
    @RatingParentID uniqueidentifier,
    @PersonID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;


    SELECT DISTINCT a.OrganizationID,
                    b.ContractorWaterHeaterID,
                    a.OrganizationName,
                    d.AddressLine1 + '' + d.AddressLine2 AS Address,
                    d.City,
                    d.State,
                    d.PostalCode,
                    b.RankingPointsTankless,
                    b.WeightedRankingTankless,
                    1 As Ranked
    FROM rheemusers..ContractorWaterHeater b
    INNER JOIN rheemusers..Organization a ON a.OrganizationID=b.OrganizationID
    INNER JOIN rheemusers..ContractorOrganizationRanking c ON b.ContractorWaterHeaterID=c.ContractorWaterHeaterID 
    INNER JOIN rheemusers..RatingCriteria e ON e.RatingCriteriaID=c.RatingCriteriaID
    INNER JOIN rheemusers..RatingCategory f ON e.RatingCategoryID=f.RatingCategoryID
    INNER JOIN rheemusers..RatingParent g ON g.RatingParentID=f.RatingParentID
    INNER JOIN rheemusers..MyOrganizations h ON h.OrganizationID = a.OrganizationID
    INNER JOIN rheemusers..ContractorOrganization co ON a.OrganizationID = co.OrganizationID
    LEFT OUTER JOIN rheemusers..Address d ON a.PrimaryAddressID=d.AddressID
    WHERE (LEN(@OrganizationName) = 0 OR a.OrganizationName LIKE '%' + @OrganizationName + '%') and
          (LEN(@State) = 0 OR d.State = @State) and
          (LEN(@Country) = 0 OR d.Country = @Country) and
          g.RatingParentID=@RatingParentID and
          h.PersonID = @PersonID and
          (b.Disabled is NULL or b.Disabled=0) and
          (co.Disabled is NULL or co.Disabled=0) 
      
UNION

    SELECT DISTINCT a.OrganizationID,
                    b.ContractorWaterHeaterID,
                    a.OrganizationName,
                    d.AddressLine1 + '' + d.AddressLine2 AS Address,
                    d.City,
                    d.State,
                    d.PostalCode,
                    0 AS RankingPointsTankless,
                    0 AS WeightedRankingTankless,
                    0 As Ranked
    FROM rheemusers..ContractorWaterHeater b
    INNER JOIN rheemusers..Organization a ON a.OrganizationID=b.OrganizationID
    INNER JOIN rheemusers..MyOrganizations e ON e.OrganizationID = a.OrganizationID
    INNER JOIN rheemusers..ContractorOrganization co ON a.OrganizationID = co.OrganizationID
    LEFT OUTER JOIN rheemusers..Address d ON a.PrimaryAddressID=d.AddressID
    WHERE (LEN(@OrganizationName) = 0 OR a.OrganizationName LIKE '%' + @OrganizationName + '%') and
          (LEN(@State) = 0 OR d.State = @State) and
          (LEN(@Country) = 0 OR d.Country = @Country) and
          b.RheemTankless=1 and
          (b.Disabled is NULL or b.Disabled=0) and
          (co.Disabled is NULL or co.Disabled=0) and
          @IncludeUnranked=1 and
          b.ContractorWaterHeaterID not in (SELECT ContractorWaterHeaterID from rheemusers..ContractorOrganizationRanking) and
          e.PersonID = @PersonID
          
    ORDER BY b.WeightedRankingTankless DESC, a.OrganizationName ASC

END
GO
