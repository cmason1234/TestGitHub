USE support;

CREATE TABLE IF NOT EXISTS apilog(
    APILogId int(11) NOT NULL AUTO_INCREMENT,
	Route varchar(256) NOT NULL,
	UserEmailAddr varchar(256) NOT NULL,
	Message LONGTEXT NOT NULL,
	StackTrace LONGTEXT NOT NULL,
	IsException bit NOT NULL DEFAULT 0,
	IsInfo bit NOT NULL DEFAULT 0,
	IsFatal bit NOT NULL DEFAULT 0,
	IsTimingEntry bit NOT NULL DEFAULT 0,
	DurationMillis BIGINT NULL,
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (APILogId)
);

call rheem.AddColumnIfNotExists('support', 'apilog', 'HttpMethod',  'varchar(6) NULL');
call rheem.AddColumnIfNotExists('support', 'apilog', 'ControllerName',  'varchar(255) NULL');


