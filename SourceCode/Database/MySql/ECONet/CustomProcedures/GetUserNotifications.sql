USE econet;

drop procedure if exists GetUserNotifications;

delimiter $$
create procedure GetUserNotifications(
	IN p_userId int)
begin

	SELECT msg.MessageId, msg.MessageTypeId, msgt.MessageTypeName, msg.MessageTitle, msg.MessageDescription, usrmsg.OptInDate 
	FROM econet.message msg
		INNER JOIN econet.usermessage usrmsg on usrmsg.MessageId = msg.MessageId
		and usrmsg.userId = p_userId
		INNER JOIN econet.messagetype msgt on msgt.MessageTypeId = msg.MessageTypeId
	ORDER BY msg.MessageId;

end; $$
delimiter ';'

