Use rheem;

CREATE TABLE IF NOT EXISTS ru_address(
	AddressID varchar(64) NOT NULL,
	AddressLine1 varchar(50) NOT NULL,
	AddressLine2 varchar(50) NULL,
	City varchar(50) NULL,
	State varchar(3) NULL,
	PostalCode varchar(50) NULL,
	Country varchar(50) NOT NULL,
	AddressType varchar(50) NOT NULL,
	Lat float NULL,
	`Long` float NULL,
	LocationType varchar(50) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (AddressID)
);

