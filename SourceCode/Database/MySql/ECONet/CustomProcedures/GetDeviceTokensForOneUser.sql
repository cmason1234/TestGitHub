USE econet;

drop procedure if exists GetDeviceTokensForOneUser;

delimiter $$
create procedure GetDeviceTokensForOneUser(
	IN p_userId int)
begin

	SELECT t.UserDeviceTokenId,
		   t.UserId,
		   t.DeviceToken,
		   t.DeviceTypeId,
		   dt.DeviceTypeName
	FROM econet.userdevicetoken t
		INNER JOIN econet.devicetype dt ON dt.DeviceTypeID=t.DeviceTypeId
	WHERE t.UserId = p_userId;

end; $$
delimiter ';'

