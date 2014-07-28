USE econet;

drop procedure if exists ArchiveEquipment;

delimiter $$
create procedure ArchiveEquipment(
	IN p_UserLocationMacId int,
	p_EquipmentId int,
	p_DoAllEquipment Bit)
begin

	DECLARE d_RowCount INT;

	If p_DoAllEquipment Then

		/*check if UserLocationMACId exists*/
		SELECT COUNT(*) INTO d_RowCount
		FROM equipmentarchive
		WHERE UserLocationMACId = p_UserLocationMacId;
		
		If d_RowCount = 0 Then
			INSERT INTO equipmentarchive
				(EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
				IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus,	CreateDateTime__Gen)
					SELECT EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
						IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus, now()
					FROM equipment
					WHERE UserLocationMACId = p_UserLocationMacId;

			INSERT INTO userlocationmacarchive 
				(UserLocationMACId, UserLocationId, MACAddress, Paired, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, CreateDateTime__Gen)
					SELECT UserLocationMACId, UserLocationId, MACAddress, Paired, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, now()
					FROM userlocationmac
					WHERE UserLocationMACId = p_UserLocationMacId;
		End If;
				
		DELETE FROM messagequeue WHERE  UserLocationMACId = p_UserLocationMacId;
		DELETE FROM equipment WHERE  UserLocationMACId = p_UserLocationMacId;
		DELETE FROM userlocationmac WHERE  UserLocationMACId = p_UserLocationMacId;
		
	Else
		
		INSERT INTO equipmentarchive
			(EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
			IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus,	CreateDateTime__Gen)
				SELECT EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
					IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus, now()
				FROM equipment
				WHERE EquipmentId = p_EquipmentId;
						
		DELETE FROM messagequeue WHERE EquipmentId = p_EquipmentId;
		DELETE FROM equipment WHERE EquipmentId = p_EquipmentId;
		
	End If;
	
end; $$
delimiter ';'

