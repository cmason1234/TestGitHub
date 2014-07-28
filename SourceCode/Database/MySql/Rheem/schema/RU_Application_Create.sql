Use rheem;

CREATE TABLE IF NOT EXISTS ru_application(
	ApplicationID varchar(64) NOT NULL,
	ApplicationName varchar(50) NOT NULL,
	WebAddress varchar(256) NULL,
	Purpose text NULL,
	FullApplicationName varchar(50) NULL,
	RheemAddress varchar(500) NULL,
	RuudAddress varchar(500) NULL,
	RequestUsers char(1) NULL,
	SystemDown bit NULL,
	RheemHomePageID int NULL,
	RuudHomePageID int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ApplicationID)
);

call CreateIndexIfNotExists(NULL, 'application_idx1', 'ru_application', 'ApplicationName', NULL);
call CreateIndexIfNotExists(NULL, 'application_idx2', 'ru_application', 'RheemHomePageID', NULL);
call CreateIndexIfNotExists(NULL, 'application_idx3', 'ru_application', 'RuudHomePageID', NULL);
