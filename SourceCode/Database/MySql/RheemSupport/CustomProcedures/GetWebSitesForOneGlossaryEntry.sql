USE support;

drop procedure if exists GetWebSitesForOneGlossaryEntry;

delimiter $$
create procedure GetWebSitesForOneGlossaryEntry(
	IN p_GlossaryID int
)
begin

	SELECT rws.RheemWebSiteID,
		   rws.WebSiteName,
           rws.WebSiteURL
    FROM rheem.ru_rheemwebsite rws
		INNER JOIN support.glossarywebsite gws ON gws.RheemWebSiteID=rws.RheemWebSiteID
    WHERE gws.GlossaryId=p_GlossaryID;

end; $$
delimiter ';'

