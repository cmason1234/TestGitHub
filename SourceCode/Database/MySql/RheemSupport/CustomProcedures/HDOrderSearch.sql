USE support;

drop procedure if exists HDOrderSearch;

delimiter $$
create procedure HDOrderSearch(
    IN p_PersonID varchar(64),
    IN p_StartDate varchar(50),
	IN p_EndDate varchar(50)
	)
begin
	select ho.hdOrderId, ho.LeadNumber, ho.PONumber, ho.VendorNumber,
		ho.CreateDateTime__Gen, ho.HomeOwnerName, p.FirstName, p.LastName, 
		co.OrganizationName as contractorName,    
		 disto.OrganizationName as distributorName  
	   from hdorder ho
	   inner join hdordershipping hs on ho.hdOrderId = hs.hdOrderId
	   inner join rheem.ru_person p on ho.EnteredByID = p.PersonID
	   inner join rheem.ru_organization co on ho.ContractorOrgID=co.OrganizationID
	   INNER JOIN rheem.ru_myorganizations mo on ho.ContractorOrgID = mo.OrganizationID and
	                       mo.PersonID = p_PersonID
	   LEFT OUTER JOIN rheem.ru_organization disto on ho.DistributorOrgID=disto.OrganizationID
		 where ho.CreateDateTime__Gen between DATE(p_StartDate) AND DATE(p_EndDate)
	   Order by  ho.CreateDateTime__Gen desc;
	 
end; $$
delimiter ';'

