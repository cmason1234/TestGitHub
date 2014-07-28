Use econet;

CREATE TABLE IF NOT EXISTS userdevicetoken(
	UserDeviceTokenId INT NOT NULL AUTO_INCREMENT ,
	UserId INT NOT NULL,
	DeviceToken varchar(256) NOT NULL,
	DeviceTypeId  INT NOT NULL,
	CFUUID varchar(256) NOT NULL,
	EndpointArn varchar(256) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserDeviceTokenId),
	CONSTRAINT FK_UserDeviceToken_1 FOREIGN KEY (UserId) 
			REFERENCES user(UserId) ON DELETE CASCADE,
	CONSTRAINT FK_UserDeviceToken_2 FOREIGN KEY (DeviceTypeId) 
			REFERENCES devicetype(DeviceTypeId) ON DELETE CASCADE
);

call rheem.AddColumnIfNotExists('econet', 'userdevicetoken', 'Brand', 'varchar(50) NULL');
call rheem.CreateIndexIfNotExists('econet', 'userdevicetoken_idx1', 'userdevicetoken', 'UserId', null);

