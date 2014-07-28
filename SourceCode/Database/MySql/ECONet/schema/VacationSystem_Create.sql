Use econet;

CREATE TABLE IF NOT EXISTS vacationsystem(
	VacationSystemId INT NOT NULL AUTO_INCREMENT ,
	VacationId INT NOT NULL,
	EquipmentId INT NOT NULL,
	CoolTemp INT NOT NULL,
	HeatTemp INT NOT NULL,
	Fan INT NOT NULL,
	CreateDateTime__Gen datetime NOT NULL,
	UpdateDateTime__Gen datetime NOT NULL,
    PRIMARY KEY (VacationSystemId),
		CONSTRAINT FK_VacationSystem_1 FOREIGN KEY (VacationId) REFERENCES vacation(VacationId) ON DELETE CASCADE,
		CONSTRAINT FK_VacationSystem_2 FOREIGN KEY (EquipmentId) REFERENCES equipment(EquipmentId) ON DELETE CASCADE		
);

call rheem.CreateIndexIfNotExists('econet', 'VacationSystem_idx1', 'vacationsystem', 'VacationId', null);
call rheem.CreateIndexIfNotExists('econet', 'VacationSystem_idx2', 'vacationsystem', 'EquipmentId', null);
