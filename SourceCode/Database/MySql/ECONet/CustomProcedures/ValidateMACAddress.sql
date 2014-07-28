USE econet;

drop procedure if exists ValidateMACAddress;

delimiter $$
create procedure ValidateMACAddress(
	IN p_MACAddress varchar(50))
begin

	SELECT ulm.paired, emailaddress, ulm.UserLocationMACId
	FROM userlocationmac ulm
	INNER JOIN econet.userlocation ul ON ul.userlocationId=ulm.userlocationId
	INNER JOIN econet.user u ON u.userId=ul.userId
	WHERE macaddress = p_MACAddress;

end; $$
delimiter ';'

