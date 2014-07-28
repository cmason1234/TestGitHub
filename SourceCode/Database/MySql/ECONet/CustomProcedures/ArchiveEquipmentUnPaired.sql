USE econet;

drop procedure if exists ArchiveEquipmentUnPaired;

delimiter $$
create procedure ArchiveEquipmentUnPaired(
	IN p_MacUnpairedId int)
begin

		INSERT INTO equipmentarchive
			(EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
			IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus,	CreateDateTime__Gen)
				SELECT EquipmentId, EquipmentMasterId, ModelNumber, SerialNumber, UserLocationMACId, MACUnpairedId, SystemName, 
					IsConnected, Category, SubCategory, DestinationAddress,	DestinationBus, now()
				FROM equipment
				WHERE MacUnpairedId = p_MacUnpairedId;

		INSERT INTO macunpairedarchive 
			(MACUnPairedId, MACAddress, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, CreateDateTime__Gen)
				SELECT MACUnPairedId, MACAddress, ServerId, PortNumber, RemoteEndPoint, SocketSessionId, now()
				FROM macunpaired
				WHERE MacUnpairedId = p_MacUnpairedId;
				
				
		DELETE FROM messagequeue WHERE MacUnpairedId = p_MacUnpairedId;
		DELETE FROM equipment WHERE MacUnpairedId = p_MacUnpairedId;
		DELETE FROM macunpaired WHERE MacUnpairedId = p_MacUnpairedId;
		

	
end; $$
delimiter ';'

