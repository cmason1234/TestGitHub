Use econet;

CREATE TABLE IF NOT EXISTS userlocationmacarchive(
	UserLocationMACId INT NOT NULL,
	UserLocationId INT NOT NULL,
	MACAddress varchar(50) NOT NULL,
	Paired bit NOT null default 0,
	ServerId INT NULL, 
	PortNumber INT NOT NULL,
	RemoteEndPoint varchar(50) NOT NULL,
	SocketSessionId varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserLocationMACId)

);



