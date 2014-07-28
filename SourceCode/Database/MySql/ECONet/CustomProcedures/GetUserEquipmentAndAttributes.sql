USE econet;

drop procedure if exists GetUserEquipmentAndAttributes;

delimiter $$
create procedure GetUserEquipmentAndAttributes(
	IN p_userId int)
begin

	SELECT SQL_NO_CACHE e.EquipmentId,
		   ul.UserLocationId,
		   ulm.UserLocationMACId,
		   ulm.MACAddress,
		   e.Category,
		   e.SubCategory,
		   e.SystemName,
		   e.IsConnected,
(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRSETP' Order by equipmentattributeId desc Limit 1) As SetPoint,
(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRCNFG' Order by equipmentattributeId desc Limit 1) As Mode,
(Select objLowerLimit From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRCNFG' Order by equipmentattributeId desc Limit 1) As LowerLimit,
(Select objValue From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRENAB' Order by equipmentattributeId desc Limit 1) As Enabled,
(Select objHigherLimit From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRSETP' Order by equipmentattributeId desc Limit 1) As MaxTemp,
(Select objLowerLimit From equipmentattribute Where EquipmentId = e.EquipmentId and ObjName='WHTRSETP' Order by equipmentattributeId desc Limit 1) As MinTemp,
(Select count(*) From equipmentalert where equipmentid in (select equipmentId from equipment where UserLocationMACID = ulm.UserLocationMACID) and AlertRead = 0 and AlertCleared = 0) as AlertCount	
	FROM econet.equipment e
		INNER JOIN econet.userlocationmac ulm ON ulm.UserLocationMACId=e.UserLocationMACId
		INNER JOIN econet.userlocation ul ON ul.UserLocationId=ulm.UserLocationId
		INNER JOIN econet.user u ON u.UserId=ul.UserId
		INNER JOIN econet.equipmentmaster em ON em.EquipmentMasterID=e.EquipmentMasterID
	WHERE u.UserId=p_userId
	and em.DisplayInMobile = 1
	and e.EquipmentMasterID <> 15;

end; $$
delimiter ';'

