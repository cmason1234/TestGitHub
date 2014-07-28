USE support;

drop procedure if exists GetControllersByDomain;

delimiter $$
create procedure GetControllersByDomain(
	IN p_domain varchar(255)
	)
begin
	SELECT distinct ControllerName,'a' as BogusString
	FROM support.routedefinition rd
		INNER JOIN support.appdomain ad ON ad.appdomainid = rd.appdomainid 
	WHERE (p_domain IS NULL OR ad.DomainPrefix = p_domain);
	 
end; $$
delimiter ';'

