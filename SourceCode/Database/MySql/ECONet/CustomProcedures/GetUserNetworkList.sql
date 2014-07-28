USE econet;

drop procedure if exists GetUserNetworkList;

delimiter $$
create procedure GetUserNetworkList(
	IN p_userId int)
begin

	SELECT e.EquipmentId,
		   ulm.MACAddress,
		   e.IsConnected,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='PRODDESC' Order by equipmentattributeId desc Limit 1) As PRODDESC,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='SW_VERSN' Order by equipmentattributeId desc Limit 1) As SW_VERSN,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WLANSTAT' Order by equipmentattributeId desc Limit 1) As WLANSTAT,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WF_SSID' Order by equipmentattributeId desc Limit 1) As WF_SSID,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WFIPADDR' Order by equipmentattributeId desc Limit 1) As WFIPADDR,
	(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WFSIGNAL' Order by equipmentattributeId desc Limit 1) As WFSIGNAL,
	(Select UpdateDateTime__GEN From equipmentattribute Where EquipmentId = e.EquipmentId Order by UpdateDateTime__GEN desc Limit 1) As LASTCOMM
	FROM econet.equipment e
		INNER JOIN econet.userlocationmac ulm ON ulm.UserLocationMACId=e.UserLocationMACId
			AND (1=(SELECT count(*) FROM equipmentattribute 
							 WHERE EquipmentId=e.EquipmentId AND ObjName='SW_VERSN' and ObjValue is not null LIMIT 1))
		INNER JOIN econet.userlocation ul ON ul.UserLocationId=ulm.UserLocationId
		INNER JOIN econet.user u ON u.UserId=ul.UserId
		INNER JOIN econet.equipmentmaster em ON em.EquipmentMasterID=e.EquipmentMasterID
	WHERE u.UserId=p_userId
	and em.equipmentmasterid = 12;

end; $$
delimiter ';'

