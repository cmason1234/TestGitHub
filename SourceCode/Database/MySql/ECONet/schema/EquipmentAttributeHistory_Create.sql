Use econet;

CREATE TABLE IF NOT EXISTS equipmentattributehistory(
	EquipmentAttributeHistoryId INT NOT NULL AUTO_INCREMENT ,
	EquipmentId INT NOT NULL,
	ObjName varchar(50) NOT NULL,
	ObjValue TEXT NOT NULL,
	UpdateDateTime__Gen datetime NOT NULL,
	CreateDateTime__Gen datetime NOT NULL,
	PRIMARY KEY (EquipmentAttributeHistoryId),
		CONSTRAINT FK_EquipmentAttributeHistory_1 FOREIGN KEY (EquipmentId) REFERENCES equipment(EquipmentId) ON DELETE CASCADE 
);

call rheem.CreateIndexIfNotExists('econet', 'EquipmentAttributeHistory_idx1', 'equipmentattributehistory', 'EquipmentId', null);

