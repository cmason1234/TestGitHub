USE rheem;

DROP PROCEDURE IF Exists GetEmailAddressForEmailList;

DELIMITER $$
CREATE PROCEDURE GetEmailAddressForEmailList(
	IN p_ListName varchar(50))
BEGIN

	select p.EmailAddress, l.ListType from ru_lists l 
		inner join ru_listuserlist lul on l.ListID=lul.ListID
		inner join ru_person p on lul.PersonID=p.PersonID and (p.Disabled is null or p.Disabled = 0)
	   where l.ListName = p_ListName
	union
	select le.EmailAddress, l.ListType from ru_lists l
		inner join ru_listemailaddress le on l.ListID=le.ListID
	   where l.ListName = p_ListName;

END$$
DELIMITER ;
