USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FindContractorZips]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[FindContractorZips]
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
CREATE PROCEDURE [dbo].[FindContractorZips] 
	-- Add the parameters for the stored procedure here
	@OrganizationID uniqueidentifier
		
as
BEGIN
	declare @inzip varchar(256)
	declare @inlat float
	declare @inlong float
	declare @latDiff float
	declare @longDiff float
	declare @maxDistance float

	select top 1  @maxDistance = radius, @inzip = dbo.postalpart(a.postalcode), @inlat =
		latitude, @inlong = longitude
		from rheemusers..ContractorOrganization co
		INNER JOIN rheemusers..Address a on co.PrimaryAddressID = a.AddressID
		INNER JOIN rheemdb..postalcode p on 	a.postalcode = p.postalcode
		 where co.OrganizationID = @organizationID
     
	if datalength(@inzip) > 0 
	begin
    	if @maxDistance > 25
		begin
			select @maxDistance = 25
		end

		if @inlat <> 0
		begin
			set @latDiff = dbo.LatitudePlusDistance(@inlat, @maxDistance) - @inlat
			set @longDiff = dbo.LongitudePlusDistance(@inlong, @inlat, @maxDistance) - @inlong

			create table #TempZipLoc (
			    rowID INT IDENTITY PRIMARY KEY,
				postalcode varchar(100) NOT NULL,
				county varchar(100),
				stateorprovince varchar(100),
				CountryName Varchar(100),
				selected int,
				distance float 
			)
			
			insert into #TempZipLoc
			select postalcode, county, stateorprovincecode, CountryName, 1 as selected,
				dbo.CalculateDistance (Lon, Lat, @inlong, @inlat)
				as distance 
				from rheemdb..postalcode where 
				Lat > @inlat - @latDiff and
				Lat < @inlat + @latDiff and 
				Lon > @inlong - @longDiff and
				Lon < @inlong + @longDiff 

			delete from #tempziploc where distance > @maxDistance
			
			insert into #TempZipLoc
			select postalcode, county, StateOrProvinceCode, CountryName, 1 as selected,
				dbo.CalculateDistance (Lon, Lat, @inlong, @inlat)
				as distance 
				from rheemdb..postalcode where
				postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
				organizationID = @organizationID  and Exclude = 0)
			
			Delete from #TempZipLoc where 
			  postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
				organizationID = @organizationID and Exclude = 1)
            
            			-- Get rid of Duplicate PostalCodes This is fancy stuff here
			DELETE t1 From #TempZipLoc t1, #TempZipLoc t2 WHERE t1.postalcode = t2.postalcode AND
			                           t1.rowID > t2.rowID
            
           Select postalcode, rheemdb.dbo.GetPostalCodeCityList(postalcode) as City, county, 
              stateorprovince, CountryName, selected, distance
            from #TempZipLoc order by postalcode
			
			
		select distinct postalcode, rheemdb.dbo.GetPostalCodeCityList(postalcode) as City,
		     county, StateOrProvinceCode as stateorProvince, CountryName, 1 as selected,
			 dbo.CalculateDistance (Lon, Lat, @inlong, @inlat) as distance 
			from rheemdb..postalcode where
			postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
			organizationID = @organizationID  and Exclude = 0) order by postalCode
			
	    select distinct postalcode, rheemdb.dbo.GetPostalCodeCityList(postalcode) as City,
		     county, stateorprovincecode as stateorProvince, CountryName, 1 as selected,
			 dbo.CalculateDistance (Lon, Lat, @inlong, @inlat) as distance 
			from rheemdb..postalcode where
			postalcode in (select postalcode from rheemusers..contractorZipCodeCoverage where
				organizationID = @organizationID and Exclude = 1)
				
		drop table #TempZipLoc
		end
	end
END
GO
