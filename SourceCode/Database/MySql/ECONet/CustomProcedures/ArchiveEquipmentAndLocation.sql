USE econet;

drop procedure if exists ArchiveEquipmentAndLocation;

delimiter $$
create procedure ArchiveEquipmentAndLocation(
	IN p_UserLocationId int)
begin

	DECLARE d_RowCount INT;

	/*check if UserLocationMACId exists*/
	SELECT COUNT(*) INTO d_RowCount
	FROM equipmentarchive
	WHERE UserLocationMACId in (SELECT UserLocationMacId FROM userlocationmac WHERE UserLocationId = p_UserLocationId);
	
	If d_RowCount = 0 Then

		INSERT INTO equipmentarchive
			(EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
			IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus,	CreateDateTime__Gen)
				SELECT EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
					IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus, now()
				FROM equipment
				WHERE UserLocationMACId in (SELECT UserLocationMacId FROM userlocationmac WHERE UserLocationId = p_UserLocationId);

		INSERT INTO userlocationmacarchive 
			(UserLocationMACId, UserLocationId, MACAddress, Paired, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, CreateDateTime__Gen)
				SELECT UserLocationMACId, UserLocationId, MACAddress, Paired, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, now()
				FROM userlocationmac
				WHERE UserLocationId = p_UserLocationId;
				
		INSERT INTO userlocationarchive
			(UserLocationId, UserId, AddressLine1, AddressLine2, City, State, PostalCode, CountryId, LocationName, TimeZone, CreateDateTime__Gen)
			SELECT UserLocationId, UserId, AddressLine1, AddressLine2, City, State, PostalCode, CountryId, LocationName, TimeZone, now()
			FROM userlocation
			WHERE UserLocationId = p_UserLocationId;

	End If;
						
	DELETE FROM messagequeue WHERE UserLocationMACId in (SELECT UserLocationMacId FROM userlocationmac WHERE UserLocationId = p_UserLocationId);
	DELETE FROM equipment WHERE UserLocationMACId in (SELECT UserLocationMacId FROM userlocationmac WHERE UserLocationId = p_UserLocationId);
	DELETE FROM userlocationmac WHERE UserLocationId = p_UserLocationId;
	DELETE FROM userlocation WHERE UserLocationId = p_UserLocationId;
		
end; $$
delimiter ';'

