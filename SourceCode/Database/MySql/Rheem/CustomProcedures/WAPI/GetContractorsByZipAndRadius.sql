USE rheem;

DROP PROCEDURE IF Exists WAPI__ContractorsByZipAndRadius__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ContractorsByZipAndRadius__Get(
    -- Add the parameters for the stored procedure here
    IN p_PostalCode varchar(50),
	IN p_Radius int, 
	IN p_HeatCool bit,
	IN p_WHRes bit,
	IN p_WHComm bit,
	IN p_WHTankless bit,
	IN p_SolarWH bit,
	IN p_HomeGen bit,
	IN p_PoolSpa bit,
	IN p_DesignStar bit,
	IN p_KwikComfort bit,
	IN p_PPlus bit,
	IN p_Cashback bit,
	IN p_TC bit,
	IN p_ASP bit,
	IN p_Rheem bit,
	IN p_Ruud bit)

  BEGIN
	Declare longFudge, latDiff, longDiff, 
	    curr_Longitude, curr_Latitude,
	    int_MinLongitude, int_MaxLongitude, 
	    int_MinLatitude, int_MaxLatitude float;
 
    -- Get the lat/long for the given zip
	Select  Lon, Lat into curr_Longitude, curr_Latitude From rdb_postalcode
		Where  PostalCode = p_PostalCode and CityType='D';

	select LatitudePlusDistance(curr_Latitude, p_Radius) into int_MaxLatitude;
	select LongitudePlusDistance(curr_Longitude, curr_Latitude, p_Radius) 
       INTO int_MaxLongitude;
	   
	SELECT 2*curr_Latitude - int_MaxLatitude, 2*curr_Longitude - int_MaxLongitude
	      INTO int_MinLatitude, int_MinLongitude;

    drop TEMPORARY table if exists TempZipLoc;

	create TEMPORARY table IF NOT EXISTS TempZipLoc (
		postalcode varchar(100) NOT NULL,
		distance float
	);

	-- Get the List of PostalCodes within XX miles of the requested postalCode
	insert into TempZipLoc (postalcode, distance)
	  select postalcode, 
        CalculateDistance(Lon, Lat, curr_Longitude, curr_Latitude) as distance 
		from rdb_postalcode where 
		  CityType='D' and 
		  Lon Between int_MinLongitude And int_MaxLongitude and 
		  Lat Between int_MinLatitude And int_MaxLatitude;

    -- Get rid of any that happen to lie outside the radius the user wants
	--  It can happen, since we draw a box, slightly bigger than 
	--    the circle we want.
	delete from TempZipLoc where distance > p_Radius;

	drop TEMPORARY table if exists TempContractors;

	Create TEMPORARY Table if not exists TempContractors (
		OrganizationID varchar(64),
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
		CorporateEmail varchar(50),
		CorporateEmail2 varchar(50),
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
		TopTen bit default 0,
        TopOne bit default 0
	);

	drop TEMPORARY table if exists TempContractors2;

	Create TEMPORARY Table if not exists TempContractors2 as select * from TempContractors;

    -- Get a list of contractors with primaryAddresses in any of the 
	--   postal codes we got above, who have a service radius that is 
	--    greater than the radius we are looking for OR 
	--     specifically service 
      -- Determine if the Distance needs to be calculated for
	-- Rows which are part of the specifically included part of this Union
	insert into TempContractors (organizationID, organizationName, phone,
	      WebSite, ACContractor, WaterHeaterContractor, 
		  PoolAndSpaContractor, GeneratorContractor, KwikComfort, postalcode, distance,
		  CorporateEmail, CorporateEmail2) 
		select co.organizationID, o.OrganizationName, o.Phone, co.WebSite, 
		  COALESCE(ACContractor, 0), COALESCE(WaterHeaterContractor, 0), 
          COALESCE(PoolAndSpaContractor, 0), COALESCE(GeneratorContractor, 0), 
          COALESCE(KwikComfort, 0), 
		  tz.postalcode, tz.distance, co.CorporateEmail, co.CorporateEmail2
		  from ru_contractororganization co
		    INNER JOIN ru_organization o ON o.OrganizationID = co.OrganizationID  
			inner join ru_address a on co.PrimaryAddressID = a.AddressID
			inner join TempZipLoc tz on a.PostalCode = tz.postalcode and
			   tz.distance < co.Radius;

	insert into TempContractors2 select * from TempContractors;

	insert into TempContractors (organizationID, organizationName, phone,
	      WebSite, ACContractor, WaterHeaterContractor, 
		  PoolAndSpaContractor, GeneratorContractor, KwikComfort, postalcode, distance,
		  CorporateEmail, CorporateEmail2) 
		select co.organizationID, o.OrganizationName, o.Phone, co.WebSite, 
		  COALESCE(ACContractor, 0), COALESCE(WaterHeaterContractor, 0), 
          COALESCE(PoolAndSpaContractor, 0), COALESCE(GeneratorContractor, 0), 
          COALESCE(KwikComfort, 0), 
		  tz.postalcode, tz.distance, co.CorporateEmail, co.CorporateEmail2
		  from ru_contractorzipcodecoverage czc		  
		    INNER JOIN ru_contractororganization co ON czc.OrganizationID = co.OrganizationID 
		    INNER JOIN ru_organization o ON o.OrganizationID = co.OrganizationID 
			inner join ru_address a on co.PrimaryAddressID = a.AddressID
			inner join TempZipLoc tz on tz.PostalCode = p_PostalCode
		  where czc.postalcode=p_PostalCode  and czc.Exclude = 0 and 
             (0=(Select count(1) from TempContractors2 where czc.organizationID = organizationID));
				
	-- Now remove any that specifically DON'T service a postal code
	Delete from TempContractors where Organizationid in 
	   (select OrganizationID from ru_contractorzipcodecoverage 
	      where postalcode= p_PostalCode and Exclude = 1);

    Update TempContractors cont
        INNER JOIN ru_contractorac cac on cont.OrganizationID=cac.OrganizationID
      set cont.AC=1, 
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
       cont.ACPlace = COALESCE(cac.LocatorPlacement, 0),
        cont.TopTen = COALESCE(cac.TopTen, 0),
        cont.TopOne = COALESCE(cac.TopOne, 0),
        cont.DesignStar = COALESCE(cac.DesignStar, 0),
        cont.PPlus = COALESCE(cac.ProtectionPlus, 0),
        cont.ShowNateLogo = COALESCE(cac.ShowNateLogo, 0),
		cont.Cashback = COALESCE(cac.Cashback, 0)
       where ShowOnLocator = 1 and 
        (Disabled = 0 or disabled is null); 
        
    Update TempContractors cont
          INNER JOIN ru_contractorwaterheater cwh on cont.OrganizationID=cwh.OrganizationID 
     set WHRheem = COALESCE(cwh.Rheem, 0), 
       WHRuud = COALESCE(cwh.Ruud, 0),
       WHCom = COALESCE(cwh.Commercial, 0), 
       WHRes = COALESCE(cwh.Residential, 0), 
       WHTankless = COALESCE(cwh.Tankless, 0), 
       WHInstall = COALESCE(cwh.Installer, 0), 
       WHPlace = COALESCE(cwh.LocatorPlacement, 0), 
       WHRichmond = COALESCE(cwh.Richmond, 0), 
       WHSolar = COALESCE(cwh.ServiceSolar, 0), 
       ASP = COALESCE(cwh.ServiceContractor, 0)
	where ShowOnLocator = 1 and 
         (cwh.Disabled = 0 or cwh.disabled is null);

   Update TempContractors cont
      INNER JOIN ru_contractorpoolspa cps on cont.OrganizationID=cps.OrganizationID 
       set PS = 1 
      where ShowOnLocator = 1 and 
       (cps.Disabled = 0 or cps.disabled is null); 

    Update TempContractors cont
        INNER JOIN ru_contractorgenerator cg on cont.OrganizationID=cg.OrganizationID
		INNER JOIN ru_organizationbrand ob on cont.OrganizationID=ob.OrganizationID and
		        ob.BrandID = '3469e15a-b68d-4d4c-92ab-c372f1a6688b'
    set cont.GEN=1, 
       cont.GENRheem = 1
       where ShowOnLocator = 1 and 
        (Disabled = 0 or disabled is null);
		   
    Update TempContractors cont
        INNER JOIN ru_contractorgenerator cg on cont.OrganizationID=cg.OrganizationID
		INNER JOIN ru_organizationbrand ob on cont.OrganizationID=ob.OrganizationID and
		        ob.BrandID = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7'
      set cont.GEN=1, 
        cont.GENRuud = 1
        where ShowOnLocator = 1 and 
          (Disabled = 0 or disabled is null);

   Update TempContractors cont
          INNER JOIN ru_contractorretail cr on cont.OrganizationID=cr.OrganizationID 
     set cont.HomeDepot = COALESCE(cr.HomeDepot, 0) 
       where HDShowOnLocator = 1 and 
     (cr.Disabled = 0 or cr.disabled is null);


    -- In Sql Server this is a big Union, MySql only lets you use Temp
    -- Tables one time in a query, so this big OR does the same thing
	SELECT OrganizationID, OrganizationName, Phone, ACContractor, 
		WaterHeaterContractor, PoolAndSpaContractor, GeneratorContractor,
		KwikComfort, WebSite, postalcode, distance, GEN, GENRheem, 
		GENRuud, AC, PS, WHCom, WHRes, WHTankless, WHSolar, 
		ACRheem, ACRheemTeam, ACRuud, ACRuudReliable, WHRuud, 
		WHRheem, WHRichmond, WHPlace, ACPlace, ShowNateLogo,
		HomeDepot, DesignStar, PPlus, Cashback, ASP, WHInstall, 
		TopTen, TopOne, CorporateEmail, CorporateEmail2
   FROM TempContractors WHERE 
       (
  	     p_HeatCool=1 AND AC=1 AND
	     ((p_Rheem = 1 AND (ACRheem = p_Rheem OR ACRheemTeam = p_Rheem)) OR 
          (p_Ruud = 1 AND (ACRuud = p_Ruud OR ACRuudReliable = p_Ruud))) AND
	     (p_KwikComfort = 0 OR KwikComfort = p_KwikComfort) AND
	     (p_DesignStar = 0 OR DesignStar = p_DesignStar) AND
	     (p_PPlus = 0  OR PPlus = p_PPlus) AND
	     (p_Cashback = 0 or Cashback = p_Cashback) AND
	     (p_TC = 0 or (ACRheemTeam = p_TC or ACRuudReliable = p_TC))
       ) OR
       (
	      p_WHRes=1 AND WHRes=1 AND
	      ( (p_Rheem = 1 AND WHRheem = p_Rheem) OR 
		    (p_Ruud = 1 AND WHRuud = p_Ruud) ) AND
	      (p_ASP = 0 OR ASP = p_ASP)
       ) OR
       (
	      p_WHComm=1 AND WHCom=1 AND
	      ( (p_Rheem = 1 AND WHRheem = p_Rheem) OR 
		    (p_Ruud = 1 AND WHRuud = p_Ruud) ) AND
	      (p_ASP = 0 OR ASP = p_ASP)
       ) OR
       (
	      p_WHTankless=1 AND WHTankless=1 AND
	      ( (p_Rheem = 1 AND WHRheem = p_Rheem) OR 
		    (p_Ruud = 1 AND WHRuud = p_Ruud) ) AND
	      (p_ASP = 0 OR ASP = p_ASP)
       ) OR
       (
	      p_SolarWH=1 AND WHSolar=1 AND
	      ( (p_Rheem = 1 AND WHRheem = p_Rheem) OR 
		    (p_Ruud = 1 AND WHRuud = p_Ruud) ) AND
	      (p_ASP = 0 OR ASP = p_ASP)
       ) OR
       (
	      p_PoolSpa=1 AND PS=1
       ) OR
       (
	      p_HomeGen=1 AND GEN=1 AND
	     ( (p_Rheem = 1 AND GenRheem = p_Rheem) OR 
		   (P_Ruud = 1 AND GENRuud = p_Ruud) )
       )
	 Order by ACPlace DESC, WHPlace DESC, TopTen DESC,  ACRheemTeam DESC, 
	     ACRheem DESC, ACRuudReliable DESC, ACRuud Desc, ShowNateLogo DESC, 
	     HomeDepot DESC, Distance ASC,  
	     OrganizationName ASC, WHInstall desc, ASP ASC;

END$$
DELIMITER ;

