USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTanklessContractorsNearZipCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTanklessContractorsNearZipCode]
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
CREATE PROCEDURE [dbo].[GetTanklessContractorsNearZipCode] 
    -- Add the parameters for the stored procedure here
    @ZipCode varchar(50)
   ,@SearchRadius int
   ,@RatingType varchar(100)    -- we'll be ignoring this for now
   ,@SortBy varchar(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
Declare @centerLat float, @centerLong float 
     ,@degLat float ,@degLong float
     ,@topLat float ,@bottomLat float
     ,@leftLong float ,@rightLong float

select @centerLat=latitude, @centerLong=longitude from rheemdb..PostalCode where PostalCode=@zipCode

set @degLat = @SearchRadius / 69.0  -- A degree of latitude is approximately 69 miles
set @topLat = @centerLat + @degLat
set @bottomLat = @centerLat - @degLat

set @degLong = @degLat / cos(@centerLat*(PI() / 180)) -- compensate for angle
set @leftLong = @centerLong + @degLong
set @rightLong = @centerLong - @degLong

select TOP 3 * from (
    select  OrganizationName, OrganizationID, OrganizationType, Fax, CorporateEmail, paid, WebSite, AddressLine1, AddressLine2, City, State, PostalCode, AddressType, Phone, RankingPointsTankless, WeightedRankingTankless, Latitude, Longitude,
      rheemdb.dbo.GetDistanceBetweenCoordinates(@centerLat, @centerLong, Cast(Latitude as float), Cast(Longitude as float), null) as distance
    from
      (
       select distinct disp.OrganizationName, disp.OrganizationID, disp.OrganizationType, disp.Fax, disp.paid, disp.WebSite, disp.CorporateEmail, disp.AddressLine1, disp.AddressLine2, disp.City, disp.State, disp.PostalCode, disp.AddressType, disp.Phone, ISNULL(disp.RankingPointsTankless, 0) As RankingPointsTankless, ISNULL(disp.WeightedRankingTankless, 0) As WeightedRankingTankless, Latitude, Longitude from (
        select org.OrganizationName, org.OrganizationID, org.OrganizationType, org.Fax, a.AddressLine1, a.AddressLine2, a.City, a.State, 
               a.PostalCode, a.AddressType, org.Phone, cwh.RankingPointsTankless, cwh.WeightedRankingTankless, co.CorporateEmail, co.PrimaryAddressID As paid, co.WebSite
          from rheemusers..ContractorOrganization co 
            inner join rheemusers..Address a on co.PrimaryAddressID = a.AddressID and
              a.PostalCode in (       
               select distinct postalcode from rheemdb..postalcode         
                    where       
                     CAST (Latitude as float ) < @topLat and       
                     CAST (Latitude as float ) > @bottomLat and       
                     CAST (Longitude as float ) < @leftLong  and       
                     CAST (Longitude as float ) > @rightLong )  
            inner join rheemusers..Organization org on co.OrganizationID = org.OrganizationID
            inner join rheemusers..ContractorWaterHeater cwh on cwh.OrganizationID = org.OrganizationID
             where RheemTankless=1 and 
                (cwh.Disabled = 0 or cwh.Disabled is null)
       ) disp
      inner join  rheemdb..PostalCode pc on disp.PostalCode = pc.PostalCode) abcd
      ) outermost 
  where distance <= @SearchRadius
  ORDER BY 
    CASE @SortBy	
        WHEN 'WEIGHT' THEN WeightedRankingTankless
        WHEN 'POINTS' THEN RankingPointsTankless
        ELSE WeightedRankingTankless
    END
    DESC,distance, OrganizationName
END
GO
