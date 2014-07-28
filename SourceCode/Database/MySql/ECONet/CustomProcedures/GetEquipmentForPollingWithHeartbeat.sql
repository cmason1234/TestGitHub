USE `econet`;
DROP procedure IF EXISTS `GetEquipmentForPollingWithHeartbeat`;

DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `GetEquipmentForPollingWithHeartbeat` (
	IN p_IpAddress varchar(45),
	p_DoUnPaired Bit,
	p_PollFreq Int,
	p_EquipmentMasterId Int,
	p_objName varchar(500))
BEGIN

	DECLARE newFreq Int;
	Set newFreq = p_PollFreq - 3;

	IF p_DoUnPaired THEN
	
		SELECT SQL_NO_CACHE distinct e.EquipmentId, e.DestinationAddress, e.UserLocationMACId, e.MACUnpairedId
		FROM server s 
				INNER JOIN macunpaired mu ON s.ServerId=mu.ServerId 
				INNER JOIN equipment e ON mu.MACUnpairedID=e.MACUnpairedID AND e.IsConnected = 1 AND e.EquipmentMasterId = p_EquipmentMasterId
					AND (0=(SELECT count(*) FROM messagequeue 
							 WHERE EquipmentId=e.EquipmentId AND ObjName=p_objName LIMIT 1))
		WHERE s.IpAddress = p_IpAddress
		AND TIME_TO_SEC(TIMEDIFF(now(),e.UpdateDateTime__Gen)) > newFreq
		AND mu.SocketSessionID <> 0;
		
	ELSE
		
		SELECT SQL_NO_CACHE distinct e.EquipmentId, e.DestinationAddress, e.UserLocationMACId, e.MACUnpairedId
		FROM server s 
			INNER JOIN userlocationmac ulm ON s.ServerId=ulm.ServerId
			INNER JOIN equipment e ON ulm.UserLocationMACID=e.UserLocationMACId AND e.IsConnected = 1 AND e.EquipmentMasterId = p_EquipmentMasterId
				AND (0=(SELECT count(*) FROM messagequeue 
							 WHERE EquipmentId=e.EquipmentId AND ObjName=p_objName LIMIT 1))
		WHERE s.IpAddress = p_IpAddress
		AND TIME_TO_SEC(TIMEDIFF(now(),e.UpdateDateTime__Gen)) > newFreq
		AND ulm.SocketSessionID <> 0;
		
	END IF;
	
	
END$$

DELIMITER ;