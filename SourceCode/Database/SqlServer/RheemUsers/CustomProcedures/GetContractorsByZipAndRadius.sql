USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorsByZipAndRadius]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorsByZipAndRadius]
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
CREATE PROCEDURE [dbo].[GetContractorsByZipAndRadius]
    -- Add the parameters for the stored procedure here
    @PostalCode varchar(50),
	@Radius int, 
	@HeatCool bit,
	@WHRes bit,
	@WHComm bit,
	@WHTankless bit,
	@SolarWH bit,
	@HomeGen bit,
	@PoolSpa bit,
	@DesignStar bit,
	@KwikComfort bit,
	@PPlus bit,
	@Cashback bit,
	@TC bit,
	@ASP bit,
	@Rheem bit,
	@Ruud bit

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	Declare @Longitude Decimal(8,5),
        @Latitude Decimal(8,5),
        @MinLongitude Decimal(8,5),
        @MaxLongitude Decimal(8,5),
        @MinLatitude Decimal(8,5),
        @MaxLatitude Decimal(8,5)
 
    -- Get the lat/long for the given zip
	Select @Longitude = Lon, @Latitude = Lat	From rheemdb..PostalCode
		Where  PostalCode = @PostalCode and CityType='D'
 
    -- Calculate the Max Lat/Long
	Select @MaxLongitude = dbo.LongitudePlusDistance(@Longitude, @Latitude, @Radius),
			@MaxLatitude = dbo.LatitudePlusDistance(@Latitude, @Radius)
 
    -- Calculate the min lat/long
	Select @MinLatitude = 2 * @Latitude - @MaxLatitude,
       @MinLongitude = 2 * @Longitude - @MaxLongitude
  
	create table #TempZipLoc (
		rowID INT IDENTITY PRIMARY KEY,
		postalcode varchar(100) NOT NULL,
		distance float 
	)
	
	-- Get the List of PostalCodes within XX miles of the requested postalCode
	insert into #TempZipLoc
	  select postalcode, 
		dbo.CalculateDistance(@Longitude, @Latitude, Lon, Lat) 
		as distance 
		from rheemdb..postalcode where 
		  CityType='D' and 
		  Lon Between @MinLongitude And @MaxLongitude and 
		  Lat Between @MinLatitude And @MaxLatitude
		  
    -- Get rid of any that happen to lie outside the radius the user wants
	--  It can happen, since we draw a box, slightly bigger than 
	--    the circle we want.
	delete from #tempziploc where distance > @Radius

	Create Table #TempContractors (
	    rowID INT IDentity Primary Key,
		OrganizationID uniqueIdentifier,
		OrganizationName varchar(300),
		Phone varchar(50),
		ACContractor bit, 
		WaterHeaterContractor bit,
		PoolAndSpaContractor bit,
		GeneratorContractor bit,
		KwikComfort bit,
		WebSite varchar(128), 
		postalcode varchar(100) NOT NULL,
	    distance float,
	    GEN bit default 0,
		GENRheem bit default 0,
		GENRuud bit default 0,
		AC bit default 0,
		PS bit  default 0,
		WHCom bit default 0,
		WHRes bit default 0,
		WHTankless bit default 0,
		WHSolar bit default 0,
		ACRheem bit default 0,
		ACRheemTeam bit default 0,
		ACRuud bit default 0,
		ACRuudReliable bit default 0,
		WHRuud bit default 0,
		WHRheem bit default 0,
		WHRichmond bit default 0,
		WHPlace bit default 0,
		ACPlace bit default 0,
		ShowNateLogo bit default 0,
		HomeDepot bit default 0,
		DesignStar bit default 0,
		PPlus bit default 0,
		Cashback bit default 0,
		ASP bit default 0,
		WHInstall bit default 0,
		TopTen bit default 0
	)
    -- Get a list of contractors with primaryAddresses in any of the 
	--   postal codes we got above, who have a service radius that is 
	--    greater than the radius we are looking for OR 
	--     specifically service 
	insert into #TempContractors (organizationID, organizationName, phone,
	      WebSite, ACContractor, WaterHeaterContractor, 
		  PoolAndSpaContractor, GeneratorContractor, KwikComfort, postalcode, distance) 
		select co.organizationID, O.OrganizationName, O.Phone, co.WebSite, 
		  ACContractor, WaterHeaterContractor, PoolAndSpaContractor, 
		  GeneratorContractor, KwikComfort, 
		  tz.postalcode, tz.distance from ContractorOrganization co
		    INNER JOIN Organization O ON O.OrganizationID = CO.OrganizationID  
			inner join Address a on co.PrimaryAddressID = a.AddressID
			inner join #TempZipLoc tz on a.PostalCode = tz.postalcode and
			   tz.distance < co.Radius
		UNION
		select co.organizationID, O.OrganizationName, O.Phone, co.WebSite, 
		  ACContractor, WaterHeaterContractor, PoolAndSpaContractor, 
		  GeneratorContractor, KwikComfort, 
		  tz.postalcode, tz.distance from contractorOrganization co
		    INNER JOIN Organization O ON O.OrganizationID = CO.OrganizationID 
			inner join Address a on co.PrimaryAddressID = a.AddressID
			inner join #TempZipLoc tz on tz.PostalCode = @PostalCode
		  where co.OrganizationID in (select OrganizationID from rheemusers..contractorZipCodeCoverage where
					postalcode= @PostalCode  and Exclude = 0)
				
	-- Now remove any that specifically DON'T service a postal code
	Delete from #TempContractors where Organizationid in 
	   (select OrganizationID from rheemusers..contractorZipCodeCoverage 
	      where postalcode= @PostalCode and Exclude = 1)

    --  Now go set the bits of each organization, based on the lower level tables
    --  The isnull's may not be totally needed, but they don't cost much.
    Update cont set cont.AC=1, 
       cont.ACRheem = 
         (CASE 
            WHEN BrandID in ('3469e15a-b68d-4d4c-92ab-c372f1a6688b', 'CD6dd81a-1a25-4400-bf6a-11a5a1cf6c20') 
             THEN 1 
            ELSE 0 
           END),
        cont.ACRheemTeam =
         (CASE 
            WHEN BrandID = 'CD6dd81a-1a25-4400-bf6a-11a5a1cf6c20'
             THEN 1 
            ELSE 0 
           END),
        cont.ACRuud =
         (CASE 
            WHEN BrandID in ('87A2902B-737A-469C-BB64-B8D05B4284A3','B91B7302-2342-4B80-B14A-DD7BC9CAE8E7') 
             THEN 1 
            ELSE 0 
           END),
         cont.ACRuudReliable =
         (CASE 
            WHEN BrandID = '87A2902B-737A-469C-BB64-B8D05B4284A3'
             THEN 1 
            ELSE 0 
           END),
       cont.ACPlace = ISNULL(cac.LocatorPlacement, 0),
        cont.TopTen = ISNULL(cac.TopTen, 0),
        cont.DesignStar = ISNULL(cac.DesignStar, 0),
        cont.PPlus = ISNULL(cac.ProtectionPlus, 0),
        cont.ShowNateLogo = ISNULL(cac.ShowNateLogo, 0),
        cont.Cashback = ISNULL(cac.Cashback, 0)
        from #TempContractors cont
        INNER JOIN ContractorAC cac on cont.OrganizationID=cac.OrganizationID
       where ShowOnLocator = 1 and (Disabled = 0 or disabled is null) 
        
    Update cont set WHRheem = ISNULL(cwh.Rheem, 0), WHRuud = ISNULL(cwh.Ruud, 0),
       WHCom = ISNULL(cwh.Commercial, 0), WHRes = ISNULL(cwh.Residential, 0), 
       WHTankless = ISNULL(cwh.Tankless, 0), WHInstall = ISNULL(cwh.Installer, 0), 
       WHPlace = ISNULL(cwh.LocatorPlacement, 0), WHRichmond = ISNULL(cwh.Richmond, 0), 
       WHSolar = ISNULL(cwh.ServiceSolar, 0), ASP = ISNULL(cwh.ServiceContractor, 0)
      From  #TempContractors cont
          INNER JOIN ContractorWaterHeater cwh on cont.OrganizationID=cwh.OrganizationID 
       where ShowOnLocator = 1 and (cwh.Disabled = 0 or cwh.disabled is null) 

   Update cont set PS = 1 
      From  #TempContractors cont
          INNER JOIN ContractorPoolSpa cps on cont.OrganizationID=cps.OrganizationID 
       where ShowOnLocator = 1 and (cps.Disabled = 0 or cps.disabled is null) 

    Update cont set cont.GEN=1, 
       cont.GENRheem = 1
        from #TempContractors cont
        INNER JOIN ContractorGenerator cg on cont.OrganizationID=cg.OrganizationID
		INNER JOIN OrganizationBrand ob on cont.OrganizationID=ob.OrganizationID and
		        ob.BrandID = '3469e15a-b68d-4d4c-92ab-c372f1a6688b'
       where ShowOnLocator = 1 and (Disabled = 0 or disabled is null) 
		   
    Update cont set cont.GEN=1, 
        cont.GENRuud = 1
        from #TempContractors cont
        INNER JOIN ContractorGenerator cg on cont.OrganizationID=cg.OrganizationID
		INNER JOIN OrganizationBrand ob on cont.OrganizationID=ob.OrganizationID and
		        ob.BrandID = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7'
       where ShowOnLocator = 1 and (Disabled = 0 or disabled is null) 

   Update cont set HomeDepot = ISNULL(cr.HomeDepot, 0) 
      From  #TempContractors cont
          INNER JOIN ContractorRetail cr on cont.OrganizationID=cr.OrganizationID 
       where HDShowOnLocator = 1 and (cr.Disabled = 0 or cr.disabled is null) 

	SELECT * FROM #TempContractors WHERE 
	   @HeatCool=1 AND AC=1 AND
	   (ACRheem = @Rheem OR ACRheemTeam = @Rheem OR ACRuud = @Ruud or ACRuudReliable = @Ruud) AND
	   (@KwikComfort IS NULL OR KwikComfort = @KwikComfort) AND
	   (@DesignStar IS NULL OR DesignStar = @DesignStar) AND
	   (@PPlus IS NULL  OR PPlus = @PPlus) AND
	   (@Cashback IS NULL or Cashback = @Cashback) AND
	   (@TC IS NULL or TopTen = @TC)
	UNION
	 SELECT * from #TempContractors WHERE
	    @WHRes=1 AND WHRes=1 AND
	   (WHRheem = @Rheem OR WHRuud = @Ruud) AND
	   (@ASP IS NULL OR ASP = @ASP)
	UNION
	 SELECT * from #TempContractors WHERE
	    @WHComm=1 AND WHCom=1 AND
	   (WHRheem = @Rheem OR WHRuud = @Ruud) AND
	   (@ASP IS NULL OR ASP = @ASP)
	UNION
	 SELECT * from #TempContractors WHERE
	    @WHTankless=1 AND WHTankless=1 AND
	   (WHRheem = @Rheem OR WHRuud = @Ruud) AND
	   (@ASP IS NULL OR ASP = @ASP)
	UNION
	 SELECT * from #TempContractors WHERE
	    @SolarWH=1 AND WHSolar=1 AND
	   (WHRheem = @Rheem OR WHRuud = @Ruud) AND
	   (@ASP IS NULL OR ASP = @ASP)
	UNION
	 SELECT * from #TempContractors WHERE
	    @PoolSpa=1 AND PS=1
 	UNION
	 SELECT * from #TempContractors WHERE
	    @HomeGen=1 AND GEN=1 AND
	   (GenRheem = @Rheem OR GENRuud = @Ruud)
	 Order by ACPlace DESC, WHPlace DESC, TopTen DESC,  ACRheemTeam DESC, 
	     ACRheem DESC, ACRuudReliable DESC, ACRuud Desc, ShowNateLogo DESC, 
	     HomeDepot DESC, Distance ASC,  
	     OrganizationName ASC, WHInstall desc, ASP ASC


END
GO


