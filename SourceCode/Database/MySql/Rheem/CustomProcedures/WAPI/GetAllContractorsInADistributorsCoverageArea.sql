USE rheem;

DROP PROCEDURE IF Exists WAPI__AllContractorsInADistributorsCoverageArea__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__AllContractorsInADistributorsCoverageArea__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgName varchar(50),
	IN p_Distance float)

  BEGIN
	 
	 select pc2.PostalCode TargetZipcode, o.OrganizationName Contractor, a.AddressLine1, 
	    a.City, a.State, a.PostalCode,
		CalculateDistance(pc.Longitude, pc.Lat, pc2.Longitude, pc2.Lat)
		ContractorDistanceFromDistributor  
		 from ru_contractororganization co 
		   inner join ru_organization o on co.OrganizationID = o.OrganizationID 
		   inner join ru_address a on co.PrimaryAddressID = a.addressid 
		   inner join rdb_postalcode pc on a.PostalCode = pc.PostalCode and pc.CityType ='D'
		   INNER JOIN (
			 select distinct a.PostalCode
				from ru_organization o
					inner join ru_distributororganization  do on do.OrganizationID = o.OrganizationID 
						and (do.Disabled is null or do.Disabled = 0)
					inner join ru_address a on do.primaryaddressID = a.AddressID 
					INNER JOIN rdb_postalcode pc on a.PostalCode=pc.PostalCode and pc.CityType='D'
			    where o.OrganizationName like p_OrgName and 
					o.OrganizationType = 'Distributor'
		   ) tzip on 1=1
		   Inner join rdb_postalcode pc2 on pc2.PostalCode = tzip.PostalCode
			and pc2.CityType='D'
		where (co.Disabled is null or co.Disabled = '0')  and 
			CalculateDistance(pc.Longitude, pc.Lat, pc2.Longitude, pc2.Lat) < p_Distance
        ORDER BY TargetZipCode, ContractorDistanceFromDistributor;

END$$
DELIMITER ;

