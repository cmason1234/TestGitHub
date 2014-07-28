Use econet;
DROP TABLE IF EXISTS `econet`.`usersystem`;

/*
CREATE TABLE IF NOT EXISTS usersystem(
	UserSystemId INT NOT NULL AUTO_INCREMENT ,
	UserLocationMACId INT NULL DEFAULT NULL,
	SystemName varchar(50) NOT NULL,
	IsConnected bit NOT NULL default 0,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserSystemId)
);

call rheem.CreateIndexIfNotExists('econet', 'usersystem_idx1', 'usersystem', 'SystemName', null);
call rheem.AddColumnIfNotExists('econet', 'usersystem', 'MACUnpairedId',  'int NULL DEFAULT NULL');
call rheem.CreateForeignKeyIfNotExists('econet', 'FK_UserSystem_1', 'usersystem', 'UserLocationMACId', 'userlocationmac', 'UserLocationMACId', 'dropAndReplace', 'ON DELETE NO ACTION');		

*/
