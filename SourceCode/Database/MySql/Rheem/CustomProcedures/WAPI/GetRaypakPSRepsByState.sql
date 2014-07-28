USE rheem;

DROP PROCEDURE IF Exists WAPI__GetRaypakPSRepsByState;

DELIMITER $$
CREATE PROCEDURE WAPI__GetRaypakPSRepsByState(
	-- Add the parameters for the stored procedure here
    IN p_State varchar(50))
BEGIN

	select Oterritory.OrganizationName as Territory, 
	p.FirstName, p.LastName, p.Phone , p.EmailAddress,
	pOrg.OrganizationName, pAdd.AddressLine1, pAdd.AddressLine2, 
	pAdd.City, pAdd.State, pAdd.PostalCode, p.Signature
	  from ru_organization Oterritory
	  Inner JOIN ru_organizationparent OP on 
		 Oterritory.OrganizationID=OP.OrganizationID and 
		 OP.ParentOrganizationID in (
			select OrganizationID from ru_organization oReg
			   where organizationtype='PS Region' and 
			       organizationname = p_State
		 )
	  Inner join ru_personorganization po on 
		 Oterritory.OrganizationID = po.OrganizationID 
	  Inner join ru_person p on 
		 po.personID = p.personID      
	 Inner join ru_organization pOrg on 
		 p.PrimaryOrganizationID  = pOrg.OrganizationID      
	 Inner join ru_address pAdd on 
		 p.PrimaryAddressID   = pAdd.AddressID;       

END$$
DELIMITER ;

