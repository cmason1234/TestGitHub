Use econet;

CREATE TABLE IF NOT EXISTS equipmentalert(
	EquipmentAlertId INT NOT NULL AUTO_INCREMENT ,
	EquipmentId INT NOT NULL,
	AlertDescription varchar(50) NOT NULL,
	UserId INT NULL,
	UserLocationId INT NULL,
	AlertDetailId INT NULL,
	AlertRead bit NOT NULL DEFAULT 0,
	AlertArchive bit NOT NULL DEFAULT 0,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentAlertId),
		CONSTRAINT FK_EquipmentAlert_1 FOREIGN KEY (EquipmentId)  
		REFERENCES equipment(EquipmentId) ON DELETE CASCADE
);

call rheem.AddColumnIfNotExists('econet', 'equipmentalert', 'AlertCleared',  'BIT NOT NULL DEFAULT 0');

call rheem.CreateForeignKeyIfNotExists('econet', 'FK_EquipmentAlert_2', 'equipmentalert', 'AlertDetailId', 'alertdetail', 'AlertDetailId', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateIndexIfNotExists('econet', 'EquipmentAlert_idx1', 'equipmentalert', 'EquipmentId', null);

