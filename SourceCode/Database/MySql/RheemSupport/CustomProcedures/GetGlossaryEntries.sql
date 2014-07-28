USE support;

drop procedure if exists GetGlossaryEntries;

delimiter $$
create procedure GetGlossaryEntries()
begin

	SELECT g.GlossaryId,
		   g.AlphaCharacter,
		   g.Term,
		   g.TermDefinition,
		   rws.WebSiteName,
		   o.OrganizationName As Division
	FROM support.glossary g
		LEFT OUTER JOIN support.glossarywebsite gws ON gws.GlossaryId=g.GlossaryId
		LEFT OUTER JOIN rheem.ru_rheemwebsite rws ON rws.RheemWebSiteID=gws.RheemWebSiteID
		LEFT OUTER JOIN support.glossarydivision gd ON gd.GlossaryId=g.GlossaryId
		LEFT OUTER JOIN rheem.ru_organization o ON o.OrganizationID=gd.OrganizationID
	ORDER BY g.Term;

end; $$
delimiter ';'

