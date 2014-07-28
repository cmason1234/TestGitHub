USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorByZipCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorByZipCode]
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
CREATE procedure [dbo].[GetDistributorByZipCode] (
   @inzip varchar(32), 
   @brandID uniqueidentifier
 ) as
 BEGIN
	Declare @curr_Longitude float, @curr_Latitude float,
	    @int_MinLongitude float, @int_MaxLongitude float, 
	    @int_MinLatitude float, @int_MaxLatitude float;
 
    Declare @p_Radius int;
	
    -- Get the lat/long for the given zip  ALSO we are getting contractors within
	--    100 miles of the given PostalCode
	Select  @curr_Longitude=Lon, @curr_Latitude=Lat, @p_Radius=100 
      From RheemDB..postalcode
		Where  (PostalCode = @inzip OR PostalCode = SUBSTRING(@inzip, 1, 3) + ' ' + SUBSTRING(@inzip, 4, len(@inzip)))
		 AND CityType='D';

	select @int_MaxLatitude = dbo.LatitudePlusDistance(@curr_Latitude, @p_Radius),  
	       @int_MaxLongitude = dbo.LongitudePlusDistance(@curr_Longitude, @curr_Latitude, @p_Radius);
	   
	SELECT @int_MinLatitude=2*@curr_Latitude - @int_MaxLatitude, 
	       @int_MinLongitude=2*@curr_Longitude - @int_MaxLongitude;

	create table #TempZipLoc (
		postalcode varchar(100) NOT NULL,
		distance float
	);

	-- Get the List of PostalCodes within XX miles of the requested postalCode
	insert into #TempZipLoc (postalcode, distance)
	  select postalcode, 
        dbo.CalculateDistance(Lon, Lat, @curr_Longitude, @curr_Latitude) as distance 
		from RheemDB..PostalCode where 
		  CityType='D' and 
		  Lon Between @int_MinLongitude And @int_MaxLongitude and 
		  Lat Between @int_MinLatitude And @int_MaxLatitude;

	SELECT DISTINCT o.OrganizationID, o.OrganizationName, o.Phone,
		 oa.AddressLine1, oa.AddressLine2, oa.City, oa.State, oa.PostalCode
	  FROM
		 (
			SELECT cac.DistributorOrganizationID,  a.PostalCode, co.Radius
			  FROM ContractorAC cac
				INNER JOIN ContractorOrganization co on co.OrganizationID=cac.OrganizationID and 
					  co.Disabled = 0
				INNER JOIN Address a on co.PrimaryAddressID = a.AddressID
				INNER JOIN OrganizationBrand ob on ob.OrganizationID = cac.OrganizationID AND
						   ob.BrandID = @brandID
			  WHERE cac.Disabled = 0
		 ) dist
		 INNER JOIN #TempZipLoc tz on dist.PostalCode = tz.postalcode and
					tz.distance <= dist.Radius
		 INNER JOIN Organization O on dist.DistributorOrganizationID = o.OrganizationID
		 INNER JOIN Address oa on o.PrimaryAddressID=oa.AddressID
      ORDER BY o.OrganizationName;


END
GO
