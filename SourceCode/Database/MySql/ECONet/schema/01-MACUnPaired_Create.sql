Use econet;

CREATE TABLE IF NOT EXISTS macunpaired(
	MACUnPairedId INT NOT NULL AUTO_INCREMENT ,
	MACAddress varchar(50) NOT NULL,
	ServerId INT NOT NULL, 
	PortNumber INT NOT NULL,
	RemoteEndPoint varchar(50) NOT NULL,
	SocketSessionId varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (MACUnPairedId)
);
call rheem.CreateIndexIfNotExists('econet', 'MACUnPaired_idx2', 'macunpaired', 'MACAddress', null);
call rheem.CreateIndexIfNotExists('econet', 'MACUnPaired_idx1', 'macunpaired', 'ServerId', null);
/*call rheem.CreateForeignKeyIfNotExists('econet', 'FK_UserSystem_2', 'usersystem', 'MACUnpairedId', 'macunpaired', 'MACUnpairedId', 'dropAndReplace', 'ON DELETE NO ACTION');		*/


