Use econet;

--  The DB table on the live AWS system does not match this definition.
--   and cannot be dropped without check the VacationSystem table.
CREATE TABLE IF NOT EXISTS vacation(
	VacationId INT NOT NULL AUTO_INCREMENT ,
	UserLocationId INT NOT NULL,
	VacationEnabledAC bit NOT NULL DEFAULT 0,
	VacationEnabledWH bit NOT NULL DEFAULT 0,
	VacationEnabledPool bit NOT NULL DEFAULT 0,
	StartDateTime datetime NOT NULL,
	EndDateTime datetime NOT NULL,	
	CreateDateTime__Gen datetime NOT NULL,
	UpdateDateTime__Gen datetime NOT NULL,
    PRIMARY KEY (VacationId),
		CONSTRAINT FK_Vacation_1 FOREIGN KEY (UserLocationId) REFERENCES userlocation(UserLocationId) ON DELETE CASCADE
		
);

call rheem.CreateIndexIfNotExists('econet', 'Vacation_idx1', 'vacation', 'UserLocationId', null);

-- VacationEnabled	(0-1) 0 = Off, 1 = On
-- VacationFan		(0-2) 0 = Off, 1 = On, 2 = Auto