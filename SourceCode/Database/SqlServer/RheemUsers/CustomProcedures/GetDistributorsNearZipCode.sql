USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorsNearZipCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorsNearZipCode]
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
CREATE PROCEDURE [dbo].[GetDistributorsNearZipCode] 
	-- Add the parameters for the stored procedure here
	@ZipCode varchar(50)
   ,@SearchRadius int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	Declare @curr_Longitude float, @curr_Latitude float,
	    @int_MinLongitude float, @int_MaxLongitude float, 
	    @int_MinLatitude float, @int_MaxLatitude float;
 
    Declare @p_Radius int;
	
    -- Get the lat/long for the given zip  ALSO we are getting contractors within
	--    100 miles of the given PostalCode
	Select  @curr_Longitude=Lon, @curr_Latitude=Lat, @p_Radius=100 
      From RheemDB..postalcode
		Where  PostalCode = @ZipCode and CityType='D';

	select @int_MaxLatitude = dbo.LatitudePlusDistance(@curr_Latitude, @p_Radius),  
	       @int_MaxLongitude = dbo.LongitudePlusDistance(@curr_Longitude, @curr_Latitude, @p_Radius);
	   
	SELECT @int_MinLatitude=2*@curr_Latitude - @int_MaxLatitude, 
	       @int_MinLongitude=2*@curr_Longitude - @int_MaxLongitude;
		   
	create table #TempZipLoc (
		postalcode varchar(100) NOT NULL,
		distance float,
		Latitude nvarchar(100),
		Longitude nvarchar(100)
	);

	-- Get the List of PostalCodes within XX miles of the requested postalCode
	insert into #TempZipLoc (postalcode, distance, Latitude, Longitude)
	  select postalcode, 
        dbo.CalculateDistance(Lon, Lat, @curr_Longitude, @curr_Latitude) as distance,
       	Latitude, Longitude	
		from RheemDB..PostalCode where 
		  CityType='D' and 
		  Lon Between @int_MinLongitude And @int_MaxLongitude and 
		  Lat Between @int_MinLatitude And @int_MaxLatitude;

	select org.OrganizationName, a.AddressLine1, a.City, a.State, a.PostalCode, org.Phone, do.WebSite,
	        Latitude, Longitude, distance
      from rheemusers..DistributorOrganization do 
        inner join rheemusers..Address a on do.PrimaryAddressID = a.AddressID
		Inner Join #TempZipLoc tz on a.PostalCode = tz.PostalCode
        inner join rheemusers..Organization org on do.OrganizationID = org.OrganizationID
         where ProStockStores=1 and 
            ([Disabled] = 0 or [Disabled] is null)
      order by distance

END
GO
