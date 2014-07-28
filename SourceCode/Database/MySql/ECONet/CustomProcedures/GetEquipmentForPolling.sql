USE `econet`;
DROP procedure IF EXISTS `GetEquipmentForPolling`;

DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `GetEquipmentForPolling` (
	IN p_IpAddress varchar(45),
	p_EquipmentMasterId Int,
	p_objName varchar(500),
	p_DoUnPaired Bit)
BEGIN

	IF p_DoUnPaired THEN
	
		SELECT SQL_NO_CACHE distinct e.EquipmentId, e.DestinationAddress
		FROM server s 
			   INNER JOIN macunpaired mu ON s.ServerId=mu.ServerId 
			   INNER JOIN equipment e ON mu.MACUnpairedID=e.MACUnpairedID AND e.IsConnected = 1 AND e.EquipmentMasterId = p_EquipmentMasterId
					AND (0=(SELECT count(*) FROM messagequeue 
							 WHERE ObjName=p_objName AND EquipmentId=e.EquipmentId))
		WHERE s.IpAddress = p_IpAddress;
		
	ELSE
		
		SELECT SQL_NO_CACHE distinct e.EquipmentId, e.DestinationAddress
		FROM server s 
		   INNER JOIN userlocationmac ulm ON s.ServerId=ulm.ServerId
		   INNER JOIN equipment e ON ulm.UserLocationMACID=e.UserLocationMACId AND e.IsConnected = 1 AND e.EquipmentMasterId = p_EquipmentMasterId
				AND (0=(SELECT count(*) FROM messagequeue 
							 WHERE ObjName=p_objName AND EquipmentId=e.EquipmentId))
		WHERE s.IpAddress = p_IpAddress;
		
	END IF;
	
	
END$$

DELIMITER ;