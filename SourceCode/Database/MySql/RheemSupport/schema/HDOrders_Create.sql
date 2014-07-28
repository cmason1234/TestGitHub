USE support;

CREATE TABLE IF NOT EXISTS hdorder (
	hdOrderId int(11) NOT NULL AUTO_INCREMENT,
	HomeOwnerName varchar(256) NOT NULL,
	LeadNumber int(11) NOT NULL,
	PONumber varchar(256) NOT NULL,
	VendorNumber int(11) NOT NULL,
	EnteredByID varchar(64) NOT NULL,
	ContractorOrgID varchar(64) NOT NULL,
	DistributorOrgID varchar(64) NULL,
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (hdOrderId)
);

CREATE TABLE IF NOT EXISTS hdorderequipment (
	hdOrderEquipmentId int(11) NOT NULL AUTO_INCREMENT,
	hdOrderId int(11) NOT NULL,
	hdEquipOrderType Varchar(256),
	hdEquipModelNumber Varchar(256),
	hdEquipQuantity int(11),
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (hdOrderEquipmentId),
	Foreign Key(hdOrderId) references hdorder(hdOrderId) on delete cascade
);
Call rheem.AddColumnIfNotExists('support', 'hdorderequipment', 'SerialInfo', 'Varchar(1024)');


CREATE TABLE IF NOT EXISTS hdordershipping (
	hdOrderShippingId int(11) NOT NULL AUTO_INCREMENT,
	hdOrderId int(11) NOT NULL,
	ShipToName varchar(256),
	ShipToAddr1 varchar(256),
	ShipToAddr2 varchar(256),
	ShipToCity varchar(256),
	ShipToState varchar(256),
	ShipToPostalCode varchar(256),
	PhoneOrderFrom varchar(2048),
	OtherItems varchar(2048),
	ShipType varchar(256),
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (hdOrderShippingId),
	Foreign Key(hdOrderId) references hdorder(hdOrderId) on delete cascade
);