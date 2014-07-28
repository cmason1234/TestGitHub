Use econet;

CREATE TABLE IF NOT EXISTS server(
	ServerId INT NOT NULL AUTO_INCREMENT ,
	IPAddress VARCHAR(50) NOT NULL,
	PortNumberListen INT NOT NULL DEFAULT 0,
	Threshold INT NOT NULL DEFAULT 0,
	CurrentConnections INT NOT NULL DEFAULT 0,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (ServerId)		
);

call rheem.CreateForeignKeyIfNotExists('econet', 'FK_MACUnPaired_1', 'macunpaired', 'ServerId', 'server', 'ServerId', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateIndexIfNotExists('econet', 'MACUnPaired_idx1', 'macunpaired', 'ServerId', null);


