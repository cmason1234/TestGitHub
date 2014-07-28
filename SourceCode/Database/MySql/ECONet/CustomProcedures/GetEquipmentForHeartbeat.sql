USE `econet`;
DROP procedure IF EXISTS `GetEquipmentForHeartbeat`;

DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `GetEquipmentForHeartbeat` (
	IN p_IpAddress varchar(45),
	p_DoUnPaired Bit)
BEGIN

	IF p_DoUnPaired THEN
	
		SELECT distinct e.EquipmentId, e.DestinationAddress, e.UserLocationMACId, e.MACUnpairedId
		FROM server s 
				INNER JOIN macunpaired mu ON s.ServerId=mu.ServerId 
				INNER JOIN equipment e ON mu.MACUnpairedID=e.MACUnpairedID AND e.IsConnected = 1
				AND (e.EquipmentMasterId = 12 or e.EquipmentMasterId = 15)
		WHERE s.IpAddress = p_IpAddress
		AND TIME_TO_SEC(TIMEDIFF(now(),e.UpdateDateTime__Gen)) > 27;
		
	ELSE
		
		SELECT distinct e.EquipmentId, e.DestinationAddress, e.UserLocationMACId, e.MACUnpairedId
		FROM server s 
			INNER JOIN userlocationmac ulm ON s.ServerId=ulm.ServerId
			INNER JOIN equipment e ON ulm.UserLocationMACID=e.UserLocationMACId AND e.IsConnected = 1 
			AND (e.EquipmentMasterId = 12 or e.EquipmentMasterId = 15)
		WHERE s.IpAddress = p_IpAddress
		AND TIME_TO_SEC(TIMEDIFF(now(),e.UpdateDateTime__Gen)) > 27;
		
	END IF;
	
	
END$$

DELIMITER ;