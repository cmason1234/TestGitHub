Use econet;

CREATE TABLE IF NOT EXISTS userlocationmac(
	UserLocationMACId INT NOT NULL AUTO_INCREMENT,
	UserLocationId INT NOT NULL,
	MACAddress varchar(50) NOT NULL,
	Paired bit NOT null default 0,
	ServerId INT NULL, 
	PortNumber INT NOT NULL,
	RemoteEndPoint varchar(50) NOT NULL,
	SocketSessionId varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserLocationMACId),
		CONSTRAINT FK_UserLocationMAC_1 FOREIGN KEY (UserLocationId) 
			REFERENCES userlocation(UserLocationId) ON DELETE CASCADE,
		CONSTRAINT FK_UserLocationMAC_2 FOREIGN KEY (ServerId) 
			REFERENCES server(ServerId) ON DELETE NO ACTION

);

call rheem.CreateIndexIfNotExists('econet', 'UserLocationMAC_idx1', 'userlocationmac', 'UserLocationId', null);
call rheem.CreateIndexIfNotExists('econet', 'UserLocationMAC_idx2', 'userlocationmac', 'MACAddress', null);

