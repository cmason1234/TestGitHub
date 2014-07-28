Use econet;

CREATE TABLE IF NOT EXISTS equipmentattribute(
	EquipmentAttributeId INT NOT NULL AUTO_INCREMENT ,
	EquipmentId INT NOT NULL,
	ObjNumber varchar(50) NOT NULL,
	ObjFlags varchar(50) NOT NULL,
	ObjLowerLimit varchar(50) NOT NULL,
	ObjHigherLimit varchar(50) NOT NULL,
	ObjName varchar(50) NOT NULL,
	ObjDescription varchar(50) NOT NULL,
	ObjValue TEXT NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentAttributeId),
		CONSTRAINT FK_EquipmentAttribute_1 FOREIGN KEY (EquipmentId) REFERENCES equipment(EquipmentId) ON DELETE CASCADE 
);

call rheem.CreateIndexIfNotExists('econet', 'EquipmentAttribute_idx1', 'equipmentattribute', 'EquipmentId', null);


call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'FormatByte1',  'INT NULL AFTER UpdateDateTime__Gen');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'FormatByte2',  'INT NULL AFTER FormatByte1');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'FormatByte3',  'INT NULL AFTER FormatByte2');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'FormatUnits',  'VARCHAR(45) NULL AFTER FormatByte3');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'ForceCode',  'INT NULL AFTER FormatUnits');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'DataType',  'INT NULL AFTER ForceCode');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'StatusCode',  'INT NULL AFTER DataType');
call rheem.AddColumnIfNotExists('econet', 'equipmentattribute', 'WriteForce',  'INT NULL AFTER StatusCode');
