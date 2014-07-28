USE support;

drop procedure if exists HDOrderFullGet;

delimiter $$
create procedure HDOrderFullGet(
    IN p_HDOrderID integer
	)
begin
	select ho.LeadNumber, ho.PONumber, ho.VendorNumber,
		ho.HomeOwnerName, concat_ws(' ', p.FirstName, p.LastName) as EnteredByName, 
		hs.ShipToName, hs.ShipToAddr1, hs.ShipToAddr2, hs.ShipToCity,
		hs.ShipToState, hs.ShipToPostalCode, hs.PhoneOrderFrom,	
		hs.OtherItems, hs.ShipType,
		co.OrganizationName as ContractorName, coa.AddressLine1 as ContractorAddr1, 
		coa.AddressLine2 as ContractorAddr2, coa.City as ContractorCity, 
		coa.State as ContractorState, coa.PostalCode as ContractorPostalCode, 
		co.Phone as ContractorPhone, co.Fax as ContractorFax,
		disto.OrganizationName as DistributorName, doa.AddressLine1 as DistributorAddr1, 
		doa.AddressLine2 as DistributorAddr2, doa.City as DistributorCity, 
		doa.State as DistributorState, doa.PostalCode as DistributorPostalCode, 
		disto.Phone as DistributorPhone, disto.Fax as DistributorFax  
	   from hdorder ho
	   inner join hdordershipping hs on ho.hdOrderId = hs.hdOrderId
	   inner join rheem.ru_person p on ho.EnteredByID = p.PersonID
	   inner join rheem.ru_organization co on ho.ContractorOrgID=co.OrganizationID
	   LEFT OUTER JOIN rheem.ru_address coa on co.PrimaryAddressID = coa.AddressID
	   LEFT OUTER JOIN rheem.ru_organization disto on ho.DistributorOrgID=disto.OrganizationID
	   LEFT OUTER JOIN rheem.ru_address doa on disto.PrimaryAddressID = doa.AddressID
		 where ho.hdOrderId = p_HDOrderID;
	 
end; $$
delimiter ';'

