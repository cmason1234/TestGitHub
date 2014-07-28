USE `econet`;
DROP procedure IF EXISTS `GetEquipmentForPollingPaired`;

/*
DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `GetEquipmentForPollingPaired` (
	IN p_IpAddress varchar(45),
	p_EquipmentMasterId Int,
	p_objName varchar(45),
	p_DoUnPaired Bit)
BEGIN

	select distinct ulm.UserLocationMacId, e.EquipmentId, e.DestinationAddress
	FROM server s 
	   INNER JOIN userlocationmac ulm ON s.ServerId=ulm.ServerId
	   INNER JOIN equipment e ON ulm.UserLocationMACID=e.UserLocationMACId and e.IsConnected = 1 and e.EquipmentMasterId = p_EquipmentMasterId
	   INNER JOIN messagequeue mq ON ulm.UserLocationMacId=mq.UserLocationMacId AND (0=(select count(*) from messagequeue 
				         where ObjName=p_objName and UserLocationMacId=ulm.UserLocationMacId))
	where s.IpAddress = p_IpAddress
	
	;
END$$

DELIMITER ;
*/