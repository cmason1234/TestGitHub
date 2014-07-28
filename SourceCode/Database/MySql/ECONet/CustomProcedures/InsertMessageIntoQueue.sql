USE `econet`;
DROP procedure IF EXISTS `InsertMessageIntoQueue`;

DELIMITER $$
USE `econet`$$
CREATE PROCEDURE `InsertMessageIntoQueue` (
	IN p_MessageToken varchar(45),
	p_EquipmentId Int,
	p_objName varchar(500),
	p_MessageType varchar(45),	
	p_MessageRequest varbinary(1024),
	p_ClientDateTime DATETIME)
BEGIN

	DECLARE d_UserLocationMacId INT;
	DECLARE d_MACUnpairedId INT;
	DECLARE d_DestinationAddress INT;
	DECLARE d_RowCount INT;
	
	SELECT SQL_NO_CACHE UserLocationMacId INTO d_UserLocationMacId
	FROM equipment
	WHERE EquipmentId = p_EquipmentId;

	SELECT SQL_NO_CACHE MACUnpairedId INTO d_MACUnpairedId
	FROM equipment
	WHERE EquipmentId = p_EquipmentId;

	SELECT SQL_NO_CACHE DestinationAddress INTO d_DestinationAddress
	FROM equipment
	WHERE EquipmentId = p_EquipmentId;
	
	/*check if objName, equipmentid and Messagetype exists*/
	SELECT SQL_NO_CACHE COUNT(*) INTO d_RowCount
	FROM messagequeue
	WHERE EquipmentId = p_EquipmentId
	AND ObjName = p_objName
	AND MessageType = p_MessageType
	AND MessageStatus <> 4
	LIMIT 1;
	
	If d_RowCount = 0 and p_EquipmentId <> 0 Then
		INSERT INTO messagequeue
		(MessageToken, UserLocationMACId, MACUnpairedId, EquipmentId, MessageType, SourceAddress, 
		DestinationAddress, MessageStatus, MessageRetry, MessageRequest,
		ClientDateTime, CreateDateTime__Gen, UpdateDateTime__Gen, ObjName)
		VALUES
		(p_MessageToken, d_UserLocationMacId, d_MACUnpairedId, p_EquipmentId, p_MessageType, 832,
		d_DestinationAddress, 1, 0, p_MessageRequest,
		p_ClientDateTime, now(), now(), p_objName);
	End If;
END$$

DELIMITER ;