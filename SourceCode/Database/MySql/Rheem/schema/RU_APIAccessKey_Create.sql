Use rheem;

CREATE TABLE IF NOT EXISTS ru_apiaccesskey(
	APIAccessKeyID varchar(36) NOT NULL,
	AccessKey varchar(50) NOT NULL,
	SecretKey varchar(256) NOT NULL,
	Active Bit NOT NULL default 0,
	KeyOwner varchar(36) NOT NULL,
	KeyType varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (APIAccessKeyID)
);
