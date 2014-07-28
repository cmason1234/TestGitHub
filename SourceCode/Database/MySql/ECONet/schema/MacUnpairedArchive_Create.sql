Use econet;

CREATE TABLE IF NOT EXISTS macunpairedarchive(
	MACUnPairedId INT,
	MACAddress varchar(50) NOT NULL,
	ServerId INT NOT NULL, 
	PortNumber INT NOT NULL,
	RemoteEndPoint varchar(50) NOT NULL,
	SocketSessionId varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
    PRIMARY KEY (MACUnPairedId)
);