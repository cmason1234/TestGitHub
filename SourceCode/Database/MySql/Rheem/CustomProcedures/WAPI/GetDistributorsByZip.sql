USE rheem;

DROP PROCEDURE IF Exists WAPI__DistributorsByZip__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__DistributorsByZip__Get(
    -- Add the parameters for the stored procedure here
    IN p_PostalCode varchar(50),
	IN p_BrandID varchar(64))

  BEGIN
	Declare curr_Longitude, curr_Latitude,
	    int_MinLongitude, int_MaxLongitude, 
	    int_MinLatitude, int_MaxLatitude float;
 
    Declare p_Radius int;
	
    -- Get the lat/long for the given zip  ALSO we are getting contractors within
	--    100 miles of the given PostalCode
	Select  Lon, Lat, 100 into curr_Longitude, curr_Latitude, p_Radius
      From rdb_postalcode
		Where  PostalCode = p_PostalCode and CityType='D';

	select LatitudePlusDistance(curr_Latitude, p_Radius),  
	       LongitudePlusDistance(curr_Longitude, curr_Latitude, p_Radius) 
	into int_MaxLatitude, int_MaxLongitude;
	   
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

	drop TEMPORARY table if exists TempContractors;

	Create TEMPORARY Table if not exists TempContractors (
		OrganizationID varchar(64),
		OrganizationName varchar(300),
		DistributorOrganizationID varchar(64),
	    distance float
	);

	SELECT DISTINCT o.OrganizationID, o.OrganizationName, o.Phone,
		 oa.AddressLine1, oa.AddressLine2, oa.City, oa.State, oa.PostalCode
	  FROM
		 (
			SELECT cac.DistributorOrganizationID,  a.PostalCode, co.Radius
			  FROM ru_contractorac cac
				INNER JOIN ru_contractororganization co on co.OrganizationID=cac.OrganizationID and 
					  co.Disabled = 0
				INNER JOIN ru_address a on co.PrimaryAddressID = a.AddressID
				INNER JOIN ru_organizationbrand ob on ob.OrganizationID = cac.OrganizationID AND
						   ob.BrandID = p_BrandID
			  WHERE cac.Disabled = 0
		 ) dist
		 INNER JOIN TempZipLoc tz on dist.PostalCode = tz.postalcode and
					tz.distance <= dist.Radius
		 INNER JOIN ru_organization o on dist.DistributorOrganizationID = o.OrganizationID
		 INNER JOIN ru_address oa on o.PrimaryAddressID=oa.AddressID
      ORDER BY o.OrganizationName;
	   

END$$
DELIMITER ;

