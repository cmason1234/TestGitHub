Use econet;

CREATE TABLE IF NOT EXISTS schedule(
	ScheduleId INT NOT NULL AUTO_INCREMENT ,
	EquipmentId INT NOT NULL,
	ScheduleDay INT NOT NULL,
	SchedulePart INT NOT NULL,
	ScheduleTime INT NOT NULL,
	ScheduleCoolTemp INT NOT NULL,
	ScheduleHeatTemp INT NOT NULL,
	ScheduleFan INT NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (ScheduleId),
		CONSTRAINT FK_Schedule_2 FOREIGN KEY (EquipmentId) REFERENCES equipment(EquipmentId) ON DELETE CASCADE
		
);

call rheem.CreateIndexIfNotExists('econet', 'Schedule_idx1', 'schedule', 'EquipmentId', null);

-- ScheduleDay 		(1-9) 1 = Monday, 7 = Sunday, 8 = m-f, 9 = sat,sun
-- SchedulePart		(0-4) 0 = Not Set, 1 = Morning, 2 = Day, 3 = Evening, 4 = Night
-- ScheduleTime 	(01:00:00 - 24:59:00) stored as minutes since midnight
-- ScheduleFan		(0-2) 0 = Off, 1 = Onn, 2 = Auto


