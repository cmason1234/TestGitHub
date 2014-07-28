USE econet;

drop procedure if exists GetUserLocationMACsForOneUser;
/*
delimiter $$
create procedure GetUserLocationMACsForOneUser(
	IN p_userId int)
begin

	SELECT us.SystemName,
		   us.IsConnected,
		   us.UserSystemId,
		   ulm.UserLocationMACId,
		   ulm.UserLocationId,
		   ulm.MACAddress,
		   ulm.Paired,
		   ulm.PortNumber,
		   ulm.RemoteEndPoint
	FROM econet.usersystem us
		INNER JOIN econet.userlocationmac ulm ON ulm.UserLocationMACId=us.UserLocationMACId
		INNER JOIN econet.userlocation ul ON ul.UserLocationId=ulm.UserLocationId
		INNER JOIN econet.user u ON u.UserId=ul.UserId
	WHERE ul.UserId=p_userId;

end; $$
delimiter ';'
*/

