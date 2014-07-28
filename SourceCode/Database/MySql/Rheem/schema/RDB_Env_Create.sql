Use rheem;

CREATE TABLE IF NOT EXISTS rdb_env(
	EnvID varchar(64) NOT NULL,
	EnvName varchar(50) NOT NULL,
	EnvValue longtext NULL,
	TimeStamp datetime NULL,
	PRIMARY KEY (EnvID)
);


