USE support;

drop procedure if exists GetDivisionsForOneGlossaryEntry;

delimiter $$
create procedure GetDivisionsForOneGlossaryEntry(
	IN p_GlossaryID int
)
begin

	SELECT o.OrganizationID,
		   o.OrganizationName As DivisionName
    FROM rheem.ru_organization o
		INNER JOIN support.glossarydivision gd ON gd.OrganizationID=o.OrganizationID
    WHERE gd.GlossaryId=p_GlossaryID;

end; $$
delimiter ';'

