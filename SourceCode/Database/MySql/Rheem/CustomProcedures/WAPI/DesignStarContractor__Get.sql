USE rheem;

DROP PROCEDURE IF Exists WAPI__DesignStarContractor__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__DesignStarContractor__Get(
    IN organizationID varchar(64))
BEGIN

	select 
		 o2.OrganizationID DistributorOrganizationID, o2.OrganizationName DistributorName, 
		 a2.AddressLine1 DistributorAddressLine1,  a2.AddressLine2 DistributorAddressLine2, 
		 a2.City DistributorCity,  a2.State DistributorState, a2.PostalCode DistributorPostalCode,
		 o2.Phone DistributorPhone, 		
		 o.OrganizationID ContractorOrganizationID, o.OrganizationName ContractorName, 
		 a.AddressLine1 ContractorAddressLine1,  a.AddressLine2 ContractorAddressLine2, 
		 a.City ContractorCity,  a.State ContractorState, a.PostalCode ContractorPostalCode, 
		 o.Phone ContractorPhone, o.Phone2 ContractorPhone2, o.Fax ContractorFax,  
		 b.BrandName, cac.Contact, co.Website, co.CorporateEmail, co.Radius, 
		 cac.DesignStar, cac.DesignStarActive
	  from ru_organization o
	    INNER JOIN ru_contractorac cac ON cac.OrganizationID = o.OrganizationID
		INNER JOIN ru_contractororganization co on cac.OrganizationID = co.OrganizationID
		INNER JOIN rdb_brand b ON cac.BrandID = b.BrandID and 
		     (b.BrandName like 'Rheem%' or b.BrandName like 'Ruud%')
		INNER JOIN ru_organization o2 ON cac.DistributorOrganizationID = o2.OrganizationID
		INNER JOIN ru_distributororganization diso ON o2.OrganizationID = diso.OrganizationID
		LEFT OUTER JOIN ru_address a ON co.PrimaryAddressID = a.AddressID
		LEFT OUTER JOIN ru_address a2 ON diso.PrimaryAddressID = a2.AddressID
		   where o.OrganizationID =  OrganizationID;

END$$
DELIMITER ;

