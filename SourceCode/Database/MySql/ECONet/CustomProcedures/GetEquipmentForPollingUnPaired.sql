USE `econet`;
DROP procedure IF EXISTS `GetEquipmentForPollingUnPaired`;

/*
DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `GetEquipmentForPollingUnPaired` (
	IN p_IpAddress varchar(45),
	p_PortNumberListen Int,
	p_EquipmentMasterId Int,
	p_objName varchar(45))
BEGIN

	select distinct mu.MACUnpairedId, e.EquipmentId, e.DestinationAddress
	from server s 
		   INNER JOIN macunpaired mu ON s.ServerId=mu.ServerId 
		   INNER JOIN equipment e ON mu.MACUnpairedID=e.MACUnpairedID AND e.IsConnected = '1' and e.EquipmentMasterId = p_EquipmentMasterId
		   INNER JOIN messagequeue mq ON e.equipmentid=mq.equipmentId AND (0=(select count(*) from messagequeue 
				         where ObjName=p_objName and UserLocationMacId=ulm.UserLocationMacId))
			where s.IpAddress = p_IpAddress;
	;
END$$

DELIMITER ;
*/