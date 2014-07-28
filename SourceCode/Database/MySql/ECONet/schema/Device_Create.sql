Use econet;

CREATE TABLE IF NOT EXISTS devicetype(
	DeviceTypeId INT NOT NULL AUTO_INCREMENT ,
	DeviceTypeName varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (DeviceTypeId)
);

call rheem.CreateIndexIfNotExists('econet', 'devicetype_idx1', 'devicetype', 'DeviceTypeName', null);

INSERT IGNORE INTO devicetype SET DeviceTypeId = 1, DeviceTypeName = 'Windows', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO devicetype SET DeviceTypeId = 2, DeviceTypeName = 'IOS', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO devicetype SET DeviceTypeId = 3, DeviceTypeName = 'Android', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
