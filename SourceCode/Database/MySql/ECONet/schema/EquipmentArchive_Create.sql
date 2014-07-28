Use econet;

CREATE TABLE IF NOT EXISTS equipmentarchive(
	EquipmentId INT NOT NULL,
	EquipmentMasterId INT NOT NULL,
	ModelNumber varchar(50) NOT NULL,
	SerialNumber varchar(50) NULL,
	UserLocationMACId INT NULL DEFAULT NULL,
	MACUnpairedId  INT NULL DEFAULT NULL,
	SystemName varchar(50) NOT NULL,
	IsConnected bit NOT NULL,
	Category varchar(50) NOT NULL,
	SubCategory varchar(50) NOT NULL,
	DestinationAddress INT NULL,
	DestinationBus INT NULL,
	CreateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentId) 
);


 
